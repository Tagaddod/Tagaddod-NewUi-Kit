import 'dart:io';
import 'dart:isolate';
import 'dart:convert';
import 'package:mason_logger/mason_logger.dart';
import 'manifest_service.dart';

Future<KitManifest> loadKitManifest(Logger logger) async {
  final localManifest = File('data/components.json');
  String content;

  if (localManifest.existsSync()) {
    content = await localManifest.readAsString();
  } else {
    final uri =
        Uri.parse('package:kit_gen/data/components.json');
    final resolved = await Isolate.resolvePackageUri(uri);
    if (resolved == null) {
      logger.err('Manifest not found. Reinstall kit-gen.');
      exit(1);
    }
    final file = File.fromUri(resolved);
    if (!file.existsSync()) {
      logger.err('Resolved path missing: ${file.path}');
      exit(1);
    }
    content = await file.readAsString();
  }

  return KitManifest.fromJson(jsonDecode(content));
}
