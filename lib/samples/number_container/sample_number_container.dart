import 'package:flutter/material.dart';
import 'package:tagaddod_ui_kit/widgets/number_container.dart';

class SampleNumberContainer extends StatelessWidget {
  const SampleNumberContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [SizedBox(height: 20), NumberContainer(value: '4')],
    );
  }
}
