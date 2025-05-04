import 'package:flutter/material.dart';
import 'package:tagaddod_ui_kit/colors/semantic/bg_colors.dart';

class AppStepper extends StatelessWidget {
  final int numOfSteps;
  final int activeIndex;
  final double height, space;
  final Color activeColor, disableColor;

  AppStepper({
    required this.numOfSteps,
    Color? disableColor,
    Color? activeColor,
    required this.activeIndex,
    this.height = 6,
    this.space = 2,
    Key? key,
  })  : disableColor = disableColor ?? BgColors.colorBgByOverlay20,
        activeColor = activeColor ?? BgColors.colorBg,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final totalWidth = constraints.maxWidth;
        final stepWidth = totalWidth / numOfSteps;
        return Row(
          children: List.generate(numOfSteps, (index) {
            final isActive = index <= activeIndex;
            return Container(
              width: stepWidth - (space * 2),
              height: height,
              margin: EdgeInsets.symmetric(horizontal: space),
              color: isActive ? activeColor : disableColor,
            );
          }),
        );
      },
    );
  }
}
