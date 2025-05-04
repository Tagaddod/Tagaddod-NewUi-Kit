import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:tagaddod_ui_kit/colors/primtives/colors.dart';
import 'package:tagaddod_ui_kit/colors/semantic/text_colors.dart';
import 'package:tagaddod_ui_kit/typography/semantics/caption_styles.dart';

class CirclePercentIndicator extends StatelessWidget {
  final Color? progressColor, disableColor, labelColor;
  final double percentage, lineWidth, radius;
  const CirclePercentIndicator(
      {required this.percentage,
      this.labelColor,
      this.disableColor,
      this.progressColor,
      this.lineWidth = 5,
      this.radius = 25,
      super.key});

  @override
  Widget build(BuildContext context) {
    return CircularPercentIndicator(
      radius: radius,
      lineWidth: lineWidth,
      percent: percentage,
      animation: true,
      center: Text(
        '${(percentage * 100).round()}%',
        style: CaptionStyles.captionLgSemiBold
            .copyWith(color: TextColors.colorText),
      ),
      backgroundColor: Colors.grey,
      circularStrokeCap: CircularStrokeCap.round,
      progressColor: AppColors.colorGray1600,
    );
  }
}
