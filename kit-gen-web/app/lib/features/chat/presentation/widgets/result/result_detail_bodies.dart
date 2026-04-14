import 'package:flutter/material.dart';
import '../../../domain/generation_payload.dart';
import '../code_block_widget.dart';
import 'kit_gaps_list.dart';
import 'matched_components_list.dart';
import 'section_card.dart';
import 'validation_summary.dart';

class ResultDetailInfoBody extends StatelessWidget {
  const ResultDetailInfoBody({super.key, required this.result});
  final GenerationPayload result;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SectionCard(
          title: 'Validation',
          child: ValidationSummary(result: result),
        ),
        const SizedBox(height: 12),
        SectionCard(
          title: 'Kit components',
          subtitle: '${result.matchedComponentCount} used in this screen',
          child: MatchedComponentsList(components: result.matchedComponents),
        ),
        if (result.kitGapCount > 0) ...[
          const SizedBox(height: 12),
          SectionCard(
            title: 'Kit gaps',
            subtitle: '${result.kitGapCount} missing — propose to add',
            child: KitGapsList(gaps: result.kitGaps),
          ),
        ],
      ],
    );
  }
}

class ResultDetailCodeBody extends StatelessWidget {
  const ResultDetailCodeBody({super.key, required this.result});
  final GenerationPayload result;

  @override
  Widget build(BuildContext context) {
    final files = result.files;
    if (files.isNotEmpty) {
      return Column(
        children: files
            .map((f) => Padding(
                  padding: const EdgeInsets.only(bottom: 14),
                  child: CodeBlockWidget(code: f.code, title: f.path),
                ))
            .toList(),
      );
    }
    if (result.screenCode.isNotEmpty) {
      return CodeBlockWidget(
        code: result.screenCode,
        title: 'generated_preview_screen.dart',
      );
    }
    return Text(
      'No code generated.',
      style: Theme.of(context).textTheme.bodyMedium,
    );
  }
}
