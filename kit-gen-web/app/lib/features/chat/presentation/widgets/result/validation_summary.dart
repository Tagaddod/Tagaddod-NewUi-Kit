import 'package:flutter/material.dart';
import '../../../domain/generation_payload.dart';
import 'status_chip.dart';

class ValidationSummary extends StatelessWidget {
  const ValidationSummary({super.key, required this.result});

  final GenerationPayload result;

  @override
  Widget build(BuildContext context) {
    final validation = result.validation;

    if (!validation.ran) {
      return Text(
        validation.errors.isEmpty
            ? 'Validation was skipped for this result.'
            : validation.errors.join('\n'),
        style: Theme.of(context).textTheme.bodySmall,
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            StatusChip(
              label: validation.passed ? 'Ready to render' : 'Blocked',
              color: validation.passed
                  ? const Color(0xFFD8EEDC)
                  : const Color(0xFFF7D8D5),
              foreground: const Color(0xFF1F1E1A),
            ),
            if (validation.repaired)
              const StatusChip(
                label: 'Auto-repaired',
                color: Color(0xFFE6DFF8),
                foreground: Color(0xFF2E2241),
              ),
          ],
        ),
        if (validation.errors.isNotEmpty) ...[
          const SizedBox(height: 10),
          SelectableText(
            validation.errors.join('\n'),
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              fontFamily: 'monospace',
              color: const Color(0xFF6B7280),
            ),
          ),
        ],
      ],
    );
  }
}
