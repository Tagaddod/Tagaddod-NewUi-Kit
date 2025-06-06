import 'package:flutter/material.dart';
import 'package:tagaddod_ui_kit/colors/semantic/bg_colors.dart';
import 'package:tagaddod_ui_kit/colors/semantic/text_colors.dart';
import 'package:tagaddod_ui_kit/typography/semantics/body_styles.dart';
import 'package:tagaddod_ui_kit/utils/button_type.dart';
import 'package:tagaddod_ui_kit/widgets/app_icon.dart';
import 'package:tagaddod_ui_kit/widgets/app_text.dart';

class AppTonalButton extends StatelessWidget {
  final ButtonType buttonType;
  final TextStyle _btnTextStyle;
  final bool isLoading;
  final String btnText;
  final String? iconPath;
  final Color? backgroundColor;
  final Color? disabledBackgroundColor;
  final Color? disabledTextColor;
  final BorderRadius? borderRadius;
  final Color? borderColor;
  Color? textColor;

  final double width;
  final double _height;

  final void Function()? onTap;

  //private constructor
  AppTonalButton._({
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
  })  : _btnTextStyle = BodyStyles.bodySmSemiBold,
        _height = 40;
  AppTonalButton.medium(
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
      : _btnTextStyle = BodyStyles.bodySmSemiBold,
        _height = 40,
        textColor = textColor ?? getDefaultTextColor(buttonType);
  AppTonalButton.large(
      {super.key,
      required this.btnText,
      this.isLoading = false,
      this.onTap,
      this.iconPath,
      this.backgroundColor,
      this.borderColor,
      Color? textColor,
      this.disabledBackgroundColor = BgColors.colorBg,
      this.disabledTextColor = TextColors.colorTextDisabled,
      this.borderRadius,
      this.width = 109,
      this.buttonType = ButtonType.defaultButton})
      : _btnTextStyle = BodyStyles.bodyMdSemiBold,
        _height = 56,
        textColor = textColor ?? getDefaultTextColor(buttonType);

  @override
  Widget build(BuildContext context) {
    //we should get style of each component in here

    return Material(
      borderRadius: borderRadius ?? BorderRadius.circular(8),
      color: Colors.transparent,
      child: Center(
        child: InkWell(
          splashColor: getHighlightColor(),
          highlightColor: Colors.transparent,
          borderRadius: borderRadius ?? BorderRadius.circular(8),
          onTap: isLoading ? null : onTap,
          child: Ink(
            width: width,
            height: _height,
            decoration: getButtonTypeDecoration(buttonType).copyWith(
              borderRadius: borderRadius,
              border:
                  borderColor == null ? null : Border.all(color: borderColor!),
              color: onTap == null ? disabledBackgroundColor : backgroundColor,
            ),
            child: isLoading
                ? Center(
                    child: SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(
                        color: textColor,
                        strokeWidth: 3,
                      ),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        //icon

                        if (iconPath != null)
                          AppIcon(
                            svgIconPath: iconPath!,
                            colorFilter: ColorFilter.mode(
                                onTap == null ? disabledTextColor! : textColor!,
                                BlendMode.srcIn),
                          ),
                        if (iconPath != null) const SizedBox(width: 5),
                        //text
                        Flexible(
                          child: Transform.translate(
                              offset: _btnTextStyle == BodyStyles.bodySmSemiBold
                                  ? Directionality.of(context).name == 'ltr'
                                      ? const Offset(0, 0)
                                      : const Offset(0, 1.6)
                                  : Directionality.of(context).name == 'ltr'
                                      ? const Offset(0, 0)
                                      : const Offset(0, 2),
                              child: getTextButtonWidget(context)),
                        ),
                      ],
                    ),
                  ),
          ),
        ),
      ),
    );
  }

  AppText getTextButtonWidget(BuildContext context) {
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
          height: Directionality.of(context).name == 'ltr' ? 0.2 : 1.5,
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
        return BgColors.colorBgFillBrandSecondaryActive;
      case ButtonType.successButton:
        return BgColors.colorBgFillSuccessSecondaryActive;
      case ButtonType.criticalButton:
        return BgColors.colorBgFillCriticalSecondaryActive;
      case ButtonType.neutralButton:
        return BgColors.colorBgSurfaceSecondaryActive;
    }
  }

//background color for button
  BoxDecoration getButtonTypeDecoration(ButtonType buttonType) {
    switch (buttonType) {
      case ButtonType.defaultButton:
        return BoxDecoration(
            color: BgColors.colorBgFillBrandSecondary,
            borderRadius: BorderRadius.circular(8));
      case ButtonType.successButton:
        return BoxDecoration(
            color: BgColors.colorBgFillSuccessSecondary,
            borderRadius: BorderRadius.circular(8));
      case ButtonType.criticalButton:
        return BoxDecoration(
            color: BgColors.colorBgFillCriticalSecondary,
            borderRadius: BorderRadius.circular(8));
      case ButtonType.neutralButton:
        return BoxDecoration(
          color: BgColors.colorBgSurfaceSecondary,
          borderRadius: BorderRadius.circular(8),
        );
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

enum ButtonSize { medium, large }
