import 'dart:io';
import 'package:path/path.dart' as p;
import 'project_paths.dart';

/// Maps enum name → ordered list of value names.
typedef EnumCatalog = Map<String, List<String>>;

/// Maps class name → ordered list of static-const field names.
typedef ConstCatalog = Map<String, List<String>>;

class KitScanResult {
  final EnumCatalog enums;
  final ConstCatalog consts;

  const KitScanResult({required this.enums, required this.consts});

  static const empty = KitScanResult(enums: {}, consts: {});
}

// In-memory cache — kit source only changes when new widgets are added.
KitScanResult? _cached;

/// Scans key UI-kit source files to extract exact enum values and asset
/// constant names. Result is cached after the first call.
/// Falls back to [KitScanResult.empty] on any error.
Future<KitScanResult> scanKitSource() async {
  if (_cached != null) return _cached!;
  try {
    final lib = p.join(repoRoot, 'lib');
    final enums = <String, List<String>>{};
    final consts = <String, List<String>>{};

    await _extractEnums(p.join(lib, 'utils', 'button_type.dart'), enums);
    await _extractEnums(p.join(lib, 'widgets', 'app_badge.dart'), enums);
    await _extractConsts(p.join(lib, 'assests', 'assets.dart'), 'AppAssets', consts);

    print('[KitEnumScanner] enums=${enums.keys.toList()} consts=${consts.keys.toList()} (cached)');
    _cached = KitScanResult(enums: enums, consts: consts);
    return _cached!;
  } catch (e) {
    print('[KitEnumScanner] WARNING: scan failed ($e) — using fallback values');
    return KitScanResult.empty;
  }
}

/// Force a re-scan on next call (e.g. after a new kit widget is added).
void invalidateKitScanCache() => _cached = null;

// ── helpers ─────────────────────────────────────────────────────────────────

final _enumRe = RegExp(r'enum\s+(\w+)\s*\{([^}]+)\}');
final _identRe = RegExp(r'^\w+$');
final _constRe = RegExp(r'static\s+const\s+\w+\s+(\w+)\s*=');

Future<void> _extractEnums(String path, EnumCatalog out) async {
  final f = File(path);
  if (!f.existsSync()) return;
  final src = await f.readAsString();
  for (final m in _enumRe.allMatches(src)) {
    final name = m.group(1)!;
    final values = m
        .group(2)!
        .split(',')
        .map((v) => v.trim().split('//').first.trim())
        .where((v) => v.isNotEmpty && _identRe.hasMatch(v))
        .toList();
    if (values.isNotEmpty) out[name] = values;
  }
}

Future<void> _extractConsts(String path, String cls, ConstCatalog out) async {
  final f = File(path);
  if (!f.existsSync()) return;
  final src = await f.readAsString();
  final names = _constRe.allMatches(src).map((m) => m.group(1)!).toList();
  if (names.isNotEmpty) out[cls] = names;
}
