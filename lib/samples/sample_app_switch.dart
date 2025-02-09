import 'package:flutter/material.dart';
import 'package:tagaddod_ui_kit/widgets/app_switch.dart';
import 'package:tagaddod_ui_kit/widgets/app_text.dart';

class SampleAppSwitch extends StatelessWidget {
  SampleAppSwitch({super.key});
  final ValueNotifier<bool> switchValue = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const AppText.bodyLg(text: "Play with This"),
            ValueListenableBuilder<bool>(
              valueListenable: switchValue,
              builder: (context, value, child) {
                return AppSwitch(
                  value: value,
                  onChanged: (value) => switchValue.value = value,
                );
              },
            ),
          ],
        ),

        //disabled default switch
        const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            AppText.bodyLg(text: "Disabled with active Switch"),
            AppSwitch(
              value: true,
            ),
          ],
        ),

        const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            AppText.bodyLg(text: "Disabled false Switch"),
            AppSwitch(
              value: false,
            ),
          ],
        ),
      ],
    );
  }
}
