import 'dart:convert';
import 'dart:io';
import '../models/kit_manifest.dart';
import 'project_paths.dart';

// In-memory cache — manifest only changes when components.json is edited.
// The server must be restarted to pick up manifest changes anyway.
KitManifest? _cached;

Future<KitManifest> loadManifest() async {
  if (_cached != null) return _cached!;
  final file = File(manifestFilePath);
  if (!file.existsSync()) {
    throw Exception('Manifest not found at $manifestFilePath');
  }
  final data = jsonDecode(await file.readAsString()) as Map<String, dynamic>;
  _cached = KitManifest.fromJson(data);
  print('[Manifest] loaded ${_cached!.widgets.length} components (cached)');
  return _cached!;
}

/// Force a reload on next [loadManifest] call (e.g. after a hot component add).
void invalidateManifestCache() => _cached = null;
