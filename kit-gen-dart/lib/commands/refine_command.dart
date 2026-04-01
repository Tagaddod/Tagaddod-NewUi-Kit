import 'dart:io';
import 'package:args/args.dart';
import 'package:mason_logger/mason_logger.dart';
import 'package:kit_gen/services/gemini_service.dart';
import 'package:kit_gen/services/system_prompt.dart';
import 'package:kit_gen/services/kit_manifest_loader.dart';
import 'package:kit_gen/config/api_config.dart';

class RefineCommand {
  final Logger logger;

  RefineCommand(this.logger);

  Future<void> run(List<String> arguments) async {
    final parser = ArgParser()
      ..addOption('file',
          abbr: 'f', help: 'Path to generated file to refine');

    final results = parser.parse(arguments);
    final filePath = results['file'] as String?;

    if (filePath == null) {
      logger.err('Usage: kit-gen refine -f <file>');
      exit(1);
    }

    final file = File(filePath);
    if (!file.existsSync()) {
      logger.err('File not found: $filePath');
      exit(1);
    }

    final apiKey = ApiConfig.getApiKey();
    if (apiKey == null || apiKey.isEmpty) {
      logger.err('API key not set. Run: kit-gen config set-key');
      exit(1);
    }

    final manifest = await loadKitManifest(logger);
    final systemPrompt = SystemPromptBuilder(manifest).build();
    final gemini = GeminiService(apiKey);
    var currentCode = await file.readAsString();

    logger.info('');
    logger.info(lightCyan.wrap('Interactive refinement mode'));
    logger.info(darkGray.wrap('Type refinement, or "done" to exit.'));
    logger.info('');

    while (true) {
      stdout.write(lightCyan.wrap('> Refine: '));
      final input = stdin.readLineSync();

      if (input == null ||
          input.trim().isEmpty ||
          input.trim().toLowerCase() == 'done') {
        logger.success('Refinement complete.');
        break;
      }

      final progress = logger.progress('Refining...');
      try {
        final prompt = 'Current code:\n```dart\n$currentCode\n```'
            '\n\nRefinement: ${input.trim()}\n\n'
            'Return the FULL updated code.';

        final result =
            await gemini.generateCode(prompt, systemPrompt);
        if (result.screenCode.trim().isEmpty) {
          progress.fail('Empty response — try again.');
          continue;
        }

        currentCode = result.screenCode;
        await file.writeAsString(currentCode);
        progress.complete('Updated ${file.path}');
        logger.detail(
            '📊 ${result.inputTokens} in / '
            '${result.outputTokens} out '
            '(~\$${result.estimatedCost.toStringAsFixed(4)})');
      } catch (e) {
        progress.fail('Refinement failed: $e');
      }
    }
  }
}
