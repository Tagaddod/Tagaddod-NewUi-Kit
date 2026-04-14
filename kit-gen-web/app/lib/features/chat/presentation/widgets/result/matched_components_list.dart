import 'package:flutter/material.dart';
import '../../../domain/generation_payload.dart';

class MatchedComponentsList extends StatelessWidget {
  const MatchedComponentsList({super.key, required this.components});

  final List<MatchedComponent> components;

  @override
  Widget build(BuildContext context) {
    if (components.isEmpty) {
      return Text(
        'No kit components matched.',
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
          color: const Color(0xFF6B7280),
        ),
      );
    }
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: components.map(_ComponentChip.new).toList(),
    );
  }
}

class _ComponentChip extends StatelessWidget {
  const _ComponentChip(this.component);

  final MatchedComponent component;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: component.description,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: const Color(0xFFF3ECE4),
          borderRadius: BorderRadius.circular(999),
          border: Border.all(color: const Color(0xFFE4D5C5)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.widgets_outlined,
              size: 13,
              color: Color(0xFF8B6244),
            ),
            const SizedBox(width: 5),
            Text(
              component.className,
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                fontWeight: FontWeight.w700,
                color: const Color(0xFF4A3421),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
