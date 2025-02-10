import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tagaddod_ui_kit/colors/semantic/bg_colors.dart';
import 'package:tagaddod_ui_kit/colors/semantic/border_colors.dart';
import 'package:tagaddod_ui_kit/colors/semantic/text_colors.dart';
import 'package:tagaddod_ui_kit/typography/semantics/body_styles.dart';

class NumberContainer extends StatelessWidget {
  final String value;
  final TextStyle? textStyle;
  final Color? borderColor;
  final Color? backgroundColor;
  final Color? textColor;
  final double? borderWidth;
  final double? borderRadius;
  final double? width;
  final double? height;

  const NumberContainer(
      {required this.value,
      this.textStyle,
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
      width: width ?? 26.w,
      height: height ?? 27.h,
      decoration: BoxDecoration(
          color: backgroundColor ?? BgColors.colorBg,
          borderRadius: BorderRadius.circular(borderRadius ?? 3.r),
          border: Border.all(
              width: borderWidth ?? 1.w,
              color: borderColor ?? BorderColors.colorBorderSecondary)),
      child: Center(
        child: Text(
          value,
          style: textStyle ??
              BodyStyles.bodyMdSemiBold
                  .copyWith(color: textColor ?? TextColors.colorText),
        ),
      ),
    );
  }
}
