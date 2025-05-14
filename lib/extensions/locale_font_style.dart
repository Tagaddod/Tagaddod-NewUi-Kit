import 'package:flutter/material.dart';
import 'package:tagaddod_ui_kit/typography/primitives/typography.dart' as ui;

extension LocaleFontStyle on TextStyle {
  TextStyle withLocaleFont(BuildContext context) {
    FontWeight? fontWeight;

    switch (Localizations.localeOf(context)) {
      case 'ar':
        fontWeight =
            ui.Typography.fontWeightSemiBold; // Replace with your Arabic font
        break;
      case 'en':
        fontWeight =
            ui.Typography.fontWeightMedium; // Replace with your English font
        break;
      default:
        fontWeight =
            ui.Typography.fontWeightSemiBold; // Replace with your default font
    }

    return copyWith(fontWeight: fontWeight);
  }
}
