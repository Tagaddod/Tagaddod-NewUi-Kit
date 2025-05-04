import 'package:flutter/material.dart';
import 'package:tagaddod_ui_kit/widgets/bar_percent_indicator.dart';

class SampleBarPercentIndicator extends StatelessWidget {
  const SampleBarPercentIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Padding(
          padding: const EdgeInsets.all(16.0),
          child: BarPercentIndicator(
            percentage: 0.2,
          ))
    ]);
  }
}
