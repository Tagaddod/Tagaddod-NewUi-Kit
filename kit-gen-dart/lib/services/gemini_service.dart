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
    final model = 'gemini-2.5-flash';
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
        'maxOutputTokens': 8192,
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
    // 1. Properly closed <screen_code> tag
    var match = RegExp(
      r'<screen_code>\s*([\s\S]*?)\s*</screen_code>',
    ).firstMatch(rawResponse);
    if (match != null) return _stripDartFence(match.group(1)!.trim());

    // 2. Unclosed <screen_code> tag — extract everything after it
    //    This handles truncated responses from the model
    final openTagIndex = rawResponse.indexOf('<screen_code>');
    if (openTagIndex != -1) {
      final after = rawResponse.substring(openTagIndex + '<screen_code>'.length);
      // Remove closing tag if partially present
      final cleaned = after.replaceAll(RegExp(r'</screen_code>.*', dotAll: true), '').trim();
      return _stripDartFence(cleaned);
    }

    // 3. Backtick-escaped tags (Gemini sometimes escapes XML in markdown)
    match = RegExp(
      r'`<screen_code>`\s*([\s\S]*?)\s*`</screen_code>`',
    ).firstMatch(rawResponse);
    if (match != null) return _stripDartFence(match.group(1)!.trim());

    // 4. First ```dart code block
    match = RegExp(r'```dart\s*([\s\S]*?)\s*```').firstMatch(rawResponse);
    if (match != null) return match.group(1)!.trim();

    // 5. Raw response if it looks like Dart code
    final trimmed = rawResponse.trim();
    if (trimmed.startsWith('import ') || trimmed.startsWith('//')) {
      return trimmed;
    }

    return null;
  }

  String _stripDartFence(String code) {
    final match = RegExp(r'```(?:dart)?\s*([\s\S]*?)\s*```').firstMatch(code);
    return match?.group(1)?.trim() ?? code;
  }

  String? get kitGaps {
    // Properly closed tag
    var match = RegExp(
      r'<kit_gaps>\s*([\s\S]*?)\s*</kit_gaps>',
    ).firstMatch(rawResponse);
    if (match != null) return match.group(1)!.trim();

    // Backtick-escaped
    match = RegExp(
      r'`<kit_gaps>`\s*([\s\S]*?)\s*`</kit_gaps>`',
    ).firstMatch(rawResponse);
    return match?.group(1)?.trim();
  }

  bool get hasGaps {
    final gaps = kitGaps;
    if (gaps == null || gaps.isEmpty) return false;
    final upper = gaps.toUpperCase().trim();
    return upper != 'NONE' && upper != '// NONE' && upper != '//NONE';
  }

  double get estimatedCost {
    // Gemini 2.5 Flash pricing (March 2026)
    // Input: $0.30 per 1M tokens
    // Output: $2.50 per 1M tokens
    return (inputTokens * 0.30 / 1000000) + (outputTokens * 2.50 / 1000000);
  }
}
