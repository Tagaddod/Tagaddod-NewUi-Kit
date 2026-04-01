import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart' as p;
import '../models/preview_result.dart';
import 'project_paths.dart';

class PreviewJobWorkspace {
  final Directory directory;
  final File generatedScreenFile;
  final File previewFile;
  bool dependenciesReady = false;

  PreviewJobWorkspace({
    required this.directory,
    required this.generatedScreenFile,
    required this.previewFile,
  });

  Future<void> writeCode(String code) async {
    await generatedScreenFile.parent.create(recursive: true);
    await generatedScreenFile.writeAsString(code);
  }

  Future<void> dispose({bool keep = false}) async {
    if (keep || !directory.existsSync()) return;
    await directory.delete(recursive: true);
  }
}

class PreviewHarnessService {
  static const previewWidth = 900;
  static const previewHeight = 1200;

  Future<PreviewJobWorkspace> createWorkspace() async {
    final templateDir = Directory(previewHarnessTemplateDir);
    if (!templateDir.existsSync()) {
      throw Exception(
        'Preview harness template not found at '
        '$previewHarnessTemplateDir',
      );
    }

    final workspaceDir =
        await Directory.systemTemp.createTemp('kit_gen_preview_');
    await _copyDirectory(templateDir, workspaceDir);

    final pubspec = File(p.join(workspaceDir.path, 'pubspec.yaml'));
    final pubspecContent = await pubspec.readAsString();
    await pubspec.writeAsString(
      pubspecContent.replaceAll(
        '{{UI_KIT_PATH}}',
        repoRoot,
      ),
    );

    return PreviewJobWorkspace(
      directory: workspaceDir,
      generatedScreenFile: File(
        p.join(
          workspaceDir.path,
          'lib',
          'generated',
          'generated_preview_screen.dart',
        ),
      ),
      previewFile: File(
        p.join(workspaceDir.path, 'preview_output', 'preview.png'),
      ),
    );
  }

  Future<List<String>> analyze(PreviewJobWorkspace workspace) async {
    final dependencyErrors = await _ensureDependencies(workspace);
    if (dependencyErrors.isNotEmpty) return dependencyErrors;

    final result = await Process.run(
      'flutter',
      [
        'analyze',
        '--no-pub',
        'lib/generated/generated_preview_screen.dart',
      ],
      workingDirectory: workspace.directory.path,
    );

    if (result.exitCode == 0) return const [];
    return _extractIssues(
      '${result.stdout}\n${result.stderr}',
      fallback: 'Generated screen failed static validation.',
    );
  }

  Future<PreviewResult> render(
    PreviewJobWorkspace workspace,
  ) async {
    final dependencyErrors = await _ensureDependencies(workspace);
    if (dependencyErrors.isNotEmpty) {
      return PreviewResult.failed(
        message: dependencyErrors.join('\n'),
      );
    }

    final result = await Process.run(
      'flutter',
      [
        'test',
        '--no-pub',
        '--update-goldens',
        'test/render_test.dart',
      ],
      workingDirectory: workspace.directory.path,
    );

    if (result.exitCode != 0) {
      return PreviewResult.failed(
        message: _extractIssues(
          '${result.stdout}\n${result.stderr}',
          fallback: 'Flutter preview rendering failed.',
        ).join('\n'),
      );
    }

    if (!workspace.previewFile.existsSync()) {
      return PreviewResult.failed(
        message: 'Preview image was not produced by the harness.',
      );
    }

    final base64Image = base64Encode(
      await workspace.previewFile.readAsBytes(),
    );

    return PreviewResult.rendered(
      imageBase64: base64Image,
      width: previewWidth,
      height: previewHeight,
      message: 'Real Flutter preview rendered from the generated screen.',
    );
  }

  Future<List<String>> _ensureDependencies(
    PreviewJobWorkspace workspace,
  ) async {
    if (workspace.dependenciesReady) return const [];

    final result = await Process.run(
      'flutter',
      ['pub', 'get'],
      workingDirectory: workspace.directory.path,
    );

    if (result.exitCode != 0) {
      return _extractIssues(
        '${result.stdout}\n${result.stderr}',
        fallback: 'Preview harness dependencies failed to resolve.',
      );
    }

    workspace.dependenciesReady = true;
    return const [];
  }

  Future<void> _copyDirectory(
    Directory source,
    Directory destination,
  ) async {
    await for (final entity in source.list(recursive: true)) {
      final relative = p.relative(entity.path, from: source.path);
      final targetPath = p.join(destination.path, relative);

      if (entity is Directory) {
        await Directory(targetPath).create(recursive: true);
        continue;
      }

      if (entity is File) {
        await File(targetPath).parent.create(recursive: true);
        await entity.copy(targetPath);
      }
    }
  }

  List<String> _extractIssues(
    String output, {
    required String fallback,
  }) {
    final lines = output
        .split('\n')
        .map((line) => line.trim())
        .where((line) => line.isNotEmpty)
        .where(
          (line) =>
              line.contains(' error • ') ||
              line.contains(' warning • ') ||
              line.contains('Exception') ||
              line.contains('TestFailure') ||
              line.startsWith('Error:') ||
              line.contains('Failed assertion') ||
              line.contains('isn\'t defined') ||
              line.contains('No named parameter'),
        )
        .take(12)
        .toList();

    if (lines.isNotEmpty) return lines;
    return [fallback];
  }
}
