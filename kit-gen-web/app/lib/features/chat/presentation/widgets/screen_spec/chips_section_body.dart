import 'package:flutter/material.dart';
import '../../../domain/generation_payload.dart';

class ChipsSectionBody extends StatelessWidget {
  const ChipsSectionBody({super.key, required this.section});

  final ScreenSpecSection section;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: section.items.map(_buildChip).toList(),
    );
  }

  Widget _buildChip(ScreenSpecItem item) {
    final isSelected = item.checked == true;
    return FilterChip(
      label: Text(item.label),
      selected: isSelected,
      showCheckmark: false,
      onSelected: (_) {},
      backgroundColor: const Color(0xFFF3E6D9),
      selectedColor: const Color(0xFF252520),
      labelStyle: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 13,
        color: isSelected ? Colors.white : const Color(0xFF16161D),
      ),
      side: BorderSide.none,
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(999),
      ),
    );
  }
}
