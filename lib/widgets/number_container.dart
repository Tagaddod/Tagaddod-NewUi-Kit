import 'package:flutter/material.dart';
import 'package:tagaddod_ui_kit/colors/semantic/bg_colors.dart';
import 'package:tagaddod_ui_kit/colors/semantic/border_colors.dart';
import 'package:tagaddod_ui_kit/colors/semantic/text_colors.dart';
import 'package:tagaddod_ui_kit/widgets/app_text.dart';

class NumberContainer extends StatelessWidget {
  final String value;
  final Color? borderColor;
  final Color? backgroundColor;
  final Color? textColor;
  final double? borderWidth;
  final double? borderRadius;
  final double? width;
  final double? height;

  const NumberContainer(
      {required this.value,
      this.backgroundColor,
      this.borderWidth = 1,
      this.borderColor,
      this.borderRadius,
      this.textColor,
      this.width,
      this.height,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? 26,
      height: height ?? 28,
      decoration: BoxDecoration(
          color: backgroundColor ?? BgColors.colorBg,
          borderRadius: BorderRadius.circular(borderRadius ?? 3),
          border: Border.all(
              width: borderWidth ?? 18,
              color: borderColor ?? BorderColors.colorBorderSecondary)),
      child: Center(
        child: AppText.bodyMdSemiBold(
            text: value, textColor: textColor ?? TextColors.colorText),
      ),
    );
  }
}
