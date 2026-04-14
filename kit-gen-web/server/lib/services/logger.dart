import 'dart:convert';
import 'dart:io';

/// Structured logger — emits JSON on Cloud Run (K_SERVICE present),
/// human-readable ANSI output in local dev.
class Log {
  static final bool _isCloudRun =
      Platform.environment.containsKey('K_SERVICE');

  static void info(String tag, String msg, [Map<String, dynamic>? fields]) =>
      _emit('INFO', tag, msg, fields);

  static void warn(String tag, String msg, [Map<String, dynamic>? fields]) =>
      _emit('WARNING', tag, msg, fields);

  static void error(String tag, String msg, [Map<String, dynamic>? fields]) =>
      _emit('ERROR', tag, msg, fields, toStderr: true);

  static void generation({
    required String requestId,
    required String event,
    required Map<String, dynamic> data,
    String severity = 'INFO',
  }) {
    _emit(severity, 'GEN:$event', '', {
      'requestId': requestId,
      ...data,
    });
  }

  static void _emit(
    String severity,
    String tag,
    String msg,
    Map<String, dynamic>? fields, {
    bool toStderr = false,
  }) {
    final now = DateTime.now().toUtc().toIso8601String();

    if (_isCloudRun) {
      final payload = <String, dynamic>{
        'severity': severity,
        'time': now,
        'tag': tag,
        if (msg.isNotEmpty) 'message': msg,
        if (fields != null) ...fields,
      };
      final line = jsonEncode(payload);
      if (toStderr) {
        stderr.writeln(line);
      } else {
        stdout.writeln(line);
      }
    } else {
      final color = switch (severity) {
        'WARNING' => '\x1B[33m',
        'ERROR' => '\x1B[31m',
        _ => '\x1B[0m',
      };
      const reset = '\x1B[0m';
      final prefix = '$color[$tag]$reset';
      final extra = fields != null
          ? '\n  ${fields.entries.map((e) => '${e.key}: ${_fmtVal(e.value)}').join('\n  ')}'
          : '';
      final line = '$prefix ${msg.isNotEmpty ? msg : ""}$extra';
      if (toStderr) {
        stderr.writeln(line);
      } else {
        stdout.writeln(line);
      }
    }
  }

  static String _fmtVal(dynamic v) {
    if (v is String && v.length > 400) return '${v.substring(0, 400)}…';
    if (v is List) return '[${v.take(5).join(', ')}${v.length > 5 ? ', …' : ''}]';
    return v.toString();
  }
}
