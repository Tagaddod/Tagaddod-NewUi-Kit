import 'dart:async';
import 'dart:html' as html;
import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';
import '../models/generation_payload.dart';
import '../services/api_service.dart';
import 'center_panel.dart';
import 'result_panel.dart';
import 'sidebar.dart';

class App extends StatefulComponent {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  static const _stages = [
    'Understanding the requirement',
    'Matching Tagaddod components',
    'Generating Flutter code',
    'Validating and repairing',
    'Rendering live preview',
  ];

  GenerationPayload? _result;
  bool _loading = false;
  bool _arch = false;
  int _stageIdx = 0;
  int _elapsed = 0;
  String _activePrompt = '';
  Timer? _timer;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _applyPrompt(String prompt) {
    final el = html.document.getElementById('prompt-ta') as html.TextAreaElement?;
    if (el != null) {
      el.value = prompt;
      el.dispatchEvent(html.Event('input'));
    }
  }

  void _startProgress(String prompt) {
    _activePrompt = prompt;
    _elapsed = 0;
    _stageIdx = 0;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!mounted || !_loading) return;
      setState(() {
        _elapsed++;
        if (_elapsed % 9 == 0 && _stageIdx < _stages.length - 1) _stageIdx++;
      });
    });
  }

  Future<void> _send(String prompt) async {
    if (prompt.isEmpty || _loading) return;
    setState(() => _loading = true);
    _startProgress(prompt);
    try {
      final res = await ApiService.generate(prompt: prompt, arch: _arch);
      setState(() { _result = res; _loading = false; });
    } catch (_) {
      setState(() => _loading = false);
    }
    _timer?.cancel();
  }

  @override
  Component build(BuildContext context) {
    return div(
      [
        Sidebar(
          arch: _arch,
          onArchChanged: (v) => setState(() => _arch = v),
          onUsePrompt: _applyPrompt,
        ),
        CenterPanel(
          loading: _loading,
          result: _result,
          currentStage: _stages[_stageIdx],
          elapsed: _elapsed,
          activePrompt: _activePrompt,
          onSend: _send,
          onUsePrompt: _applyPrompt,
        ),
        if (_result != null) ResultPanel(result: _result!),
      ],
      classes: 'app-shell',
    );
  }
}
