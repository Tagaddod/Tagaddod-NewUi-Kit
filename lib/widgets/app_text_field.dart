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
  final String labelText;
  final double? borderRadius;
  final TextEditingController? textEditingController;
  final TextInputType? keyboardType;
  final bool obscureText;
  final bool readOnly;
  final String? hintText;
  final String? helperText;
  final Widget? prefix;
  final Widget? suffix;
  final Function(String)? onChanged;
  final String? errorText;
  final AutovalidateMode? autovalidateMode;
  final String? Function(String?)? validator;
  final double _height;
  final String? errorSvgIconPath;
  final double width;
  final bool isEnabled;
  const AppTextField._({
    super.key,
    required this.labelText,
    this.textEditingController,
    this.isOptionalEnabled = false,
    this.onChanged,
    this.errorText,
    this.validator,
    this.autovalidateMode,
    this.helperText,
    this.prefix,
    this.errorSvgIconPath,
    this.suffix,
    this.borderRadius,
    this.hintText,
    this.width = 200,
    this.isEnabled = true,
    this.keyboardType,
    this.obscureText = false,
    this.readOnly = false,
  })  : _size = TextFieldSize.medium,
        _btnTextStyle = BodyStyles.bodySm,
        _height = 40;

  const AppTextField.medium(
      {super.key,
      required this.labelText,
      this.textEditingController,
      this.validator,
      this.onChanged,
      this.isOptionalEnabled = false,
      this.errorText,
      this.borderRadius,
      this.helperText,
      this.autovalidateMode,
      this.prefix,
      this.suffix,
      this.hintText,
      this.keyboardType,
      this.errorSvgIconPath,
      this.isEnabled = true,
      this.width = 200,
      this.obscureText = false,
      this.readOnly = false})
      : _size = TextFieldSize.medium,
        _btnTextStyle = BodyStyles.bodySm,
        _height = 40;

  const AppTextField.large(
      {super.key,
      required this.labelText,
      this.textEditingController,
      this.isOptionalEnabled = false,
      this.onChanged,
      this.errorText,
      this.borderRadius,
      this.validator,
      this.prefix,
      this.autovalidateMode,
      this.suffix,
      this.isEnabled = true,
      this.errorSvgIconPath,
      this.hintText,
      this.width = 200,
      this.keyboardType,
      this.obscureText = false,
      this.readOnly = false,
      this.helperText})
      : _size = TextFieldSize.large,
        _btnTextStyle = BodyStyles.bodyMdSemiBold,
        _height = 56;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late TextEditingController _textEditingController;
  final ValueNotifier<String?> errorNotifier = ValueNotifier<String?>(null);

  @override
  initState() {
    super.initState();
    _textEditingController =
        widget.textEditingController ?? TextEditingController();
    errorNotifier.value = widget.errorText ??
        widget.validator?.call(widget.textEditingController?.text);

    _textEditingController.addListener(_validateInput);
  }

  @override
  void dispose() {
    _textEditingController.removeListener(_validateInput);
    if (widget.textEditingController == null) {
      _textEditingController.dispose();
    }
    errorNotifier.dispose();
    super.dispose();
  }

  void _validateInput() {
    if (widget.validator != null) {
      final error = widget.validator!(_textEditingController.text);
      errorNotifier.value = error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        //label text
        SizedBox(
          width: widget.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              getTextButtonWidget(),
              if (widget.isOptionalEnabled)
                Text(
                  " (Optional)",
                  style: BodyStyles.bodySm
                      .copyWith(color: TextColors.colorTextSecondary),
                )
            ],
          ),
        ),

        const SizedBox(height: 5),
        //text field
        SizedBox(
          height: widget._height,
          width: widget.width,
          child: ValueListenableBuilder<String?>(
              valueListenable: errorNotifier,
              builder: (context, error, child) {
                bool isError = error != null ||
                    (widget.errorText != null && widget.errorText!.isNotEmpty);

                return TextFormField(
                  controller: _textEditingController,
                  autovalidateMode: widget.autovalidateMode,
                  validator: widget.validator,
                  onTapOutside: (event) {
                    FocusManager.instance.primaryFocus?.unfocus();
                  },
                  onChanged: (value) {
                    _validateInput();
                    if (widget.onChanged != null) {
                      widget.onChanged!(value);
                    }
                  },
                  keyboardType: widget.keyboardType,
                  obscureText: widget.obscureText,
                  readOnly: widget.readOnly,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 12),
                    errorText: null,
                    hintText: widget.hintText,
                    errorStyle: const TextStyle(
                      color: Colors.transparent,
                      fontSize: 0,
                    ),
                    hintStyle: widget.isEnabled
                        ? widget._btnTextStyle == BodyStyles.bodySm
                            ? BodyStyles.bodySm
                                .copyWith(color: TextColors.colorTextSecondary)
                            : BodyStyles.bodyMd
                        : BodyStyles.bodySm,
                    isDense: true,
                    prefix: widget.prefix,
                    suffix: widget.suffix,
                    disabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: BgColors.colorBgSurfaceDisabled,
                      ),
                      borderRadius:
                          BorderRadius.circular(widget.borderRadius ?? 8.0),
                    ),
                    border: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: BorderColors.colorBorder),
                      borderRadius:
                          BorderRadius.circular(widget.borderRadius ?? 8.0),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: BorderColors.colorBorderCritical,
                        ),
                        borderRadius:
                            BorderRadius.circular(widget.borderRadius ?? 8.0)),
                    errorBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: BorderColors.colorBorderCritical,
                        ),
                        borderRadius:
                            BorderRadius.circular(widget.borderRadius ?? 8.0)),
                    fillColor: isError
                        ? BgColors.colorBgFillCriticalSecondary
                        : !widget.isEnabled || widget.readOnly
                            ? BgColors.colorBgSurfaceDisabled
                            : BgColors.colorBgSurface,
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: BorderColors.colorBorderBrand),
                      borderRadius:
                          BorderRadius.circular(widget.borderRadius ?? 8.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: widget.readOnly
                              ? Colors.transparent
                              : BorderColors.colorBorder),
                      borderRadius:
                          BorderRadius.circular(widget.borderRadius ?? 8.0),
                    ),
                    enabled: widget.isEnabled,
                    filled: true,
                  ),
                );
              }),
        ),
        if (widget.helperText != null)
          SizedBox(
            width: widget.width,
            child: AppText.bodySm(
              text: widget.helperText!,
              textColor: TextColors.colorTextSecondary,
            ),
          ),
        const SizedBox(height: 5),

        ValueListenableBuilder<String?>(
            valueListenable: errorNotifier,
            builder: (context, error, child) {
              if (error == null) return const SizedBox.shrink();
              return SizedBox(
                width: widget.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppIcon(
                      svgIconPath:
                          widget.errorSvgIconPath ?? "assets/svg/error.svg",
                      colorFilter: const ColorFilter.mode(
                          BorderColors.colorBorderCritical, BlendMode.srcIn),
                    ),
                    const SizedBox(width: 8),
                    AppText.bodySm(
                      text: error,
                      textColor: TextColors.colorTextCritical,
                    ),
                  ],
                ),
              );
            }),
      ],
    );
  }

  AppText getTextButtonWidget() {
    switch (widget._btnTextStyle) {
      case BodyStyles.bodySm:
        return AppText.bodySm(
          text: widget.labelText,
          textColor: widget.isEnabled ? null : TextColors.colorTextDisabled,
        );
      case BodyStyles.bodyMdSemiBold:
        return AppText.bodyMdSemiBold(
          text: widget.labelText,
          textColor: widget.isEnabled ? null : TextColors.colorTextDisabled,
        );

      default:
        return AppText.bodySm(
          text: widget.labelText,
          textColor: widget.isEnabled ? null : TextColors.colorTextDisabled,
        );
    }
  }
}

enum TextFieldSize { medium, large }
