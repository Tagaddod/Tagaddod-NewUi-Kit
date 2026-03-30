import 'dart:io';
import 'dart:convert';
import 'package:args/args.dart';
import 'package:mason_logger/mason_logger.dart';
import 'package:kit_gen/services/manifest_service.dart';
import 'package:kit_gen/data/embedded_manifest.dart';

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
      // Try to load manifest from file, fallback to embedded
      String manifestContent;
      
      final manifestFile = File('data/components.json');
      if (manifestFile.existsSync()) {
        manifestContent = await manifestFile.readAsString();
      } else {
        manifestContent = embeddedManifest;
      }

      final manifestJson = jsonDecode(manifestContent);
      final manifest = KitManifest.fromJson(manifestJson);

      final results = manifest.widgets.where((widget) {
        final nameMatch = widget.className.toLowerCase().contains(query);
        final descMatch = widget.description.toLowerCase().contains(query);
        return nameMatch || descMatch;
      }).toList();

      if (results.isEmpty) {
        logger.warn('No components found matching: "$query"');
        logger.info('');
        logger.info('Try searching for:');
        logger.detail('  button, field, text, icon');
        logger.detail('  navigation, modal, dialog');
        logger.detail('  progress, indicator, badge');
        logger.info('');
        return;
      }

      logger.info('');
      logger.info(
          lightBlue.wrap('🔍 Found ${results.length} component(s) matching: "$query"'));
      logger.info('');
      logger.info(darkGray.wrap('─' * 80));

      for (final widget in results) {
        logger.info('');
        logger.info(styleBold.wrap(widget.className));
        logger.info(widget.description);
        logger.detail('Import: ${widget.importPath}');
        logger.info('');
        logger.info(lightCyan.wrap('Example:'));
        logger.info(widget.example);
        logger.info(darkGray.wrap('─' * 80));
      }

      logger.info('');
    } catch (e) {
      logger.err('Error: $e');
      exit(1);
    }
  }
}
