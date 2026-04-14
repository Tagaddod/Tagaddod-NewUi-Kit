import '../models/preview_job_workspace.dart';
import 'workspace_factory.dart';

class WarmWorkspacePool {
  final int size;
  final _available = <PreviewJobWorkspace>[];

  WarmWorkspacePool({this.size = 2});

  bool get hasAvailable => _available.isNotEmpty;
  int get availableCount => _available.length;

  Future<void> initialize() async {
    final results = await Future.wait(
      List.generate(size, (_) => _tryCreate()),
      eagerError: false,
    );
    for (final ws in results) {
      if (ws != null) _available.add(ws);
    }
    print('[WarmWorkspacePool] Ready: ${_available.length}/$size workspaces warmed.');
  }

  PreviewJobWorkspace? tryAcquire() {
    if (_available.isEmpty) return null;
    final ws = _available.removeAt(0);
    _replenishAsync();
    return ws;
  }

  void replenish() => _replenishAsync();

  void _replenishAsync() {
    _tryCreate().then((ws) {
      if (ws != null) _available.add(ws);
    });
  }

  Future<PreviewJobWorkspace?> _tryCreate() async {
    try {
      return await WorkspaceFactory.create();
    } catch (e) {
      print('[WarmWorkspacePool] Failed to create workspace: $e');
      return null;
    }
  }
}
