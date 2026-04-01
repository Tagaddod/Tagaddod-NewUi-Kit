import 'dart:convert';
import 'package:http/http.dart' as http;
import '../domain/generation_payload.dart';

class ChatRepository {
  ChatRepository({String? baseUrl})
      : baseUrl = _resolveBaseUrl(baseUrl);

  final String baseUrl;

  Future<GenerationPayload> generate({
    required String prompt,
    required bool arch,
  }) async {
    final uri = Uri.parse('$baseUrl/api/generate');
    final res = await http.post(
      uri,
      headers: {'content-type': 'application/json'},
      body: jsonEncode({'prompt': prompt, 'arch': arch}),
    );
    if (res.statusCode != 200) {
      throw Exception('Failed: ${res.body}');
    }
    return GenerationPayload.fromJson(
      jsonDecode(res.body) as Map<String, dynamic>,
    );
  }

  static String _resolveBaseUrl(String? override) {
    if (override != null && override.trim().isNotEmpty) {
      return override;
    }

    const envBaseUrl = String.fromEnvironment(
      'KIT_GEN_API_BASE_URL',
    );
    if (envBaseUrl.isNotEmpty) return envBaseUrl;

    if (Uri.base.scheme.startsWith('http')) {
      return Uri.base.origin;
    }

    return 'http://localhost:8080';
  }
}
