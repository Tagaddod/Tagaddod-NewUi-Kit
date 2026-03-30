import 'dart:convert';
import 'package:http/http.dart' as http;

class GeminiService {
  final String apiKey;
  static const String _baseUrl =
      'https://generativelanguage.googleapis.com/v1beta/models';

  GeminiService(this.apiKey);

  Future<GenerationResult> generateCode(
    String requirement,
    String systemPrompt,
  ) async {
    const model = 'gemini-2.5-flash';
    final url = Uri.parse('$_baseUrl/$model:generateContent?key=$apiKey');

    final requestBody = {
      'system_instruction': {
        'parts': [
          {'text': systemPrompt}
        ]
      },
      'contents': [
        {
          'parts': [
            {'text': requirement}
          ]
        }
      ],
      'generationConfig': {
        'temperature': 0.4,
        'maxOutputTokens': 8192,
        'responseMimeType': 'application/json',
        'responseSchema': {
          'type': 'object',
          'properties': {
            'screen_code': {
              'type': 'string',
              'description':
                  'Complete Flutter Dart code for the requested screen',
            },
            'kit_gaps': {
              'type': 'array',
              'description': 'List of missing components not in the kit',
              'items': {
                'type': 'object',
                'properties': {
                  'widget_name': {'type': 'string'},
                  'description': {'type': 'string'},
                  'proposed_implementation': {'type': 'string'},
                },
                'required': ['widget_name', 'description'],
              },
            },
          },
          'required': ['screen_code', 'kit_gaps'],
        },
      },
    };

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(requestBody),
    );

    if (response.statusCode != 200) {
      throw Exception(
          'Gemini API error: ${response.statusCode} - ${response.body}');
    }

    final data = jsonDecode(response.body);
    final text =
        data['candidates'][0]['content']['parts'][0]['text'] as String;

    final usage = data['usageMetadata'];
    final inputTokens = usage['promptTokenCount'] as int;
    final outputTokens = usage['candidatesTokenCount'] as int;

    // Parse structured JSON response
    final parsed = jsonDecode(text) as Map<String, dynamic>;

    return GenerationResult(
      screenCode: parsed['screen_code'] as String? ?? '',
      kitGapsList: (parsed['kit_gaps'] as List<dynamic>?)
              ?.map((g) => KitGap.fromJson(g as Map<String, dynamic>))
              .toList() ??
          [],
      inputTokens: inputTokens,
      outputTokens: outputTokens,
    );
  }
}

class KitGap {
  final String widgetName;
  final String description;
  final String? proposedImplementation;

  KitGap({
    required this.widgetName,
    required this.description,
    this.proposedImplementation,
  });

  factory KitGap.fromJson(Map<String, dynamic> json) => KitGap(
        widgetName: json['widget_name'] as String,
        description: json['description'] as String,
        proposedImplementation:
            json['proposed_implementation'] as String?,
      );

  @override
  String toString() {
    final buf = StringBuffer('• $widgetName: $description');
    if (proposedImplementation != null) {
      buf.writeln('\n  Proposed:\n$proposedImplementation');
    }
    return buf.toString();
  }
}

class GenerationResult {
  final String screenCode;
  final List<KitGap> kitGapsList;
  final int inputTokens;
  final int outputTokens;

  GenerationResult({
    required this.screenCode,
    required this.kitGapsList,
    required this.inputTokens,
    required this.outputTokens,
  });

  bool get hasGaps => kitGapsList.isNotEmpty;

  String get kitGapsText => kitGapsList.map((g) => g.toString()).join('\n\n');

  double get estimatedCost {
    // Gemini 2.5 Flash: $0.30 input / $2.50 output per 1M tokens
    return (inputTokens * 0.30 / 1000000) +
        (outputTokens * 2.50 / 1000000);
  }
}
