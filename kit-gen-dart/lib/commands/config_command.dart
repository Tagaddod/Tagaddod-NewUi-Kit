import 'dart:io';
import 'package:mason_logger/mason_logger.dart';
import 'package:kit_gen/config/api_config.dart';

class ConfigCommand {
  final Logger logger;
  ConfigCommand(this.logger);

  Future<void> run(List<String> arguments) async {
    if (arguments.isEmpty) {
      _showConfig();
      return;
    }
    switch (arguments[0]) {
      case 'set-key':
        await _setApiKey(arguments.skip(1).toList());
      case 'show':
        _showConfig();
      default:
        logger.err('Unknown: ${arguments[0]}');
        logger.info('Usage: kit-gen config [set-key|show]');
        exit(1);
    }
  }

  Future<void> _setApiKey(List<String> args) async {
    String? apiKey;
    if (args.isNotEmpty) {
      apiKey = args[0];
    } else {
      logger.info('');
      logger.info('Enter your Gemini API key:');
      logger.detail('Get it: https://aistudio.google.com/apikey');
      stdout.write('\nAPI Key: ');
      apiKey = stdin.readLineSync();
    }
    if (apiKey == null || apiKey.trim().isEmpty) {
      logger.warn('Cancelled.');
      exit(0);
    }
    await ApiConfig.setApiKey(apiKey.trim());
    logger.info('');
    logger.success('✓ API key saved!');
    logger.info('You can now run: kit-gen gen -i');
  }

  void _showConfig() {
    logger.info('');
    logger.info(lightBlue.wrap('⚙️  Kit-Gen Configuration'));
    logger.info(darkGray.wrap('─' * 80));
    if (ApiConfig.hasApiKey()) {
      final key = ApiConfig.getApiKey()!;
      final masked =
          '${key.substring(0, 8)}...${key.substring(key.length - 4)}';
      logger.info('API Key: ${lightGreen.wrap('✓ Set')} ($masked)');
    } else {
      logger.info('API Key: ${yellow.wrap('✗ Not set')}');
      logger.info('  kit-gen config set-key');
      logger.info('  export GEMINI_API_KEY=your_key');
    }
    logger.info(darkGray.wrap('─' * 80));
    logger.info('');
  }
}
