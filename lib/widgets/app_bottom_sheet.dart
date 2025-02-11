import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tagaddod_ui_kit/colors/primtives/colors.dart';
import 'package:tagaddod_ui_kit/colors/semantic/bg_colors.dart';

class AppBottomSheet extends StatelessWidget {
  final Widget body;
  final bool showHeader;
  final CrossAxisAlignment? crossAxisAlignment;
  final MainAxisAlignment? mainAxisAlignment;
  final MainAxisSize? mainAxisSize;
  final VerticalDirection? verticalDirection;
  final TextDirection? textDirection;
  final Color? headerColor;
  final Color? headerBackgroundColor;

  const AppBottomSheet(
      {required this.body,
      this.mainAxisAlignment,
      this.mainAxisSize,
      this.crossAxisAlignment,
      this.showHeader = true,
      this.textDirection,
      this.verticalDirection,
      this.headerBackgroundColor,
      this.headerColor,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.start,
      crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.center,
      mainAxisSize: mainAxisSize ?? MainAxisSize.max,
      textDirection: textDirection,
      verticalDirection: verticalDirection ?? VerticalDirection.down,
      children: [
        Container(
          width: double.infinity,
          color: headerBackgroundColor ?? BgColors.colorBgFill,
          child: Center(
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 16.h),
              height: 4.h,
              width: 32.w,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100.r),
                  color: headerColor ?? AppColors.colorGray1100),
            ),
          ),
        ),
        body
      ],
    );
  }
}
