import 'dart:io';
import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf/shelf.dart';
import 'package:shelf_static/shelf_static.dart';
import 'package:path/path.dart' as p;
import 'package:kit_gen_web_server/server_router.dart';

Future<void> main() async {
  final appBuild = p.normalize(p.join('..', 'app', 'build', 'web'));
  final appDir = Directory(appBuild);
  final staticHandler = appDir.existsSync()
      ? createStaticHandler(appBuild, defaultDocument: 'index.html')
      : null;

  final handler = Pipeline()
      .addMiddleware(logRequests())
      .addMiddleware(_cors())
      .addHandler((request) async {
    if (request.url.path.startsWith('api/')) {
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
  return (inner) {
    return (request) async {
      if (request.method == 'OPTIONS') {
        return Response.ok('', headers: _corsHeaders());
      }
      final response = await inner(request);
      return response.change(headers: {...response.headers, ..._corsHeaders()});
    };
  };
}

Map<String, String> _corsHeaders() => {
      'access-control-allow-origin': '*',
      'access-control-allow-methods': 'GET,POST,OPTIONS',
      'access-control-allow-headers': 'content-type,authorization',
    };
