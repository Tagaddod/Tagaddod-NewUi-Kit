import 'package:flutter/material.dart';
import 'package:tagaddod_ui_kit/widgets/app_check_box.dart';
import 'package:tagaddod_ui_kit/widgets/app_text.dart';

class SampleAppCheckBox extends StatefulWidget {
  const SampleAppCheckBox({super.key});

  @override
  State<SampleAppCheckBox> createState() => _SampleAppCheckBoxState();
}

class _SampleAppCheckBoxState extends State<SampleAppCheckBox> {
  ValueNotifier<bool?> checkBoxValue = ValueNotifier<bool?>(null);
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        ValueListenableBuilder<bool?>(
          valueListenable: checkBoxValue,
          builder: (context, value, child) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                const AppText.bodyLg(
                  text: "Play with This",
                  height: 0.9,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  width: 10,
                ),
                AppCheckBox(
                  value: value,
                  tristate: true,
                  onChanged: (value) {
                    checkBoxValue.value = value;
                  },
                ),
              ],
            );
          },
        ),
        const SizedBox(
          height: 20,
        ),

        //disabled Check Box
        const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            AppText.bodyLg(text: "Disabled Default Check Box"),
            SizedBox(
              width: 10,
            ),
            AppCheckBox(
              value: false,
              tristate: true,
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        //disabled with value true
        const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            AppText.bodyLg(text: "Disabled Checked Check Box"),
            SizedBox(
              width: 10,
            ),
            AppCheckBox(
              value: true,
              tristate: true,
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),

        //disabled with value null
        const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            AppText.bodyLg(text: "Disabled Inderminate Check Box"),
            SizedBox(
              width: 10,
            ),
            AppCheckBox(
              value: null,
              tristate: true,
            ),
          ],
        ),
      ],
    );
  }
}
