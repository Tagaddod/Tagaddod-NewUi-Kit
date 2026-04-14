import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/generation_payload.dart';

class ApiService {
  static String get _base {
    const env = String.fromEnvironment('KIT_GEN_API_BASE_URL');
    if (env.isNotEmpty) return env;
    final uri = Uri.base;
    if (uri.scheme.startsWith('http')) return uri.origin;
    return 'http://localhost:8080';
  }

  static Future<GenerationPayload> generate({
    required String prompt,
    required bool arch,
  }) async {
    final res = await http.post(
      Uri.parse('$_base/api/generate'),
      headers: {'content-type': 'application/json'},
      body: jsonEncode({'prompt': prompt, 'arch': arch}),
    );
    if (res.statusCode != 200) {
      throw Exception('Generation failed (${res.statusCode}): ${res.body}');
    }
    return GenerationPayload.fromJson(
      jsonDecode(res.body) as Map<String, dynamic>,
    );
  }
}
