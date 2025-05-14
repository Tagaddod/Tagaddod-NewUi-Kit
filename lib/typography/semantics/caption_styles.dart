import 'package:flutter/cupertino.dart';
import 'package:tagaddod_ui_kit/extensions/locale_font_style.dart';
import 'package:tagaddod_ui_kit/typography/primitives/typography.dart';

class CaptionStyles {
  static const captionLg = TextStyle(
    fontSize: Typography.fontSize300,
    fontWeight: Typography.fontWeightRegular,
    height: 1.5,
  );

  static TextStyle captionLgMedium(BuildContext context) => const TextStyle(
        fontSize: Typography.fontSize300,
        fontWeight: Typography.fontWeightMedium,
        height: 1.5,
      ).withLocaleFont(context);

  static const captionLgSemiBold = TextStyle(
    fontSize: Typography.fontSize300,
    fontWeight: Typography.fontWeightSemiBold,
    height: 1.5,
  );

  static const captionSm = TextStyle(
    fontSize: Typography.fontSize250,
    fontWeight: Typography.fontWeightRegular,
    height: 1.5,
  );

  static const captionSmSemiBold = TextStyle(
    fontSize: Typography.fontSize250,
    fontWeight: Typography.fontWeightSemiBold,
    height: 1,
  );
}
