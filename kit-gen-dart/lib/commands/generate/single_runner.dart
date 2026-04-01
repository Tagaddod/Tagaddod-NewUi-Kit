import 'dart:io';
import 'package:args/args.dart';
import 'package:mason_logger/mason_logger.dart';
import 'package:kit_gen/services/gemini_service.dart';
import 'output_handler.dart';

Future<void> runSingleGeneration(
  Logger logger,
  GeminiService gemini,
  String systemPrompt,
  String requirement,
  ArgResults results, {
  required bool verbose,
  required bool shouldRetry,
}) async {
  final progress = logger.progress('Generating Flutter code');

  try {
    var result =
        await gemini.generateCode(requirement, systemPrompt);

    if (shouldRetry && result.screenCode.trim().isEmpty) {
      progress.update('Retrying with strict prompt...');
      result = await gemini.generateCode(
        '$requirement\n\nIMPORTANT: Follow constructor rules '
        'strictly. Return COMPLETE code, not just imports.',
        systemPrompt,
      );
    }

    progress.complete('Code generated!');
    printVerbose(logger, result, verbose);
    printResult(logger, result);
    saveOutput(logger, results, result, requirement);
    runValidation(logger, results);
  } catch (e) {
    progress.fail('Generation failed');
    logger.err('Error: $e');
    exit(1);
  }
}
