import 'dart:io';
import '../models/api_generation_response.dart';
import '../models/generation_result.dart';
import '../models/preview_job_workspace.dart';
import '../models/preview_result.dart';
import '../models/validation_result.dart';
import '../models/widget_info.dart';
import 'ai_service.dart';
import 'anthropic_service.dart';
import 'cache_service.dart';
import 'component_retrieval_service.dart';
import 'component_usage_service.dart';
import 'gemini_service.dart';
import 'imagen_service.dart';
import 'kit_enum_scanner.dart';
import 'logger.dart';
import 'manifest_loader.dart';
import 'preview_harness_service.dart';
import 'screen_spec_builder.dart';
import 'system_prompt_builder.dart';

class GenerationWorkflowService {
  /// Gemini API key (also used for ImagenService concept fallback).
  final String apiKey;

  final _retrieval = ComponentRetrievalService();
  final _usage = ComponentUsageService();
  final _previewHarness = PreviewHarnessService();
  final _screenSpecBuilder = ScreenSpecBuilder();
  late final CacheService _geminiCache;

  GenerationWorkflowService(this.apiKey) {
    _geminiCache = CacheService(apiKey);
  }

  AiService _buildAiService() {
    final provider = (Platform.environment['AI_PROVIDER'] ?? 'anthropic').toLowerCase();
    if (provider == 'gemini') return GeminiService(apiKey);
    final key = Platform.environment['ANTHROPIC_API_KEY'] ?? '';
    if (key.isNotEmpty) {
      Log.info('AI', 'main model: ${AnthropicService.defaultModel}');
      return AnthropicService(key);
    }
    Log.warn('AI', 'ANTHROPIC_API_KEY not set — falling back to Gemini');
    return GeminiService(apiKey);
  }

  AiService _buildRepairAiService() {
    final provider = (Platform.environment['AI_PROVIDER'] ?? 'anthropic').toLowerCase();
    if (provider == 'gemini') return GeminiService(apiKey);
    final key = Platform.environment['ANTHROPIC_API_KEY'] ?? '';
    if (key.isNotEmpty) {
      Log.info('AI', 'repair model: ${AnthropicService.repairModel}');
      return AnthropicService(key, model: AnthropicService.repairModel);
    }
    return GeminiService(apiKey);
  }

  Future<ApiGenerationResponse> generate({
    required String requirement,
    required bool arch,
    String? contextCode,
  }) async {
    final requestId = _genId();
    final timings = <String, int>{};
    final totalWatch = Stopwatch()..start();

    Log.generation(
      requestId: requestId,
      event: 'START',
      data: {
        'mode': arch ? 'arch' : 'single',
        'prompt': requirement,
        'promptLength': requirement.length,
      },
    );

    // ── Retrieval ────────────────────────────────────────────────────────────
    final retrievalWatch = Stopwatch()..start();
    final manifestFuture = loadManifest();
    final kitScanFuture = scanKitSource();
    final manifest = await manifestFuture;
    final kitScan = await kitScanFuture;
    final retrieved = _retrieval.select(requirement: requirement, manifest: manifest);
    timings['retrievalMs'] = retrievalWatch.elapsed.inMilliseconds;

    Log.generation(
      requestId: requestId,
      event: 'RETRIEVAL',
      data: {
        'selectedWidgets': retrieved.detailedWidgets.map((w) => w.className).toList(),
        'usedFullManifest': retrieved.usedFullManifest,
        'totalWidgetsAvailable': manifest.widgets.length,
        'retrievalMs': timings['retrievalMs'],
      },
    );

    // ── System prompt build ──────────────────────────────────────────────────
    final promptBuilder = SystemPromptBuilder(
      widgets: retrieved.detailedWidgets,
      availableWidgetNames: retrieved.allWidgetNames,
      usedFullManifest: retrieved.usedFullManifest,
      kitScan: kitScan,
    );
    final systemPrompt = promptBuilder.build(arch: arch, contextCode: contextCode);

    Log.generation(
      requestId: requestId,
      event: 'SYSTEM_PROMPT',
      data: {
        'systemPromptChars': systemPrompt.length,
        'systemPromptPreview': systemPrompt.substring(0, systemPrompt.length.clamp(0, 600)),
      },
    );

    // ── AI call ──────────────────────────────────────────────────────────────
    final ai = _buildAiService();
    final geminiAi = ai is GeminiService ? ai : null;
    final provider = geminiAi != null ? 'gemini' : 'anthropic';
    Log.info('AI', 'provider=$provider requestId=$requestId');

    String? geminiCacheName;
    if (!arch && geminiAi != null) {
      final fullPromptBuilder = SystemPromptBuilder(
        widgets: manifest.widgets,
        availableWidgetNames: manifest.widgets.map((w) => w.className).toList(),
        usedFullManifest: true,
        kitScan: kitScan,
      );
      final fullPrompt = fullPromptBuilder.build(arch: false, contextCode: contextCode);
      geminiCacheName = await _geminiCache.ensure(fullPrompt);
    }

    final generationWatch = Stopwatch()..start();
    var generated = geminiCacheName != null
        ? await geminiAi!.generateCached(
            requirement: requirement,
            cacheName: geminiCacheName,
            arch: false,
          )
        : await ai.generate(
            prompt: requirement,
            systemPrompt: systemPrompt,
            arch: arch,
          );
    timings['generationMs'] = generationWatch.elapsed.inMilliseconds;

    Log.generation(
      requestId: requestId,
      event: 'GENERATION_DONE',
      data: {
        'provider': provider,
        'inputTokens': generated.inputTokens,
        'outputTokens': generated.outputTokens,
        'generationMs': timings['generationMs'],
        'screenCodeChars': generated.screenCode.length,
        'kitGapsCount': generated.kitGaps.length,
        'kitGaps': generated.kitGaps.map((g) => g.widgetName).toList(),
        'rawCodePreview': generated.screenCode.substring(
          0, generated.screenCode.length.clamp(0, 800),
        ),
      },
    );

    var totalInputTokens = generated.inputTokens;
    var totalOutputTokens = generated.outputTokens;
    var screenCode = _sanitizeCode(generated.screenCode);
    var files = _sanitizeFiles(generated.files);
    var validation = ValidationResult.skipped(
      message: arch ? 'Validation skipped for architecture mode.' : 'Validation did not run.',
    );
    var preview = arch
        ? PreviewResult.unavailable(message: 'Preview available only in single-screen mode.')
        : PreviewResult.unavailable();

    PreviewJobWorkspace? workspace;
    final keepPreviewJobs = Platform.environment['KIT_GEN_KEEP_PREVIEW_JOBS'] == '1';

    if (!arch) {
      var repaired = false;
      try {
        workspace = await _previewHarness.createWorkspace();

        final validationWatch = Stopwatch()..start();
        var errors = await _validateSingleScreen(workspace: workspace, screenCode: screenCode);
        timings['validationMs'] = validationWatch.elapsed.inMilliseconds;

        Log.generation(
          requestId: requestId,
          event: 'VALIDATION_PASS_0',
          data: {
            'passed': errors.isEmpty,
            'errorCount': errors.length,
            'errors': errors,
            'validationMs': timings['validationMs'],
          },
          severity: errors.isEmpty ? 'INFO' : 'WARNING',
        );

        if (errors.isNotEmpty && screenCode.trim().isNotEmpty) {
          repaired = true;
          final repairWatch = Stopwatch()..start();
          final repairAi = _buildRepairAiService();

          // ── Repair pass 1 ────────────────────────────────────────────────
          final repairPrompt1 = _buildRepairPrompt(
            requirement: requirement,
            screenCode: screenCode,
            errors: errors,
            manifest: manifest.widgets,
          );
          Log.generation(
            requestId: requestId,
            event: 'REPAIR_PROMPT_1',
            data: {'repairPrompt': repairPrompt1, 'errorsBeingFixed': errors},
            severity: 'WARNING',
          );

          generated = await repairAi.generate(
            prompt: repairPrompt1,
            systemPrompt: systemPrompt,
            arch: false,
          );
          totalInputTokens += generated.inputTokens;
          totalOutputTokens += generated.outputTokens;
          screenCode = _sanitizeCode(generated.screenCode);
          errors = await _validateSingleScreen(workspace: workspace, screenCode: screenCode);

          Log.generation(
            requestId: requestId,
            event: 'VALIDATION_PASS_1',
            data: {
              'passed': errors.isEmpty,
              'errorCount': errors.length,
              'errors': errors,
              'inputTokens': generated.inputTokens,
              'outputTokens': generated.outputTokens,
            },
            severity: errors.isEmpty ? 'INFO' : 'WARNING',
          );

          // ── Repair pass 2 ────────────────────────────────────────────────
          if (errors.isNotEmpty && screenCode.trim().isNotEmpty) {
            final repairPrompt2 = _buildRepairPrompt(
              requirement: requirement,
              screenCode: screenCode,
              errors: errors,
              manifest: manifest.widgets,
            );
            Log.generation(
              requestId: requestId,
              event: 'REPAIR_PROMPT_2',
              data: {'repairPrompt': repairPrompt2, 'errorsBeingFixed': errors},
              severity: 'WARNING',
            );

            generated = await repairAi.generate(
              prompt: repairPrompt2,
              systemPrompt: systemPrompt,
              arch: false,
            );
            totalInputTokens += generated.inputTokens;
            totalOutputTokens += generated.outputTokens;
            screenCode = _sanitizeCode(generated.screenCode);
            errors = await _validateSingleScreen(workspace: workspace, screenCode: screenCode);

            Log.generation(
              requestId: requestId,
              event: 'VALIDATION_PASS_2',
              data: {
                'passed': errors.isEmpty,
                'errorCount': errors.length,
                'errors': errors,
                'inputTokens': generated.inputTokens,
                'outputTokens': generated.outputTokens,
              },
              severity: errors.isEmpty ? 'INFO' : 'ERROR',
            );
          }

          timings['repairMs'] = repairWatch.elapsed.inMilliseconds;
          timings['validationMs'] =
              (timings['validationMs'] ?? 0) + validationWatch.elapsed.inMilliseconds;
        }

        validation = ValidationResult(
          ran: true,
          passed: errors.isEmpty,
          errors: errors,
          repaired: repaired,
        );

        final previewWatch = Stopwatch()..start();
        if (validation.passed) {
          preview = await _previewHarness.renderLive(workspace);
          workspace = null;
        } else {
          await workspace.writeCode(_safeErrorScreen);
          preview = await _previewHarness.renderLive(workspace);
          workspace = null;
          preview = PreviewResult.livePreview(
            previewUrl: preview.previewUrl!,
            message: 'Code had ${validation.errors.length} error(s) — showing fix-needed screen.',
          );
        }
        timings['previewMs'] = previewWatch.elapsed.inMilliseconds;
      } catch (e, st) {
        Log.error('PIPELINE', 'Preview pipeline exception', {
          'requestId': requestId,
          'error': e.toString(),
          'stackTrace': st.toString().substring(0, st.toString().length.clamp(0, 600)),
        });
        validation = ValidationResult.skipped(
            message: 'Preview pipeline error: $e', repaired: repaired);
        preview = PreviewResult.failed(message: 'Preview pipeline error: $e');
        timings.putIfAbsent('validationMs', () => 0);
        timings.putIfAbsent('previewMs', () => 0);
      } finally {
        await workspace?.dispose(keep: keepPreviewJobs);
      }

      if (preview.status != 'live' && screenCode.trim().isNotEmpty) {
        final conceptWatch = Stopwatch()..start();
        final fallback = await ImagenService(apiKey).generateMockup(
          prompt: requirement,
          generatedCode: screenCode,
        );
        timings['conceptPreviewMs'] = conceptWatch.elapsed.inMilliseconds;
        if (fallback != null && fallback.isNotEmpty) {
          preview = PreviewResult.conceptFallback(
            imageBase64: fallback,
            message: preview.message ?? 'Live preview unavailable. Showing a concept fallback.',
          );
        }
      } else {
        timings['conceptPreviewMs'] = 0;
      }
    } else {
      timings.addAll({'validationMs': 0, 'previewMs': 0, 'conceptPreviewMs': 0});
    }

    final codeForMatching = arch ? files.map((f) => f.code).join('\n\n') : screenCode;
    final matchedComponents = _usage.extract(
      manifestWidgets: manifest.widgets,
      preferredWidgets: retrieved.detailedWidgets,
      code: codeForMatching,
    );
    final screenSpec = _screenSpecBuilder.build(
      requirement: requirement,
      kitGaps: generated.kitGaps,
      generatedSpec: generated.screenSpec,
      arch: arch,
    );

    totalWatch.stop();
    timings['totalMs'] = totalWatch.elapsedMilliseconds;

    Log.generation(
      requestId: requestId,
      event: 'COMPLETE',
      data: {
        'validationPassed': validation.passed,
        'repaired': validation.repaired,
        'previewStatus': preview.status,
        'matchedComponents': matchedComponents.map((c) => c.className).toList(),
        'kitGaps': generated.kitGaps.map((g) => g.widgetName).toList(),
        'totalInputTokens': totalInputTokens,
        'totalOutputTokens': totalOutputTokens,
        'timings': timings,
      },
      severity: validation.passed ? 'INFO' : 'WARNING',
    );

    return ApiGenerationResponse(
      mode: arch ? 'arch' : 'single',
      requirement: requirement,
      screenCode: arch ? '' : screenCode,
      files: files,
      matchedComponents: matchedComponents,
      kitGaps: generated.kitGaps,
      validation: validation,
      preview: preview,
      screenSpec: screenSpec,
      tokens: {'input': totalInputTokens, 'output': totalOutputTokens},
      timings: timings,
    );
  }

  static String _genId() {
    final ms = DateTime.now().millisecondsSinceEpoch;
    return 'req-${ms.toRadixString(36)}';
  }

  Future<List<String>> _validateSingleScreen({
    required PreviewJobWorkspace workspace,
    required String screenCode,
  }) async {
    final contractErrors = _checkContract(screenCode);
    if (contractErrors.isNotEmpty) return contractErrors;
    await workspace.writeCode(screenCode);
    return _previewHarness.analyze(workspace);
  }

  List<String> _checkContract(String code) {
    if (code.trim().isEmpty) return ['Generator returned empty screen code.'];
    final errors = <String>[];
    if (!RegExp(r'class\s+GeneratedPreviewScreen\s+extends\s+\w+').hasMatch(code)) {
      errors.add('Generated code must declare `GeneratedPreviewScreen`.');
    }
    if (RegExp(r'\bvoid\s+main\s*\(').hasMatch(code)) errors.add('Must not include `main()`.');
    if (RegExp(r'\bMaterialApp\s*\(').hasMatch(code)) errors.add('Must not include `MaterialApp`.');
    if (RegExp(r'\bCupertinoApp\s*\(').hasMatch(code)) errors.add('Must not include `CupertinoApp`.');

    // Detect private PascalCase helpers that are called but never defined in the file.
    // e.g. `return _ProductCard(...)` with no `class _ProductCard` anywhere.
    final callPattern = RegExp(r'\b(_[A-Z][A-Za-z0-9]*)\s*\(');
    final definedNames = RegExp(r'class\s+(_[A-Z][A-Za-z0-9]*)').allMatches(code).map((m) => m.group(1)!).toSet();
    final calledNames = callPattern.allMatches(code).map((m) => m.group(1)!).toSet();
    for (final name in calledNames.difference(definedNames)) {
      errors.add(
        'INLINE REQUIRED: `$name(...)` is called but `class $name` is never defined in the file. '
        'Do NOT use private widget classes. Inline the widget tree directly in `build()` or `itemBuilder`.',
      );
    }

    // SafeArea inside Scaffold.body causes blank screens in the DeviceFrame preview.
    if (RegExp(r'\bbody\s*:\s*SafeArea\s*\(').hasMatch(code)) {
      errors.add(
        'BANNED: `body: SafeArea(...)` detected. The DeviceFrame preview already injects device safe-area insets. '
        'Adding SafeArea inside body double-applies those insets and renders the body blank. '
        'Remove SafeArea — use `body: SingleChildScrollView(...)` or `body: Column(...)` directly.',
      );
    }

    // PreferredSize wrapping TopAppBar causes safe-area miscalculation.
    if (RegExp(r'\bappBar\s*:\s*PreferredSize\s*\(').hasMatch(code)) {
      errors.add(
        'BANNED: `appBar: PreferredSize(...)` detected. Use `appBar: TopAppBar(...)` directly — '
        'do NOT wrap TopAppBar in PreferredSize. The wrapper interferes with Scaffold safe-area measurement.',
      );
    }

    return errors;
  }

  String _buildRepairPrompt({
    required String requirement,
    required String screenCode,
    required List<String> errors,
    required List<WidgetInfo> manifest,
  }) {
    // Look up the correct API for every kit widget mentioned in the error lines.
    final mentionedApis = StringBuffer();
    for (final w in manifest) {
      final mentioned = errors.any((e) => e.contains(w.className));
      if (mentioned) {
        mentionedApis.writeln('### ${w.className}');
        mentionedApis.writeln('Constructors: ${w.constructors.join(', ')}');
        mentionedApis.writeln('Parameters: ${w.parameters}');
        mentionedApis.writeln('Example:\n```dart\n${w.example}\n```\n');
      }
    }

    final apiHint = mentionedApis.isNotEmpty
        ? '\n## Correct API for Failing Components\n$mentionedApis'
        : '';

    // Detect undefined private helper methods/classes (e.g. _ProductCard used as a
    // method call on the State, but defined as a separate class or not defined at all).
    final hasUndefinedPrivate = errors.any((e) =>
        e.contains("isn't defined for the type") && e.contains("'_"));
    final undefinedPrivateHint = hasUndefinedPrivate
        ? "\n## IMPORTANT — Undefined Private Helper\n"
            "One or more errors are caused by calling a private helper (e.g. `_ProductCard(...)`) as if it is a method on the State class, "
            "but it is defined as a separate top-level Widget class or not defined at all.\n"
            "Fix: either (a) define it as a method returning Widget inside the State class, "
            "or (b) use it as a Widget class directly (e.g. `_ProductCard(...)` as a widget, not a method call).\n"
            "Do NOT leave any `_XyzWidget(...)` references that are not backed by a definition in the same file."
        : '';

    // Detect if errors are caused by fake kit imports so the repair knows
    // to fall back to plain Flutter instead of guessing kit APIs.
    final hasFakeKitImport = errors.any((e) =>
        (e.contains("isn't defined") && !e.contains("isn't defined for the type")) ||
        e.contains('Undefined class') ||
        e.contains('Undefined name') ||
        e.contains('could not be resolved'));

    final fakeKitHint = hasFakeKitImport
        ? '\n## IMPORTANT — Fake Kit Import Detected\n'
            'One or more errors are caused by using a Tagaddod kit class that does NOT exist in the manifest. '
            'Do NOT try to guess or fix the kit class name. Instead:\n'
            '1. Replace the fake kit widget with equivalent standard Flutter/Material widgets.\n'
            '2. Add a kit_gap entry with a complete proposed_implementation for the Flutter lead to review.\n'
            'This is the correct approach — the screen must compile today.'
        : '';

    return '''
The previous generated screen failed validation.

Original requirement:
$requirement

Validation errors:
- ${errors.take(10).join('\n- ')}
$apiHint$undefinedPrivateHint$fakeKitHint
Current code:
```dart
$screenCode
```

Return a FULL corrected Dart file for `GeneratedPreviewScreen`.
Keep the same product intent. Keep the code concise — max 120 lines.
- For any element the Tagaddod kit covers: use ONLY the exact constructors from the manifest.
- For any element the kit does NOT cover: build with standard Flutter widgets and add a kit_gap.
- NEVER define private widget classes (e.g. `class _ProductCard`). Inline ALL widget trees directly in `build()` or `itemBuilder`.
- Dollar signs in string literals MUST use a single backslash: `'\\\$10.00'`. NEVER write `\$\$` or `\$\${...}` — that is invalid Dart and will break compilation.
Do not add `main()` or `MaterialApp`.
''';
  }

  // A valid Flutter-only screen shown when validation fails after repair.
  // Uses only dart:material — no kit imports — so it always compiles.
  // Raw string avoids any dollar-sign interpolation issues.
  static const _safeErrorScreen = r'''
import 'package:flutter/material.dart';

class GeneratedPreviewScreen extends StatelessWidget {
  const GeneratedPreviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFFFAF9F6),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 48),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.warning_amber_rounded, color: Color(0xFFD97742), size: 40),
            SizedBox(height: 20),
            Text(
              'Fix needed',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Color(0xFF1A1A1A),
              ),
            ),
            SizedBox(height: 8),
            Text(
              'The generated code had errors that the repair pass could not fully resolve.\n'
              'Check the Code tab to see the validation details.',
              style: TextStyle(fontSize: 14, color: Color(0xFF666666), height: 1.5),
            ),
          ],
        ),
      ),
    );
  }
}
''';

  String _sanitizeCode(String code) {
    var s = code.trim();
    if (s.startsWith('```')) {
      s = s
          .replaceFirst(RegExp(r'^```dart\s*'), '')
          .replaceFirst(RegExp(r'^```\s*'), '')
          .replaceFirst(RegExp(r'\s*```$'), '')
          .trim();
    }

    // Fix string literal issues: raw strings with embedded newlines, and
    // regular strings that have actual newline bytes embedded inside them
    // (which produce "unterminated string literal" errors in flutter analyze).
    s = _fixStringLiterals(s);

    // Gemini sometimes emits '$$' thinking it escapes a dollar sign (Python/SQL
    // style). In Dart '$$' is "undefined identifier '$'" — always invalid.
    s = s.replaceAll(r'$$', r'\$');

    // Bare '$N' (dollar + digit) is never valid Dart string interpolation —
    // identifiers cannot start with a digit. This catches unescaped currency
    // values like '$1.20' or '$0.80' that Gemini emits without the backslash.
    // The negative lookbehind prevents double-escaping already-correct '\$N'.
    s = s.replaceAllMapped(
      RegExp(r'(?<!\\)\$(\d)'),
      (m) => '\\\$${m.group(1)}',
    );

    // Gemini sometimes leaks JSON array separators: the code ends with "}},,,".
    // Strip any commas (and whitespace) that appear after the final closing brace.
    s = s.replaceFirstMapped(
      RegExp(r'(\})\s*,+\s*$'),
      (m) => m.group(1)!,
    );

    return s;
  }

  /// Scans every string literal in the generated Dart code and fixes two
  /// categories of LLM-induced corruption:
  ///
  /// 1. **Raw strings** (`r'...'` / `r"..."`): converted to regular strings
  ///    with `$` escaped and actual newlines removed.  The JSON decoder
  ///    sometimes injects real newline bytes into raw strings, which Dart
  ///    cannot parse.
  ///
  /// 2. **Regular strings** (`'...'` / `"..."`): any real newline byte
  ///    embedded inside is silently removed.  Gemini occasionally places
  ///    a `\n` (JSON newline) immediately before a `$` price value, which
  ///    the JSON decoder converts to an actual newline — causing the closing
  ///    quote to land on the next line and producing unterminated-string
  ///    errors like `1:3801`.
  ///
  /// Triple-quoted strings (`'''...'''` / `"""..."""`) are left untouched
  /// because newlines are valid inside them.
  static String _fixStringLiterals(String code) {
    final buf = StringBuffer();
    var i = 0;
    final len = code.length;

    while (i < len) {
      final c = code[i];

      // ── Raw string: r' or r" ──────────────────────────────────────────────
      if (c == 'r' &&
          i + 1 < len &&
          (code[i + 1] == "'" || code[i + 1] == '"')) {
        final quote = code[i + 1];
        final start = i + 2;
        final end = code.indexOf(quote, start);
        if (end == -1) {
          buf.write(code.substring(i));
          break;
        }
        final content = code.substring(start, end);
        final safe = content
            .replaceAll(r'$', r'\$')
            .replaceAll('\n', ' ')
            .replaceAll('\r', '');
        buf
          ..write("'")
          ..write(safe)
          ..write("'");
        i = end + 1;
        continue;
      }

      // ── Triple-quoted string: ''' or """ ──────────────────────────────────
      if ((c == "'" || c == '"') &&
          i + 2 < len &&
          code[i + 1] == c &&
          code[i + 2] == c) {
        final q3 = '$c$c$c';
        final end = code.indexOf(q3, i + 3);
        if (end == -1) {
          buf.write(code.substring(i));
          break;
        }
        buf.write(code.substring(i, end + 3));
        i = end + 3;
        continue;
      }

      // ── Regular string: ' or " ────────────────────────────────────────────
      if (c == "'" || c == '"') {
        final quote = c;
        buf.write(quote);
        i++;
        while (i < len) {
          final sc = code[i];
          if (sc == '\\' && i + 1 < len) {
            buf.write(sc);
            buf.write(code[i + 1]);
            i += 2;
          } else if (sc == quote) {
            buf.write(quote);
            i++;
            break;
          } else if (sc == '\n' || sc == '\r') {
            // Real newline inside a single-line string — drop it.
            if (sc == '\r' && i + 1 < len && code[i + 1] == '\n') i++;
            i++;
          } else {
            buf.write(sc);
            i++;
          }
        }
        continue;
      }

      buf.write(c);
      i++;
    }

    return buf.toString();
  }

  List<GeneratedFile> _sanitizeFiles(List<GeneratedFile> files) =>
      files.map((f) => GeneratedFile(path: f.path, code: _sanitizeCode(f.code))).toList();
}
