import 'package:flutter/material.dart';
import 'package:tagaddod_ui_kit/utils/button_type.dart';
import 'package:tagaddod_ui_kit/widgets/icon_button/app_outlined_icon_button.dart';

class SampleAppOutlinedIconButton extends StatelessWidget {
  const SampleAppOutlinedIconButton({
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
            const Text("App outline icon button Medium"),
            AppOutlinedIconButton.medium(
              iconPath: "assets/svg/add.svg",
              buttonType: ButtonType.defaultButton,
              onTap: () {},
            ),
            const SizedBox(
              height: 5,
            ),
            AppOutlinedIconButton.medium(
              iconPath: "assets/svg/add.svg",
              buttonType: ButtonType.criticalButton,
              onTap: () {},
              isCircle: true,
            ),
            const SizedBox(
              height: 5,
            ),
            AppOutlinedIconButton.medium(
              iconPath: "assets/svg/add.svg",
              buttonType: ButtonType.neutralButton,
              onTap: () {},
              isCircle: true,
            ),
            const SizedBox(
              height: 5,
            ),
            AppOutlinedIconButton.medium(
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
            AppOutlinedIconButton.large(
              iconPath: "assets/svg/add.svg",
              buttonType: ButtonType.defaultButton,
              onTap: () {},
            ),
            const SizedBox(
              height: 5,
            ),
            AppOutlinedIconButton.large(
              iconPath: "assets/svg/add.svg",
              buttonType: ButtonType.criticalButton,
              onTap: () {},
              isCircle: true,
            ),
            const SizedBox(
              height: 5,
            ),
            AppOutlinedIconButton.large(
              iconPath: "assets/svg/add.svg",
              buttonType: ButtonType.neutralButton,
              onTap: () {},
              isCircle: true,
            ),
            const SizedBox(
              height: 5,
            ),
            AppOutlinedIconButton.large(
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
