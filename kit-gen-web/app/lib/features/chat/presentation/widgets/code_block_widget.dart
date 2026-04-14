import 'package:flutter/material.dart';
import 'package:flutter_highlight/flutter_highlight.dart';
import 'package:flutter_highlight/themes/github.dart';
import '../../../../core/widgets/copy_button.dart';

class CodeBlockWidget extends StatelessWidget {
  const CodeBlockWidget({super.key, required this.code, this.title});
  final String code;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: const Color(0xFF17181C),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFF2C2E34)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 28,
            offset: Offset(0, 18),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(16, 14, 12, 14),
              decoration: const BoxDecoration(
                color: Color(0xFF1F2127),
                border: Border(bottom: BorderSide(color: Color(0xFF2C2E34))),
              ),
              child: Row(
                children: [
                  Row(
                    children: const [
                      _WindowDot(color: Color(0xFFFF5F57)),
                      SizedBox(width: 6),
                      _WindowDot(color: Color(0xFFFEBB2E)),
                      SizedBox(width: 6),
                      _WindowDot(color: Color(0xFF28C840)),
                    ],
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Text(
                      title ?? 'Generated code',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  CopyButton(text: code, tooltip: 'Copy code'),
                ],
              ),
            ),
            HighlightView(
              code,
              language: 'dart',
              theme: githubTheme,
              padding: const EdgeInsets.all(16),
              textStyle: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 12.5,
                height: 1.45,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _WindowDot extends StatelessWidget {
  const _WindowDot({required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 10,
      width: 10,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}
