import 'dart:convert';
import 'package:shelf/shelf.dart';
import '../services/manifest_loader.dart';

Future<Response> manifestHandler(Request req) async {
  try {
    final manifest = await loadManifest();
    return Response.ok(
      jsonEncode(manifest.toJson()),
      headers: {'content-type': 'application/json'},
    );
  } catch (e) {
    return Response.internalServerError(
      body: jsonEncode({'error': '$e'}),
      headers: {'content-type': 'application/json'},
    );
  }
}
