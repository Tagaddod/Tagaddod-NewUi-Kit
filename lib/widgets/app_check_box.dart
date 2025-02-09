import 'package:flutter/material.dart';
import 'package:tagaddod_ui_kit/colors/semantic/bg_colors.dart';
import 'package:tagaddod_ui_kit/colors/semantic/border_colors.dart';
import 'package:tagaddod_ui_kit/colors/semantic/icon_colors.dart';

class AppCheckBox extends StatelessWidget {
  final bool? value;
  final ValueChanged<bool?>? onChanged;
  final double? borderRadius;
  final double scale;
  final double? splashRadius;
  final bool tristate;
  final bool isError;
  final bool autoFocus;
  final BorderSide? borderSide;
  final Color? focusColor;
  final Color? hoverColor;
  final FocusNode? focusNode;
  final MouseCursor? mouseCursor;
  final Color? overlayColor;
  final Color? activeColor;
  final Color? fillColor;
  final Color? checkColor;

  const AppCheckBox({
    super.key,
    required this.value,
    this.onChanged,
    this.borderRadius,
    this.scale = 1,
    this.splashRadius,
    this.tristate = false,
    this.isError = false,
    this.autoFocus = false,
    this.borderSide,
    this.focusColor,
    this.hoverColor,
    this.fillColor,
    this.focusNode,
    this.mouseCursor,
    this.activeColor,
    this.overlayColor,
    this.checkColor,
  });

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: scale,
      child: Checkbox(
        value: value,
        onChanged: onChanged,
        tristate:
            tristate, // if tristate is true, then the checkbox can be in 3 states: null, false, true
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) {
            return fillColor ??
                (onChanged == null && value == false
                    ? BgColors.colorBgSurface
                    : BgColors.colorBgFillDisabled);
          }
          return null;
        }),
        activeColor: activeColor ?? BgColors.colorBgFillBrand,
        checkColor: checkColor ?? IconColors.colorIconOnBgFill,
        splashRadius: splashRadius,

        side: borderSide ??
            const BorderSide(color: BorderColors.colorBorderActive),
        focusColor: focusColor,
        hoverColor: hoverColor,
        focusNode: focusNode,
        mouseCursor: mouseCursor,
        isError: isError,
        autofocus: autoFocus,

        overlayColor: WidgetStatePropertyAll(
            overlayColor ?? BgColors.colorBgOverlayBrand12),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 4),
            side: BorderSide(
                color: isError
                    ? BorderColors.colorBorderCritical
                    : value == false
                        ? BorderColors.colorBorderActive
                        : onChanged == null
                            ? BorderColors.colorBorderDisabled
                            : Colors.transparent)),
      ),
    );
  }
}
