import 'dart:io';
import 'dart:isolate';
import 'package:args/args.dart';
import 'package:mason_logger/mason_logger.dart';
import 'package:kit_gen/services/gemini_service.dart';
import 'package:kit_gen/services/manifest_service.dart';
import 'package:kit_gen/services/system_prompt.dart';
import 'package:kit_gen/config/api_config.dart';
import 'dart:convert';
import 'package:path/path.dart' as path;

class GenerateCommand {
  final Logger logger;

  GenerateCommand(this.logger);

  Future<void> run(List<String> arguments) async {
    final parser = ArgParser()
      ..addOption('requirement',
          abbr: 'r', help: 'Requirement text', mandatory: false)
      ..addOption('output', abbr: 'o', help: 'Output file path')
      ..addFlag('interactive', abbr: 'i', help: 'Interactive mode');

    final results = parser.parse(arguments);

    final apiKey = ApiConfig.getApiKey();
    if (apiKey == null || apiKey.isEmpty) {
      logger.err('API key not configured');
      logger.info('');
      logger.info('Set your API key:');
      logger.info('  kit-gen config set-key');
      logger.info('');
      logger.info('Or set environment variable:');
      logger.info('  export GEMINI_API_KEY=your_key');
      logger.info('');
      logger.info('Get FREE key: https://aistudio.google.com/apikey');
      exit(1);
    }

    String? requirement = results['requirement'];

    if (requirement == null || results['interactive']) {
      logger.info('');
      logger.info(lightCyan.wrap('Describe the screen/feature you want to build:'));
      requirement = stdin.readLineSync();

      if (requirement == null || requirement.trim().isEmpty) {
        logger.warn('Cancelled.');
        exit(0);
      }
    }

    logger.info('');
    logger.info(lightBlue.wrap('📋 Requirement:'));
    logger.detail(requirement);
    logger.info('');

    final progress = logger.progress('Generating Flutter code');

    try {
      // Load manifest using package: URI resolution
      String manifestContent;
      
      // Try local file first (for development)
      final localManifest = File('data/components.json');
      if (localManifest.existsSync()) {
        manifestContent = await localManifest.readAsString();
      } else {
        // Resolve package resource using Isolate.resolvePackageUri
        final manifestUri = Uri.parse('package:kit_gen/data/components.json');
        final resolvedUri = await Isolate.resolvePackageUri(manifestUri);
        
        if (resolvedUri == null) {
          progress.fail('Manifest not found');
          logger.err('Could not resolve package:kit_gen/data/components.json');
          logger.info('');
          logger.info('Please reinstall kit-gen:');
          logger.info('  dart pub global activate --source git https://github.com/Tagaddod/Tagaddod-NewUi-Kit.git --git-path kit-gen-dart');
          exit(1);
        }
        
        final manifestFile = File.fromUri(resolvedUri);
        if (!manifestFile.existsSync()) {
          progress.fail('Manifest file not found');
          logger.err('Resolved path does not exist: ${manifestFile.path}');
          exit(1);
        }
        
        manifestContent = await manifestFile.readAsString();
      }

      final manifestJson = jsonDecode(manifestContent);
      final manifest = KitManifest.fromJson(manifestJson);

      final promptBuilder = SystemPromptBuilder(manifest);
      final systemPrompt = promptBuilder.build();

      final gemini = GeminiService(apiKey);
      final result = await gemini.generateCode(requirement, systemPrompt);

      progress.complete('Code generated!');

      logger.info('');
      logger.info(lightGreen.wrap('✓ Generated Screen Code:'));
      logger.info('');
      logger.info(darkGray.wrap('─' * 80));
      final code = result.screenCode;
      if (code != null) {
        logger.info(code);
      } else {
        logger.warn('Could not parse structured response. Raw output:');
        logger.info('');
        logger.info(result.rawResponse);
      }
      logger.info(darkGray.wrap('─' * 80));

      if (result.hasGaps) {
        logger.info('');
        logger.warn('⚠ Kit Gaps Detected:');
        logger.info('');
        logger.info(darkGray.wrap('─' * 80));
        logger.info(result.kitGaps ?? '');
        logger.info(darkGray.wrap('─' * 80));
        logger.info('');
        logger.warn(
            '💡 These components should be added to the UI kit before using this code.');
        logger.info('');
      } else {
        logger.info('');
        logger.success('✓ No kit gaps — all components exist in the kit!');
        logger.info('');
      }

      final cost = result.estimatedCost;
      logger.detail(
          '📊 Usage: ${result.inputTokens} input, ${result.outputTokens} output tokens (~\$${cost.toStringAsFixed(4)})');

      if (results['output'] != null) {
        final outputPath = results['output'] as String;
        final file = File(outputPath);
        await file.parent.create(recursive: true);

        final content = StringBuffer();
        content.writeln('// Generated by kit-gen');
        content.writeln('// Requirement: $requirement');
        content.writeln('');
        content.write(result.screenCode ?? result.rawResponse);

        if (result.hasGaps) {
          content.writeln('');
          content.writeln('');
          content.writeln('/*');
          content.writeln('=== KIT GAPS DETECTED ===');
          content.writeln('');
          content.writeln(result.kitGaps);
          content.writeln('*/');
        }

        await file.writeAsString(content.toString());
        logger.info('');
        logger.success('✓ Saved to: $outputPath');
      } else {
        logger.info('');
        logger.detail('💡 Tip: Use -o <file> to save the output');
      }

      logger.info('');
    } catch (e) {
      progress.fail('Generation failed');
      logger.err('Error: $e');
      exit(1);
    }
  }
}
