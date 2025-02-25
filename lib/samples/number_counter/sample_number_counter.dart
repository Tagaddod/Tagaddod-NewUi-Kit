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
          fractionDigits: 1,
          hasContainer: false,
          textEditingController: controller1,
          errorText: "Error msg",
          initialValue: value1,
          maxValue: 10,
          minValue: 2,
          onChanged: (v) {
            value1 = double.tryParse(v) ?? 0;
            setState(() {});
          },
          onIncrease: () {
            value1++;
            setState(() {});
          },
          onDecrease: () {
            value1--;
            setState(() {});
          },
        ),
        SizedBox(
          height: 50,
        ),
        NumberCounter(
          textEditingController: controller2,
          errorText: "Error msg",
          initialValue: value2,
          maxValue: 10,
          minValue: 2,
          onChanged: (v) {
            value2 = double.tryParse(v) ?? 0;
            setState(() {});
          },
          onIncrease: () {
            value2++;
            setState(() {});
          },
          onDecrease: () {
            value2--;
            setState(() {});
          },
        )
      ],
    );
  }
}
