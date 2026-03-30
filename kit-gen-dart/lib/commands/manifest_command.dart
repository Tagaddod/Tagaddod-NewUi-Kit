import 'dart:io';
import 'dart:convert';
import 'package:args/args.dart';
import 'package:mason_logger/mason_logger.dart';
import 'package:kit_gen/services/manifest_service.dart';
import 'package:path/path.dart' as path;

class ManifestCommand {
  final Logger logger;

  ManifestCommand(this.logger);

  Future<void> run(List<String> arguments) async {
    final progress = logger.progress('Scanning UI kit');

    try {
      final kitPath = path.normalize(path.join(
        Directory.current.path,
        '..',
      ));

      final manifestService = ManifestService(kitPath);
      final manifest = await manifestService.generateManifest();

      final outputDir = Directory('data');
      if (!outputDir.existsSync()) {
        await outputDir.create(recursive: true);
      }

      final outputFile = File('data/components.json');
      await outputFile.writeAsString(
        JsonEncoder.withIndent('  ').convert(manifest.toJson()),
      );

      progress.complete('Manifest generated!');

      logger.info('');
      logger.success('✓ Found ${manifest.widgets.length} widgets');
      logger.info('  Output: ${outputFile.path}');
      logger.info('');
      logger.info('Widgets:');
      for (final widget in manifest.widgets) {
        logger.info('  • ${widget.className}');
      }
      logger.info('');
    } catch (e) {
      progress.fail('Failed to generate manifest');
      logger.err('Error: $e');
      exit(1);
    }
  }
}
