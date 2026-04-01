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
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: Text(title ?? 'Generated code'),
              ),
              const Spacer(),
              CopyButton(text: code, tooltip: 'Copy code'),
            ],
          ),
          HighlightView(
            code,
            language: 'dart',
            theme: githubTheme,
            padding: const EdgeInsets.all(12),
            textStyle: const TextStyle(fontFamily: 'monospace', fontSize: 12),
          ),
        ],
      ),
    );
  }
}
