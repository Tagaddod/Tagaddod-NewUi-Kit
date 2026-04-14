import 'package:flutter/material.dart';
import 'package:tagaddod_ui_kit/utils/button_type.dart';
import 'package:tagaddod_ui_kit/widgets/app_text.dart';
import 'package:tagaddod_ui_kit/widgets/button/app_filled_button.dart';
import '../../../domain/generation_payload.dart';

class ActionsSectionBody extends StatelessWidget {
  const ActionsSectionBody({
    super.key,
    required this.section,
    required this.width,
  });

  final ScreenSpecSection section;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: section.items.asMap().entries.map((e) {
        final isLast = e.key == section.items.length - 1;
        return Padding(
          padding: EdgeInsets.only(bottom: isLast ? 0 : 10),
          child: _buildAction(e.value),
        );
      }).toList(),
    );
  }

  Widget _buildAction(ScreenSpecItem item) {
    if (item.kind == 'link') {
      return Center(
        child: AppText.bodySmSemiBold(
          text: item.label,
          textColor: const Color(0xFFB85D2D),
        ),
      );
    }
    return AppFilledButton.large(
      btnText: item.label,
      width: width,
      onTap: () {},
      buttonType: _buttonType(item.emphasis),
    );
  }

  ButtonType _buttonType(String? emphasis) => switch (emphasis) {
    'secondary' => ButtonType.neutralButton,
    'critical' => ButtonType.criticalButton,
    'positive' => ButtonType.successButton,
    _ => ButtonType.defaultButton,
  };
}
