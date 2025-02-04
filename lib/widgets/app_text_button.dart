import 'package:flutter/material.dart';
import 'package:tagaddod_ui_kit/colors/semantic/bg_colors.dart';
import 'package:tagaddod_ui_kit/colors/semantic/text_colors.dart';
import 'package:tagaddod_ui_kit/typography/semantics/body_styles.dart';
import 'package:tagaddod_ui_kit/utils/button_type.dart';
import 'package:tagaddod_ui_kit/widgets/app_icon.dart';
import 'package:tagaddod_ui_kit/widgets/app_text.dart';

class AppTextButton extends StatelessWidget {
  final ButtonType buttonType;
  final TextStyle _btnTextStyle;
  final bool isLoading;
  final String btnText;
  final String? iconPath;
  final Color? disabledTextColor;
  final Color? textColor;
  final BorderRadius? borderRadius;
  final double width;
  final double _height;

  final void Function()? onTap;

  //private constructor
  const AppTextButton._({
    required this.isLoading,
    required this.btnText,
    this.onTap,
    this.iconPath,
    this.width = 80,
    this.disabledTextColor,
    this.textColor,
    this.borderRadius,
    this.buttonType = ButtonType.defaultButton,
  })  : _btnTextStyle = BodyStyles.bodySmSemiBold,
        _height = 40;

  AppTextButton.medium(
      {super.key,
      required this.btnText,
      this.isLoading = false,
      this.onTap,
      this.iconPath,
      this.disabledTextColor = TextColors.colorTextDisabled,
      this.width = 64,
      Color? textColor,
      this.borderRadius,
      this.buttonType = ButtonType.defaultButton})
      : _btnTextStyle = BodyStyles.bodySmSemiBold,
        _height = 40,
        textColor = textColor ?? getDefaultTextColor(buttonType);

  AppTextButton.large(
      {super.key,
      required this.btnText,
      this.isLoading = false,
      this.onTap,
      this.iconPath,
      Color? textColor,
      this.borderRadius,
      this.disabledTextColor = TextColors.colorTextDisabled,
      this.width = 69,
      this.buttonType = ButtonType.defaultButton})
      : _btnTextStyle = BodyStyles.bodyMdSemiBold,
        _height = 56,
        textColor = textColor ?? getDefaultTextColor(buttonType);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Center(
        child: InkWell(
          highlightColor: Colors.transparent,
          splashColor: getHighlightColor(),
          borderRadius: borderRadius ?? BorderRadius.circular(8),
          onTap: onTap,
          child: Ink(
            width: width,
            height: _height,
            child: isLoading
                ? Center(
                    child: SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(
                        color: textColor,
                      ),
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      //icon
                      if (iconPath != null)
                        AppIcon(
                          svgIconPath: iconPath!,
                          colorFilter:
                              ColorFilter.mode(textColor!, BlendMode.srcIn),
                        ),
                      SizedBox(
                        width: iconPath != null ? 5 : 0,
                      ),
                      //text

                      Expanded(child: getTextButtonWidget()),
                    ],
                  ),
          ),
        ),
      ),
    );
  }

  AppText getTextButtonWidget() {
    switch (_btnTextStyle) {
      case BodyStyles.bodySmSemiBold:
        return AppText.bodySmSemiBold(
          text: btnText,
          textColor: onTap == null ? disabledTextColor : textColor,
        );
      case BodyStyles.bodyMdSemiBold:
        return AppText.bodyMdSemiBold(
          text: btnText,
          textColor: onTap == null ? disabledTextColor : textColor,
        );

      default:
        return AppText.bodySmSemiBold(
          text: btnText,
          textColor: onTap == null ? disabledTextColor : textColor,
        );
    }
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
        return BgColors.colorBgSurfaceSecondary;
    }
  }
}
//get Default Text Color

Color getDefaultTextColor(ButtonType buttonType) {
  switch (buttonType) {
    case ButtonType.defaultButton:
      return TextColors.colorTextLink;
    case ButtonType.successButton:
      return TextColors.colorTextSuccess;

    case ButtonType.neutralButton:
      return TextColors.colorText;

    case ButtonType.criticalButton:
      return TextColors.colorTextCritical;
  }
}
