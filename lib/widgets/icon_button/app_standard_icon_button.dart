import 'package:flutter/material.dart';
import 'package:tagaddod_ui_kit/colors/semantic/bg_colors.dart';
import 'package:tagaddod_ui_kit/colors/semantic/icon_colors.dart';
import 'package:tagaddod_ui_kit/utils/button_type.dart';
import 'package:tagaddod_ui_kit/widgets/app_icon.dart';

class AppStandardIconButton extends StatelessWidget {
  final ButtonType buttonType;
  final String iconPath;
  final Color? backgroundColor;
  final Color? disabledBackgroundColor;
  final Color? disabledIconColor;
  Color? iconColor;
  final double width;
  final double height;
  final double? iconWidth;
  final double? iconHeight;
  bool isCircle;
  final void Function()? onTap;
  final Color? splashColor;
  final BorderRadius? borderRadius;

  //private constructor
  AppStandardIconButton._(
      {this.onTap,
      required this.iconPath,
      this.width = 40,
      this.height = 40,
      this.backgroundColor,
      this.disabledBackgroundColor,
      this.disabledIconColor = IconColors.colorIconDisabled,
      this.iconColor,
      this.buttonType = ButtonType.defaultButton,
      this.iconHeight,
      this.iconWidth,
      this.borderRadius,
      this.splashColor = BgColors.colorBgSurfaceActive,
      this.isCircle = false});

  AppStandardIconButton.medium(
      {super.key,
      this.onTap,
      required this.iconPath,
      this.backgroundColor,
      this.borderRadius,
      this.disabledBackgroundColor,
      Color? borderColor,
      this.width = 40,
      this.height = 40,
      Color? iconColor,
      double? iconHeight,
      double? iconWidth,
      this.buttonType = ButtonType.defaultButton,
      this.disabledIconColor = IconColors.colorIconDisabled,
      this.splashColor = BgColors.colorBgSurfaceActive,
      this.isCircle = false})
      : iconColor = iconColor ?? getDefaultIconColor(buttonType),
        iconWidth = iconWidth ?? 20,
        iconHeight = iconHeight ?? 20;

  AppStandardIconButton.large(
      {super.key,
      this.onTap,
      required this.iconPath,
      this.backgroundColor,
      Color? borderColor,
      Color? iconColor,
      double? iconHeight,
      this.borderRadius,
      double? iconWidth,
      this.disabledBackgroundColor,
      this.disabledIconColor = IconColors.colorIconDisabled,
      this.width = 56,
      this.height = 56,
      this.splashColor = BgColors.colorBgSurfaceActive,
      this.isCircle = false,
      this.buttonType = ButtonType.defaultButton})
      : iconColor = iconColor ?? getDefaultIconColor(buttonType),
        iconWidth = iconWidth ?? 32,
        iconHeight = iconHeight ?? 32;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: borderRadius ?? BorderRadius.circular(8),
      child: InkWell(
        splashColor: splashColor,
        highlightColor: Colors.transparent,
        customBorder: isCircle ? const CircleBorder() : null,
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

//get Default Text Color
}

Color getDefaultIconColor(ButtonType buttonType) {
  switch (buttonType) {
    case ButtonType.defaultButton:
      return IconColors.colorIconLink;
    case ButtonType.successButton:
      return IconColors.colorIconSuccess;

    case ButtonType.neutralButton:
      return IconColors.colorIcon;

    case ButtonType.criticalButton:
      return IconColors.colorIconCritical;
  }
}
