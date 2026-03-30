import 'dart:io';

class ApiConfig {
  static String? _cachedApiKey;
  
  static String? getApiKey() {
    if (_cachedApiKey != null) return _cachedApiKey;
    
    _cachedApiKey = Platform.environment['GEMINI_API_KEY'];
    
    if (_cachedApiKey == null || _cachedApiKey!.isEmpty) {
      final configFile = File(_getConfigPath());
      if (configFile.existsSync()) {
        final content = configFile.readAsStringSync().trim();
        if (content.isNotEmpty) {
          _cachedApiKey = content;
        }
      }
    }
    
    return _cachedApiKey;
  }
  
  static Future<void> setApiKey(String apiKey) async {
    _cachedApiKey = apiKey;
    
    final configFile = File(_getConfigPath());
    await configFile.parent.create(recursive: true);
    await configFile.writeAsString(apiKey);
  }
  
  static String _getConfigPath() {
    final home = Platform.environment['HOME'] ?? Platform.environment['USERPROFILE'];
    return '$home/.kit-gen/api_key';
  }
  
  static bool hasApiKey() {
    return getApiKey() != null && getApiKey()!.isNotEmpty;
  }
}
