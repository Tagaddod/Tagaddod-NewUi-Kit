import 'package:flutter/material.dart';
import 'package:tagaddod_ui_kit/widgets/circle_percent_indicator.dart';

class SampleCirclePercentIndicator extends StatelessWidget {
  const SampleCirclePercentIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(children: [
      Padding(
          padding: EdgeInsets.all(16.0),
          child: CirclePercentIndicator(
            percentage: .20,
          ))
    ]);
  }
}
