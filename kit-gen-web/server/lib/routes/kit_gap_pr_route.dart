import 'dart:convert';
import 'package:shelf/shelf.dart';
import '../models/kit_gap.dart';
import '../services/github_service.dart';

/// POST /api/kit-gaps/pr
/// Body: { "gaps": [...] }
/// Creates a GitHub PR for the provided kit gaps on demand.
/// Returns: { "prUrl": "https://..." } or { "error": "..." }
Future<Response> kitGapPrHandler(Request request) async {
  try {
    final body = jsonDecode(await request.readAsString()) as Map<String, dynamic>;
    final rawGaps = body['gaps'] as List<dynamic>?;
    if (rawGaps == null || rawGaps.isEmpty) {
      return _json({'error': 'No gaps provided.'}, 400);
    }

    final gaps = rawGaps
        .cast<Map<String, dynamic>>()
        .map(KitGap.fromJson)
        .toList();

    final prUrl = await GitHubService.createKitGapPR(gaps);
    if (prUrl == null) {
      return _json({
        'error': 'PR creation failed. Check that GITHUB_TOKEN is set and has repo scope.',
      }, 500);
    }
    return _json({'prUrl': prUrl});
  } catch (e) {
    return _json({'error': '$e'}, 500);
  }
}

Response _json(Map<String, dynamic> body, [int status = 200]) => Response(
      status,
      body: jsonEncode(body),
      headers: {'content-type': 'application/json'},
    );
