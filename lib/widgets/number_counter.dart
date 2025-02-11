import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tagaddod_ui_kit/assests/assets.dart';
import 'package:tagaddod_ui_kit/colors/semantic/border_colors.dart';
import 'package:tagaddod_ui_kit/colors/semantic/text_colors.dart';
import 'package:tagaddod_ui_kit/typography/semantics/body_styles.dart';
import 'package:tagaddod_ui_kit/utils/button_type.dart';
import 'package:tagaddod_ui_kit/widgets/app_icon.dart';
import 'package:tagaddod_ui_kit/widgets/app_text.dart';
import 'package:tagaddod_ui_kit/widgets/icon_button/app_tonal_icon_button.dart';

class NumberCounter extends StatelessWidget {
  TextEditingController textEditingController;
  double initialValue;
  final double? maxValue;
  final double minValue;
  final Function()? onIncrease, onDecrease, onTap, onEditingComplete;
  void Function(String)? onSubmitted;
  final bool hasContainer;
  final ValueChanged<String>? onChanged;
  final bool readOnly;
  void Function(PointerDownEvent)? onTapOutside;
  final InputDecoration? inputDecoration;
  final TextInputType? textInputType;
  final Brightness? keyboardAppearance;
  final TextStyle? textStyle;
  final Color? cursorColor;
  final int fractionDigits;
  final double? textInputWidth;
  final double? cursorHeight;
  final double? borderRadius;
  final Color? borderColor;
  final Color? errorBorderColor;
  final String? errorIconPath;
  final Color? errorIconColor;
  final String errorText;
  final TextStyle? errorTextStyle;
  final Color? errorTextColor;
  final double? errorIconWidth;
  final double? errorIconHeight;
  final bool validateTextInput;

  NumberCounter(
      {super.key,
      required this.textEditingController,
      required this.initialValue,
      this.minValue = 0,
      this.maxValue,
      this.textInputWidth,
      this.onDecrease,
      this.onIncrease,
      this.onChanged,
      this.fractionDigits = 0,
      this.readOnly = false,
      this.onSubmitted,
      this.cursorColor,
      this.onEditingComplete,
      this.onTap,
      this.keyboardAppearance,
      this.textStyle,
      this.textInputType,
      this.inputDecoration,
      this.hasContainer = true,
      this.borderRadius,
      this.cursorHeight,
      this.borderColor,
      this.errorBorderColor,
      this.onTapOutside,
      required this.errorText,
      this.errorIconColor,
      this.errorIconPath,
      this.errorTextColor,
      this.errorTextStyle,
      this.errorIconHeight,
      this.errorIconWidth,
      this.validateTextInput = true});

  @override
  Widget build(BuildContext context) {
    bool isIncreaseButtonActive =
        maxValue == null ? true : (initialValue < maxValue!);
    bool isDecreaseButtonActive = (initialValue > minValue);
    bool hasError = validateTextInput &&
        (maxValue == null
            ? (initialValue < minValue)
            : (initialValue > maxValue! || initialValue < minValue));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
          decoration: hasContainer
              ? BoxDecoration(
                  borderRadius: BorderRadius.circular(borderRadius ?? 8.r),
                  border: Border.all(
                      color: hasError
                          ? errorBorderColor ?? BorderColors.colorBorderCritical
                          : borderColor ?? BorderColors.colorBorder))
              : null,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppTonalIconButton.medium(
                onTap: isIncreaseButtonActive ? onIncrease : null,
                iconPath: AppAssets.plus,
                buttonType: ButtonType.defaultButton,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: SizedBox(
                  width: textInputWidth ?? 24.w,
                  child: TextField(
                    controller: textEditingController
                      ..text = initialValue.toStringAsFixed(fractionDigits),
                    onChanged: onChanged,
                    readOnly: readOnly,
                    textAlign: TextAlign.center,
                    textAlignVertical: TextAlignVertical.center,
                    decoration: inputDecoration,
                    keyboardType: textInputType ?? TextInputType.number,
                    keyboardAppearance: keyboardAppearance,
                    style: textStyle ?? BodyStyles.bodyLg,
                    onTap: onTap,
                    onTapOutside: onTapOutside,
                    onEditingComplete: onEditingComplete,
                    onSubmitted: onSubmitted,
                    cursorColor: cursorColor,
                    cursorHeight: cursorHeight,
                  ),
                ),
              ),
              AppTonalIconButton.medium(
                onTap: isDecreaseButtonActive ? onDecrease : null,
                iconPath: AppAssets.minus,
                buttonType: ButtonType.defaultButton,
              ),
            ],
          ),
        ),
        hasError
            ? Padding(
                padding: EdgeInsets.only(top: 10.h),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    AppIcon(
                      svgIconPath: errorIconPath ?? AppAssets.alertCircle,
                      width: errorIconWidth ?? 20.w,
                      height: errorIconHeight ?? 20.h,
                      colorFilter: ColorFilter.mode(
                          errorIconColor ?? BorderColors.colorBorderCritical,
                          BlendMode.srcIn),
                    ),
                    SizedBox(
                      width: 8.w,
                    ),
                    AppText.bodySm(
                      text: errorText,
                      textColor: errorTextColor ?? TextColors.colorTextCritical,
                    )
                  ],
                ),
              )
            : const SizedBox()
      ],
    );
  }
}
