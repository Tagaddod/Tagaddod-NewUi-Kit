import 'package:flutter/material.dart';
import 'package:tagaddod_ui_kit/colors/primtives/colors.dart';
import 'package:tagaddod_ui_kit/widgets/app_icon.dart';
import 'package:tagaddod_ui_kit/widgets/app_text.dart';

class AppFilledButton extends StatelessWidget {
  final ButtonSize _buttonSize;
  final bool isLoading;
  final String btnText;
  final String? iconPath;
  final void Function()? onTap;

  //private constructor
  const AppFilledButton._(
      {required this.isLoading,
      required this.btnText,
      this.onTap,
      this.iconPath})
      : _buttonSize = ButtonSize.medium;
  const AppFilledButton.medium(
      {super.key,
      required this.btnText,
      this.isLoading = false,
      this.onTap,
      this.iconPath})
      : _buttonSize = ButtonSize.medium;
  const AppFilledButton.large(
      {super.key,
      required this.btnText,
      this.isLoading = false,
      this.onTap,
      this.iconPath})
      : _buttonSize = ButtonSize.large;

  @override
  Widget build(BuildContext context) {
    //we should get style of each component in here
    return InkWell(
      splashColor: AppColors.colorWhite,
      onTap: onTap,
      child: Container(
        constraints: const BoxConstraints(
          minWidth: 40,
          minHeight: 40,
        ),
        child: isLoading
            ? const CircularProgressIndicator(
                color: AppColors.colorWhite,
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  //icon
                  if (iconPath != null) AppIcon(svgIconPath: iconPath!),
                  //text
                  AppText.bodyMdSemiBold(text: btnText),
                ],
              ),
      ),
    );
  }
}

enum ButtonSize { medium, large }
