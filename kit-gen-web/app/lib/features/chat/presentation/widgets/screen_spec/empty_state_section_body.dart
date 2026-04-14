import 'package:flutter/material.dart';
import 'package:tagaddod_ui_kit/utils/button_type.dart';
import 'package:tagaddod_ui_kit/widgets/app_text.dart';
import 'package:tagaddod_ui_kit/widgets/button/app_filled_button.dart';
import '../../../domain/generation_payload.dart';

class EmptyStateSectionBody extends StatelessWidget {
  const EmptyStateSectionBody({
    super.key,
    required this.section,
    required this.width,
  });

  final ScreenSpecSection section;
  final double width;

  @override
  Widget build(BuildContext context) {
    final action =
        section.items.where((i) => i.kind == 'button').firstOrNull;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Column(
        children: [
          Container(
            height: 80,
            width: 80,
            decoration: BoxDecoration(
              color: const Color(0xFFF3E6D9),
              borderRadius: BorderRadius.circular(24),
            ),
            child: const Icon(
              Icons.inbox_outlined,
              size: 38,
              color: Color(0xFFB85D2D),
            ),
          ),
          const SizedBox(height: 16),
          if (section.title.trim().isNotEmpty)
            AppText.bodyLgSemiBold(text: section.title),
          if (section.subtitle.trim().isNotEmpty) ...[
            const SizedBox(height: 6),
            AppText.bodySm(
              text: section.subtitle,
              textColor: const Color(0xFF686C83),
            ),
          ],
          if (action != null) ...[
            const SizedBox(height: 20),
            AppFilledButton.large(
              btnText: action.label,
              width: width * 0.6,
              onTap: () {},
              buttonType: ButtonType.defaultButton,
            ),
          ],
        ],
      ),
    );
  }
}
