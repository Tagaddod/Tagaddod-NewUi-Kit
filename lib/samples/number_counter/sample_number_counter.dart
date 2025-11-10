import 'package:flutter/material.dart';
import 'package:tagaddod_ui_kit/widgets/number_counter.dart';

class SampleNumberCounter extends StatefulWidget {
  const SampleNumberCounter({super.key});

  @override
  State<SampleNumberCounter> createState() => _SampleNumberCounterState();
}

class _SampleNumberCounterState extends State<SampleNumberCounter> {
  double value1 = 5;
  double value2 = 3;
  final TextEditingController controller1 = TextEditingController();
  final TextEditingController controller2 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("min value is 2 , max value is 10"),
        SizedBox(
          height: 20,
        ),
        NumberCounter(
          width: 200,
          hasContainer: false,
          textEditingController: controller1,
          errorText: "Error msg",
          initialValue: value1,
          maxValue: 10,
          minValue: 2,
        ),
        SizedBox(
          height: 50,
        ),
        NumberCounter(
          width: 200,
          textEditingController: controller2,
          errorText: "Error msg",
          textInputType: TextInputType.numberWithOptions(decimal: true),
          initialValue: value2,
          maxValue: 10,
          minValue: 0,
          onChanged: (value) {
            print("value2: $value");
          },
        )
      ],
    );
  }
}
