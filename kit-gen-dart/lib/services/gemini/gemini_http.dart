import 'dart:convert';
import 'package:http/http.dart' as http;

const geminiModel = 'gemini-2.5-flash';
const geminiBaseUrl =
    'https://generativelanguage.googleapis.com/v1beta/models';

Future<Map<String, dynamic>> callGemini({
  required String apiKey,
  required String requirement,
  required String systemPrompt,
  required Map<String, Object> schema,
}) async {
  final url = Uri.parse(
      '$geminiBaseUrl/$geminiModel:generateContent?key=$apiKey');

  final body = {
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
      'responseSchema': schema,
    },
  };

  final response = await http.post(
    url,
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode(body),
  );

  if (response.statusCode != 200) {
    throw Exception(
        'Gemini API error: ${response.statusCode} - '
        '${response.body}');
  }

  return jsonDecode(response.body) as Map<String, dynamic>;
}

String extractText(Map<String, dynamic> data) =>
    data['candidates'][0]['content']['parts'][0]['text']
        as String;

(int, int) extractUsage(Map<String, dynamic> data) {
  final u = data['usageMetadata'];
  return (
    u['promptTokenCount'] as int,
    u['candidatesTokenCount'] as int,
  );
}
