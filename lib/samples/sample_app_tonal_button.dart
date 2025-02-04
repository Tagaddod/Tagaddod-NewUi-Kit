import 'package:flutter/material.dart';
import 'package:tagaddod_ui_kit/utils/button_type.dart';
import 'package:tagaddod_ui_kit/widgets/app_tonal_button.dart';

class SampleAppTonalButton extends StatelessWidget {
  const SampleAppTonalButton({
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
            const Text("App Tonal button Medium"),
            AppTonalButton.medium(
              btnText: "Default Button",
              iconPath: "assets/svg/add.svg",
              buttonType: ButtonType.defaultButton,
              width: MediaQuery.sizeOf(context).width * 0.5,
              onTap: () {},
            ),
            const SizedBox(
              height: 5,
            ),
            AppTonalButton.medium(
                btnText: "Success Button",
                buttonType: ButtonType.successButton,
                width: MediaQuery.sizeOf(context).width * 0.5,
                onTap: () {}),
            const SizedBox(
              height: 5,
            ),
            AppTonalButton.medium(
                btnText: "Critical Button",
                buttonType: ButtonType.criticalButton,
                width: MediaQuery.sizeOf(context).width * 0.5,
                onTap: () {}),
            const SizedBox(
              height: 5,
            ),
            AppTonalButton.medium(
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
        const Text("Large App Tonal Button"),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AppTonalButton.large(
              btnText: "Default Button",
              iconPath: "assets/svg/add.svg",
              buttonType: ButtonType.defaultButton,
              width: MediaQuery.sizeOf(context).width * 0.5,
              onTap: () {},
            ),
            const SizedBox(
              height: 5,
            ),
            AppTonalButton.large(
                btnText: "Success Button",
                buttonType: ButtonType.successButton,
                width: MediaQuery.sizeOf(context).width * 0.5,
                onTap: () {}),
            const SizedBox(
              height: 5,
            ),
            AppTonalButton.large(
                btnText: "Critical Button",
                buttonType: ButtonType.criticalButton,
                width: MediaQuery.sizeOf(context).width * 0.5,
                onTap: () {}),
            const SizedBox(
              height: 5,
            ),
            AppTonalButton.large(
                btnText: "Neutral Button",
                width: MediaQuery.sizeOf(context).width * 0.5,
                buttonType: ButtonType.neutralButton,
                onTap: () {}),
            const SizedBox(
              height: 5,
            ),
            AppTonalButton.large(
              btnText: "disabled Button",
              iconPath: "assets/svg/add.svg",
              buttonType: ButtonType.defaultButton,
              width: MediaQuery.sizeOf(context).width * 0.5,
              onTap: null,
            ),
            const SizedBox(
              height: 5,
            ),
            AppTonalButton.large(
              btnText: "Loading Button",
              iconPath: "assets/svg/add.svg",
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
