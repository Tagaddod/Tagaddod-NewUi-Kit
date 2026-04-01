#!/usr/bin/env dart

import 'dart:io';
import 'package:kit_gen/commands/generate_command.dart';
import 'package:kit_gen/commands/info_command.dart';
import 'package:kit_gen/commands/manifest_command.dart';
import 'package:kit_gen/commands/search_command.dart';
import 'package:kit_gen/commands/config_command.dart';
import 'package:kit_gen/commands/refine_command.dart';
import 'package:kit_gen/commands/template_command.dart';
import 'package:kit_gen/cli/usage.dart';
import 'package:mason_logger/mason_logger.dart';

void main(List<String> arguments) async {
  final logger = Logger();

  if (arguments.isEmpty) {
    printKitGenUsage(logger);
    exit(0);
  }

  final command = arguments[0];
  final rest = arguments.skip(1).toList();

  try {
    switch (command) {
      case 'generate' || 'gen':
        await GenerateCommand(logger).run(rest);
      case 'refine':
        await RefineCommand(logger).run(rest);
      case 'template' || 'tpl':
        await TemplateCommand(logger).run(rest);
      case 'info':
        await InfoCommand(logger).run(rest);
      case 'manifest':
        await ManifestCommand(logger).run(rest);
      case 'search':
        await SearchCommand(logger).run(rest);
      case 'config':
        await ConfigCommand(logger).run(rest);
      case 'help' || '--help' || '-h':
        printKitGenUsage(logger);
      case 'version' || '--version':
        logger.info('kit-gen version 2.0.0');
      default:
        logger.err('Unknown command: $command');
        printKitGenUsage(logger);
        exit(1);
    }
  } catch (e) {
    logger.err('Error: $e');
    exit(1);
  }
}
