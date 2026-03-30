import 'dart:io';
import 'dart:convert';
import 'package:args/args.dart';
import 'package:mason_logger/mason_logger.dart';
import 'package:kit_gen/services/manifest_service.dart';
import 'package:kit_gen/data/embedded_manifest.dart';

class InfoCommand {
  final Logger logger;

  InfoCommand(this.logger);

  Future<void> run(List<String> arguments) async {
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

      logger.info('');
      logger.info(lightBlue.wrap('📦 Tagaddod UI Kit Information'));
      logger.info('');
      logger.info(darkGray.wrap('─' * 80));
      logger.info('Package:        ${manifest.packageName}');
      logger.info('Version:        ${manifest.kitVersion}');
      logger.info('Total Widgets:  ${manifest.widgets.length}');
      logger.info(
          'Last Updated:   ${manifest.generatedAt.toLocal().toString().split('.')[0]}');
      logger.info(darkGray.wrap('─' * 80));

      logger.info('');
      logger.info(lightBlue.wrap('📋 Available Widgets:'));
      logger.info('');

      final categories = _categorizeWidgets(manifest.widgets);

      for (final entry in categories.entries) {
        if (entry.value.isNotEmpty) {
          logger.info(lightCyan.wrap('  ${entry.key}:'));
          for (final widget in entry.value) {
            logger.info('    • ${widget.className}');
          }
          logger.info('');
        }
      }
    } catch (e) {
      logger.err('Error: $e');
      exit(1);
    }
  }

  Map<String, List<WidgetInfo>> _categorizeWidgets(List<WidgetInfo> widgets) {
    final categories = <String, List<WidgetInfo>>{
      'Buttons': [],
      'Inputs': [],
      'Navigation': [],
      'Indicators': [],
      'Layout': [],
      'Other': [],
    };

    for (final widget in widgets) {
      final name = widget.className;

      if (name.contains('Button')) {
        categories['Buttons']!.add(widget);
      } else if (name.contains('TextField') ||
          name.contains('CheckBox') ||
          name.contains('Radio') ||
          name.contains('Switch')) {
        categories['Inputs']!.add(widget);
      } else if (name.contains('Navigation') ||
          name.contains('AppBar') ||
          name.contains('Tab')) {
        categories['Navigation']!.add(widget);
      } else if (name.contains('Progress') ||
          name.contains('Indicator') ||
          name.contains('Badge') ||
          name.contains('Stepper')) {
        categories['Indicators']!.add(widget);
      } else if (name.contains('Container') ||
          name.contains('Divider') ||
          name.contains('Expandable')) {
        categories['Layout']!.add(widget);
      } else {
        categories['Other']!.add(widget);
      }
    }

    return categories;
  }
}
