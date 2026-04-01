import 'dart:io';
import 'package:mason_logger/mason_logger.dart';
import 'package:kit_gen/services/kit_manifest_loader.dart';
import 'info/widget_categorizer.dart';

class InfoCommand {
  final Logger logger;
  InfoCommand(this.logger);

  Future<void> run(List<String> arguments) async {
    try {
      final manifest = await loadKitManifest(logger);

      logger.info('');
      logger.info(lightBlue.wrap('📦 Tagaddod UI Kit Information'));
      logger.info('');
      logger.info(darkGray.wrap('─' * 80));
      logger.info('Package:        ${manifest.packageName}');
      logger.info('Version:        ${manifest.kitVersion}');
      logger.info('Total Widgets:  ${manifest.widgets.length}');
      logger.info(
          'Last Updated:   '
          '${manifest.generatedAt.toLocal().toString().split('.')[0]}');
      logger.info(darkGray.wrap('─' * 80));

      logger.info('');
      logger.info(lightBlue.wrap('📋 Available Widgets:'));
      logger.info('');

      final categories = categorizeWidgets(manifest.widgets);
      for (final entry in categories.entries) {
        if (entry.value.isNotEmpty) {
          logger.info(lightCyan.wrap('  ${entry.key}:'));
          for (final w in entry.value) {
            logger.info('    • ${w.className}');
          }
          logger.info('');
        }
      }
    } catch (e) {
      logger.err('Error: $e');
      exit(1);
    }
  }
}
