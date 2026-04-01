import 'dart:io';
import 'package:args/args.dart';
import 'package:mason_logger/mason_logger.dart';
import 'package:kit_gen/services/gemini_service.dart';
import 'package:kit_gen/services/system_prompt.dart';
import 'package:kit_gen/services/kit_manifest_loader.dart';
import 'package:kit_gen/config/api_config.dart';
import 'generate/single_runner.dart';
import 'generate/arch_runner.dart';

class GenerateCommand {
  final Logger logger;
  GenerateCommand(this.logger);

  Future<void> run(List<String> arguments) async {
    final parser = ArgParser()
      ..addOption('requirement', abbr: 'r')
      ..addOption('output', abbr: 'o')
      ..addOption('context', abbr: 'c')
      ..addFlag('interactive', abbr: 'i')
      ..addFlag('verbose')
      ..addFlag('retry')
      ..addFlag('arch')
      ..addFlag('validate');

    final results = parser.parse(arguments);
    final verbose = results['verbose'] as bool;
    final shouldRetry = results['retry'] as bool;
    final arch = results['arch'] as bool;
    final apiKey = _requireApiKey();
    final requirement = _resolveRequirement(results);

    logger.info('');
    logger.info(lightBlue.wrap('📋 Requirement:'));
    logger.detail(requirement);
    logger.info('');

    final manifest = await loadKitManifest(logger);
    final builder = SystemPromptBuilder(manifest);

    String? ctx;
    if (results['context'] != null) {
      final f = File(results['context'] as String);
      ctx = f.existsSync() ? f.readAsStringSync() : null;
    }

    final prompt = arch
        ? builder.buildArch(contextCode: ctx)
        : builder.build(contextCode: ctx);
    final gemini = GeminiService(apiKey);

    if (arch) {
      await runArchGeneration(logger, gemini, prompt,
          requirement, results,
          verbose: verbose, shouldRetry: shouldRetry);
    } else {
      await runSingleGeneration(logger, gemini, prompt,
          requirement, results,
          verbose: verbose, shouldRetry: shouldRetry);
    }
  }

  String _requireApiKey() {
    final key = ApiConfig.getApiKey();
    if (key == null || key.isEmpty) {
      logger.err('API key not configured');
      logger.info('  kit-gen config set-key');
      exit(1);
    }
    return key;
  }

  String _resolveRequirement(ArgResults results) {
    var req = results['requirement'] as String?;
    if (req == null || results['interactive']) {
      logger.info('');
      logger.info(lightCyan.wrap(
          'Describe the screen/feature to build:'));
      req = stdin.readLineSync();
      if (req == null || req.trim().isEmpty) {
        logger.warn('Cancelled.');
        exit(0);
      }
    }
    return req;
  }
}
