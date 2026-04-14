import 'dart:html' as html;
import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';

class PromptInput extends StatefulComponent {
  final bool loading;
  final void Function(String) onSend;

  const PromptInput({required this.loading, required this.onSend, super.key});

  @override
  State<PromptInput> createState() => _PromptInputState();
}

class _PromptInputState extends State<PromptInput> {
  bool _hasText = false;
  html.EventListener? _keyListener;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      _keyListener = (html.Event e) {
        if (e is html.KeyboardEvent && e.key == 'Enter' && !e.shiftKey) {
          e.preventDefault();
          _send();
        }
      };
      html.document.getElementById('prompt-ta')?.addEventListener('keydown', _keyListener!);
    });
  }

  @override
  void dispose() {
    if (_keyListener != null) {
      html.document.getElementById('prompt-ta')?.removeEventListener('keydown', _keyListener!);
    }
    super.dispose();
  }

  void _send() {
    final el = html.document.getElementById('prompt-ta') as html.TextAreaElement?;
    final text = el?.value?.trim() ?? '';
    if (text.isEmpty || component.loading) return;
    el?.value = '';
    setState(() => _hasText = false);
    component.onSend(text);
  }

  @override
  Component build(BuildContext context) {
    return div(
      [
        div(
          [
            textarea(
              [],
              id: 'prompt-ta',
              placeholder: 'Describe the screen you want to build…',
              rows: 3,
              classes: 'prompt-textarea',
              onInput: (String value) =>
                  setState(() => _hasText = value.trim().isNotEmpty),
            ),
            div(
              [
                span(
                  [Component.text('Enter ↵ to send · Shift+Enter for new line')],
                  classes: 'prompt-hint',
                ),
                button(
                  [
                    span([Component.text('↑')], classes: 'send-btn-icon'),
                    Component.text(
                        component.loading ? 'Generating…' : 'Generate'),
                  ],
                  classes: 'send-btn',
                  disabled: !_hasText || component.loading,
                  onClick: _send,
                ),
              ],
              classes: 'prompt-footer',
            ),
          ],
          classes: 'prompt-inner',
        ),
      ],
      classes: 'prompt-bar',
    );
  }
}
