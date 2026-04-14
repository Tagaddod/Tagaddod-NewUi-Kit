import 'dart:io';
import 'package:path/path.dart' as p;

String get _scriptDir =>
    p.dirname(File.fromUri(Platform.script).path);

String get repoRoot => _findRepoRoot();

/// Path for `tagaddod_ui_kit` in preview workspaces (`path:` in pubspec).
/// In Docker, [KIT_GEN_UI_KIT_PATH] points at a flat copy of lib/ assets/
/// fonts/ + pubspec so Flutter always resolves assets (independent of
/// monorepo discovery).
String get uiKitPackagePath =>
    Platform.environment['KIT_GEN_UI_KIT_PATH'] ?? repoRoot;

String get kitGenWebRoot => p.join(repoRoot, 'kit-gen-web');

String get serverRoot => p.join(kitGenWebRoot, 'server');

String get manifestFilePath => p.join(
      repoRoot,
      'kit-gen-dart',
      'lib',
      'data',
      'components.json',
    );

String get previewHarnessTemplateDir =>
    p.join(kitGenWebRoot, 'preview_harness');

String _findRepoRoot() {
  final seeds = [_scriptDir, Directory.current.path];

  for (final seed in seeds) {
    var current = p.normalize(seed);
    while (true) {
      final hasKitGenDart =
          Directory(p.join(current, 'kit-gen-dart')).existsSync();
      final hasKitGenWeb =
          Directory(p.join(current, 'kit-gen-web')).existsSync();
      if (hasKitGenDart && hasKitGenWeb) {
        return current;
      }

      final parent = p.dirname(current);
      if (parent == current) break;
      current = parent;
    }
  }

  throw Exception('Unable to resolve repository root.');
}
