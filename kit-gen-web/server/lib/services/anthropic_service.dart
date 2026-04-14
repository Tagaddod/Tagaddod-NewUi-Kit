import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../models/generation_result.dart';
import '../models/kit_gap.dart';
import '../models/screen_spec.dart';
import 'ai_service.dart';
import 'generation_schemas.dart';

/// Anthropic Claude provider.  Uses tool-use for schema-enforced JSON output
/// and ephemeral prompt caching so the system prompt is cached automatically
/// on the first request (no explicit cache management needed).
///
/// Model selection (env vars):
///   ANTHROPIC_MODEL        — main generation (default: claude-sonnet-4-5)
///   ANTHROPIC_REPAIR_MODEL — repair pass     (default: claude-haiku-4-5)
class AnthropicService implements AiService {
  static const _base = 'https://api.anthropic.com/v1/messages';
  static const _apiVersion = '2023-06-01';
  static const _maxTokens = 16000;

  // Default to Haiku 4.5: 3-8s generation (vs 15-25s for Sonnet), 5× cheaper.
  // Our detailed system prompt guides Haiku well enough for UI code generation.
  // Override: ANTHROPIC_MODEL=claude-sonnet-4-5 for highest quality.
  static const _defaultModel = 'claude-haiku-4-5';
  static const _defaultRepairModel = 'claude-haiku-4-5';

  static String get defaultModel =>
      Platform.environment['ANTHROPIC_MODEL'] ?? _defaultModel;
  static String get repairModel =>
      Platform.environment['ANTHROPIC_REPAIR_MODEL'] ?? _defaultRepairModel;

  final String _apiKey;
  final String _model;

  AnthropicService(this._apiKey, {String? model})
      : _model = model ?? defaultModel;

  @override
  Future<GenerationResult> generate({
    required String prompt,
    required String systemPrompt,
    required bool arch,
  }) async {
    final toolName = arch ? 'generate_arch' : 'generate_screen';
    final schema = arch ? archSchema : singleScreenSchema;

    final body = {
      'model': _model,
      'max_tokens': _maxTokens,
      // cache_control marks the system prompt for ephemeral caching.
      // Repeated requests with the same system content are served from cache.
      'system': [
        {'type': 'text', 'text': systemPrompt, 'cache_control': {'type': 'ephemeral'}},
      ],
      'tools': [
        {
          'name': toolName,
          'description': arch
              ? 'Generate Flutter feature files (screen, cubit, state).'
              : 'Generate a Flutter UI screen with spec and Dart code.',
          'input_schema': schema,
          'cache_control': {'type': 'ephemeral'},
        }
      ],
      'tool_choice': {'type': 'tool', 'name': toolName},
      'messages': [
        {'role': 'user', 'content': prompt},
      ],
    };

    final res = await http.post(
      Uri.parse(_base),
      headers: {
        'x-api-key': _apiKey,
        'anthropic-version': _apiVersion,
        'anthropic-beta': 'prompt-caching-2024-07-31',
        'content-type': 'application/json',
      },
      body: jsonEncode(body),
    );

    if (res.statusCode != 200) {
      throw Exception('Anthropic failed (${res.statusCode}): ${res.body}');
    }

    final map = jsonDecode(res.body) as Map<String, dynamic>;

    if ((map['stop_reason'] as String?) == 'max_tokens') {
      throw Exception('Anthropic output truncated (max_tokens). Try a shorter prompt.');
    }

    final content = (map['content'] as List<dynamic>);
    final toolUse = content
        .cast<Map<String, dynamic>>()
        .firstWhere((c) => c['type'] == 'tool_use',
            orElse: () => throw Exception('Anthropic returned no tool_use block.'));

    final parsed = toolUse['input'] as Map<String, dynamic>;
    return _toResult(parsed, map['usage'] as Map<String, dynamic>? ?? {});
  }

  GenerationResult _toResult(Map<String, dynamic> p, Map<String, dynamic> u) {
    final cacheRead = u['cache_read_input_tokens'] as int? ?? 0;
    if (cacheRead > 0) {
      print('[Anthropic] prompt cache hit: $cacheRead tokens read from cache');
    }
    ScreenSpec? spec;
    if (p['screen_spec'] is Map<String, dynamic>) {
      spec = ScreenSpec.fromJson(p['screen_spec'] as Map<String, dynamic>);
    }
    return GenerationResult(
      screenCode: p['screen_code'] as String? ?? '',
      files: (p['files'] as List<dynamic>? ?? [])
          .map((f) => GeneratedFile.fromJson(f as Map<String, dynamic>))
          .toList(),
      kitGaps: (p['kit_gaps'] as List<dynamic>? ?? [])
          .map((g) => KitGap.fromJson(g as Map<String, dynamic>))
          .toList(),
      screenSpec: spec,
      inputTokens: u['input_tokens'] as int? ?? 0,
      outputTokens: u['output_tokens'] as int? ?? 0,
      rawResponse: jsonEncode(p),
    );
  }
}
