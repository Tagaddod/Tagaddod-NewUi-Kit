import 'package:flutter/material.dart';
import 'package:tagaddod_ui_kit/colors/semantic/bg_colors.dart';
import 'package:tagaddod_ui_kit/colors/semantic/border_colors.dart';
import 'package:tagaddod_ui_kit/colors/semantic/text_colors.dart';
import 'package:tagaddod_ui_kit/typography/semantics/body_styles.dart';
import 'package:tagaddod_ui_kit/widgets/app_icon.dart';
import 'package:tagaddod_ui_kit/widgets/app_text.dart';

class AppTextField extends StatefulWidget {
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
  final Function(String)? onChanged;
  final String? errorText;
  final String? optionalText;
  final AutovalidateMode? autovalidateMode;
  final String? Function(String?)? validator;
  final double height;
  final String? errorSvgIconPath;
  final bool expands;
  final double width;
  final int? minLines;

  final int? maxLines;
  final bool isEnabled;

  const AppTextField._({
    super.key,
    this.labelText,
    this.hintTextColor,
    this.cursorColor,
    this.onChanged,
    this.errorText,
    this.lineHeight,
    this.validator,
    this.autovalidateMode,
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
  })  : _size = TextFieldSize.medium,
        _btnTextStyle = BodyStyles.bodySmSemiBold,
        isEnabled = true,
        obscureText = false,
        isOptionalEnabled = false,
        textEditingController = null,
        expands = false,
        minLines = 1,
        readOnly = false,
        maxLines = 1;

  const AppTextField.medium(
      {super.key,
      this.labelText,
      this.cursorColor,
      this.hintTextColor,
      this.textEditingController,
      this.errorBorderColor,
      this.focusedBorderColor,
      this.validator,
      this.onChanged,
      this.lineHeight,
      this.isOptionalEnabled = false,
      this.errorText,
      this.borderRadius,
      this.helperText,
      this.optionalText,
      this.autovalidateMode,
      this.expands = false,
      this.prefix,
      this.minLines,
      this.maxLines,
      this.suffix,
      this.hintText,
      this.keyboardType,
      this.errorSvgIconPath,
      this.isEnabled = true,
      this.width = 200,
      this.height = 40,
      this.obscureText = false,
      this.readOnly = false})
      : _size = TextFieldSize.medium,
        _btnTextStyle = BodyStyles.bodySmSemiBold;

  const AppTextField.large({
    super.key,
    this.labelText,
    this.cursorColor,
    this.textEditingController,
    this.hintTextColor,
    this.isOptionalEnabled = false,
    this.onChanged,
    this.errorText,
    this.borderRadius,
    this.validator,
    this.helperText,
    this.prefix,
    this.suffix,
    this.minLines,
    this.lineHeight,
    this.errorBorderColor,
    this.focusedBorderColor,
    this.maxLines,
    this.optionalText,
    this.autovalidateMode,
    this.isEnabled = true,
    this.errorSvgIconPath,
    this.hintText,
    this.width = 200,
    this.height = 56,
    this.keyboardType,
    this.obscureText = false,
    this.readOnly = false,
    this.expands = false,
  })  : _size = TextFieldSize.large,
        _btnTextStyle = BodyStyles.bodyMdSemiBold;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late TextEditingController _textEditingController;
  final bool _isFocused = false;
  String? _errorText;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _errorText = widget.errorText;
    _textEditingController =
        widget.textEditingController ?? TextEditingController();

    // Add listener to handle validation state changes
    _textEditingController.addListener(_handleValidation);
  }

  void _handleValidation() {
    if (widget.autovalidateMode == AutovalidateMode.always ||
        (widget.autovalidateMode == AutovalidateMode.onUserInteraction &&
            _textEditingController.text.isNotEmpty)) {
      final error = _validate(_textEditingController.text);
      if (error != _errorText) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) {
            setState(() {
              _errorText = error;
            });
          }
        });
      }
    }
  }

  String? _validate(String? value) {
    if (widget.validator != null) {
      return widget.validator!(value);
    }
    return null;
  }

  @override
  void didUpdateWidget(AppTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.errorText != oldWidget.errorText) {
      _errorText = widget.errorText;
    }
    if (widget.autovalidateMode != oldWidget.autovalidateMode) {
      _handleValidation();
    }
  }

  @override
  void dispose() {
    if (widget.textEditingController == null) {
      _textEditingController.dispose();
    }
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        //label text
        if (widget.labelText != null)
          SizedBox(
            width: widget.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                getTextButtonWidget(),
                const SizedBox(
                  width: 2,
                ),
                if (widget.isOptionalEnabled)
                  Text(
                    widget.optionalText ?? "(Optional)",
                    style: widget._btnTextStyle == BodyStyles.bodySmSemiBold
                        ? BodyStyles.bodySm
                            .copyWith(color: TextColors.colorTextSecondary)
                        : BodyStyles.bodyMd.copyWith(
                            color: TextColors.colorTextSecondary, height: 1.5),
                  )
              ],
            ),
          ),

        SizedBox(
            height: widget._btnTextStyle == BodyStyles.bodySmSemiBold
                ? Directionality.of(context).name == 'ltr'
                    ? 5
                    : 3
                : Directionality.of(context).name == 'ltr'
                    ? 5
                    : 2),
        //text field
        Container(
          height: widget.height,
          width: widget.width,
          margin: EdgeInsets.zero,
          padding: EdgeInsets.zero,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(widget.borderRadius ?? 8),
              color: _errorText != null
                  ? BgColors.colorBgFillCriticalSecondary
                  : !widget.isEnabled || widget.readOnly
                      ? BgColors.colorBgSurfaceDisabled
                      : BgColors.colorBgSurface,
              border: Border.all(
                color: _errorText != null
                    ? widget.errorBorderColor ??
                        BorderColors.colorBorderCritical // Error state
                    : _isFocused
                        ? widget.focusedBorderColor ??
                            BorderColors.colorBorderBrand // Focused state
                        : BorderColors.colorBorder, // Default state
                width: 1,
              )),
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
                  controller: _textEditingController,
                  autovalidateMode: widget.autovalidateMode,
                  validator: _validate,
                  focusNode: _focusNode,
                  onTapOutside: (event) {
                    FocusManager.instance.primaryFocus?.unfocus();
                  },
                  onChanged: (value) {
                    if (widget.onChanged != null) {
                      widget.onChanged!(value);
                    }
                    // Handle validation on user interaction
                    if (widget.autovalidateMode ==
                        AutovalidateMode.onUserInteraction) {
                      _handleValidation();
                    }
                  },
                  keyboardType: widget.keyboardType,
                  obscureText: widget.obscureText,
                  maxLines: widget.maxLines ?? 1,
                  minLines: widget.minLines,
                  expands: widget.expands,
                  readOnly: widget.readOnly,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                        horizontal: 0,
                        vertical:
                            widget._btnTextStyle == BodyStyles.bodySmSemiBold
                                ? Directionality.of(context).name == 'ltr'
                                    ? 6
                                    : 0
                                : 12),
                    border: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(widget.borderRadius ?? 8),
                      borderSide: BorderSide.none,
                    ),
                    isDense: true,
                    constraints: BoxConstraints(maxHeight: widget.height),
                    hintText: widget.hintText,
                    errorStyle: TextStyle(
                      color: _errorText != null
                          ? widget.errorBorderColor ?? Colors.red
                          : widget.focusedBorderColor ??
                              BorderColors.colorBorderBrand,
                      fontSize: 0,
                    ),
                    hintStyle: widget.isEnabled
                        ? widget._btnTextStyle == BodyStyles.bodySmSemiBold
                            ? BodyStyles.bodySm.copyWith(
                                color: widget.hintTextColor ??
                                    TextColors.colorTextSecondary,
                                height: 1.6)
                            : BodyStyles.bodyMd.copyWith(
                                color: widget.hintTextColor ??
                                    TextColors.colorText,
                              )
                        : widget._btnTextStyle == BodyStyles.bodySmSemiBold
                            ? BodyStyles.bodySm.copyWith(
                                color: TextColors.colorTextSecondary,
                              )
                            : BodyStyles.bodyMd.copyWith(
                                color: TextColors.colorTextSecondary,
                              ),
                    fillColor: _errorText != null
                        ? BgColors.colorBgFillCriticalSecondary
                        : !widget.isEnabled || widget.readOnly
                            ? BgColors.colorBgSurfaceDisabled
                            : BgColors.colorBgSurface,
                    enabled: widget.isEnabled,
                    filled: true,
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

        if (widget.helperText != null) ...[
          const SizedBox(
            height: 5,
          ),
          SizedBox(
            width: widget.width,
            child: AppText.bodySm(
              text: widget.helperText!,
              textColor: TextColors.colorTextSecondary,
            ),
          ),
        ],

        SizedBox(
            height: widget._btnTextStyle == BodyStyles.bodySmSemiBold ? 7 : 6),

        if (_errorText != null) ...[
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
                      BorderColors.colorBorderCritical, BlendMode.srcIn),
                ),
                const SizedBox(width: 6),
                AppText.bodySm(
                  text: _errorText!,
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

  AppText getTextButtonWidget() {
    switch (widget._btnTextStyle) {
      case BodyStyles.bodySmSemiBold:
        return AppText.bodySmSemiBold(
          text: widget.labelText!,
          height: widget.lineHeight,
          textColor: widget.isEnabled ? null : TextColors.colorTextDisabled,
        );
      case BodyStyles.bodyMdSemiBold:
        return AppText.bodyMdSemiBold(
          text: widget.labelText!,
          height: widget.lineHeight,
          textColor: widget.isEnabled ? null : TextColors.colorTextDisabled,
        );

      default:
        return AppText.bodySm(
          text: widget.labelText!,
          height: widget.lineHeight,
          textColor: widget.isEnabled ? null : TextColors.colorTextDisabled,
        );
    }
  }
}

enum TextFieldSize { medium, large }
