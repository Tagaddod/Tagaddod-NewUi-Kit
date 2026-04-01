import 'dart:convert';
import 'package:shelf/shelf.dart';
import '../services/manifest_loader.dart';
import '../services/component_retrieval_service.dart';

Future<Response> searchHandler(Request req) async {
  final query = (req.url.queryParameters['q'] ?? '').toLowerCase();
  final manifest = await loadManifest();
  final widgets = query.trim().isEmpty
      ? manifest.widgets
      : ComponentRetrievalService()
          .select(requirement: query, manifest: manifest)
          .detailedWidgets;

  return Response.ok(
    jsonEncode({
      'widgets': widgets.map((widget) => widget.toJson()).toList(),
    }),
    headers: {'content-type': 'application/json'},
  );
}
