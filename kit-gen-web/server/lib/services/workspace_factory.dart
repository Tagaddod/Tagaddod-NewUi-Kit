import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:path/path.dart' as p;
import '../models/preview_job_workspace.dart';
import 'project_paths.dart' show previewHarnessTemplateDir, uiKitPackagePath;

class WorkspaceFactory {
  static final _random = Random();

  static Future<PreviewJobWorkspace> create() async {
    final templateDir = Directory(previewHarnessTemplateDir);
    if (!templateDir.existsSync()) {
      throw Exception('Preview harness template not found at $previewHarnessTemplateDir');
    }

    final workspaceDir = await Directory.systemTemp.createTemp('kit_gen_preview_');
    await _copyDirectory(templateDir, workspaceDir);

    final pubspec = File(p.join(workspaceDir.path, 'pubspec.yaml'));
    await pubspec.writeAsString(
      (await pubspec.readAsString())
          .replaceAll('{{UI_KIT_PATH}}', uiKitPackagePath),
    );

    final pubGet = await Process.run(
      'flutter', ['pub', 'get'],
      workingDirectory: workspaceDir.path,
    );
    if (pubGet.exitCode != 0) {
      await workspaceDir.delete(recursive: true);
      throw Exception('pub get failed: ${pubGet.stderr}');
    }

    // --machine: structured JSON output so we can parse the launch URL and appId.
    // -d web-server: serves the Flutter app without opening a browser.
    // --web-port 0: let the OS pick a free port.
    final process = await Process.start(
      'flutter',
      ['run', '--machine', '-d', 'web-server', '--web-port', '0'],
      workingDirectory: workspaceDir.path,
    );

    final info = await _captureStartupInfo(process).timeout(
      const Duration(seconds: 120),
      onTimeout: () => throw Exception('flutter run web-server timed out'),
    );

    return PreviewJobWorkspace(
      sessionId: _generateId(),
      directory: workspaceDir,
      generatedScreenFile: File(
        p.join(workspaceDir.path, 'lib', 'generated', 'generated_preview_screen.dart'),
      ),
      previewerPort: info.port,
      appId: info.appId,
      previewerProcess: process,
    );
  }

  /// Parses the flutter run --machine stdout stream to extract:
  ///   • the web launch URL  → port
  ///   • the machine appId   → needed for the hot-reload JSON command
  static Future<_StartupInfo> _captureStartupInfo(Process process) {
    final completer = Completer<_StartupInfo>();
    final buffer = StringBuffer();

    int? port;
    String? appId;

    void tryComplete() {
      if (port != null && appId != null && !completer.isCompleted) {
        completer.complete(_StartupInfo(port: port!, appId: appId!));
      }
    }

    process.stdout.transform(utf8.decoder).listen((chunk) {
      buffer.write(chunk);
      final text = buffer.toString();

      // URL event: {"event":"app.webLaunchUrl","params":{"url":"http://localhost:PORT",...}}
      if (port == null) {
        final m = RegExp(r'"url":"http://localhost:(\d+)"').firstMatch(text);
        if (m != null) {
          port = int.parse(m.group(1)!);
          tryComplete();
        }
      }

      // appId appears in app.start / app.started events
      if (appId == null) {
        final m = RegExp(r'"appId":"([^"]+)"').firstMatch(text);
        if (m != null) {
          appId = m.group(1)!;
          tryComplete();
        }
      }
    });

    process.stderr.transform(utf8.decoder).listen((line) {
      if (line.trim().isNotEmpty) print('[preview-run] $line');
    });

    return completer.future;
  }

  static String _generateId() =>
      '${DateTime.now().millisecondsSinceEpoch}-${_random.nextInt(9000) + 1000}';

  static Future<void> _copyDirectory(Directory source, Directory dest) async {
    await for (final entity in source.list(recursive: true)) {
      final rel = p.relative(entity.path, from: source.path);
      final target = p.join(dest.path, rel);
      if (entity is Directory) {
        await Directory(target).create(recursive: true);
      } else if (entity is File) {
        await File(target).parent.create(recursive: true);
        await entity.copy(target);
      }
    }
  }
}

class _StartupInfo {
  final int port;
  final String appId;
  const _StartupInfo({required this.port, required this.appId});
}
