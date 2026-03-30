import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class GeminiService {
  final String apiKey;
  static const String baseUrl =
      'https://generativelanguage.googleapis.com/v1beta/models';

  GeminiService(this.apiKey);

  Future<GenerationResult> generateCode(
    String requirement,
    String systemPrompt,
  ) async {
    final model = 'gemini-2.0-flash-exp';
    final url = Uri.parse('$baseUrl/$model:generateContent?key=$apiKey');

    final requestBody = {
      'contents': [
        {
          'parts': [
            {'text': '$systemPrompt\n\nUser requirement:\n$requirement'}
          ]
        }
      ],
      'generationConfig': {
        'temperature': 0.7,
        'topK': 40,
        'topP': 0.95,
        'maxOutputTokens': 4096,
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
    final text = data['candidates'][0]['content']['parts'][0]['text'] as String;

    final usage = data['usageMetadata'];
    final inputTokens = usage['promptTokenCount'] as int;
    final outputTokens = usage['candidatesTokenCount'] as int;

    return GenerationResult(
      rawResponse: text,
      inputTokens: inputTokens,
      outputTokens: outputTokens,
    );
  }
}

class GenerationResult {
  final String rawResponse;
  final int inputTokens;
  final int outputTokens;

  GenerationResult({
    required this.rawResponse,
    required this.inputTokens,
    required this.outputTokens,
  });

  String? get screenCode {
    final match =
        RegExp(r'<screen_code>([\s\S]*?)</screen_code>').firstMatch(rawResponse);
    return match?.group(1)?.trim();
  }

  String? get kitGaps {
    final match =
        RegExp(r'<kit_gaps>([\s\S]*?)</kit_gaps>').firstMatch(rawResponse);
    return match?.group(1)?.trim();
  }

  bool get hasGaps {
    final gaps = kitGaps;
    return gaps != null && gaps.toUpperCase() != 'NONE';
  }

  double get estimatedCost {
    return (inputTokens * 0.10 / 1000000) + (outputTokens * 0.40 / 1000000);
  }
}
