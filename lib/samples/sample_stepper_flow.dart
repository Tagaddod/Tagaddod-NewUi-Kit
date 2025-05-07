import 'package:flutter/material.dart';
import 'package:tagaddod_ui_kit/widgets/stepper_flow.dart';

class SampleStepperFlow extends StatelessWidget {
  const SampleStepperFlow({super.key});

  @override
  Widget build(BuildContext context) {
    return StepperFlow(steps: [
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
    ], activeIndex: 0);
  }
}
