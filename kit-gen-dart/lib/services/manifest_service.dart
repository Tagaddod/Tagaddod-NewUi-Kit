import 'dart:io';
import 'package:path/path.dart' as path;
import 'manifest/widget_info.dart';
import 'manifest/kit_manifest.dart';
import 'manifest/widget_parser.dart';
import 'manifest/widget_merger.dart';

export 'manifest/widget_info.dart';
export 'manifest/kit_manifest.dart';

class ManifestService {
  final String kitPath;
  final _parser = WidgetSignatureParser();

  ManifestService(this.kitPath);

  Future<KitManifest> generateManifest({
    KitManifest? existing,
  }) async {
    final widgetsDir =
        Directory(path.join(kitPath, 'lib', 'widgets'));
    final widgets = <WidgetInfo>[];
    final existingMap = <String, WidgetInfo>{};

    if (existing != null) {
      for (final w in existing.widgets) {
        existingMap[w.className] = w;
      }
    }

    await for (final entity in widgetsDir.list(recursive: true)) {
      if (entity is File && entity.path.endsWith('.dart')) {
        final parsed = await _parseWidgetFile(entity);
        for (final info in parsed) {
          widgets.add(mergeWidgetInfo(info, existingMap[info.className]));
        }
      }
    }

    widgets.sort((a, b) => a.className.compareTo(b.className));
    return KitManifest(
      generatedAt: DateTime.now(),
      kitVersion: '1.0.0',
      packageName: 'tagaddod_ui_kit',
      widgets: widgets,
    );
  }

  Future<List<WidgetInfo>> _parseWidgetFile(File file) async {
    final content = await file.readAsString();
    final results = <WidgetInfo>[];
    final classPattern = RegExp(
      r'class\s+(\w+)\s+extends\s+'
      r'(StatelessWidget|StatefulWidget|FormField)',
    );

    for (final match in classPattern.allMatches(content)) {
      final className = match.group(1)!;
      if (className.startsWith('_')) continue;

      final rel = path.relative(
          file.path, from: path.join(kitPath, 'lib'));
      final ctors =
          _parser.extractConstructors(content, className);

      results.add(WidgetInfo(
        className: className,
        description: '$className component',
        importPath: 'package:tagaddod_ui_kit/$rel',
        example: _parser.buildExample(className, ctors),
        constructors: ctors,
        parameters:
            _parser.extractParameters(content, className),
      ));
    }
    return results;
  }
}
