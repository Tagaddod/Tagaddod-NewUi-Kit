import 'package:flutter/material.dart';
import 'package:tagaddod_ui_kit/utils/button_type.dart';
import 'package:tagaddod_ui_kit/widgets/button/app_text_button.dart';

class SampleAppTextButton extends StatelessWidget {
  const SampleAppTextButton({
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
            const Text("App Text Button Medium"),
            AppTextButton.medium(
              btnText: "Default Button",
              iconPath: "assets/svg/add.svg",
              buttonType: ButtonType.defaultButton,
              width: MediaQuery.sizeOf(context).width * 0.5,
              onTap: () {},
            ),
            const SizedBox(
              height: 5,
            ),
            AppTextButton.medium(
                btnText: "Success Button",
                buttonType: ButtonType.successButton,
                width: MediaQuery.sizeOf(context).width * 0.5,
                onTap: () {}),
            const SizedBox(
              height: 5,
            ),
            AppTextButton.medium(
                btnText: "Critical Button",
                buttonType: ButtonType.criticalButton,
                width: MediaQuery.sizeOf(context).width * 0.5,
                onTap: () {}),
            const SizedBox(
              height: 5,
            ),
            AppTextButton.medium(
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
        const Text("Large App Text Button"),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AppTextButton.large(
              btnText: "Default Button",
              iconPath: "assets/svg/add.svg",
              buttonType: ButtonType.defaultButton,
              width: MediaQuery.sizeOf(context).width * 0.5,
              onTap: () {},
            ),
            const SizedBox(
              height: 5,
            ),
            AppTextButton.large(
                btnText: "Success Button",
                buttonType: ButtonType.successButton,
                width: MediaQuery.sizeOf(context).width * 0.5,
                onTap: () {}),
            const SizedBox(
              height: 5,
            ),
            AppTextButton.large(
                btnText: "Critical Button",
                buttonType: ButtonType.criticalButton,
                width: MediaQuery.sizeOf(context).width * 0.5,
                onTap: () {}),
            const SizedBox(
              height: 5,
            ),
            AppTextButton.large(
                btnText: "Neutral Button",
                width: MediaQuery.sizeOf(context).width * 0.5,
                buttonType: ButtonType.neutralButton,
                onTap: () {}),
            const SizedBox(
              height: 5,
            ),
            AppTextButton.large(
              btnText: "disabled Button",
              iconPath: "assets/svg/add.svg",
              buttonType: ButtonType.defaultButton,
              width: MediaQuery.sizeOf(context).width * 0.5,
              onTap: null,
            ),
            const SizedBox(
              height: 5,
            ),
            AppTextButton.large(
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
