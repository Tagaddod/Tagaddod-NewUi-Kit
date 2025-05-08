import 'package:flutter/material.dart';
import 'package:tagaddod_ui_kit/assests/assets.dart';
import 'package:tagaddod_ui_kit/widgets/icon_button/app_filled_icon_button.dart';
import 'package:tagaddod_ui_kit/widgets/stepper_flow.dart';

class SampleStepperFlow extends StatelessWidget {
  const SampleStepperFlow({super.key});

  @override
  Widget build(BuildContext context) {
    return StepperFlow(
        icon: AppFilledIconButton.medium(
          iconPath: AppAssets.back,
          isCircle: true,
        ),
        steps: [
          StepView(
              stepBody: Text("hello"),
              stepName: "name",
              stepTitle: "title",
              stepSubtitle: 'subtitle'),
          StepView(
              stepBody: Text("hello2"),
              stepName: "name",
              stepTitle: "title",
              stepSubtitle: 'subtitle'),
          StepView(
              stepBody: Text("hello"),
              stepName: "name",
              stepTitle: "title",
              stepSubtitle: 'subtitle'),
          StepView(
              stepBody: Text("hello2"),
              stepName: "name",
              stepTitle: "title",
              stepSubtitle: 'subtitle'),
        ],
        activeIndex: 0);
  }
}
