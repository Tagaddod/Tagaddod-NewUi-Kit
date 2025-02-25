import 'package:flutter/material.dart';
import 'package:tagaddod_ui_kit/colors/semantic/bg_colors.dart';
import 'package:tagaddod_ui_kit/colors/semantic/border_colors.dart';
import 'package:tagaddod_ui_kit/colors/semantic/icon_colors.dart';
import 'package:tagaddod_ui_kit/utils/button_type.dart';
import 'package:tagaddod_ui_kit/widgets/app_icon.dart';

class AppOutlinedIconButton extends StatelessWidget {
  final ButtonType buttonType;
  final String iconPath;
  final Color? backgroundColor;
  final Color? disabledBackgroundColor;
  final Color? disabledIconColor;
  final Color? disabledBorderColor;
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
  AppOutlinedIconButton._(
      {this.onTap,
      required this.iconPath,
      this.width = 40,
      this.height = 40,
      this.backgroundColor,
      this.borderRadius,
      this.disabledBackgroundColor,
      this.borderColor,
      this.iconColor,
      this.buttonType = ButtonType.defaultButton,
      this.disabledIconColor = IconColors.colorIconDisabled,
      this.disabledBorderColor = BorderColors.colorBorderDisabled,
      this.iconHeight,
      this.iconWidth,
      this.isCircle = false});

  AppOutlinedIconButton.medium(
      {super.key,
      this.onTap,
      required this.iconPath,
      this.backgroundColor,
      this.disabledBackgroundColor,
      this.disabledIconColor = IconColors.colorIconDisabled,
      this.disabledBorderColor = BorderColors.colorBorderDisabled,
      Color? borderColor,
      this.borderRadius,
      this.width = 40,
      this.height = 40,
      Color? iconColor,
      double? iconHeight,
      double? iconWidth,
      this.isCircle = false,
      this.buttonType = ButtonType.defaultButton})
      : iconColor = iconColor ?? getDefaultIconColor(buttonType),
        borderColor = borderColor ?? getDefaultBorderColor(buttonType),
        iconWidth = iconWidth ?? 20,
        iconHeight = iconHeight ?? 20;

  AppOutlinedIconButton.large(
      {super.key,
      this.onTap,
      required this.iconPath,
      this.backgroundColor,
      Color? borderColor,
      Color? iconColor,
      double? iconHeight,
      double? iconWidth,
      this.isCircle = false,
      this.disabledBorderColor = BorderColors.colorBorderDisabled,
      this.disabledBackgroundColor,
      this.disabledIconColor = IconColors.colorIconDisabled,
      this.borderRadius,
      this.width = 56,
      this.height = 56,
      this.buttonType = ButtonType.defaultButton})
      : iconColor = iconColor ?? getDefaultIconColor(buttonType),
        borderColor = borderColor ?? getDefaultBorderColor(buttonType),
        iconWidth = iconWidth ?? 32,
        iconHeight = iconHeight ?? 32;

  @override
  Widget build(BuildContext context) {
    return Material(
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
              border: Border.all(
                  color: onTap == null ? disabledBorderColor! : borderColor!),
              color: onTap == null ? disabledBackgroundColor : backgroundColor,
              shape: isCircle ? BoxShape.circle : BoxShape.rectangle),
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
        return BgColors.colorBgFillBrandSecondary;
      case ButtonType.successButton:
        return BgColors.colorBgFillSuccessSecondary;
      case ButtonType.criticalButton:
        return BgColors.colorBgFillCriticalSecondary;
      case ButtonType.neutralButton:
        return BgColors.colorBgSurfaceSecondaryActive;
    }
  }
}
//get Default Text Color

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

Color getDefaultBorderColor(ButtonType buttonType) {
  switch (buttonType) {
    case ButtonType.defaultButton:
      return BorderColors.colorBorderBrand;
    case ButtonType.successButton:
      return BorderColors.colorBorderSuccess;
    case ButtonType.criticalButton:
      return BorderColors.colorBorderCritical;
    case ButtonType.neutralButton:
      return IconColors.colorIcon;
  }
}
