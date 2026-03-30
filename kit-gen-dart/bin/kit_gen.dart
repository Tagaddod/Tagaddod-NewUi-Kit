#!/usr/bin/env dart

import 'dart:io';
import 'package:args/args.dart';
import 'package:kit_gen/commands/generate_command.dart';
import 'package:kit_gen/commands/info_command.dart';
import 'package:kit_gen/commands/manifest_command.dart';
import 'package:kit_gen/commands/search_command.dart';
import 'package:kit_gen/commands/config_command.dart';
import 'package:mason_logger/mason_logger.dart';

void main(List<String> arguments) async {
  final logger = Logger();

  final parser = ArgParser()
    ..addFlag('help', abbr: 'h', negatable: false, help: 'Show help')
    ..addFlag('version', abbr: 'v', negatable: false, help: 'Show version');

  if (arguments.isEmpty) {
    _printUsage(logger);
    exit(0);
  }

  final command = arguments[0];

  try {
    switch (command) {
      case 'generate':
      case 'gen':
        await GenerateCommand(logger).run(arguments.skip(1).toList());
        break;
      case 'info':
        await InfoCommand(logger).run(arguments.skip(1).toList());
        break;
      case 'manifest':
        await ManifestCommand(logger).run(arguments.skip(1).toList());
        break;
      case 'search':
        await SearchCommand(logger).run(arguments.skip(1).toList());
        break;
      case 'config':
        await ConfigCommand(logger).run(arguments.skip(1).toList());
        break;
      case 'help':
      case '--help':
      case '-h':
        _printUsage(logger);
        break;
      case 'version':
      case '--version':
      case '-v':
        logger.info('kit-gen version 1.0.0');
        break;
      default:
        logger.err('Unknown command: $command');
        _printUsage(logger);
        exit(1);
    }
  } catch (e) {
    logger.err('Error: $e');
    exit(1);
  }
}

void _printUsage(Logger logger) {
  logger.info('''
${lightCyan.wrap('Kit-Gen')} - AI-powered Flutter code generator

${styleBold.wrap('Usage:')}
  kit-gen <command> [options]

${styleBold.wrap('Commands:')}
  generate, gen    Generate Flutter code from requirement
  config           Configure API key
  info             Show UI kit information
  manifest         Regenerate component manifest
  search           Search for components
  help             Show this help message

${styleBold.wrap('Examples:')}
  kit-gen gen -r "Create a login screen"
  kit-gen gen -i
  kit-gen info
  kit-gen search button

${styleBold.wrap('Options:')}
  -h, --help       Show help
  -v, --version    Show version

${styleBold.wrap('Quick Start:')}
  1. Install: dart pub global activate kit_gen
  2. Set API key: kit-gen config set-key
  3. Generate: kit-gen gen -i
  4. Use the code!

${styleBold.wrap('Documentation:')}
  cat START-HERE.md    5-minute overview
  cat QUICKSTART.md    3-minute setup
  cat WORKFLOW.md      Daily usage guide
''');
}
