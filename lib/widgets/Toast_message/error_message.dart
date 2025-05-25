import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tagaddod_ui_kit/assests/assets.dart';
import 'package:tagaddod_ui_kit/colors/semantic/bg_colors.dart';
import 'package:tagaddod_ui_kit/colors/semantic/border_colors.dart';
import 'package:tagaddod_ui_kit/colors/semantic/icon_colors.dart';
import 'package:tagaddod_ui_kit/colors/semantic/text_colors.dart';
import 'package:tagaddod_ui_kit/typography/semantics/body_styles.dart';
import 'package:tagaddod_ui_kit/utils/toast_service.dart';

class ErrorMessage extends StatelessWidget {
  final Color backgroundColor, borderColor, titleColor, subtitleColor;
  final VoidCallback? onClose;
  final String title;
  final String? subtitle;
  final bool showLeadingIcon, showTrailingIcon;
  final String leadingIconPath, trailingIconPath;
  final Color leadingIconColor, trailingIconColor, verticalLineColor;
  final bool showVerticalLine;
  final double verticalLineWidth;

  const ErrorMessage(
      {required this.title,
      this.subtitle,
      this.backgroundColor = BgColors.colorBgFillCriticalSecondary,
      this.borderColor = BorderColors.colorBorderCritical,
      this.subtitleColor = TextColors.colorText,
      this.onClose,
      this.titleColor = TextColors.colorTextCritical,
      this.trailingIconPath = AppAssets.close,
      this.leadingIconPath = AppAssets.alertCircle,
      this.showLeadingIcon = true,
      this.showTrailingIcon = true,
      this.leadingIconColor = IconColors.colorIconCritical,
      this.trailingIconColor = IconColors.colorIcon,
      this.verticalLineColor = BorderColors.colorBorderCritical,
      this.showVerticalLine = false,
      this.verticalLineWidth = 5,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor, // Light green background
        border: Border.all(
            color: showVerticalLine ? Colors.transparent : borderColor),
        borderRadius: showVerticalLine ? null : BorderRadius.circular(8),
      ),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            showVerticalLine
                ? Container(
                    width: verticalLineWidth,
                    color: verticalLineColor,
                  )
                : const SizedBox(
                    width: 0,
                  ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    showLeadingIcon
                        ? SvgPicture.asset(
                            leadingIconPath,
                            width: 24,
                            height: 24,
                            colorFilter: ColorFilter.mode(
                                leadingIconColor, BlendMode.srcIn),
                          )
                        : const SizedBox(
                            width: 0,
                          ),
                    const SizedBox(
                      width: 9,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: BodyStyles.bodyMdMedium(context)
                                .copyWith(color: titleColor),
                          ),
                          subtitle == null
                              ? const SizedBox.shrink()
                              : Text(
                                  subtitle ?? '',
                                  style: BodyStyles.bodySm
                                      .copyWith(color: subtitleColor),
                                ),
                        ],
                      ),
                    ),
                    showTrailingIcon
                        ? InkWell(
                            onTap: () {
                              if (onClose != null) {
                                onClose!();
                              }
                              ToastService.dismiss();
                            },
                            child: SvgPicture.asset(
                              trailingIconPath,
                              width: 20,
                              height: 20,
                              colorFilter: ColorFilter.mode(
                                  trailingIconColor, BlendMode.srcIn),
                            ),
                          )
                        : const SizedBox(
                            width: 0,
                          ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
