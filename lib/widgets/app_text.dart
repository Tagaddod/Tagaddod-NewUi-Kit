import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:tagaddod_ui_kit/colors/primtives/colors.dart';
import 'package:tagaddod_ui_kit/typography/semantics/body_styles.dart';
import 'package:tagaddod_ui_kit/typography/semantics/caption_styles.dart';
import 'package:tagaddod_ui_kit/typography/semantics/heading_styles.dart';

class AppText extends StatelessWidget {
  final AppTextStatus _appTextStatus;
  final String text;
  final Color? textColor;
  final TextAlign textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final double? letterSpacing;
  final double? height;
  final TextDecoration? decoration;
  final Locale? locale;
  final TextDirection? textDirection;

  const AppText.headingMd({
    super.key,
    this.textColor = AppColors.colorBlack,
    required this.text,
    this.textAlign = TextAlign.start,
    this.maxLines,
    this.overflow,
    this.letterSpacing,
    this.height,
    this.decoration,
    this.locale,
    this.textDirection,
  }) : _appTextStatus = AppTextStatus.headingMd;

  const AppText.headingSm({
    super.key,
    this.textColor = AppColors.colorBlack,
    required this.text,
    this.textAlign = TextAlign.start,
    this.maxLines,
    this.overflow,
    this.letterSpacing,
    this.height,
    this.decoration,
    this.locale,
    this.textDirection,
  }) : _appTextStatus = AppTextStatus.headingSm;

  const AppText.bodyLg({
    super.key,
    this.textColor = AppColors.colorBlack,
    required this.text,
    this.textAlign = TextAlign.start,
    this.maxLines,
    this.overflow,
    this.letterSpacing,
    this.height,
    this.decoration,
    this.locale,
    this.textDirection,
  }) : _appTextStatus = AppTextStatus.bodyLg;

  const AppText.bodyLgMedium({
    super.key,
    this.textColor = AppColors.colorBlack,
    required this.text,
    this.textAlign = TextAlign.start,
    this.maxLines,
    this.overflow,
    this.letterSpacing,
    this.height,
    this.decoration,
    this.locale,
    this.textDirection,
  }) : _appTextStatus = AppTextStatus.bodyLgMedium;

  const AppText.bodyLgSemiBold({
    super.key,
    this.textColor = AppColors.colorBlack,
    required this.text,
    this.textAlign = TextAlign.start,
    this.maxLines,
    this.overflow,
    this.letterSpacing,
    this.height,
    this.decoration,
    this.locale,
    this.textDirection,
  }) : _appTextStatus = AppTextStatus.bodyLgSemiBold;

  const AppText.bodyMd({
    super.key,
    this.textColor = AppColors.colorBlack,
    required this.text,
    this.textAlign = TextAlign.start,
    this.maxLines,
    this.overflow,
    this.letterSpacing,
    this.height,
    this.decoration,
    this.locale,
    this.textDirection,
  }) : _appTextStatus = AppTextStatus.bodyMd;

  const AppText.bodyMdMedium({
    super.key,
    this.textColor = AppColors.colorBlack,
    required this.text,
    this.textAlign = TextAlign.start,
    this.maxLines,
    this.overflow,
    this.letterSpacing,
    this.height,
    this.decoration,
    this.locale,
    this.textDirection,
  }) : _appTextStatus = AppTextStatus.bodyMdMedium;

  const AppText.bodyMdSemiBold({
    super.key,
    this.textColor = AppColors.colorBlack,
    required this.text,
    this.textAlign = TextAlign.start,
    this.maxLines,
    this.overflow,
    this.letterSpacing,
    this.height,
    this.decoration,
    this.locale,
    this.textDirection,
  }) : _appTextStatus = AppTextStatus.bodyMdSemiBold;

  const AppText.bodySm({
    super.key,
    this.textColor = AppColors.colorBlack,
    required this.text,
    this.textAlign = TextAlign.start,
    this.maxLines,
    this.overflow,
    this.letterSpacing,
    this.height,
    this.decoration,
    this.locale,
    this.textDirection,
  }) : _appTextStatus = AppTextStatus.bodySm;

  const AppText.bodySmMedium({
    super.key,
    this.textColor = AppColors.colorBlack,
    required this.text,
    this.textAlign = TextAlign.start,
    this.maxLines,
    this.overflow,
    this.letterSpacing,
    this.height,
    this.decoration,
    this.locale,
    this.textDirection,
  }) : _appTextStatus = AppTextStatus.bodySmMedium;

  const AppText.bodySmSemiBold({
    super.key,
    this.textColor = AppColors.colorBlack,
    required this.text,
    this.textAlign = TextAlign.start,
    this.maxLines,
    this.overflow,
    this.letterSpacing,
    this.height,
    this.locale,
    this.textDirection,
    this.decoration,
  }) : _appTextStatus = AppTextStatus.bodySmSemiBold;

  const AppText.captionLg({
    super.key,
    this.textColor = AppColors.colorBlack,
    required this.text,
    this.textAlign = TextAlign.start,
    this.maxLines,
    this.overflow,
    this.letterSpacing,
    this.height,
    this.decoration,
    this.locale,
    this.textDirection,
  }) : _appTextStatus = AppTextStatus.captionLg;

  const AppText.captionLgMedium({
    super.key,
    this.textColor = AppColors.colorBlack,
    required this.text,
    this.textAlign = TextAlign.start,
    this.maxLines,
    this.overflow,
    this.letterSpacing,
    this.height,
    this.decoration,
    this.locale,
    this.textDirection,
  }) : _appTextStatus = AppTextStatus.captionLgMedium;

  const AppText.captionLgSemiBold({
    super.key,
    this.textColor = AppColors.colorBlack,
    required this.text,
    this.textAlign = TextAlign.start,
    this.maxLines,
    this.overflow,
    this.letterSpacing,
    this.locale,
    this.textDirection,
    this.height,
    this.decoration,
  }) : _appTextStatus = AppTextStatus.captionLgSemiBold;

  const AppText.captionSm({
    super.key,
    this.textColor = AppColors.colorBlack,
    required this.text,
    this.textAlign = TextAlign.start,
    this.maxLines,
    this.overflow,
    this.letterSpacing,
    this.height,
    this.locale,
    this.textDirection,
    this.decoration,
  }) : _appTextStatus = AppTextStatus.captionSm;

  const AppText.captionSmSemiBold({
    super.key,
    this.textColor = AppColors.colorBlack,
    required this.text,
    this.textAlign = TextAlign.start,
    this.maxLines,
    this.overflow,
    this.letterSpacing,
    this.height,
    this.decoration,
    this.locale,
    this.textDirection,
  }) : _appTextStatus = AppTextStatus.captionSmSemiBold;

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      text,
      textAlign: textAlign,
      maxLines: maxLines,
      locale: locale,
      textDirection: textDirection,
      overflow: overflow ?? TextOverflow.ellipsis,
      style: AppTextStyles.getStyle(_appTextStatus, context).copyWith(
        color: textColor,
        letterSpacing: letterSpacing,
        leadingDistribution: TextLeadingDistribution.even,
        height: height,
        decoration: decoration,
      ),
    );
  }
}

class AppTextStyles {
  final AppTextStatus status;
  AppTextStyles({required this.status});
  static TextStyle getStyle(AppTextStatus status, BuildContext context) {
    switch (status) {
      case AppTextStatus.headingMd:
        return HeadingStyles.headingMd;
      case AppTextStatus.headingSm:
        return HeadingStyles.headingSm;
      case AppTextStatus.bodyLg:
        return BodyStyles.bodyLg;
      case AppTextStatus.bodyLgMedium:
        return BodyStyles.bodyLgMedium(context);
      case AppTextStatus.bodyLgSemiBold:
        return BodyStyles.bodyLgSemiBold;
      case AppTextStatus.bodyMd:
        return BodyStyles.bodyMd;
      case AppTextStatus.bodyMdMedium:
        return BodyStyles.bodyMdMedium(context);
      case AppTextStatus.bodyMdSemiBold:
        return BodyStyles.bodyMdSemiBold;

      case AppTextStatus.bodySm:
        return BodyStyles.bodySm;
      case AppTextStatus.bodySmMedium:
        return BodyStyles.bodySmMedium(context);
      case AppTextStatus.bodySmSemiBold:
        return BodyStyles.bodySmSemiBold;
      case AppTextStatus.captionLg:
        return CaptionStyles.captionLg;
      case AppTextStatus.captionLgMedium:
        return CaptionStyles.captionLgMedium(context);
      case AppTextStatus.captionLgSemiBold:
        return CaptionStyles.captionLgSemiBold;
      case AppTextStatus.captionSm:
        return CaptionStyles.captionSm;
      case AppTextStatus.captionSmSemiBold:
        return CaptionStyles.captionSmSemiBold;
    }
  }
}

enum AppTextStatus {
  headingMd,
  headingSm,
  bodyLg,
  bodyLgMedium,
  bodyLgSemiBold,
  bodyMd,
  bodyMdMedium,
  bodyMdSemiBold,
  bodySm,
  bodySmMedium,
  bodySmSemiBold,
  captionLg,
  captionLgMedium,
  captionLgSemiBold,

  captionSm,

  captionSmSemiBold,
}
