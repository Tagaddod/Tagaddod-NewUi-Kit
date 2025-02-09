import 'package:flutter/material.dart';
import 'package:tagaddod_ui_kit/colors/semantic/bg_colors.dart';
import 'package:tagaddod_ui_kit/colors/semantic/border_colors.dart';

class AppSwitch extends StatelessWidget {
  final bool value;
  final void Function(bool)? onChanged;
  final double? splashRadius;
  final Color? activeColor;
  final Color? activeTrackColor;
  final Color? inactiveTrackColor;
  final Color? thumbColor;
  final Color? trackColor;
  final Color? overlayColor;
  final Color? trackOutlineColor;
  final MouseCursor? mouseCursor;
  final WidgetStateProperty<Icon?>? thumbIcon;
  final Color? hoverColor;
  const AppSwitch({
    super.key,
    required this.value,
    this.onChanged,
    this.splashRadius,
    this.activeColor,
    this.activeTrackColor,
    this.inactiveTrackColor,
    this.thumbColor,
    this.trackColor,
    this.trackOutlineColor,
    this.overlayColor,
    this.mouseCursor,
    this.thumbIcon,
    this.hoverColor,
  });

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: value,
      onChanged: onChanged,
      hoverColor: hoverColor,
      mouseCursor: mouseCursor,
      thumbIcon: thumbIcon,
      activeColor: activeColor ?? BgColors.colorBgFill,
      trackOutlineColor: WidgetStatePropertyAll(trackOutlineColor ??
          (onChanged != null && value == false
              ? BorderColors.colorBorder
              : Colors.transparent)),
      activeTrackColor: activeTrackColor ??
          (onChanged == null
              ? BgColors.colorBgSurfaceDisabled
              : BgColors.colorBgFillBrand),
      inactiveTrackColor: inactiveTrackColor ??
          (onChanged == null && value == true
              ? BgColors.colorBgSurfaceSecondary
              : BgColors.colorBgSurfaceSecondary),
      thumbColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          return thumbColor ??
              (onChanged == null && value == false
                  ? BgColors.colorBgFillDisabled
                  : BgColors.colorBgFill);
        }

        return BgColors.colorBgFill;
      }),
      trackColor: WidgetStatePropertyAll(trackColor),
      overlayColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          return overlayColor ?? BgColors.colorBgFillDisabled;
        }
        return null;
      }),
      splashRadius: splashRadius,
    );
  }
}
