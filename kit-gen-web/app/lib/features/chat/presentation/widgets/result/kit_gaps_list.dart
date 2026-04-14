import 'package:flutter/material.dart';
import '../../../domain/generation_payload.dart';
import 'kit_gap_tile.dart';

class KitGapsList extends StatelessWidget {
  const KitGapsList({super.key, required this.gaps});

  final List<GenerationKitGap> gaps;

  @override
  Widget build(BuildContext context) {
    if (gaps.isEmpty) {
      return Text(
        'No missing kit capabilities were flagged for this prompt.',
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: const Color(0xFF6B7280),
        ),
      );
    }
    return Column(
      children: gaps
          .map((g) => KitGapTile(key: ValueKey(g.widgetName), gap: g))
          .toList(),
    );
  }
}
