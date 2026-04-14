import 'package:flutter/material.dart';
import 'package:tagaddod_ui_kit/widgets/app_text.dart';
import '../../../domain/generation_payload.dart';

class ProfileSectionBody extends StatelessWidget {
  const ProfileSectionBody({super.key, required this.section});

  final ScreenSpecSection section;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: section.items
          .map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: _ProfileCard(item: item),
            ),
          )
          .toList(),
    );
  }
}

class _ProfileCard extends StatelessWidget {
  const _ProfileCard({required this.item});

  final ScreenSpecItem item;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2D7CB)),
      ),
      child: Row(
        children: [
          Container(
            height: 64,
            width: 64,
            decoration: BoxDecoration(
              color: const Color(0xFFF3E6D9),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Icon(
              Icons.person_outline_rounded,
              size: 30,
              color: Color(0xFFB85D2D),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText.bodyLgSemiBold(text: item.label),
                const SizedBox(height: 3),
                AppText.bodySm(
                  text: item.value ?? 'Tagaddod Account',
                  textColor: const Color(0xFF686C83),
                ),
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
    );
  }
}
