import 'package:flutter/material.dart';
import 'package:tagaddod_ui_kit/assests/assets.dart';
import 'package:tagaddod_ui_kit/colors/semantic/bg_colors.dart';
import 'package:tagaddod_ui_kit/colors/semantic/border_colors.dart';
import 'package:tagaddod_ui_kit/colors/semantic/text_colors.dart';
import 'package:tagaddod_ui_kit/typography/semantics/body_styles.dart';
import 'package:tagaddod_ui_kit/utils/button_type.dart';
import 'package:tagaddod_ui_kit/widgets/app_icon.dart';
import 'package:tagaddod_ui_kit/widgets/app_text.dart';
import 'package:tagaddod_ui_kit/widgets/icon_button/app_tonal_icon_button.dart';

class NumberCounter extends StatefulWidget {
  TextEditingController textEditingController;
  double initialValue;
  final double incrementRate;
  final double decrementRate;
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
  final double? width;
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
  final Color? backgroundColor;

  NumberCounter(
      {super.key,
      required this.textEditingController,
      required this.initialValue,
      this.minValue = 0,
      this.maxValue,
      this.width,
      this.onDecrease,
      this.onIncrease,
      this.onChanged,
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
      this.backgroundColor,
      this.decrementRate = 1,
      this.incrementRate = 1,
      this.validateTextInput = true});

  @override
  State<NumberCounter> createState() => _NumberCounterState();
}

class _NumberCounterState extends State<NumberCounter> {
  @override
  void initState() {
    widget.textEditingController.text = widget.initialValue.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isIncreaseButtonActive = widget.maxValue == null
        ? true
        : (widget.initialValue < widget.maxValue!);
    bool isDecreaseButtonActive = (widget.initialValue > widget.minValue);
    bool hasError = widget.validateTextInput &&
        (widget.maxValue == null
            ? (widget.initialValue < widget.minValue)
            : (widget.initialValue > widget.maxValue! ||
                widget.initialValue < widget.minValue));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: widget.width ?? 127,
          padding: widget.hasContainer
              ? const EdgeInsets.symmetric(horizontal: 8, vertical: 8)
              : null,
          decoration: widget.hasContainer
              ? BoxDecoration(
                  color: widget.backgroundColor ?? BgColors.colorBgFill,
                  borderRadius: BorderRadius.circular(widget.borderRadius ?? 8),
                  border: Border.all(
                      color: hasError
                          ? widget.errorBorderColor ??
                              BorderColors.colorBorderCritical
                          : widget.borderColor ?? BorderColors.colorBorder))
              : null,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppTonalIconButton.medium(
                onTap: isIncreaseButtonActive
                    ? () {
                        widget.initialValue += widget.incrementRate;
                        widget.textEditingController.text =
                            widget.initialValue.toString();
                        if (widget.onIncrease != null) widget.onIncrease!();
                        setState(() {});
                      }
                    : null,
                iconPath: AppAssets.plus,
                buttonType: ButtonType.defaultButton,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: TextField(
                    controller: widget.textEditingController,
                    onChanged: (v) {
                      if (v.isEmpty) return;

                      widget.initialValue = double.parse(v);
                      if (widget.onChanged != null) widget.onChanged!(v);
                      setState(() {});
                    },
                    readOnly: widget.readOnly,
                    textAlign: TextAlign.center,
                    textAlignVertical: TextAlignVertical.center,
                    decoration: widget.inputDecoration,
                    keyboardType: widget.textInputType ?? TextInputType.number,
                    keyboardAppearance: widget.keyboardAppearance,
                    style: widget.textStyle ?? BodyStyles.bodyLg,
                    onTap: widget.onTap,
                    onTapOutside: widget.onTapOutside,
                    onEditingComplete: widget.onEditingComplete,
                    onSubmitted: widget.onSubmitted,
                    cursorColor: widget.cursorColor,
                    cursorHeight: widget.cursorHeight,
                  ),
                ),
              ),
              AppTonalIconButton.medium(
                onTap: isDecreaseButtonActive
                    ? () {
                        widget.initialValue -= widget.decrementRate;
                        widget.textEditingController.text =
                            widget.initialValue.toString();
                        if (widget.onDecrease != null) widget.onDecrease!();
                        setState(() {});
                      }
                    : null,
                iconPath: AppAssets.minus,
                buttonType: ButtonType.defaultButton,
              ),
            ],
          ),
        ),
        hasError
            ? Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    AppIcon(
                      svgIconPath:
                          widget.errorIconPath ?? AppAssets.alertCircle,
                      width: widget.errorIconWidth ?? 20,
                      height: widget.errorIconHeight ?? 20,
                      colorFilter: ColorFilter.mode(
                          widget.errorIconColor ??
                              BorderColors.colorBorderCritical,
                          BlendMode.srcIn),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    AppText.bodySm(
                      text: widget.errorText,
                      textColor:
                          widget.errorTextColor ?? TextColors.colorTextCritical,
                    )
                  ],
                ),
              )
            : const SizedBox()
      ],
    );
  }
}
