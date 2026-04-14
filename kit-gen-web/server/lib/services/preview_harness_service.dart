import 'dart:async';
import 'dart:io';
import '../models/preview_job_workspace.dart';
import '../models/preview_result.dart';
import 'warm_workspace_pool.dart';
import 'workspace_factory.dart';

class PreviewHarnessService {
  static WarmWorkspacePool? _pool;

  static Future<void> initializePool({int size = 2}) async {
    _pool = WarmWorkspacePool(size: size);
    await _pool!.initialize();
  }

  Future<PreviewJobWorkspace> createWorkspace() async =>
      _pool?.tryAcquire() ?? await WorkspaceFactory.create();

  Future<List<String>> analyze(PreviewJobWorkspace workspace) async {
    final result = await Process.run(
      'flutter',
      ['analyze', '--no-pub', 'lib/generated/generated_preview_screen.dart'],
      workingDirectory: workspace.directory.path,
    );
    if (result.exitCode == 0) return const [];
    final combined = '${result.stdout}\n${result.stderr}'.trim();
    print('[analyze] flutter analyze exit=${result.exitCode}\n$combined\n---');
    return _extractErrors(combined);
  }

  /// Writes code is already on disk (written by _validateSingleScreen).
  /// Explicitly trigger hot-reload so the running flutter web-server picks up
  /// the file change immediately, then wait for DDC recompilation.
  Future<PreviewResult> renderLive(PreviewJobWorkspace workspace) async {
    await workspace.hotReload();
    await Future.delayed(const Duration(seconds: 6));
    final url = 'http://localhost:${workspace.previewerPort}/';
    Timer(const Duration(minutes: 5), () {
      workspace.dispose();
      _pool?.replenish();
    });
    return PreviewResult.livePreview(previewUrl: url);
  }

  static List<String> _extractErrors(String output) {
    final lines = output
        .split('\n')
        .map((l) => l.trim())
        .where((l) => l.isNotEmpty)
        .toList();

    // flutter analyze exits 1 even for info-only passes.
    // Never trigger a repair for info-only lints — they are NOT compile errors.
    final hasActualError = lines.any(
        (l) => l.contains(' error • ') || l.startsWith('error •'));
    final hasWarning = lines.any(
        (l) => l.contains(' warning • ') || l.startsWith('warning •'));
    if (!hasActualError && !hasWarning) return const [];

    // Grab error-level lines.
    final errorLines = lines
        .where((l) => l.contains(' error • ') || l.startsWith('error •'))
        .take(15)
        .toList();
    if (errorLines.isNotEmpty) return errorLines;

    // Warning-level lines (may still block compilation in strict mode).
    final warnLines = lines
        .where((l) => l.contains(' warning • ') || l.startsWith('warning •'))
        .take(15)
        .toList();
    if (warnLines.isNotEmpty) return warnLines;

    // Broad net for unlabeled compile-time failures.
    return lines
        .where(
          (l) =>
              l.contains('Exception') ||
              l.contains('Failed assertion') ||
              l.startsWith('Error:') ||
              l.contains("isn't defined") ||
              l.contains('No named parameter') ||
              l.contains("can't be assigned") ||
              l.contains('Too few positional') ||
              l.contains('Too many positional') ||
              l.contains('Undefined name') ||
              l.contains('Undefined class'),
        )
        .take(15)
        .toList();
  }
}
