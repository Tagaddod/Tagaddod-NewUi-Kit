import 'dart:convert';
import 'dart:io';
import 'package:shelf/shelf.dart';
import '../services/generation_workflow_service.dart';

Future<Response> generateHandler(Request req) async {
  try {
    final key = Platform.environment['GEMINI_API_KEY'] ?? '';
    if (key.isEmpty) return _bad('GEMINI_API_KEY is missing');

    final body = jsonDecode(await req.readAsString()) as Map<String, dynamic>;
    final prompt = (body['prompt'] as String? ?? '').trim();
    final arch = body['arch'] as bool? ?? false;
    final contextCode = body['contextCode'] as String?;
    if (prompt.isEmpty) return _bad('prompt is required');

    final workflow = GenerationWorkflowService(key);
    final result = await workflow.generate(
      requirement: prompt,
      arch: arch,
      contextCode: contextCode,
    );

    return Response.ok(
      jsonEncode(result.toJson()),
      headers: {'content-type': 'application/json'},
    );
  } catch (e) {
    return Response.internalServerError(
      body: jsonEncode({'error': '$e'}),
      headers: {'content-type': 'application/json'},
    );
  }
}

Response _bad(String m) => Response(
      400,
      body: jsonEncode({'error': m}),
      headers: {'content-type': 'application/json'},
    );
