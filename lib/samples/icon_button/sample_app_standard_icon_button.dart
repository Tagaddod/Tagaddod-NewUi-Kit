import 'package:flutter/material.dart';
import 'package:tagaddod_ui_kit/utils/button_type.dart';
import 'package:tagaddod_ui_kit/widgets/icon_button/app_standard_icon_button.dart';

class SampleAppStandardIconButton extends StatelessWidget {
  const SampleAppStandardIconButton({
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
            const Text("App standard icon button Medium"),
            AppStandardIconButton.medium(
              iconPath: "assets/svg/add.svg",
              buttonType: ButtonType.defaultButton,
              onTap: () {},
            ),
            const SizedBox(
              height: 5,
            ),
            AppStandardIconButton.medium(
              iconPath: "assets/svg/add.svg",
              buttonType: ButtonType.criticalButton,
              onTap: () {},
              isCircle: true,
            ),
            const SizedBox(
              height: 5,
            ),
            AppStandardIconButton.medium(
              iconPath: "assets/svg/add.svg",
              buttonType: ButtonType.neutralButton,
              onTap: () {},
            ),
            const SizedBox(
              height: 5,
            ),
            AppStandardIconButton.medium(
              iconPath: "assets/svg/add.svg",
              buttonType: ButtonType.successButton,
              onTap: null,
            ),
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
            AppStandardIconButton.large(
              iconPath: "assets/svg/add.svg",
              buttonType: ButtonType.defaultButton,
              isCircle: true,
              onTap: () {},
            ),
            const SizedBox(
              height: 5,
            ),
            AppStandardIconButton.large(
              iconPath: "assets/svg/add.svg",
              buttonType: ButtonType.criticalButton,
              onTap: () {},
            ),
            const SizedBox(
              height: 5,
            ),
            AppStandardIconButton.large(
              iconPath: "assets/svg/add.svg",
              buttonType: ButtonType.neutralButton,
              onTap: () {},
            ),
            const SizedBox(
              height: 5,
            ),
            AppStandardIconButton.large(
              iconPath: "assets/svg/add.svg",
              buttonType: ButtonType.successButton,
              onTap: () {},
            ),
            const SizedBox(
              height: 5,
            ),
          ],
        )
      ],
    );
  }
}
