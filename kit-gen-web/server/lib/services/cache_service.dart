import 'dart:convert';
import 'package:http/http.dart' as http;

/// Manages a single Gemini explicit context cache for the stable system
/// prompt (rules + full component manifest).
///
/// Auto-invalidates when the prompt content changes (hash-based), and
/// refreshes before TTL expiry.  Falls back gracefully to no-cache mode
/// on any error (e.g. free-tier accounts that don't support caching).
class CacheService {
  static const _base = 'https://generativelanguage.googleapis.com/v1beta';
  static const _model = 'models/gemini-2.5-flash';
  static const _ttlSeconds = 3600; // 1 hour

  final String _apiKey;
  String? _name;
  DateTime? _expiresAt;
  String? _promptHash;

  CacheService(this._apiKey);

  /// Returns the active cache name, or `null` if caching is unavailable.
  String? get activeName {
    if (_name == null || _expiresAt == null) return null;
    final ttlOk = DateTime.now()
        .isBefore(_expiresAt!.subtract(const Duration(minutes: 10)));
    return ttlOk ? _name : null;
  }

  /// Ensures a valid cache exists for [systemPrompt].
  /// If the prompt content has changed since the last cache, the old cache
  /// is deleted and a new one is created.
  /// Returns the cache name, or `null` on failure.
  Future<String?> ensure(String systemPrompt) async {
    final hash = _fingerprint(systemPrompt);

    // Prompt changed → invalidate stale cache immediately.
    if (_name != null && _promptHash != null && _promptHash != hash) {
      print('[CacheService] prompt changed — invalidating old cache: $_name');
      unawaited(_delete(_name!));
      _name = null;
      _expiresAt = null;
      _promptHash = null;
    }

    if (activeName != null) return activeName;
    return _create(systemPrompt, hash);
  }

  Future<String?> _create(String systemPrompt, String hash) async {
    try {
      final res = await http.post(
        Uri.parse('$_base/cachedContents?key=$_apiKey'),
        headers: {'content-type': 'application/json'},
        body: jsonEncode({
          'model': _model,
          'system_instruction': {
            'parts': [
              {'text': systemPrompt},
            ],
          },
          'ttl': '${_ttlSeconds}s',
        }),
      );
      if (res.statusCode != 200) {
        print('[CacheService] create failed (${res.statusCode}) — no-cache mode');
        return null;
      }
      final data = jsonDecode(res.body) as Map<String, dynamic>;
      _name = data['name'] as String;
      _expiresAt = DateTime.now().add(const Duration(seconds: _ttlSeconds));
      _promptHash = hash;
      final tokens = data['usageMetadata']?['totalTokenCount'] ?? '?';
      print('[CacheService] created: $_name  tokens=$tokens  hash=$hash  ttl=${_ttlSeconds}s');
      return _name;
    } catch (e) {
      print('[CacheService] error: $e — no-cache mode');
      return null;
    }
  }

  Future<void> _delete(String name) async {
    try {
      await http.delete(Uri.parse('$_base/$name?key=$_apiKey'));
      print('[CacheService] deleted stale cache: $name');
    } catch (_) {}
  }

  /// Stable, runtime-consistent fingerprint of the prompt content.
  /// Uses length + sampled char codes — no external dependency needed.
  static String _fingerprint(String s) {
    final len = s.length;
    if (len == 0) return '0_0';
    var sum = 0;
    final step = len ~/ 40;
    for (var i = 0; i < len; i += step == 0 ? 1 : step) {
      sum = (sum * 31 + s.codeUnitAt(i)) & 0xFFFFFFFF;
    }
    return '${len}_${sum.toRadixString(16)}';
  }
}

void unawaited(Future<void> f) {}
