import 'dart:io';
import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf/shelf.dart';
import 'package:shelf_static/shelf_static.dart';
import 'package:path/path.dart' as p;
import 'package:kit_gen_web_server/server_router.dart';
import 'package:kit_gen_web_server/services/preview_harness_service.dart';

Future<void> main() async {
  print('[Server] Warming preview workspace pool...');
  PreviewHarnessService.initializePool(size: 1).catchError((e) {
    print('[Server] Pool warm-up failed (non-fatal): $e');
  });

  // Prefer the Jaspr UI build (ui/build/jaspr); fall back to the Flutter build.
  final jasprBuild = p.normalize(p.join('..', 'ui', 'build', 'jaspr'));
  final flutterBuild = p.normalize(p.join('..', 'app', 'build', 'web'));
  final uiDir = Directory(jasprBuild).existsSync() ? jasprBuild : flutterBuild;
  final staticHandler = Directory(uiDir).existsSync()
      ? createStaticHandler(uiDir, defaultDocument: 'index.html')
      : null;

  final handler = Pipeline()
      .addMiddleware(logRequests())
      .addMiddleware(_cors())
      .addHandler((request) async {
    // Shelf may expose paths as "api/..." or "/api/..." depending on host.
    final path = request.requestedUri.path;
    final apiPrefix = path.startsWith('/api/') || path == '/api' || path.startsWith('api/');
    if (apiPrefix) {
      return buildRouter().call(request);
    }
    if (staticHandler != null) return staticHandler(request);
    return Response.ok(
      'Kit-Gen server is running. Build web app to serve UI.',
      headers: {'content-type': 'text/plain'},
    );
  });

  final server = await io.serve(handler, InternetAddress.anyIPv4, 8080);
  print('Kit-Gen web server on http://localhost:${server.port}');
}

Middleware _cors() {
  return (inner) => (request) async {
        if (request.method == 'OPTIONS') {
          return Response.ok('', headers: _corsHeaders());
        }
        final response = await inner(request);
        return response.change(headers: {...response.headers, ..._corsHeaders()});
      };
}

Map<String, String> _corsHeaders() => {
      'access-control-allow-origin': '*',
      'access-control-allow-methods': 'GET,POST,OPTIONS',
      'access-control-allow-headers': 'content-type,authorization',
    };
