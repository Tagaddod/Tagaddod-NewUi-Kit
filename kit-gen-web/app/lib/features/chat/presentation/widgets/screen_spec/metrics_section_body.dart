import 'package:flutter/material.dart';
import 'package:tagaddod_ui_kit/widgets/app_text.dart';
import '../../../domain/generation_payload.dart';

class MetricsSectionBody extends StatelessWidget {
  const MetricsSectionBody({
    super.key,
    required this.section,
    required this.width,
  });

  final ScreenSpecSection section;
  final double width;

  @override
  Widget build(BuildContext context) {
    final cardWidth = width > 260 ? (width - 12) / 2 : width;
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: section.items
          .map(
            (item) => SizedBox(
              width: cardWidth.clamp(0, width),
              child: _MetricCard(item: item),
            ),
          )
          .toList(),
    );
  }
}

class _MetricCard extends StatelessWidget {
  const _MetricCard({required this.item});

  final ScreenSpecItem item;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2D7CB)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText.captionLgSemiBold(
            text: item.label,
            textColor: const Color(0xFF686C83),
          ),
          const SizedBox(height: 8),
          AppText.headingMd(text: item.value ?? '--'),
        ],
      ),
    );
  }
}
