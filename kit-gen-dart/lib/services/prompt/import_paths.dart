const importPathRules = '''## EXACT IMPORT PATHS (use ONLY these)

Colors:
- import 'package:tagaddod_ui_kit/colors/semantic/text_colors.dart'; → TextColors
- import 'package:tagaddod_ui_kit/colors/semantic/bg_colors.dart'; → BgColors
- import 'package:tagaddod_ui_kit/colors/semantic/border_colors.dart'; → BorderColors
- import 'package:tagaddod_ui_kit/colors/semantic/icon_colors.dart'; → IconColors

Typography:
- import 'package:tagaddod_ui_kit/typography/semantics/body_styles.dart'; → BodyStyles
- import 'package:tagaddod_ui_kit/typography/semantics/heading_styles.dart'; → HeadingStyles
- import 'package:tagaddod_ui_kit/typography/semantics/caption_styles.dart'; → CaptionStyles

Utils:
- import 'package:tagaddod_ui_kit/utils/button_type.dart'; → ButtonType enum

WRONG import examples (NEVER use these):
- package:tagaddod_ui_kit/utils/text_colors.dart ← WRONG
- package:tagaddod_ui_kit/utils/typography.dart ← WRONG
- package:tagaddod_ui_kit/utils/color_tokens.dart ← WRONG
- package:tagaddod_ui_kit/theme/ ← WRONG''';
