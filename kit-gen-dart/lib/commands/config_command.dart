import 'dart:io';
import 'package:mason_logger/mason_logger.dart';
import 'package:kit_gen/config/api_config.dart';

class ConfigCommand {
  final Logger logger;

  ConfigCommand(this.logger);

  Future<void> run(List<String> arguments) async {
    if (arguments.isEmpty) {
      _showCurrentConfig();
      return;
    }

    final subcommand = arguments[0];

    switch (subcommand) {
      case 'set-key':
        await _setApiKey(arguments.skip(1).toList());
        break;
      case 'show':
        _showCurrentConfig();
        break;
      default:
        logger.err('Unknown config command: $subcommand');
        logger.info('Usage: kit-gen config [set-key|show]');
        exit(1);
    }
  }

  Future<void> _setApiKey(List<String> arguments) async {
    String? apiKey;

    if (arguments.isNotEmpty) {
      apiKey = arguments[0];
    } else {
      logger.info('');
      logger.info('Enter your Gemini API key:');
      logger.detail('Get it from: https://aistudio.google.com/apikey');
      logger.info('');
      stdout.write('API Key: ');
      apiKey = stdin.readLineSync();
    }

    if (apiKey == null || apiKey.trim().isEmpty) {
      logger.warn('Cancelled.');
      exit(0);
    }

    await ApiConfig.setApiKey(apiKey.trim());
    
    logger.info('');
    logger.success('✓ API key saved successfully!');
    logger.info('');
    logger.detail('Saved to: ${_getConfigPath()}');
    logger.info('');
    logger.info('You can now run: kit-gen gen -i');
    logger.info('');
  }

  void _showCurrentConfig() {
    logger.info('');
    logger.info(lightBlue.wrap('⚙️  Kit-Gen Configuration'));
    logger.info('');
    logger.info(darkGray.wrap('─' * 80));

    if (ApiConfig.hasApiKey()) {
      final key = ApiConfig.getApiKey()!;
      final masked = '${key.substring(0, 8)}...${key.substring(key.length - 4)}';
      logger.info('API Key:  ${lightGreen.wrap('✓ Set')} ($masked)');
      logger.info('Location: ${_getConfigPath()}');
    } else {
      logger.info('API Key:  ${yellow.wrap('✗ Not set')}');
      logger.info('');
      logger.info('To set your API key:');
      logger.info('  kit-gen config set-key');
      logger.info('');
      logger.info('Or:');
      logger.info('  export GEMINI_API_KEY=your_key');
    }

    logger.info(darkGray.wrap('─' * 80));
    logger.info('');
  }

  String _getConfigPath() {
    final home = Platform.environment['HOME'] ?? Platform.environment['USERPROFILE'];
    return '$home/.kit-gen/api_key';
  }
}
