import 'package:flutter/material.dart';
import 'package:tagaddod_ui_kit/colors/semantic/bg_colors.dart';
import 'package:tagaddod_ui_kit/colors/semantic/border_colors.dart';

class AppRadioButton<T> extends StatelessWidget {
  final T value;
  final T groupValue;
  final void Function(bool)? onChanged;

  final double? borderWidth;
  final double? splashRadius;

  ValueNotifier<bool> selected = ValueNotifier<bool>(false);
  AppRadioButton({
    super.key,
    required this.value,
    required this.groupValue,
    this.borderWidth,
    this.onChanged,
    this.splashRadius,
  });

  @override
  Widget build(BuildContext context) {
    selected.value = (value == groupValue);
    debugPrint(selected.value.toString());
    return ValueListenableBuilder<bool>(
      valueListenable: selected,
      builder: (context, value, child) => SizedBox(
        width: 32,
        height: 32,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            splashColor: selected.value
                ? BgColors.colorBgOverlayBrand12
                : BgColors.colorBgSurface,
            borderRadius: BorderRadius.circular(splashRadius ?? 25),
            onTap: onChanged != null
                ? () {
                    if (onChanged != null) {
                      onChanged!(selected.value);
                    }
                  }
                : null,
            child: Center(
              child: Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                      color: onChanged == null
                          ? BorderColors.colorBorderDisabled
                          : selected.value
                              ? BgColors.colorBgFillBrand
                              : BorderColors.colorBorderActive,
                      width: borderWidth ?? (selected.value ? 2 : 1)),
                ),
                child: selected.value
                    ? Center(
                        child: Container(
                          width: 10,
                          height: 10,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: onChanged == null
                                ? BorderColors.colorBorderDisabled
                                : BgColors
                                    .colorBgFillBrand, // Inner circle color when selected
                            //outer circle
                          ),
                        ),
                      )
                    : null,
              ),
            ),
          ),
        ),
      ),
    );
    // return Radio<T>(
    //   value: value,
    //   groupValue: groupValue,
    //   onChanged: onChanged,
    //   fillColor: WidgetStateProperty.resolveWith((states) {
    //     if (states.contains(WidgetState.disabled)) {
    //       return fillColor ??
    //           (onChanged == null && value == false
    //               ? BgColors.colorBgFillDisabled
    //               : BgColors.colorBgSurface);
    //     }

    //     return fillColor ??
    //         (onChanged != null && (value == groupValue)
    //             ? BgColors.colorBgFillBrand
    //             : BorderColors.colorBorderActive);
    //   }),
    //   focusColor: focusColor,
    //   hoverColor: hoverColor,
    //   mouseCursor: mouseCursor,
    //   splashRadius: splashRadius,
    //   visualDensity: visualDensity,
    //   overlayColor: WidgetStatePropertyAll(
    //       overlayColor ?? BgColors.colorBgOverlayBrand12),
    //   materialTapTargetSize: materialTapTargetSize,
    //   toggleable: isToggleable,
    //   autofocus: autoFocus,
    //   activeColor: activeColor,
    // );
  }
}
