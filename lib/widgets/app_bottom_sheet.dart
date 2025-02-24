import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tagaddod_ui_kit/colors/primtives/colors.dart';
import 'package:tagaddod_ui_kit/colors/semantic/bg_colors.dart';
import 'package:tagaddod_ui_kit/dimensions/primitives/dimensions.dart';

class AppBottomSheet extends StatelessWidget {
  final Widget body;
  final bool showDragHandler;
  final CrossAxisAlignment? crossAxisAlignment;
  final MainAxisAlignment? mainAxisAlignment;
  final MainAxisSize? mainAxisSize;
  final VerticalDirection? verticalDirection;
  final TextDirection? textDirection;
  final Color? dragHandlerColor;
  final Color? headerBackgroundColor;
  final EdgeInsets? contentPadding;
  final Color? contentBackgroundColor;
  final double? borderRadius;
  const AppBottomSheet(
      {required this.body,
      this.mainAxisAlignment,
      this.mainAxisSize,
      this.crossAxisAlignment,
      this.showDragHandler = true,
      this.textDirection,
      this.verticalDirection,
      this.headerBackgroundColor,
      this.dragHandlerColor,
      this.contentPadding,
      this.contentBackgroundColor,
      this.borderRadius,
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
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(Dimensions.borderRadiusFull),
                topRight: Radius.circular(Dimensions.borderRadiusFull)),
            color: headerBackgroundColor ?? BgColors.colorBgFill,
          ),
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 16.h),
            child: showDragHandler
                ? Center(
                    child: Container(
                      height: 4,
                      width: 32,
                      decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(Dimensions.borderRadius100),
                          color: dragHandlerColor ?? AppColors.colorGray1100),
                    ),
                  )
                : const SizedBox(),
          ),
        ),
        Expanded(
          child: Container(
            width: double.infinity,
            color: contentBackgroundColor ?? BgColors.colorBgFillBrandSecondary,
            padding: contentPadding ?? const EdgeInsets.all(16),
            child: body,
          ),
        ),
      ],
    );
  }
}
