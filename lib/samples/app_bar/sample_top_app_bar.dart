import 'package:flutter/material.dart';
import 'package:tagaddod_ui_kit/assests/assets.dart';
import 'package:tagaddod_ui_kit/widgets/button/app_filled_button.dart';
import 'package:tagaddod_ui_kit/widgets/icon_button/app_filled_icon_button.dart';
import 'package:tagaddod_ui_kit/widgets/top_app_bar.dart';

class SampleTopAppBar extends StatelessWidget {
  const SampleTopAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        TopAppBar(
          prefix: AppFilledIconButton.medium(iconPath: AppAssets.plus),
        ),
        const SizedBox(
          height: 10,
        ),
        TopAppBar(
          title: Text("Address"),
          prefix: AppFilledIconButton.medium(iconPath: AppAssets.plus),
        ),
        const SizedBox(
          height: 10,
        ),
        TopAppBar(automaticallyImplyLeading: false, title: Text("Address")),
        const SizedBox(
          height: 10,
        ),
        TopAppBar(
            automaticallyImplyLeading: false,
            title: Text("Address"),
            suffix: AppFilledButton.medium(
              btnText: "Hello",
            )),
        const SizedBox(
          height: 10,
        ),
        TopAppBar(
            prefix: AppFilledIconButton.medium(iconPath: AppAssets.plus),
            title: Text("Address"),
            suffix: AppFilledButton.medium(
              btnText: "Hello",
            ))
      ],
    );
  }
}
