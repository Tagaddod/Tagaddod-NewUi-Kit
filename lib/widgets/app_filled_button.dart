import 'package:flutter/material.dart';
import 'package:tagaddod_ui_kit/colors/primtives/colors.dart';
import 'package:tagaddod_ui_kit/colors/semantic/bg_colors.dart';
import 'package:tagaddod_ui_kit/colors/semantic/text_colors.dart';
import 'package:tagaddod_ui_kit/typography/semantics/body_styles.dart';
import 'package:tagaddod_ui_kit/utils/button_type.dart';
import 'package:tagaddod_ui_kit/widgets/app_icon.dart';
import 'package:tagaddod_ui_kit/widgets/app_text.dart';

class AppFilledButton extends StatelessWidget {
  final ButtonSize _buttonSize;
  final ButtonType buttonType;
  final TextStyle _btnTextStyle;
  final bool isLoading;
  final String btnText;
  final String? iconPath;
  final Color? backgroundColor;
  final Color? disabledBackgroundColor;
  final Color? disabledTextColor;
  final BorderRadius? borderRadius;
  final Border? borderColor;
  Color? textColor;

  final double width;
  final double _height;

  final void Function()? onTap;

  //private constructor
  AppFilledButton._({
    required this.isLoading,
    required this.btnText,
    this.onTap,
    this.iconPath,
    this.width = 80,
    this.backgroundColor,
    this.borderRadius,
    this.disabledBackgroundColor,
    this.disabledTextColor,
    this.borderColor,
    this.textColor,
    this.buttonType = ButtonType.defaultButton,
  })  : _buttonSize = ButtonSize.medium,
        _btnTextStyle = BodyStyles.bodySmSemiBold,
        _height = 40;
  AppFilledButton.medium(
      {super.key,
      required this.btnText,
      this.isLoading = false,
      this.onTap,
      this.iconPath,
      this.backgroundColor,
      this.disabledBackgroundColor = BgColors.colorBgFillDisabled,
      this.disabledTextColor = TextColors.colorTextDisabled,
      this.borderColor,
      this.borderRadius,
      this.width = 80,
      Color? textColor,
      this.buttonType = ButtonType.defaultButton})
      : _buttonSize = ButtonSize.medium,
        _btnTextStyle = BodyStyles.bodySmSemiBold,
        _height = 40,
        textColor = textColor ?? getDefaultTextColor(buttonType);
  AppFilledButton.large(
      {super.key,
      required this.btnText,
      this.isLoading = false,
      this.onTap,
      this.iconPath,
      this.backgroundColor,
      this.borderColor,
      Color? textColor,
      this.disabledBackgroundColor = BgColors.colorBgFillDisabled,
      this.disabledTextColor = TextColors.colorTextDisabled,
      this.borderRadius,
      this.width = 109,
      this.buttonType = ButtonType.defaultButton})
      : _buttonSize = ButtonSize.large,
        _btnTextStyle = BodyStyles.bodyMdSemiBold,
        _height = 56,
        textColor = textColor ?? getDefaultTextColor(buttonType);

  @override
  Widget build(BuildContext context) {
    //we should get style of each component in here

    return Center(
      child: InkWell(
        highlightColor: getHighlightColor(),
        borderRadius: BorderRadius.circular(8),
        mouseCursor: WidgetStateMouseCursor.clickable,
        onTap: onTap,
        child: Ink(
          width: width,
          height: _height,
          decoration: getButtonTypeDecoration(buttonType).copyWith(
            borderRadius: borderRadius,
            border: borderColor,
            color: onTap == null ? disabledBackgroundColor : backgroundColor,
          ),
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
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Center(
                    child: Row(
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
        return BgColors.colorBgFillBrandActive;
      case ButtonType.successButton:
        return BgColors.colorBgFillSuccessActive;
      case ButtonType.criticalButton:
        return BgColors.colorBgFillCriticalActive;
      case ButtonType.neutralButton:
        return BgColors.colorBgSurfaceSecondaryActive;
    }
  }

//background color for button
  BoxDecoration getButtonTypeDecoration(ButtonType buttonType) {
    switch (buttonType) {
      case ButtonType.defaultButton:
        return BoxDecoration(
            color: BgColors.colorBgFillBrand,
            borderRadius: BorderRadius.circular(8));
      case ButtonType.successButton:
        return BoxDecoration(
            color: BgColors.colorBgFillSuccess,
            borderRadius: BorderRadius.circular(8));
      case ButtonType.criticalButton:
        return BoxDecoration(
            color: BgColors.colorBgFillCritical,
            borderRadius: BorderRadius.circular(8));
      case ButtonType.neutralButton:
        return BoxDecoration(
            color: BgColors.colorBgSurfaceSecondaryActive,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.colorGray1600));
    }
  }
}
//get Default Text Color

Color getDefaultTextColor(ButtonType buttonType) {
  switch (buttonType) {
    case ButtonType.defaultButton:
      return TextColors.colorTextOnBgFill;
    case ButtonType.successButton:
      return TextColors.colorTextOnBgFill;
    case ButtonType.criticalButton:
      return TextColors.colorTextOnBgFill;
    case ButtonType.neutralButton:
      return TextColors.colorText;
  }
}

enum ButtonSize { medium, large }
