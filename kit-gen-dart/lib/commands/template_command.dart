import 'dart:io';
import 'package:args/args.dart';
import 'package:mason_logger/mason_logger.dart';
import 'package:kit_gen/data/templates.dart';

class TemplateCommand {
  final Logger logger;

  TemplateCommand(this.logger);

  Future<void> run(List<String> arguments) async {
    final parser = ArgParser()
      ..addOption('name',
          abbr: 'n', help: 'Template name (e.g. login, settings)')
      ..addOption('output', abbr: 'o', help: 'Output file path')
      ..addFlag('list',
          abbr: 'l', help: 'List all available templates');

    final results = parser.parse(arguments);

    if (results['list'] as bool) {
      _listTemplates();
      return;
    }

    final name = results['name'] as String?;
    if (name == null) {
      logger.err('Usage: kit-gen template -n <name> [-o <file>]');
      logger.info('Use --list to see available templates.');
      exit(1);
    }

    final template = screenTemplates[name.toLowerCase()];
    if (template == null) {
      logger.err('Template "$name" not found.');
      _listTemplates();
      exit(1);
    }

    logger.info('');
    logger.success('✓ Template: ${template.name}');
    logger.info(darkGray.wrap(template.description));
    logger.info('');

    if (results['output'] != null) {
      final outputPath = results['output'] as String;
      final file = File(outputPath);
      await file.parent.create(recursive: true);
      await file.writeAsString(template.code);
      logger.success('✓ Saved to: $outputPath');
    } else {
      logger.info(darkGray.wrap('─' * 80));
      logger.info(template.code);
      logger.info(darkGray.wrap('─' * 80));
      logger.detail('💡 Use -o <file> to save');
    }
  }

  void _listTemplates() {
    logger.info('');
    logger.info(lightCyan.wrap('Available Templates:'));
    logger.info('');
    for (final entry in screenTemplates.entries) {
      logger.info(
          '  ${lightGreen.wrap(entry.key.padRight(16))}'
          '${entry.value.description}');
    }
    logger.info('');
    logger.info(
        'Usage: kit-gen template -n <name> -o lib/screens/<name>.dart');
  }
}
