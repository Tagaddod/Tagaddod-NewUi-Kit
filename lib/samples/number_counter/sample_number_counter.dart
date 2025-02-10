import 'package:flutter/material.dart';
import 'package:tagaddod_ui_kit/widgets/number_counter.dart';

class SampleNumberCounter extends StatefulWidget {
  const SampleNumberCounter({super.key});

  @override
  State<SampleNumberCounter> createState() => _SampleNumberCounterState();
}

class _SampleNumberCounterState extends State<SampleNumberCounter> {
  double value = 5;
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        NumberCounter(
          textEditingController: controller,
          initialValue: value,
          maxValue: 10,
          minValue: 2,
          onChanged: (v) {
            value = double.tryParse(v) ?? 0;
            setState(() {});
          },
          onIncrease: () {
            value++;
            setState(() {});
          },
          onDecrease: () {
            value--;
            setState(() {});
          },
        )
      ],
    );
  }
}
