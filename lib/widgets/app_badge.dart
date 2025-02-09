import 'package:flutter/material.dart';
import 'package:tagaddod_ui_kit/colors/primtives/colors.dart';
import 'package:tagaddod_ui_kit/colors/semantic/bg_colors.dart';
import 'package:tagaddod_ui_kit/colors/semantic/text_colors.dart';
import 'package:tagaddod_ui_kit/dimensions/primitives/dimensions.dart';
import 'package:tagaddod_ui_kit/widgets/app_icon.dart';

import 'package:tagaddod_ui_kit/widgets/app_text.dart';

class AppBadge extends StatelessWidget {
  final AppBadgeType badgeType;
  final AppBadgeSize _badgeSize;
  final bool isStrong;
  final double? borderRadius;
  final double? width;
  final double _height;
  final String? svgIconPath;
  final String? textLabel;
  const AppBadge._({
    super.key,
  })  : badgeType = AppBadgeType.defaultBadge,
        _badgeSize = AppBadgeSize.small,
        borderRadius = null,
        isStrong = false,
        _height = 24,
        width = 66,
        svgIconPath = null,
        textLabel = null;
  const AppBadge.small(
      {super.key,
      this.isStrong = false,
      this.badgeType = AppBadgeType.defaultBadge,
      this.width,
      this.svgIconPath,
      this.textLabel,
      this.borderRadius})
      : _badgeSize = AppBadgeSize.small,
        _height = 24;
  const AppBadge.medium(
      {super.key,
      this.isStrong = false,
      this.width,
      this.svgIconPath,
      this.textLabel,
      this.badgeType = AppBadgeType.defaultBadge,
      this.borderRadius})
      : _badgeSize = AppBadgeSize.medium,
        _height = 32;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: _height,
      constraints: BoxConstraints(
        maxHeight: _height,
        minWidth: _badgeSize == AppBadgeSize.small ? 59 : 76,
        maxWidth: width ?? double.infinity,
      ),
      decoration: BoxDecoration(
        color: getBadgeColor(),
        borderRadius:
            BorderRadius.circular(borderRadius ?? Dimensions.borderRadiusFull),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          //icon
          children: [
            if (svgIconPath != null)
              AppIcon(
                svgIconPath: svgIconPath!,
                colorFilter: ColorFilter.mode(getTextColor(), BlendMode.srcIn),
              ),
            if (svgIconPath != null) const SizedBox(width: 4),
            //text

            Flexible(
              child: _badgeSize == AppBadgeSize.small
                  ? AppText.captionLgSemiBold(
                      text: textLabel ?? "",
                      textColor: getTextColor(),
                    )
                  : AppText.bodySmSemiBold(
                      text: textLabel ?? "", textColor: getTextColor()),
            )
          ],
        ),
      ),
    );
  }

  getBadgeColor() {
    //cases for getting background color based on badge type and isStrong
    if (badgeType == AppBadgeType.defaultBadge) {
      if (isStrong) {
        return AppColors.colorGray1500;
      }
      return BgColors.colorBg;
    }
    if (badgeType == AppBadgeType.disabled) {
      if (isStrong) {
        return AppColors.colorGray1100;
      }
      return BgColors.colorBg;
    }

    if (badgeType == AppBadgeType.info) {
      if (isStrong) {
        return BgColors.colorBgFillBrand;
      }
      return BgColors.colorBgFillBrandSecondary;
    }

    if (badgeType == AppBadgeType.success) {
      if (isStrong) {
        return BgColors.colorBgFillSuccess;
      }
      return BgColors.colorBgFillSuccessSecondary;
    }

    if (badgeType == AppBadgeType.warning) {
      if (isStrong) {
        return BgColors.colorBgFillWarning;
      }
      return BgColors.colorBgFillWarningSecondary;
    }

    if (badgeType == AppBadgeType.critical) {
      if (isStrong) {
        return BgColors.colorBgFillCritical;
      }
      return BgColors.colorBgFillCriticalSecondary;
    }
  }

  Color getTextColor() {
    //cases for getting background color based on badge type and isStrong
    if (badgeType == AppBadgeType.defaultBadge) {
      if (isStrong) {
        return TextColors.colorTextOnBgFill;
      }
      return TextColors.colorText;
    }
    if (badgeType == AppBadgeType.disabled) {
      if (isStrong) {
        return TextColors.colorTextOnBgFill;
      }
      return TextColors.colorTextSecondary;
    }

    if (badgeType == AppBadgeType.info) {
      if (isStrong) {
        return TextColors.colorTextOnBgFill;
      }
      return TextColors.colorTextLink;
    }

    if (badgeType == AppBadgeType.success) {
      if (isStrong) {
        return TextColors.colorTextOnBgFill;
      }
      return TextColors.colorTextSuccess;
    }

    if (badgeType == AppBadgeType.warning) {
      if (isStrong) {
        return TextColors.colorTextWarning;
      }
      return TextColors.colorTextWarning;
    }

    if (badgeType == AppBadgeType.critical) {
      if (isStrong) {
        return TextColors.colorTextOnBgFill;
      }
      return TextColors.colorTextCritical;
    } else {
      if (isStrong) {
        return TextColors.colorTextOnBgFill;
      }
      return TextColors.colorText;
    }
  }
}

enum AppBadgeSize { small, medium }

enum AppBadgeType { defaultBadge, disabled, info, success, warning, critical }
