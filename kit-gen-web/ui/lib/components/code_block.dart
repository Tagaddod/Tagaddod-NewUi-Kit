import 'dart:html' as html;
import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';

class CodeBlock extends StatefulComponent {
  final String filename;
  final String code;
  const CodeBlock({required this.filename, required this.code, super.key});

  @override
  State<CodeBlock> createState() => _CodeBlockState();
}

class _CodeBlockState extends State<CodeBlock> {
  bool _copied = false;

  void _copy() {
    html.window.navigator.clipboard?.writeText(component.code);
    setState(() => _copied = true);
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) setState(() => _copied = false);
    });
  }

  @override
  Component build(BuildContext context) {
    return div(
      [
        div(
          [
            span([Component.text(component.filename)]),
            button(
              [Component.text(_copied ? '✓ Copied' : 'Copy')],
              classes: 'copy-btn${_copied ? ' copied' : ''}',
              onClick: _copy,
            ),
          ],
          classes: 'code-header',
        ),
        pre([
          code(
            [Component.text(component.code)],
            classes: 'language-dart',
          ),
        ]),
      ],
      classes: 'code-block',
    );
  }
}
