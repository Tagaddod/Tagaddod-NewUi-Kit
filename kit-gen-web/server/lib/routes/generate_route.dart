import 'dart:convert';
import 'dart:io';
import 'package:shelf/shelf.dart';
import '../services/generation_workflow_service.dart';
import '../services/logger.dart';

Future<Response> generateHandler(Request req) async {
  final sw = Stopwatch()..start();
  try {
    final key = Platform.environment['GEMINI_API_KEY'] ?? '';
    if (key.isEmpty) {
      Log.error('API', 'GEMINI_API_KEY is missing');
      return _bad('GEMINI_API_KEY is missing');
    }

    final body = jsonDecode(await req.readAsString()) as Map<String, dynamic>;
    final prompt = (body['prompt'] as String? ?? '').trim();
    final arch = body['arch'] as bool? ?? false;
    final contextCode = body['contextCode'] as String?;
    if (prompt.isEmpty) return _bad('prompt is required');

    Log.info('API', 'POST /api/generate', {
      'mode': arch ? 'arch' : 'single',
      'promptLength': prompt.length,
    });

    final workflow = GenerationWorkflowService(key);
    final result = await workflow.generate(
      requirement: prompt,
      arch: arch,
      contextCode: contextCode,
    );

    Log.info('API', 'POST /api/generate → 200', {
      'totalMs': sw.elapsedMilliseconds,
      'validationPassed': result.validation.passed,
      'previewStatus': result.preview.status,
    });

    return Response.ok(
      jsonEncode(result.toJson()),
      headers: {'content-type': 'application/json'},
    );
  } catch (e, st) {
    Log.error('API', 'POST /api/generate → 500', {
      'error': e.toString(),
      'stackTrace': st.toString().substring(0, st.toString().length.clamp(0, 800)),
      'totalMs': sw.elapsedMilliseconds,
    });
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
