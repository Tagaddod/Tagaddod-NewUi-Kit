import 'dart:convert';
import 'dart:io';

class PreviewJobWorkspace {
  final String sessionId;
  final Directory directory;
  final File generatedScreenFile;
  final int previewerPort;
  final String appId;
  final Process previewerProcess;
  bool dependenciesReady;

  PreviewJobWorkspace({
    required this.sessionId,
    required this.directory,
    required this.generatedScreenFile,
    required this.previewerPort,
    required this.appId,
    required this.previewerProcess,
    this.dependenciesReady = true,
  });

  Future<void> writeCode(String code) async {
    await generatedScreenFile.parent.create(recursive: true);
    await generatedScreenFile.writeAsString(code);
  }

  /// Sends a hot-reload via the flutter run --machine JSON protocol.
  /// This is equivalent to pressing 'r' in the terminal when NOT in machine mode.
  Future<void> hotReload() async {
    try {
      final cmd = jsonEncode([
        {
          'id': 1,
          'method': 'app.restart',
          'params': {'appId': appId, 'fullRestart': false},
        }
      ]);
      previewerProcess.stdin.writeln(cmd);
      await previewerProcess.stdin.flush();
      print('[preview-run] hot-reload triggered for appId=$appId');
    } catch (e) {
      print('[preview-run] hot-reload failed: $e');
    }
  }

  Future<void> dispose({bool keep = false}) async {
    previewerProcess.kill();
    if (!keep && directory.existsSync()) {
      await directory.delete(recursive: true);
    }
  }
}
