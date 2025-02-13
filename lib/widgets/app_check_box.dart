import 'package:flutter/material.dart';
import 'package:tagaddod_ui_kit/colors/semantic/bg_colors.dart';
import 'package:tagaddod_ui_kit/colors/semantic/border_colors.dart';
import 'package:tagaddod_ui_kit/colors/semantic/icon_colors.dart';

class AppCheckBox extends StatelessWidget {
  final bool? value;
  final ValueChanged<bool?>? onChanged;
  final double? borderRadius;
  final double checkmarkSize;
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
  final double size;

  const AppCheckBox({
    super.key,
    required this.value,
    this.onChanged,
    this.borderRadius,
    this.checkmarkSize = 14, // Default checkmark size
    this.size = 20, // Default checkbox size
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
    return SizedBox(
      width: 36,
      height: 36,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          splashColor:
              onChanged == null ? null : BgColors.colorBgOverlayBrand12,
          borderRadius: BorderRadius.circular(24),
          onTap: onChanged == null
              ? null
              : () {
                  if (onChanged != null) {
                    if (tristate) {
                      // Handle tristate toggling
                      onChanged!(value == null
                          ? false
                          : (value == false ? true : null));
                    } else {
                      onChanged!(!(value ?? false));
                    }
                  }
                },
          child: Center(
            child: Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                color: _getFillColor(),
                borderRadius: BorderRadius.circular(borderRadius ?? 4),
                border: Border.all(
                  color: onChanged != null && value != false
                      ? Colors.transparent
                      : onChanged == null && value == false
                          ? BorderColors.colorBorderDisabled
                          : onChanged == null && (value == true || tristate)
                              ? Colors.transparent
                              : BorderColors.colorBorderActive,
                  width: 1,
                ),
              ),
              child: value == true
                  ? Center(
                      child: Icon(
                        Icons.check,
                        size: checkmarkSize,
                        weight: 5,
                        color: checkColor ?? IconColors.colorIconOnBgFill,
                      ),
                    )
                  : (value == null && tristate)
                      ? Center(
                          child: Icon(
                            Icons.remove,
                            size: checkmarkSize,
                            weight: 20,
                            color: checkColor ?? IconColors.colorIconOnBgFill,
                          ),
                        )
                      : null,
            ),
          ),
        ),
      ),
    );
  }

  Color _getFillColor() {
    if (onChanged != null && value == null && tristate) {
      return BgColors.colorBgFillBrand;
    }
    if (onChanged != null && value == false && tristate) {
      return BgColors.colorBgSurface;
    }
    if (onChanged == null && (value == false)) return BgColors.colorBgSurface;
    if (onChanged == null && (value == true || tristate)) {
      return BgColors.colorBgFillDisabled;
    }
    if (onChanged != null && value == true && tristate) {
      return activeColor ?? BgColors.colorBgFillBrand;
    }
    return fillColor ?? BgColors.colorBgSurface;
  }
}
