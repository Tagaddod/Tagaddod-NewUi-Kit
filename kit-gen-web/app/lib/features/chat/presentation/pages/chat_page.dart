import 'dart:async';
import 'package:flutter/material.dart';
import '../../data/chat_repository.dart';
import '../../domain/generation_payload.dart';
import '../widgets/background_orb.dart';
import '../widgets/center_panel.dart';
import '../widgets/control_rail.dart';
import '../widgets/result/result_detail_panel.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key, this.repository});
  final ChatRepository? repository;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  static const _stages = [
    'Understanding the requirement',
    'Matching Tagaddod components',
    'Generating Flutter code',
    'Validating and repairing',
    'Rendering live preview',
  ];

  late final ChatRepository _chat;
  final _controller = TextEditingController();
  GenerationPayload? _latest;
  var _loading = false;
  var _arch = false;
  var _stageIndex = 0;
  var _elapsed = 0;
  String _activePrompt = '';
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _chat = widget.repository ?? ChatRepository();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  void _applyPrompt(String prompt, {bool send = false}) {
    _controller.text = prompt;
    _controller.selection = TextSelection.collapsed(offset: prompt.length);
    if (send) unawaited(_send()); else setState(() {});
  }

  void _startProgress(String prompt) {
    _activePrompt = prompt;
    _elapsed = 0;
    _stageIndex = 0;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!mounted || !_loading) return;
      setState(() {
        _elapsed++;
        if (_elapsed % 9 == 0 && _stageIndex < _stages.length - 1) _stageIndex++;
      });
    });
  }

  Future<void> _send() async {
    final text = _controller.text.trim();
    if (text.isEmpty || _loading) return;
    setState(() { _loading = true; _controller.clear(); });
    _startProgress(text);
    try {
      final res = await _chat.generate(prompt: text, arch: _arch);
      setState(() { _latest = res; _loading = false; });
    } catch (e) {
      setState(() { _loading = false; });
    }
    _timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(color: Color(0xFFF0E8DC)),
        child: Stack(
          children: [
            const Positioned(top: -160, left: -100,
              child: BackgroundOrb(color: Color(0xFFFFD6B7), size: 340)),
            const Positioned(right: -120, top: 80,
              child: BackgroundOrb(color: Color(0xFFDFE0FF), size: 300)),
            const Positioned(bottom: -100, right: 200,
              child: BackgroundOrb(color: Color(0xFFD4EFE0), size: 260)),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: LayoutBuilder(builder: _buildLayout),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLayout(BuildContext context, BoxConstraints constraints) {
    final wide = constraints.maxWidth >= 900;
    final center = CenterPanel(
      controller: _controller,
      loading: _loading,
      latest: _latest,
      activePrompt: _activePrompt,
      currentStage: _stages[_stageIndex],
      elapsedSeconds: _elapsed,
      arch: _arch,
      onSend: _send,
      onUsePrompt: _applyPrompt,
    );

    if (!wide) return center;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(
          width: 220,
          child: ControlRail(
            arch: _arch,
            onArchChanged: (v) => setState(() => _arch = v),
            onUsePrompt: _applyPrompt,
          ),
        ),
        const SizedBox(width: 14),
        Expanded(child: center),
        if (_latest != null) ...[
          const SizedBox(width: 14),
          SizedBox(
            width: 300,
            child: ResultDetailPanel(result: _latest!),
          ),
        ],
      ],
    );
  }
}
