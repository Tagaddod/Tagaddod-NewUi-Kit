import 'dart:convert';
import 'dart:io';
import '../models/kit_manifest.dart';
import 'project_paths.dart';

Future<KitManifest> loadManifest() async {
  final file = File(manifestFilePath);
  if (!file.existsSync()) {
    throw Exception('Manifest not found at $manifestFilePath');
  }
  final data = jsonDecode(await file.readAsString()) as Map<String, dynamic>;
  return KitManifest.fromJson(data);
}
