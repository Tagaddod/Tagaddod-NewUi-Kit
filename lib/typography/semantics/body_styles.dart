import 'package:flutter/cupertino.dart';
import 'package:tagaddod_ui_kit/extensions/locale_font_style.dart';
import 'package:tagaddod_ui_kit/typography/primitives/typography.dart';

class BodyStyles {
  static const bodyLg = TextStyle(
    fontSize: Typography.fontSize450,
    fontWeight: Typography.fontWeightRegular,
    height: 1.5,
  );
  static TextStyle bodyLgMedium(BuildContext context) => const TextStyle(
        fontSize: Typography.fontSize450,
        fontWeight: Typography.fontWeightMedium,
        height: 1.5,
      ).withLocaleFont(context);

  static const bodyLgSemiBold = TextStyle(
    fontSize: Typography.fontSize450,
    fontWeight: Typography.fontWeightSemiBold,
    height: 1.5,
  );

  static const bodyMd = TextStyle(
    fontSize: Typography.fontSize400,
    fontWeight: Typography.fontWeightRegular,
    height: 1.2,
  );

  static TextStyle bodyMdMedium(BuildContext context) => const TextStyle(
        fontSize: Typography.fontSize400,
        fontWeight: Typography.fontWeightMedium,
        height: 1.5,
      ).withLocaleFont(context);

  static const bodyMdSemiBold = TextStyle(
    fontSize: Typography.fontSize400,
    fontWeight: Typography.fontWeightSemiBold,
    height: 1.5,
  );

  static const bodySm = TextStyle(
    fontSize: Typography.fontSize350,
    fontWeight: Typography.fontWeightRegular,
    leadingDistribution: TextLeadingDistribution.even,
  );

  static const bodySmMedium = TextStyle(
    fontSize: Typography.fontSize350,
    fontWeight: Typography.fontWeightMedium,
    height: 1.5,
  );

  static const bodySmSemiBold = TextStyle(
    fontSize: Typography.fontSize350,
    fontWeight: Typography.fontWeightSemiBold,
    height: 1.5,
    leadingDistribution: TextLeadingDistribution.even,
  );
}
