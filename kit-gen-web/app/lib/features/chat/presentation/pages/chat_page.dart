import 'package:flutter/material.dart';
import 'dart:async';
import '../../data/chat_repository.dart';
import '../../domain/chat_message.dart';
import '../widgets/chat_input_bar.dart';
import '../widgets/generation_progress_widget.dart';
import '../widgets/message_bubble.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({
    super.key,
    this.repository,
  });

  final ChatRepository? repository;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late final ChatRepository _chat;
  final _controller = TextEditingController();
  final _messages = <ChatMessage>[];
  final _scroll = ScrollController();
  var _loading = false;
  var _arch = false;
  var _stageIndex = 0;
  var _elapsed = 0;
  String _activePrompt = '';
  Timer? _timer;

  static const _stages = [
    'Understanding the requirement',
    'Matching Tagaddod UI kit components',
    'Generating Flutter screen code',
    'Validating and repairing output',
    'Rendering the real preview',
  ];

  @override
  void initState() {
    super.initState();
    _chat = widget.repository ?? ChatRepository();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _scroll.dispose();
    _controller.dispose();
    super.dispose();
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
        if (_elapsed % 3 == 0 && _stageIndex < _stages.length - 1) {
          _stageIndex++;
        }
      });
    });
  }

  void _stopProgress() {
    _timer?.cancel();
    _timer = null;
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_scroll.hasClients) return;
      _scroll.animateTo(
        _scroll.position.maxScrollExtent,
        duration: const Duration(milliseconds: 280),
        curve: Curves.easeOut,
      );
    });
  }

  Future<void> _send() async {
    final text = _controller.text.trim();
    if (text.isEmpty || _loading) return;

    setState(() {
      _messages.add(ChatMessage.user(text));
      _loading = true;
      _controller.clear();
    });
    _startProgress(text);
    _scrollToBottom();

    try {
      final res = await _chat.generate(prompt: text, arch: _arch);
      setState(() {
        _messages.add(ChatMessage.generated(res));
        _loading = false;
      });
      _stopProgress();
      _scrollToBottom();
    } catch (e) {
      setState(() {
        _messages.add(ChatMessage.error('Error: $e'));
        _loading = false;
      });
      _stopProgress();
      _scrollToBottom();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFF6F1E8),
              Color(0xFFEDE2D2),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1180),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(18, 18, 18, 14),
                child: Column(
                  children: [
                    _ChatHeader(
                      arch: _arch,
                      onArchChanged: (value) {
                        setState(() => _arch = value);
                      },
                    ),
                    const SizedBox(height: 16),
                    Expanded(
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.72),
                          borderRadius: BorderRadius.circular(28),
                          border: Border.all(
                            color: const Color(0x1C000000),
                          ),
                        ),
                        child: _messages.isEmpty && !_loading
                            ? const _EmptyState()
                            : ListView.builder(
                                controller: _scroll,
                                padding: const EdgeInsets.all(18),
                                itemCount:
                                    _messages.length + (_loading ? 1 : 0),
                                itemBuilder: (_, i) {
                                  if (i >= _messages.length) {
                                    return GenerationProgressWidget(
                                      prompt: _activePrompt,
                                      stage: _stages[_stageIndex],
                                      elapsedSeconds: _elapsed,
                                    );
                                  }
                                  return MessageBubble(
                                    message: _messages[i],
                                  );
                                },
                              ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    ChatInputBar(
                      controller: _controller,
                      onSend: _send,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ChatHeader extends StatelessWidget {
  const _ChatHeader({
    required this.arch,
    required this.onArchChanged,
  });

  final bool arch;
  final ValueChanged<bool> onArchChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Kit-Gen',
                style: Theme.of(context).textTheme.displaySmall?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
              ),
              const SizedBox(height: 6),
              Text(
                'Turn product requirements into Tagaddod UI kit code and a board-friendly preview.',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
        ),
        const SizedBox(width: 16),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 8,
          ),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.78),
            borderRadius: BorderRadius.circular(999),
            border: Border.all(color: const Color(0x18000000)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.account_tree_outlined, size: 18),
              const SizedBox(width: 10),
              const Text('Architecture mode'),
              const SizedBox(width: 8),
              Switch(value: arch, onChanged: onArchChanged),
            ],
          ),
        ),
      ],
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(28),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 780),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: const Color(0xFFFDF8F2),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: const Icon(
                  Icons.auto_awesome_outlined,
                  size: 36,
                ),
              ),
              const SizedBox(height: 18),
              Text(
                'Describe a screen. Show the board what it would look like.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
              ),
              const SizedBox(height: 10),
              Text(
                'Kit-Gen grounds the result in your Tagaddod UI kit, returns the code, and leads with a preview that non-technical stakeholders can understand instantly.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 22),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                alignment: WrapAlignment.center,
                children: const [
                  _IntroChip(label: 'Real Preview First'),
                  _IntroChip(label: 'Tagaddod Components'),
                  _IntroChip(label: 'Gap Recommendations'),
                  _IntroChip(label: 'Developer View'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _IntroChip extends StatelessWidget {
  const _IntroChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: const Color(0x16000000)),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelLarge?.copyWith(
              fontWeight: FontWeight.w700,
            ),
      ),
    );
  }
}
