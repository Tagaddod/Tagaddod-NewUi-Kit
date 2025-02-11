import 'package:flutter/material.dart';
import 'package:tagaddod_ui_kit/utils/button_type.dart';
import 'package:tagaddod_ui_kit/widgets/button/app_filled_button.dart';

class SampleAppFilledButton extends StatelessWidget {
  const SampleAppFilledButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //medium
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text("App filled button Medium"),
            AppFilledButton.medium(
              btnText: "Default Button",
              iconPath: "assets/svg/Prefix.svg",
              buttonType: ButtonType.defaultButton,
              width: MediaQuery.sizeOf(context).width * 0.5,
              onTap: () {},
            ),
            const SizedBox(
              height: 5,
            ),
            AppFilledButton.medium(
                btnText: "Success Button",
                buttonType: ButtonType.successButton,
                width: MediaQuery.sizeOf(context).width * 0.5,
                onTap: () {}),
            const SizedBox(
              height: 5,
            ),
            AppFilledButton.medium(
                btnText: "Critical Button",
                buttonType: ButtonType.criticalButton,
                width: MediaQuery.sizeOf(context).width * 0.5,
                onTap: () {}),
            const SizedBox(
              height: 5,
            ),
            AppFilledButton.medium(
                btnText: "Neutral Button",
                width: MediaQuery.sizeOf(context).width * 0.5,
                buttonType: ButtonType.neutralButton,
                onTap: () {}),
            const SizedBox(
              height: 5,
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        //large
        const Text("Large App Filled Button"),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AppFilledButton.large(
              btnText: "Default Button",
              iconPath: "assets/svg/Prefix.svg",
              buttonType: ButtonType.defaultButton,
              width: MediaQuery.sizeOf(context).width * 0.5,
              onTap: () {},
            ),
            const SizedBox(
              height: 5,
            ),
            AppFilledButton.large(
                btnText: "Success Button",
                buttonType: ButtonType.successButton,
                width: MediaQuery.sizeOf(context).width * 0.5,
                onTap: () {}),
            const SizedBox(
              height: 5,
            ),
            AppFilledButton.large(
                btnText: "Critical Button",
                buttonType: ButtonType.criticalButton,
                width: MediaQuery.sizeOf(context).width * 0.5,
                onTap: () {}),
            const SizedBox(
              height: 5,
            ),
            AppFilledButton.large(
                btnText: "Neutral Button",
                width: MediaQuery.sizeOf(context).width * 0.5,
                buttonType: ButtonType.neutralButton,
                onTap: () {}),
            const SizedBox(
              height: 5,
            ),
            AppFilledButton.large(
              btnText: "disabled Button",
              iconPath: "assets/svg/Prefix.svg",
              buttonType: ButtonType.defaultButton,
              width: MediaQuery.sizeOf(context).width * 0.5,
              onTap: null,
            ),
            const SizedBox(
              height: 5,
            ),
            AppFilledButton.large(
              btnText: "Loading Button",
              iconPath: "assets/svg/Prefix.svg",
              buttonType: ButtonType.defaultButton,
              isLoading: true,
              width: MediaQuery.sizeOf(context).width * 0.5,
              onTap: () {},
            ),
          ],
        )
      ],
    );
  }
}
