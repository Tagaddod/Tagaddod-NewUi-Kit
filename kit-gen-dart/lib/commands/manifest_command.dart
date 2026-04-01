import 'dart:io';
import 'dart:convert';
import 'package:mason_logger/mason_logger.dart';
import 'package:kit_gen/services/manifest_service.dart';
import 'package:path/path.dart' as path;

class ManifestCommand {
  final Logger logger;

  ManifestCommand(this.logger);

  Future<void> run(List<String> arguments) async {
    final progress = logger.progress('Scanning UI kit source');

    try {
      final kitPath = path.normalize(
          path.join(Directory.current.path, '..'));

      KitManifest? existing;
      final existingFile = File('lib/data/components.json');
      if (existingFile.existsSync()) {
        final json = jsonDecode(await existingFile.readAsString());
        existing = KitManifest.fromJson(json);
        logger.detail(
            'Merging with existing manifest '
            '(${existing.widgets.length} widgets)');
      }

      final service = ManifestService(kitPath);
      final manifest =
          await service.generateManifest(existing: existing);

      final outputDir = Directory('data');
      if (!outputDir.existsSync()) {
        outputDir.createSync(recursive: true);
      }

      final outputFile = File('data/components.json');
      const encoder = JsonEncoder.withIndent('  ');
      await outputFile.writeAsString(encoder.convert(manifest.toJson()));

      progress.complete('Manifest generated!');

      logger.info('');
      logger.success('✓ Found ${manifest.widgets.length} widgets');
      logger.info('  Output: ${outputFile.path}');
      logger.info('');
      logger.info('Widgets:');
      for (final widget in manifest.widgets) {
        final ctors = widget.constructors.isNotEmpty
            ? ' [${widget.constructors.length} constructors]'
            : '';
        logger.info('  • ${widget.className}$ctors');
      }
      logger.info('');
      logger.info(
          'Copy to lib/data for distribution:\n'
          '  cp data/components.json lib/data/components.json');
    } catch (e) {
      progress.fail('Failed to generate manifest');
      logger.err('Error: $e');
      exit(1);
    }
  }
}
