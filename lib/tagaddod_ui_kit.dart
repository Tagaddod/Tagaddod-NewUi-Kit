// Barrel file — import this single file to access all Tagaddod UI kit widgets,
// colors, assets, and enums.
export 'package:tagaddod_ui_kit/colors/primtives/colors.dart';
export 'package:tagaddod_ui_kit/assests/assets.dart';
// Utils — ButtonType must be exported separately (defined in utils/, not in button files)
export 'package:tagaddod_ui_kit/utils/button_type.dart';
export 'package:tagaddod_ui_kit/widgets/top_app_bar.dart';
export 'package:tagaddod_ui_kit/widgets/app_text.dart';
export 'package:tagaddod_ui_kit/widgets/app_text_field.dart';
export 'package:tagaddod_ui_kit/widgets/app_icon.dart';
export 'package:tagaddod_ui_kit/widgets/app_logo.dart';
export 'package:tagaddod_ui_kit/widgets/app_badge.dart';
export 'package:tagaddod_ui_kit/widgets/app_divider.dart';
export 'package:tagaddod_ui_kit/widgets/app_check_box.dart';
export 'package:tagaddod_ui_kit/widgets/app_radio_button.dart';
export 'package:tagaddod_ui_kit/widgets/app_switch.dart';
export 'package:tagaddod_ui_kit/widgets/app_loading_view.dart';
export 'package:tagaddod_ui_kit/widgets/app_expandable_view.dart';
export 'package:tagaddod_ui_kit/widgets/app_bottom_sheet.dart';
export 'package:tagaddod_ui_kit/widgets/app_dotted_box.dart';
export 'package:tagaddod_ui_kit/widgets/app_stepper.dart';
export 'package:tagaddod_ui_kit/widgets/stepper_flow.dart';
export 'package:tagaddod_ui_kit/widgets/scrollable_tab_bar.dart';
export 'package:tagaddod_ui_kit/widgets/bottom_navigation_bar.dart';
export 'package:tagaddod_ui_kit/widgets/bar_percent_indicator.dart';
export 'package:tagaddod_ui_kit/widgets/circle_percent_indicator.dart';
export 'package:tagaddod_ui_kit/widgets/number_container.dart';
export 'package:tagaddod_ui_kit/widgets/number_counter.dart';
export 'package:tagaddod_ui_kit/widgets/multi_segment_circular_progress.dart';
export 'package:tagaddod_ui_kit/widgets/multi_segment_progress_line.dart';
// Buttons — getDefaultTextColor and ButtonSize are internal helpers; export
// them once from app_filled_button and hide the duplicates in other files.
export 'package:tagaddod_ui_kit/widgets/button/app_filled_button.dart';
export 'package:tagaddod_ui_kit/widgets/button/app_outlined_button.dart'
    hide getDefaultTextColor;
export 'package:tagaddod_ui_kit/widgets/button/app_text_button.dart'
    hide getDefaultTextColor;
export 'package:tagaddod_ui_kit/widgets/button/app_tonal_button.dart'
    hide getDefaultTextColor, ButtonSize;
// Icon buttons — ButtonSize, getDefaultIconColor, getDefaultBorderColor are
// internal helpers already exported via the button files above.
export 'package:tagaddod_ui_kit/widgets/icon_button/app_filled_icon_button.dart'
    hide ButtonSize;
export 'package:tagaddod_ui_kit/widgets/icon_button/app_outlined_icon_button.dart'
    hide getDefaultIconColor, getDefaultBorderColor;
export 'package:tagaddod_ui_kit/widgets/icon_button/app_standard_icon_button.dart'
    hide getDefaultIconColor;
export 'package:tagaddod_ui_kit/widgets/icon_button/app_tonal_icon_button.dart'
    hide getDefaultIconColor, ButtonSize;
export 'package:tagaddod_ui_kit/widgets/app_modal_dialog/app_modal_dialog.dart';
export 'package:tagaddod_ui_kit/widgets/Toast_message/success_message.dart';
export 'package:tagaddod_ui_kit/widgets/Toast_message/error_message.dart';
