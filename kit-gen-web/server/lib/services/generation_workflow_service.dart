import 'dart:io';
import '../models/api_generation_response.dart';
import '../models/generation_result.dart';
import '../models/preview_result.dart';
import '../models/validation_result.dart';
import 'component_retrieval_service.dart';
import 'component_usage_service.dart';
import 'gemini_service.dart';
import 'imagen_service.dart';
import 'manifest_loader.dart';
import 'preview_harness_service.dart';
import 'system_prompt_builder.dart';

class GenerationWorkflowService {
  final String apiKey;
  final _retrieval = ComponentRetrievalService();
  final _usage = ComponentUsageService();
  final _previewHarness = PreviewHarnessService();

  GenerationWorkflowService(this.apiKey);

  Future<ApiGenerationResponse> generate({
    required String requirement,
    required bool arch,
    String? contextCode,
  }) async {
    final timings = <String, int>{};
    final totalWatch = Stopwatch()..start();
    final manifest = await loadManifest();

    final retrievalWatch = Stopwatch()..start();
    final retrieved = _retrieval.select(
      requirement: requirement,
      manifest: manifest,
    );
    retrievalWatch.stop();
    timings['retrievalMs'] = retrievalWatch.elapsedMilliseconds;

    final promptBuilder = SystemPromptBuilder(
      widgets: retrieved.detailedWidgets,
      availableWidgetNames: retrieved.allWidgetNames,
      usedFullManifest: retrieved.usedFullManifest,
    );

    final gemini = GeminiService(apiKey);
    final generationWatch = Stopwatch()..start();
    var generated = await gemini.generate(
      prompt: requirement,
      systemPrompt: promptBuilder.build(
        arch: arch,
        contextCode: contextCode,
      ),
      arch: arch,
    );
    generationWatch.stop();
    timings['generationMs'] = generationWatch.elapsedMilliseconds;

    var totalInputTokens = generated.inputTokens;
    var totalOutputTokens = generated.outputTokens;

    var screenCode = _sanitizeCode(generated.screenCode);
    var files = _sanitizeFiles(generated.files);
    var validation = ValidationResult.skipped(
      message: arch
          ? 'Validation is currently skipped for architecture mode.'
          : 'Validation did not run.',
    );
    var preview = arch
        ? PreviewResult.unavailable(
            message: 'Real preview is available only for single-screen '
                'mode in v1.',
          )
        : PreviewResult.unavailable();

    PreviewJobWorkspace? workspace;
    final isConceptFallbackEnabled =
        Platform.environment['KIT_GEN_ENABLE_CONCEPT_FALLBACK'] != '0';
    final keepPreviewJobs =
        Platform.environment['KIT_GEN_KEEP_PREVIEW_JOBS'] == '1';

    if (!arch) {
      var repaired = false;
      try {
        workspace = await _previewHarness.createWorkspace();

        final initialValidation = Stopwatch()..start();
        var validationErrors = await _validateSingleScreen(
          workspace: workspace,
          screenCode: screenCode,
        );
        initialValidation.stop();
        timings['validationMs'] = initialValidation.elapsedMilliseconds;

        if (validationErrors.isNotEmpty &&
            screenCode.trim().isNotEmpty) {
          repaired = true;
          final repairWatch = Stopwatch()..start();
          generated = await gemini.generate(
            prompt: _buildRepairPrompt(
              requirement: requirement,
              screenCode: screenCode,
              errors: validationErrors,
            ),
            systemPrompt: promptBuilder.build(
              arch: false,
              contextCode: contextCode,
            ),
            arch: false,
          );
          repairWatch.stop();
          timings['repairMs'] = repairWatch.elapsedMilliseconds;
          totalInputTokens += generated.inputTokens;
          totalOutputTokens += generated.outputTokens;
          screenCode = _sanitizeCode(generated.screenCode);

          final repairedValidation = Stopwatch()..start();
          validationErrors = await _validateSingleScreen(
            workspace: workspace,
            screenCode: screenCode,
          );
          repairedValidation.stop();
          timings['validationMs'] =
              (timings['validationMs'] ?? 0) +
                  repairedValidation.elapsedMilliseconds;
        }

        validation = ValidationResult(
          ran: true,
          passed: validationErrors.isEmpty,
          errors: validationErrors,
          repaired: repaired,
        );

        if (validation.passed) {
          final previewWatch = Stopwatch()..start();
          await workspace.writeCode(screenCode);
          preview = await _previewHarness.render(workspace);
          previewWatch.stop();
          timings['previewMs'] = previewWatch.elapsedMilliseconds;
        } else {
          timings['previewMs'] = 0;
          preview = PreviewResult.failed(
            message:
                'Generated code could not pass validation for the real '
                'preview harness.',
          );
        }
      } catch (e) {
        validation = ValidationResult.skipped(
          message: 'Preview pipeline error: $e',
          repaired: repaired,
        );
        preview = PreviewResult.failed(
          message: 'Preview pipeline error: $e',
        );
        timings.putIfAbsent('validationMs', () => 0);
        timings.putIfAbsent('previewMs', () => 0);
      } finally {
        await workspace?.dispose(keep: keepPreviewJobs);
      }

      if (preview.status != 'rendered' &&
          isConceptFallbackEnabled &&
          screenCode.trim().isNotEmpty) {
        final conceptWatch = Stopwatch()..start();
        final fallbackImage = await ImagenService(apiKey).generateMockup(
          prompt: requirement,
          generatedCode: screenCode,
        );
        conceptWatch.stop();
        timings['conceptPreviewMs'] =
            conceptWatch.elapsedMilliseconds;

        if (fallbackImage != null && fallbackImage.isNotEmpty) {
          preview = PreviewResult.conceptFallback(
            imageBase64: fallbackImage,
            message: preview.message ??
                'Real preview unavailable. Showing a concept fallback.',
          );
        }
      } else {
        timings['conceptPreviewMs'] = 0;
      }
    } else {
      timings['validationMs'] = 0;
      timings['previewMs'] = 0;
      timings['conceptPreviewMs'] = 0;
    }

    final codeForMatching = arch
        ? files.map((file) => file.code).join('\n\n')
        : screenCode;

    final matchedComponents = _usage.extract(
      manifestWidgets: manifest.widgets,
      preferredWidgets: retrieved.detailedWidgets,
      code: codeForMatching,
    );

    totalWatch.stop();
    timings['totalMs'] = totalWatch.elapsedMilliseconds;

    return ApiGenerationResponse(
      mode: arch ? 'arch' : 'single',
      requirement: requirement,
      screenCode: arch ? '' : screenCode,
      files: files,
      matchedComponents: matchedComponents,
      kitGaps: generated.kitGaps,
      validation: validation,
      preview: preview,
      tokens: {
        'input': totalInputTokens,
        'output': totalOutputTokens,
      },
      timings: timings,
    );
  }

  Future<List<String>> _validateSingleScreen({
    required PreviewJobWorkspace workspace,
    required String screenCode,
  }) async {
    final contractErrors = _checkSingleScreenContract(screenCode);
    if (contractErrors.isNotEmpty) return contractErrors;

    await workspace.writeCode(screenCode);
    return _previewHarness.analyze(workspace);
  }

  List<String> _checkSingleScreenContract(String code) {
    final errors = <String>[];
    if (code.trim().isEmpty) {
      return ['Generator returned empty screen code.'];
    }
    if (!RegExp(
      r'class\s+GeneratedPreviewScreen\s+extends\s+\w+',
    ).hasMatch(code)) {
      errors.add(
        'Generated code must declare `GeneratedPreviewScreen`.',
      );
    }
    if (RegExp(r'\bvoid\s+main\s*\(').hasMatch(code)) {
      errors.add('Generated screen must not include `main()`.');
    }
    if (RegExp(r'\bMaterialApp\s*\(').hasMatch(code)) {
      errors.add(
        'Generated screen must not include `MaterialApp`.',
      );
    }
    if (RegExp(r'\bCupertinoApp\s*\(').hasMatch(code)) {
      errors.add(
        'Generated screen must not include `CupertinoApp`.',
      );
    }
    return errors;
  }

  String _buildRepairPrompt({
    required String requirement,
    required String screenCode,
    required List<String> errors,
  }) {
    final limitedErrors = errors.take(10).join('\n- ');
    return '''
The previous generated screen failed validation.

Original requirement:
$requirement

Validation errors:
- $limitedErrors

Current code:
```dart
$screenCode
```

Return a FULL corrected Dart file for `GeneratedPreviewScreen`.
Keep the same product intent, use only Tagaddod kit components, and do not add `main()` or `MaterialApp`.
''';
  }

  String _sanitizeCode(String code) {
    var sanitized = code.trim();
    if (sanitized.startsWith('```')) {
      sanitized = sanitized
          .replaceFirst(RegExp(r'^```dart\s*'), '')
          .replaceFirst(RegExp(r'^```\s*'), '')
          .replaceFirst(RegExp(r'\s*```$'), '')
          .trim();
    }
    return sanitized;
  }

  List<GeneratedFile> _sanitizeFiles(List<GeneratedFile> files) {
    return files
        .map(
          (file) => GeneratedFile(
            path: file.path,
            code: _sanitizeCode(file.code),
          ),
        )
        .toList();
  }
}
