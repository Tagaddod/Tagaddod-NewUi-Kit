import 'package:flutter/material.dart';
import 'package:tagaddod_ui_kit/colors/semantic/bg_colors.dart';
import 'package:tagaddod_ui_kit/colors/semantic/icon_colors.dart';
import 'package:tagaddod_ui_kit/utils/button_type.dart';
import 'package:tagaddod_ui_kit/widgets/app_icon.dart';

class AppTonalIconButton extends StatelessWidget {
  final ButtonType buttonType;
  final String iconPath;
  final Color? backgroundColor;
  final Color? disabledBackgroundColor;
  final Color? disabledIconColor;
  final BorderRadius? borderRadius;
  Color? iconColor;
  final double width;
  final double height;
  bool isCircle;
  final double? iconWidth;
  final double? iconHeight;
  final void Function()? onTap;

  //private constructor
  AppTonalIconButton._(
      {this.onTap,
      required this.iconPath,
      this.width = 40,
      this.height = 40,
      this.backgroundColor,
      this.borderRadius,
      this.disabledBackgroundColor = BgColors.colorBg,
      this.disabledIconColor = IconColors.colorIconDisabled,
      this.iconColor,
      this.buttonType = ButtonType.defaultButton,
      this.iconHeight,
      this.iconWidth,
      this.isCircle = false});

  AppTonalIconButton.medium(
      {super.key,
      this.onTap,
      required this.iconPath,
      this.disabledBackgroundColor = BgColors.colorBg,
      this.disabledIconColor = IconColors.colorIconDisabled,
      this.borderRadius,
      this.width = 40,
      this.height = 40,
      Color? iconColor,
      Color? backgroundColor,
      double? iconHeight,
      double? iconWidth,
      this.isCircle = false,
      this.buttonType = ButtonType.defaultButton})
      : iconColor = iconColor ?? getDefaultIconColor(buttonType),
        backgroundColor =
            backgroundColor ?? getDefaultBackgroundColor(buttonType),
        iconWidth = iconWidth ?? 20,
        iconHeight = iconHeight ?? 20;

  AppTonalIconButton.large(
      {super.key,
      this.onTap,
      required this.iconPath,
      Color? backgroundColor,
      Color? textColor,
      double? iconHeight,
      double? iconWidth,
      this.isCircle = false,
      this.disabledBackgroundColor = BgColors.colorBg,
      this.disabledIconColor = IconColors.colorIconDisabled,
      this.borderRadius,
      this.width = 56,
      this.height = 56,
      this.buttonType = ButtonType.defaultButton})
      : iconColor = textColor ?? getDefaultIconColor(buttonType),
        backgroundColor =
            backgroundColor ?? getDefaultBackgroundColor(buttonType),
        iconWidth = iconWidth ?? 32,
        iconHeight = iconHeight ?? 32;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: borderRadius ?? BorderRadius.circular(8),
      child: InkWell(
        splashColor: getHighlightColor(),
        customBorder: isCircle ? const CircleBorder() : null,
        highlightColor: Colors.transparent,
        borderRadius: borderRadius ?? BorderRadius.circular(8),
        onTap: onTap,
        child: Ink(
          width: width,
          height: height,
          decoration: BoxDecoration(
              borderRadius:
                  isCircle ? null : borderRadius ?? BorderRadius.circular(8),
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

  Color getHighlightColor() {
    switch (buttonType) {
      case ButtonType.defaultButton:
        return BgColors.colorBgFillBrandSecondaryActive;
      case ButtonType.successButton:
        return BgColors.colorBgFillSuccessSecondaryActive;
      case ButtonType.criticalButton:
        return BgColors.colorBgFillCriticalSecondaryActive;
      case ButtonType.neutralButton:
        return BgColors.colorBgSurfaceSecondaryActive;
    }
  }
}

Color getDefaultBackgroundColor(ButtonType buttonType) {
  switch (buttonType) {
    case ButtonType.defaultButton:
      return BgColors.colorBgFillBrandSecondary;
    case ButtonType.successButton:
      return BgColors.colorBgFillSuccessSecondary;
    case ButtonType.criticalButton:
      return BgColors.colorBgFillCriticalSecondary;
    case ButtonType.neutralButton:
      return BgColors.colorBgSurfaceSecondary;
  }
}

Color getDefaultIconColor(ButtonType buttonType) {
  switch (buttonType) {
    case ButtonType.defaultButton:
      return IconColors.colorIconLink;
    case ButtonType.successButton:
      return IconColors.colorIconSuccess;
    case ButtonType.criticalButton:
      return IconColors.colorIconCritical;
    case ButtonType.neutralButton:
      return IconColors.colorIcon;
  }
}

enum ButtonSize { medium, large }
