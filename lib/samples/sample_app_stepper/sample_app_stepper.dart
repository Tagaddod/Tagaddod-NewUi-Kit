import 'package:flutter/material.dart';
import 'package:tagaddod_ui_kit/widgets/app_stepper.dart';

class SampleAppStepper extends StatelessWidget {
  const SampleAppStepper({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: AppStepper(numOfSteps: 6, activeIndex: 3),
          ),
        ],
      ),
    );
  }
}
