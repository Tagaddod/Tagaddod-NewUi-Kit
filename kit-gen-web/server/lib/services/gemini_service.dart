import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/generation_result.dart';
import '../models/kit_gap.dart';

class GeminiService {
  GeminiService(this.apiKey);
  final String apiKey;
  static const _base = 'https://generativelanguage.googleapis.com/v1beta/models';
  static const _model = 'gemini-2.5-flash';

  Future<GenerationResult> generate({
    required String prompt,
    required String systemPrompt,
    required bool arch,
  }) async {
    final schema = arch ? _archSchema : _singleSchema;
    final body = {
      'system_instruction': {'parts': [{'text': systemPrompt}]},
      'contents': [
        {'parts': [{'text': prompt}]}
      ],
      'generationConfig': {
        'temperature': 0.4,
        'maxOutputTokens': 8192,
        'responseMimeType': 'application/json',
        'responseSchema': schema,
      }
    };

    final uri = Uri.parse('$_base/$_model:generateContent?key=$apiKey');
    final res = await http.post(uri, headers: {'content-type': 'application/json'}, body: jsonEncode(body));
    if (res.statusCode != 200) throw Exception('Gemini failed: ${res.body}');

    final map = jsonDecode(res.body) as Map<String, dynamic>;
    final text = map['candidates'][0]['content']['parts'][0]['text'] as String;
    final parsed = jsonDecode(text) as Map<String, dynamic>;
    final usage = map['usageMetadata'] as Map<String, dynamic>? ?? {};

    final files = (parsed['files'] as List<dynamic>?)
            ?.map((f) => GeneratedFile.fromJson(f as Map<String, dynamic>))
            .toList() ??
        [];
    final gaps = (parsed['kit_gaps'] as List<dynamic>?)
            ?.map((g) => KitGap.fromJson(g as Map<String, dynamic>))
            .toList() ??
        [];

    return GenerationResult(
      screenCode: parsed['screen_code'] as String? ?? '',
      files: files,
      kitGaps: gaps,
      inputTokens: usage['promptTokenCount'] as int? ?? 0,
      outputTokens: usage['candidatesTokenCount'] as int? ?? 0,
      rawResponse: text,
    );
  }
}

const _singleSchema = {
  'type': 'object',
  'properties': {
    'screen_code': {'type': 'string'},
    'kit_gaps': _gapsSchema
  },
  'required': ['screen_code', 'kit_gaps']
};

const _gapsSchema = {
  'type': 'array',
  'items': {
    'type': 'object',
    'properties': {
      'widget_name': {'type': 'string'},
      'description': {'type': 'string'},
      'reason': {'type': 'string'},
      'suggested_component_name': {'type': 'string'},
      'priority': {'type': 'integer'},
      'proposed_implementation': {'type': 'string'}
    },
    'required': [
      'widget_name',
      'description',
      'reason',
      'suggested_component_name',
      'priority'
    ]
  }
};

const _archSchema = {
  'type': 'object',
  'properties': {
    'files': {
      'type': 'array',
      'items': {
        'type': 'object',
        'properties': {'path': {'type': 'string'}, 'code': {'type': 'string'}},
        'required': ['path', 'code']
      }
    },
    'kit_gaps': _gapsSchema
  },
  'required': ['files', 'kit_gaps']
};
