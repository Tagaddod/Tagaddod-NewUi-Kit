import 'screen_template.dart';

const emptyStateTemplate = ScreenTemplate(
  name: 'Empty State Screen',
  description:
      'Empty state with icon, message, and action button',
  code: r"""
import 'package:flutter/material.dart';
import 'package:tagaddod_ui_kit/widgets/app_text.dart';
import 'package:tagaddod_ui_kit/widgets/app_icon.dart';
import 'package:tagaddod_ui_kit/widgets/button/app_filled_button.dart';
import 'package:tagaddod_ui_kit/colors/semantic/text_colors.dart';
import 'package:tagaddod_ui_kit/colors/semantic/icon_colors.dart';
import 'package:tagaddod_ui_kit/utils/button_type.dart';

class EmptyStateScreen extends StatelessWidget {
  const EmptyStateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppIcon(
                svgIconPath: 'assets/svg/empty.svg',
                width: 80, height: 80,
                colorFilter: ColorFilter.mode(
                  IconColors.colorIconSecondary, BlendMode.srcIn),
              ),
              const SizedBox(height: 24),
              AppText.headingSm(
                text: 'Nothing here yet',
                textColor: TextColors.colorText,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              AppText.bodyMd(
                text: 'Start by adding your first item',
                textColor: TextColors.colorTextSecondary,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              AppFilledButton.medium(
                btnText: 'Get Started',
                onTap: () {},
                buttonType: ButtonType.defaultButton,
                width: 200,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
""",
);
