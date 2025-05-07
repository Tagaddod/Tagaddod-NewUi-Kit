import 'package:flutter/material.dart';
import 'package:tagaddod_ui_kit/colors/semantic/bg_colors.dart';
import 'package:tagaddod_ui_kit/colors/semantic/border_colors.dart';
import 'package:tagaddod_ui_kit/colors/semantic/icon_colors.dart';
import 'package:tagaddod_ui_kit/colors/semantic/text_colors.dart';
import 'package:tagaddod_ui_kit/utils/button_type.dart';
import 'package:tagaddod_ui_kit/widgets/app_icon.dart';

class AppFilledIconButton extends StatelessWidget {
  final ButtonType buttonType;
  final String iconPath;
  final Color? backgroundColor, splashColor;
  final Color? disabledBackgroundColor;
  final Color? disabledIconColor;
  final BorderRadius? borderRadius;
  final Color? borderColor;
  Color? iconColor;
  final double width;
  final double height;
  bool isCircle;
  final double? iconWidth;
  final double? iconHeight;
  final void Function()? onTap;

  //private constructor
  AppFilledIconButton._(
      {this.onTap,
      required this.iconPath,
      this.width = 40,
      this.height = 40,
      this.backgroundColor,
      this.splashColor,
      this.borderRadius,
      this.disabledBackgroundColor,
      this.disabledIconColor,
      this.borderColor,
      this.iconColor,
      this.buttonType = ButtonType.defaultButton,
      this.iconHeight,
      this.iconWidth,
      this.isCircle = false});

  AppFilledIconButton.medium(
      {super.key,
      this.onTap,
      required this.iconPath,
      this.backgroundColor,
      this.splashColor,
      this.disabledBackgroundColor = BgColors.colorBgFillDisabled,
      this.disabledIconColor = IconColors.colorIconOnBgFill,
      this.borderColor,
      this.borderRadius,
      this.width = 40,
      this.height = 40,
      Color? iconColor,
      double? iconHeight,
      double? iconWidth,
      this.isCircle = false,
      this.buttonType = ButtonType.defaultButton})
      : iconColor = iconColor ?? getDefaultIconColor(buttonType),
        iconWidth = iconWidth ?? 20,
        iconHeight = iconHeight ?? 20;

  AppFilledIconButton.large(
      {super.key,
      this.onTap,
      this.splashColor,
      required this.iconPath,
      this.backgroundColor,
      this.borderColor,
      Color? textColor,
      double? iconHeight,
      double? iconWidth,
      this.isCircle = false,
      this.disabledBackgroundColor = BgColors.colorBgFillDisabled,
      this.disabledIconColor = TextColors.colorTextOnBgFill,
      this.borderRadius,
      this.width = 56,
      this.height = 56,
      this.buttonType = ButtonType.defaultButton})
      : iconColor = textColor ?? getDefaultIconColor(buttonType),
        iconWidth = iconWidth ?? 32,
        iconHeight = iconHeight ?? 32;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: borderRadius ?? BorderRadius.circular(8),
      color: Colors.transparent,
      child: InkWell(
        splashColor: splashColor ?? getHighlightColor(),
        customBorder: isCircle ? const CircleBorder() : null,
        highlightColor: Colors.transparent,
        borderRadius: borderRadius ?? BorderRadius.circular(8),
        onTap: onTap,
        child: Ink(
          width: width,
          height: height,
          decoration: getButtonTypeDecoration(buttonType).copyWith(
              borderRadius:
                  isCircle ? null : borderRadius ?? BorderRadius.circular(8),
              border: Border.all(color: borderColor ?? Colors.transparent),
              shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
              color: onTap == null ? disabledBackgroundColor : backgroundColor),
          child: Center(
            child: AppIcon(
              svgIconPath: iconPath,
              width: iconWidth,
              height: iconHeight,
              colorFilter: ColorFilter.mode(
                  onTap == null ? disabledIconColor! : iconColor!,
                  BlendMode.srcIn),
            ),
          ),
        ),
      ),
    );
  }

  //get highlight color
  Color getHighlightColor() {
    switch (buttonType) {
      case ButtonType.defaultButton:
        return BgColors.colorBgFillBrandActive;
      case ButtonType.successButton:
        return BgColors.colorBgFillSuccessActive;
      case ButtonType.criticalButton:
        return BgColors.colorBgFillCriticalActive;
      case ButtonType.neutralButton:
        return BgColors.colorBgSurfaceSecondaryActive;
    }
  }

//background color for button
  BoxDecoration getButtonTypeDecoration(ButtonType buttonType) {
    switch (buttonType) {
      case ButtonType.defaultButton:
        return const BoxDecoration(color: BgColors.colorBgFillBrand);
      case ButtonType.successButton:
        return const BoxDecoration(
          color: BgColors.colorBgFillSuccess,
        );
      case ButtonType.criticalButton:
        return const BoxDecoration(color: BgColors.colorBgFillCritical);
      case ButtonType.neutralButton:
        return BoxDecoration(
            color: BgColors.colorBgFill,
            border: Border.all(color: BorderColors.colorBorder));
    }
  }
}
//get Default Text Color

Color getDefaultIconColor(ButtonType buttonType) {
  switch (buttonType) {
    case ButtonType.defaultButton:
      return IconColors.colorIconOnBgFill;
    case ButtonType.successButton:
      return IconColors.colorIconOnBgFill;
    case ButtonType.criticalButton:
      return IconColors.colorIconOnBgFill;
    case ButtonType.neutralButton:
      return IconColors.colorIcon;
  }
}

enum ButtonSize { medium, large }
