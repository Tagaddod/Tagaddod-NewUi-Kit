import 'package:flutter/material.dart';
import 'package:tagaddod_ui_kit/colors/semantic/bg_colors.dart';
import 'package:tagaddod_ui_kit/colors/semantic/border_colors.dart';
import 'package:tagaddod_ui_kit/colors/semantic/text_colors.dart';
import 'package:tagaddod_ui_kit/typography/semantics/body_styles.dart';
import 'package:tagaddod_ui_kit/widgets/app_icon.dart';
import 'package:tagaddod_ui_kit/widgets/app_text.dart';

class AppTextFieldSam extends FormField<String> {
  final TextFieldSize _size;
  final TextStyle _btnTextStyle;
  final bool isOptionalEnabled;
  final Color? errorBorderColor;
  final Color? focusedBorderColor;
  final Color? hintTextColor;
  final Color? cursorColor;
  final String? labelText;
  final double? borderRadius;
  final TextEditingController? textEditingController;
  final TextInputType? keyboardType;
  final bool obscureText;
  final bool readOnly;
  final String? hintText;
  final String? helperText;
  final double? lineHeight;
  final Widget? prefix;
  final Widget? suffix;
  final String? optionalText;
  final double height;
  final String? errorSvgIconPath;
  final bool expands;
  final double width;
  final int? minLines;
  final int? maxLines;

  AppTextFieldSam._({
    super.key,
    this.labelText,
    this.hintTextColor,
    this.isOptionalEnabled = false,
    this.cursorColor,
    super.onSaved,
    super.validator,
    super.autovalidateMode = AutovalidateMode.disabled,
    String? initialValue,
    this.helperText,
    this.focusedBorderColor,
    this.errorBorderColor,
    this.prefix,
    this.errorSvgIconPath,
    this.optionalText,
    this.suffix,
    this.borderRadius,
    this.hintText,
    this.width = 200,
    this.height = 40,
    this.keyboardType,
    this.textEditingController,
    this.lineHeight,
    super.enabled = true,
    super.restorationId,
    this.expands = false,
    this.minLines,
    this.maxLines,
    this.obscureText = false,
    this.readOnly = false,
    VoidCallback? onChanged,
  })  : _size = TextFieldSize.medium,
        _btnTextStyle = BodyStyles.bodySmSemiBold,
        super(
          initialValue: initialValue ?? textEditingController?.text,
          builder: (FormFieldState<String> field) {
            return _AppTextFieldContent(
              size: TextFieldSize.medium,
              btnTextStyle: BodyStyles.bodySmSemiBold,
              field: field,
              labelText: labelText,
              hintTextColor: hintTextColor,
              cursorColor: cursorColor,
              helperText: helperText,
              focusedBorderColor: focusedBorderColor,
              errorBorderColor: errorBorderColor,
              prefix: prefix,
              errorSvgIconPath: errorSvgIconPath,
              optionalText: optionalText,
              suffix: suffix,
              borderRadius: borderRadius,
              hintText: hintText,
              width: width,
              height: height,
              keyboardType: keyboardType,
              textEditingController: textEditingController,
              lineHeight: lineHeight,
              isOptionalEnabled: isOptionalEnabled,
              expands: expands,
              minLines: minLines,
              maxLines: maxLines,
              obscureText: obscureText,
              readOnly: readOnly,
              enabled: enabled,
              onChanged: onChanged,
            );
          },
        );

  AppTextFieldSam.medium({
    super.key,
    this.labelText,
    this.hintTextColor,
    this.cursorColor,
    super.onSaved,
    super.validator,
    super.autovalidateMode = AutovalidateMode.disabled,
    String? initialValue,
    this.helperText,
    this.focusedBorderColor,
    this.errorBorderColor,
    this.prefix,
    this.errorSvgIconPath,
    this.optionalText,
    this.suffix,
    this.borderRadius,
    this.hintText,
    this.width = 200,
    this.height = 40,
    this.keyboardType,
    this.textEditingController,
    this.lineHeight,
    this.isOptionalEnabled = false,
    this.expands = false,
    this.minLines,
    this.maxLines,
    this.obscureText = false,
    this.readOnly = false,
    super.enabled = true,
    super.restorationId,
    VoidCallback? onChanged,
  })  : _size = TextFieldSize.medium,
        _btnTextStyle = BodyStyles.bodySmSemiBold,
        super(
          initialValue: initialValue ?? textEditingController?.text,
          builder: (FormFieldState<String> field) {
            return _AppTextFieldContent(
              size: TextFieldSize.medium,
              btnTextStyle: BodyStyles.bodySmSemiBold,
              field: field,
              labelText: labelText,
              hintTextColor: hintTextColor,
              cursorColor: cursorColor,
              helperText: helperText,
              focusedBorderColor: focusedBorderColor,
              errorBorderColor: errorBorderColor,
              prefix: prefix,
              errorSvgIconPath: errorSvgIconPath,
              optionalText: optionalText,
              suffix: suffix,
              borderRadius: borderRadius,
              hintText: hintText,
              width: width,
              height: height,
              keyboardType: keyboardType,
              textEditingController: textEditingController,
              lineHeight: lineHeight,
              isOptionalEnabled: isOptionalEnabled,
              expands: expands,
              minLines: minLines,
              maxLines: maxLines,
              obscureText: obscureText,
              readOnly: readOnly,
              enabled: enabled,
              onChanged: onChanged,
            );
          },
        );

  AppTextFieldSam.large({
    super.key,
    this.labelText,
    this.hintTextColor,
    this.cursorColor,
    super.onSaved,
    super.validator,
    super.autovalidateMode = AutovalidateMode.disabled,
    String? initialValue,
    this.helperText,
    this.focusedBorderColor,
    this.errorBorderColor,
    this.prefix,
    this.errorSvgIconPath,
    this.optionalText,
    this.suffix,
    this.borderRadius,
    this.hintText,
    this.width = 200,
    this.height = 56,
    this.keyboardType,
    this.textEditingController,
    this.lineHeight,
    this.isOptionalEnabled = false,
    this.expands = false,
    this.minLines,
    this.maxLines,
    this.obscureText = false,
    this.readOnly = false,
    super.enabled = true,
    super.restorationId,
    VoidCallback? onChanged,
  })  : _size = TextFieldSize.large,
        _btnTextStyle = BodyStyles.bodyMdSemiBold,
        super(
          initialValue: initialValue ?? textEditingController?.text,
          builder: (FormFieldState<String> field) {
            return _AppTextFieldContent(
              size: TextFieldSize.large,
              btnTextStyle: BodyStyles.bodyMdSemiBold,
              field: field,
              labelText: labelText,
              hintTextColor: hintTextColor,
              cursorColor: cursorColor,
              helperText: helperText,
              focusedBorderColor: focusedBorderColor,
              errorBorderColor: errorBorderColor,
              prefix: prefix,
              errorSvgIconPath: errorSvgIconPath,
              optionalText: optionalText,
              suffix: suffix,
              borderRadius: borderRadius,
              hintText: hintText,
              width: width,
              height: height,
              keyboardType: keyboardType,
              textEditingController: textEditingController,
              lineHeight: lineHeight,
              isOptionalEnabled: isOptionalEnabled,
              expands: expands,
              minLines: minLines,
              maxLines: maxLines,
              obscureText: obscureText,
              readOnly: readOnly,
              enabled: enabled,
              onChanged: onChanged,
            );
          },
        );
}

class _AppTextFieldContent extends StatefulWidget {
  final TextFieldSize size;
  final TextStyle btnTextStyle;
  final FormFieldState<String> field;
  final bool isOptionalEnabled;
  final Color? errorBorderColor;
  final Color? focusedBorderColor;
  final Color? hintTextColor;
  final Color? cursorColor;
  final String? labelText;
  final double? borderRadius;
  final TextEditingController? textEditingController;
  final TextInputType? keyboardType;
  final bool obscureText;
  final bool readOnly;
  final String? hintText;
  final String? helperText;
  final double? lineHeight;
  final Widget? prefix;
  final Widget? suffix;
  final String? optionalText;
  final double height;
  final String? errorSvgIconPath;
  final bool expands;
  final double width;
  final int? minLines;
  final int? maxLines;
  final bool enabled;
  final VoidCallback? onChanged;

  const _AppTextFieldContent({
    required this.size,
    required this.btnTextStyle,
    required this.field,
    this.labelText,
    this.hintTextColor,
    this.cursorColor,
    this.helperText,
    this.focusedBorderColor,
    this.errorBorderColor,
    this.prefix,
    this.errorSvgIconPath,
    this.optionalText,
    this.suffix,
    this.borderRadius,
    this.hintText,
    this.width = 200,
    this.height = 40,
    this.keyboardType,
    this.textEditingController,
    this.lineHeight,
    this.isOptionalEnabled = false,
    this.expands = false,
    this.minLines,
    this.maxLines,
    this.obscureText = false,
    this.readOnly = false,
    this.enabled = true,
    this.onChanged,
  });

  @override
  _AppTextFieldContentState createState() => _AppTextFieldContentState();
}

class _AppTextFieldContentState extends State<_AppTextFieldContent> {
  late TextEditingController _controller;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _controller = widget.textEditingController ??
        TextEditingController(text: widget.field.value);

    _focusNode.addListener(() {
      if (!_focusNode.hasFocus &&
          widget.field.widget.autovalidateMode == AutovalidateMode.onUnfocus) {
        widget.field.validate();
      }
      setState(() {});
    });

    _controller.addListener(() {
      widget.field.didChange(_controller.text);
      widget.onChanged?.call();
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    if (widget.textEditingController == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final hasFocus = _focusNode.hasFocus;
    final hasError = widget.field.errorText != null;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Label text
        if (widget.labelText != null)
          SizedBox(
            width: widget.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _getTextButtonWidget(),
                const SizedBox(width: 2),
                if (widget.isOptionalEnabled)
                  Text(
                    widget.optionalText ?? "(Optional)",
                    style: widget.btnTextStyle == BodyStyles.bodySmSemiBold
                        ? BodyStyles.bodySm
                            .copyWith(color: TextColors.colorTextSecondary)
                        : BodyStyles.bodyMd.copyWith(
                            color: TextColors.colorTextSecondary, height: 1.5),
                  ),
              ],
            ),
          ),

        SizedBox(
          height: widget.btnTextStyle == BodyStyles.bodySmSemiBold
              ? Directionality.of(context).name == 'ltr'
                  ? 5
                  : 3
              : Directionality.of(context).name == 'ltr'
                  ? 5
                  : 2,
        ),

        // Text field
        Container(
          height: widget.height,
          width: widget.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.borderRadius ?? 8),
            color: !widget.enabled || widget.readOnly
                ? BgColors.colorBgSurfaceDisabled
                : hasError
                    ? BgColors.colorBgFillCriticalSecondary
                    : BgColors.colorBgSurface,
            border: Border.all(
              color: hasError
                  ? widget.errorBorderColor ?? BorderColors.colorBorderCritical
                  : hasFocus
                      ? widget.focusedBorderColor ??
                          BorderColors.colorBorderBrand
                      : BorderColors.colorBorder,
              width: 1,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (widget.prefix != null) ...[
                Padding(
                  padding: const EdgeInsetsDirectional.only(start: 12),
                  child: widget.prefix!,
                ),
                const SizedBox(width: 6),
              ],
              if (widget.prefix == null) const SizedBox(width: 12),
              Expanded(
                child: TextFormField(
                  cursorColor: widget.cursorColor,
                  controller: _controller,
                  focusNode: _focusNode,
                  onTapOutside: (event) {
                    FocusManager.instance.primaryFocus?.unfocus();
                  },
                  keyboardType: widget.keyboardType,
                  obscureText: widget.obscureText,
                  maxLines: widget.maxLines ?? 1,
                  minLines: widget.minLines,
                  expands: widget.expands,
                  readOnly: widget.readOnly,
                  enabled: widget.enabled,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 0,
                      vertical: widget.btnTextStyle == BodyStyles.bodySmSemiBold
                          ? Directionality.of(context).name == 'ltr'
                              ? 6
                              : 0
                          : 12,
                    ),
                    border: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(widget.borderRadius ?? 8),
                      borderSide: BorderSide.none,
                    ),
                    isDense: true,
                    constraints: BoxConstraints(maxHeight: widget.height),
                    hintText: widget.hintText,
                    hintStyle: widget.enabled
                        ? widget.btnTextStyle == BodyStyles.bodySmSemiBold
                            ? BodyStyles.bodySm.copyWith(
                                color: widget.hintTextColor ??
                                    TextColors.colorTextSecondary,
                                height: 1.6,
                              )
                            : BodyStyles.bodyMd.copyWith(
                                color: widget.hintTextColor ??
                                    TextColors.colorText,
                              )
                        : widget.btnTextStyle == BodyStyles.bodySmSemiBold
                            ? BodyStyles.bodySm.copyWith(
                                color: TextColors.colorTextSecondary,
                              )
                            : BodyStyles.bodyMd.copyWith(
                                color: TextColors.colorTextSecondary,
                              ),
                    filled: true,
                    fillColor: widget.field.errorText != null
                        ? BgColors.colorBgFillCriticalSecondary
                        : !widget.enabled || widget.readOnly
                            ? BgColors.colorBgSurfaceDisabled
                            : BgColors.colorBgSurface,
                  ),
                ),
              ),
              if (widget.suffix != null) ...[
                widget.suffix!,
                const SizedBox(width: 12),
              ],
            ],
          ),
        ),

        // Helper text
        if (widget.helperText != null) ...[
          const SizedBox(height: 5),
          SizedBox(
            width: widget.width,
            child: AppText.bodySm(
              text: widget.helperText!,
              textColor: TextColors.colorTextSecondary,
            ),
          ),
        ],

        // Error text
        if (hasError) ...[
          const SizedBox(height: 7),
          SizedBox(
            width: widget.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppIcon(
                  svgIconPath: widget.errorSvgIconPath ??
                      "assets/svg/alert-circle (1).svg",
                  height: 20,
                  width: 20,
                  colorFilter: const ColorFilter.mode(
                    BorderColors.colorBorderCritical,
                    BlendMode.srcIn,
                  ),
                ),
                const SizedBox(width: 6),
                AppText.bodySm(
                  text: widget.field.errorText!,
                  textColor: TextColors.colorTextCritical,
                  textAlign: TextAlign.center,
                  height: Directionality.of(context).name == 'ltr' ? null : 1.5,
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }

  AppText _getTextButtonWidget() {
    switch (widget.btnTextStyle) {
      case BodyStyles.bodySmSemiBold:
        return AppText.bodySmSemiBold(
          text: widget.labelText!,
          height: widget.lineHeight,
          textColor: widget.enabled ? null : TextColors.colorTextDisabled,
        );
      case BodyStyles.bodyMdSemiBold:
        return AppText.bodyMdSemiBold(
          text: widget.labelText!,
          height: widget.lineHeight,
          textColor: widget.enabled ? null : TextColors.colorTextDisabled,
        );
      default:
        return AppText.bodySm(
          text: widget.labelText!,
          height: widget.lineHeight,
          textColor: widget.enabled ? null : TextColors.colorTextDisabled,
        );
    }
  }
}

enum TextFieldSize { medium, large }
