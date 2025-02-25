import 'package:flutter/material.dart';
import 'package:tagaddod_ui_kit/widgets/app_radio_button.dart';
import 'package:tagaddod_ui_kit/widgets/app_text.dart';

class SampleAppRadioButton extends StatelessWidget {
  ValueNotifier<bool> radioValue = ValueNotifier<bool>(false);
  SampleAppRadioButton({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const AppText.bodyLg(text: "Test This"),
            const SizedBox(
              width: 10,
            ),
            ValueListenableBuilder<bool>(
              valueListenable: radioValue,
              builder: (context, value, child) => AppRadioButton<bool>(
                value: true,
                groupValue: radioValue.value,
                onChanged: (value) {
                  radioValue.value = !value;
                },
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),

        //disabled radio
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const AppText.bodyLg(text: "Disabled Radio button"),
            AppRadioButton<bool>(
              value: true,
              groupValue: true,
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const AppText.bodyLg(text: "Disabled Radio button"),
            AppRadioButton<bool>(
              value: true,
              groupValue: false,
            ),
          ],
        ),
      ],
    );
  }
}
