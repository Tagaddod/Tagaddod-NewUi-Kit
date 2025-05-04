import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:tagaddod_ui_kit/colors/primtives/colors.dart';
import 'package:tagaddod_ui_kit/colors/semantic/bg_colors.dart';
import 'package:tagaddod_ui_kit/colors/semantic/text_colors.dart';
import 'package:tagaddod_ui_kit/typography/semantics/caption_styles.dart';

class BarPercentIndicator extends StatelessWidget {
  final double percentage;
  final Color? progressColor, disableColor, labelColor;
  final double? barHeight, barWidth;
  final bool isRTL;

  const BarPercentIndicator({
    super.key,
    required this.percentage,
    this.isRTL = false,
    this.progressColor = BgColors.colorBgFillSuccess,
    this.disableColor = AppColors.colorGray100,
    this.labelColor = Colors.red,
    this.barHeight = 16,
    this.barWidth,
  });

  @override
  Widget build(BuildContext context) {
    return LinearPercentIndicator(
      isRTL: isRTL,
      width: barWidth,
      animation: true,
      lineHeight: barHeight!,
      percent: percentage,
      center: Text(
        '${(percentage * 100).round()}%',
        style: CaptionStyles.captionLgSemiBold
            .copyWith(color: TextColors.colorText),
      ),
      barRadius: const Radius.circular(14),
      progressColor: progressColor,
      backgroundColor: AppColors.colorGray100,
    );
  }
}
