import 'package:flutter/material.dart';
import 'package:tagaddod_ui_kit/widgets/app_text.dart';
import '../../../domain/generation_payload.dart';

class InfoRowsSectionBody extends StatelessWidget {
  const InfoRowsSectionBody({super.key, required this.section});

  final ScreenSpecSection section;

  @override
  Widget build(BuildContext context) {
    if (section.items.isEmpty) return const SizedBox.shrink();
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2D7CB)),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: section.items.asMap().entries.map((e) {
          return _InfoRow(item: e.value, showDivider: e.key < section.items.length - 1);
        }).toList(),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.item, required this.showDivider});

  final ScreenSpecItem item;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: AppText.bodySm(
                  text: item.label,
                  textColor: const Color(0xFF686C83),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                flex: 3,
                child: AppText.bodyMdSemiBold(text: item.value ?? '--'),
              ),
            ],
          ),
        ),
        if (showDivider)
          const Divider(height: 1, thickness: 1, color: Color(0xFFE2D7CB)),
      ],
    );
  }
}
