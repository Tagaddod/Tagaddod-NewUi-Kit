import 'dart:io';
import 'package:mason_logger/mason_logger.dart';
import 'package:kit_gen/services/kit_manifest_loader.dart';

class SearchCommand {
  final Logger logger;
  SearchCommand(this.logger);

  Future<void> run(List<String> arguments) async {
    if (arguments.isEmpty) {
      logger.err('Usage: kit-gen search <query>');
      exit(1);
    }

    final query = arguments.join(' ').toLowerCase();

    try {
      final manifest = await loadKitManifest(logger);

      final results = manifest.widgets.where((w) {
        return w.className.toLowerCase().contains(query) ||
            w.description.toLowerCase().contains(query);
      }).toList();

      if (results.isEmpty) {
        logger.warn('No components matching: "$query"');
        logger.info('Try: button, field, text, icon, modal');
        return;
      }

      logger.info('');
      logger.info(lightBlue.wrap(
          '🔍 Found ${results.length} component(s) for "$query"'));
      logger.info(darkGray.wrap('─' * 80));

      for (final w in results) {
        logger.info('');
        logger.info(styleBold.wrap(w.className));
        logger.info(w.description);
        logger.detail('Import: ${w.importPath}');
        logger.info('');
        logger.info(lightCyan.wrap('Example:'));
        logger.info(w.example);
        logger.info(darkGray.wrap('─' * 80));
      }
      logger.info('');
    } catch (e) {
      logger.err('Error: $e');
      exit(1);
    }
  }
}
