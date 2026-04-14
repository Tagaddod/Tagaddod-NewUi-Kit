import 'package:flutter/material.dart';
import '../../../domain/generation_payload.dart';

class TabBarSectionBody extends StatelessWidget {
  const TabBarSectionBody({super.key, required this.section});

  final ScreenSpecSection section;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: const Color(0xFFF3E6D9),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: section.items.asMap().entries.map((e) {
          final isSelected = e.value.checked ?? e.key == 0;
          return Expanded(
            child: _TabChip(label: e.value.label, isSelected: isSelected),
          );
        }).toList(),
      ),
    );
  }
}

class _TabChip extends StatelessWidget {
  const _TabChip({required this.label, required this.isSelected});

  final String label;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration.zero,
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFF252520) : Colors.transparent,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: isSelected ? Colors.white : const Color(0xFF686C83),
        ),
      ),
    );
  }
}
