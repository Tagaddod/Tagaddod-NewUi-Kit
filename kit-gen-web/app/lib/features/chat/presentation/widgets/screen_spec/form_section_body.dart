import 'package:flutter/material.dart';
import 'package:tagaddod_ui_kit/utils/button_type.dart';
import 'package:tagaddod_ui_kit/widgets/app_text.dart';
import 'package:tagaddod_ui_kit/widgets/app_text_field.dart';
import 'package:tagaddod_ui_kit/widgets/button/app_filled_button.dart';
import '../../../domain/generation_payload.dart';

class FormSectionBody extends StatelessWidget {
  const FormSectionBody({
    super.key,
    required this.section,
    required this.width,
  });

  final ScreenSpecSection section;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: section.items
          .map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _buildItem(item),
            ),
          )
          .toList(),
    );
  }

  Widget _buildItem(ScreenSpecItem item) {
    return switch (item.kind) {
      'text_field' => AppTextField.large(
        labelText: item.label,
        hintText: item.hint,
        initialValue: item.value,
        obscureText: item.obscured ?? false,
        width: width,
      ),
      'link' => Align(
        alignment: Alignment.centerLeft,
        child: AppText.bodySmSemiBold(
          text: item.label,
          textColor: const Color(0xFF8F4D2E),
        ),
      ),
      'button' => AppFilledButton.large(
        btnText: item.label,
        width: width,
        onTap: () {},
        buttonType: _buttonType(item.emphasis),
      ),
      _ => AppText.bodyMd(text: item.label),
    };
  }

  ButtonType _buttonType(String? emphasis) => switch (emphasis) {
    'secondary' => ButtonType.neutralButton,
    'critical' => ButtonType.criticalButton,
    'positive' => ButtonType.successButton,
    _ => ButtonType.defaultButton,
  };
}
