import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/generation_result.dart';
import '../models/kit_gap.dart';
import '../models/screen_spec.dart';
import 'ai_service.dart';
import 'generation_schemas.dart';
import 'logger.dart';

class GeminiService implements AiService {
  GeminiService(this.apiKey);
  final String apiKey;
  static const _base =
      'https://generativelanguage.googleapis.com/v1beta/models';
  static const _model = 'gemini-2.5-flash';

  /// Standard generation — full system prompt sent every request.
  @override
  Future<GenerationResult> generate({
    required String prompt,
    required String systemPrompt,
    required bool arch,
  }) async {
    Map<String, dynamic> _buildBody(String p) => {
      'system_instruction': {
        'parts': [
          {'text': systemPrompt},
        ],
      },
      'contents': [
        {
          'parts': [{'text': p}],
        },
      ],
      'generationConfig': _config(arch),
    };
    try {
      return await _post(_buildBody(prompt), arch);
    } on _MaxTokensException {
      Log.warn('Gemini', 'MAX_TOKENS — retrying with concise hint');
      final concisePrompt =
          '$prompt\n\nIMPORTANT: Keep the Dart code very concise — max 120 lines. Use only inline widgets, no large dummy data lists.';
      return _post(_buildBody(concisePrompt), arch);
    }
  }

  /// Cached generation — system prompt is pre-cached; only the requirement
  /// is sent per request.  Falls back automatically if [cacheName] is null.
  Future<GenerationResult> generateCached({
    required String requirement,
    required String cacheName,
    required bool arch,
    String? systemPromptFallback,
  }) async {
    final body = {
      'cachedContent': cacheName,
      'contents': [
        {
          'role': 'user',
          'parts': [{'text': requirement}],
        },
      ],
      'generationConfig': _config(arch),
    };
    try {
      return await _post(body, arch);
    } on _MaxTokensException {
      Log.warn('Gemini', 'MAX_TOKENS on cached call — retrying with concise hint');
      final conciseBody = {
        'cachedContent': cacheName,
        'contents': [
          {
            'role': 'user',
            'parts': [{'text': '$requirement\n\nIMPORTANT: Keep the Dart code very concise — max 120 lines. Use only inline widgets, no large dummy data lists.'}],
          },
        ],
        'generationConfig': _config(arch),
      };
      return _post(conciseBody, arch);
    }
  }

  Map<String, dynamic> _config(bool arch) => {
    'temperature': 0.4,
    'maxOutputTokens': 32768,
    'responseMimeType': 'application/json',
    'responseSchema': arch ? archSchema : singleScreenSchema,
  };

  Future<GenerationResult> _post(Map<String, dynamic> body, [bool arch = false]) async {
    final uri = Uri.parse('$_base/$_model:generateContent?key=$apiKey');
    final sw = Stopwatch()..start();
    final res = await http.post(
      uri,
      headers: {'content-type': 'application/json'},
      body: jsonEncode(body),
    );
    sw.stop();

    if (res.statusCode != 200) {
      Log.error('Gemini', 'HTTP ${res.statusCode}', {
        'responseBody': res.body.substring(0, res.body.length.clamp(0, 500)),
        'latencyMs': sw.elapsedMilliseconds,
      });
      throw Exception('Gemini failed (${res.statusCode}): ${res.body}');
    }

    final map = jsonDecode(res.body) as Map<String, dynamic>;
    final candidate = map['candidates'][0] as Map<String, dynamic>;

    final finishReason = candidate['finishReason'] as String? ?? '';
    final usage = map['usageMetadata'] as Map<String, dynamic>? ?? {};
    final cachedTokens = usage['cachedContentTokenCount'] as int? ?? 0;

    Log.info('Gemini', 'response received', {
      'model': _model,
      'finishReason': finishReason,
      'latencyMs': sw.elapsedMilliseconds,
      'inputTokens': usage['promptTokenCount'] ?? 0,
      'outputTokens': usage['candidatesTokenCount'] ?? 0,
      'cachedTokens': cachedTokens,
    });

    if (cachedTokens > 0) {
      Log.info('Gemini', 'cache hit: $cachedTokens cached tokens saved');
    }

    if (finishReason == 'MAX_TOKENS') throw _MaxTokensException();

    final text = candidate['content']['parts'][0]['text'] as String;
    Map<String, dynamic> parsed;
    try {
      parsed = jsonDecode(text) as Map<String, dynamic>;
    } on FormatException catch (e) {
      Log.error('Gemini', 'Malformed JSON response', {
        'parseError': e.message,
        'rawTextPreview': text.substring(0, text.length.clamp(0, 800)),
      });
      throw Exception(
        'Gemini returned malformed JSON (${e.message}). '
        'This usually means the output was silently truncated. '
        'Try a simpler screen description.',
      );
    }

    final files =
        (parsed['files'] as List<dynamic>?)
            ?.map((f) => GeneratedFile.fromJson(f as Map<String, dynamic>))
            .toList() ??
        [];
    final gaps =
        (parsed['kit_gaps'] as List<dynamic>?)
            ?.map((g) => KitGap.fromJson(g as Map<String, dynamic>))
            .toList() ??
        [];
    ScreenSpec? screenSpec;
    final screenSpecJson = parsed['screen_spec'];
    if (screenSpecJson is Map<String, dynamic>) {
      screenSpec = ScreenSpec.fromJson(screenSpecJson);
    }

    return GenerationResult(
      screenCode: parsed['screen_code'] as String? ?? '',
      files: files,
      kitGaps: gaps,
      screenSpec: screenSpec,
      inputTokens: usage['promptTokenCount'] as int? ?? 0,
      outputTokens: usage['candidatesTokenCount'] as int? ?? 0,
      rawResponse: text,
    );
  }
}

// Schemas moved to generation_schemas.dart — imported above.

class _MaxTokensException implements Exception {
  @override
  String toString() => 'Gemini output was truncated (MAX_TOKENS).';
}
