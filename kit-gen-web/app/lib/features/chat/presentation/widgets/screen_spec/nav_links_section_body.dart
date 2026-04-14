import 'package:flutter/material.dart';
import 'package:tagaddod_ui_kit/widgets/app_text.dart';
import '../../../domain/generation_payload.dart';

class NavLinksSectionBody extends StatelessWidget {
  const NavLinksSectionBody({super.key, required this.section});

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
          return _NavRow(item: e.value, showDivider: e.key < section.items.length - 1);
        }).toList(),
      ),
    );
  }
}

class _NavRow extends StatelessWidget {
  const _NavRow({required this.item, required this.showDivider});

  final ScreenSpecItem item;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText.bodyMd(text: item.label),
                    if ((item.value ?? '').isNotEmpty) ...[
                      const SizedBox(height: 2),
                      AppText.bodySm(
                        text: item.value!,
                        textColor: const Color(0xFF686C83),
                      ),
                    ],
                  ],
                ),
              ),
              const Icon(
                Icons.arrow_forward_ios_rounded,
                size: 14,
                color: Color(0xFFADAFBD),
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
