import 'dart:convert';
import 'package:http/http.dart' as http;

class ImagenService {
  ImagenService(this.apiKey);
  final String apiKey;

  Future<String?> generateMockup({
    required String prompt,
    required String generatedCode,
  }) async {
    final uri = Uri.parse(
      'https://generativelanguage.googleapis.com/v1beta/models/imagen-4.0-fast-generate-001:predict',
    );
    final visualPrompt = '''
Create a clean mobile app screenshot mockup based on this product requirement:
$prompt

Use this generated Flutter screen code as layout guidance:
$generatedCode

Important style constraints:
- modern enterprise Flutter app look
- neutral background, clear spacing, readable typography
- realistic mobile frame composition
- no watermark text
- no random decorative elements
''';
    final body = {
      'instances': [
        {'prompt': visualPrompt}
      ],
      'parameters': {'sampleCount': 1, 'aspectRatio': '9:16'}
    };

    final res = await http.post(
      uri,
      headers: {'x-goog-api-key': apiKey, 'content-type': 'application/json'},
      body: jsonEncode(body),
    );
    if (res.statusCode != 200) return null;

    final map = jsonDecode(res.body) as Map<String, dynamic>;
    final preds = map['predictions'] as List<dynamic>?;
    if (preds == null || preds.isEmpty) return null;
    return preds.first['bytesBase64Encoded'] as String?;
  }
}
