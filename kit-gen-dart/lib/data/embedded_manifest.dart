// Auto-generated manifest - DO NOT EDIT MANUALLY
// To update: run `dart run kit_gen manifest` then copy to lib/data/components.json
// Then regenerate this file

const String embeddedManifest = '''
{
  "generatedAt": "2026-03-30T12:43:55.514876",
  "kitVersion": "1.0.0",
  "packageName": "tagaddod_ui_kit",
  "widgets": [
    {
      "className": "AppBadge",
      "description": "Badge for status indicators and labels.",
      "importPath": "package:tagaddod_ui_kit/widgets/app_badge.dart",
      "example": "AppBadge.small(\\n  textLabel: 'New',\\n  badgeType: AppBadgeType.info,\\n)"
    },
    {
      "className": "AppBottomNavigationBar",
      "description": "Bottom navigation bar.",
      "importPath": "package:tagaddod_ui_kit/widgets/bottom_navigation_bar.dart",
      "example": "AppBottomNavigationBar()"
    },
    {
      "className": "AppBottomSheet",
      "description": "Bottom sheet modal component.",
      "importPath": "package:tagaddod_ui_kit/widgets/app_bottom_sheet.dart",
      "example": "AppBottomSheet()"
    },
    {
      "className": "AppCheckBox",
      "description": "Checkbox input with custom styling.",
      "importPath": "package:tagaddod_ui_kit/widgets/app_check_box.dart",
      "example": "AppCheckBox(\\n  value: isChecked,\\n  onChanged: (value) => setState(() => isChecked = value),\\n)"
    },
    {
      "className": "AppDivider",
      "description": "Horizontal or vertical divider line.",
      "importPath": "package:tagaddod_ui_kit/widgets/app_divider.dart",
      "example": "AppDivider()"
    },
    {
      "className": "AppExpandableView",
      "description": "Expandable/collapsible content container.",
      "importPath": "package:tagaddod_ui_kit/widgets/app_expandable_view.dart",
      "example": "AppExpandableView()"
    },
    {
      "className": "AppFilledButton",
      "description": "Primary filled button with multiple sizes. Use for main CTAs.",
      "importPath": "package:tagaddod_ui_kit/widgets/button/app_filled_button.dart",
      "example": "AppFilledButton.large(\\n  btnText: 'Submit',\\n  onTap: () {},\\n  buttonType: ButtonType.defaultButton,\\n)"
    },
    {
      "className": "AppFilledIconButton",
      "description": "AppFilledIconButton component",
      "importPath": "package:tagaddod_ui_kit/widgets/icon_button/app_filled_icon_button.dart",
      "example": "AppFilledIconButton()"
    },
    {
      "className": "AppIcon",
      "description": "SVG icon renderer with color filter support.",
      "importPath": "package:tagaddod_ui_kit/widgets/app_icon.dart",
      "example": "AppIcon(\\n  svgIconPath: 'assets/svg/icon.svg',\\n  width: 24,\\n  height: 24,\\n)"
    },
    {
      "className": "AppLoadingView",
      "description": "Loading spinner overlay.",
      "importPath": "package:tagaddod_ui_kit/widgets/app_loading_view.dart",
      "example": "AppLoadingView()"
    },
    {
      "className": "AppLogo",
      "description": "AppLogo component",
      "importPath": "package:tagaddod_ui_kit/widgets/app_logo.dart",
      "example": "AppLogo()"
    },
    {
      "className": "AppModalDialog",
      "description": "Modal dialog with header and content.",
      "importPath": "package:tagaddod_ui_kit/widgets/app_modal_dialog/app_modal_dialog.dart",
      "example": "AppModalDialog()"
    },
    {
      "className": "AppModalHeader",
      "description": "AppModalHeader component",
      "importPath": "package:tagaddod_ui_kit/widgets/app_modal_dialog/modal_header.dart",
      "example": "AppModalHeader()"
    },
    {
      "className": "AppOutlinedButton",
      "description": "Outlined button. Use for secondary actions.",
      "importPath": "package:tagaddod_ui_kit/widgets/button/app_outlined_button.dart",
      "example": "AppOutlinedButton()"
    },
    {
      "className": "AppOutlinedIconButton",
      "description": "AppOutlinedIconButton component",
      "importPath": "package:tagaddod_ui_kit/widgets/icon_button/app_outlined_icon_button.dart",
      "example": "AppOutlinedIconButton()"
    },
    {
      "className": "AppStandardIconButton",
      "description": "AppStandardIconButton component",
      "importPath": "package:tagaddod_ui_kit/widgets/icon_button/app_standard_icon_button.dart",
      "example": "AppStandardIconButton()"
    },
    {
      "className": "AppStepper",
      "description": "Step-by-step progress indicator.",
      "importPath": "package:tagaddod_ui_kit/widgets/app_stepper.dart",
      "example": "AppStepper()"
    },
    {
      "className": "AppSwitch",
      "description": "Toggle switch component.",
      "importPath": "package:tagaddod_ui_kit/widgets/app_switch.dart",
      "example": "AppSwitch(\\n  value: isEnabled,\\n  onChanged: (value) => setState(() => isEnabled = value),\\n)"
    },
    {
      "className": "AppText",
      "description": "Typography component with semantic variants.",
      "importPath": "package:tagaddod_ui_kit/widgets/app_text.dart",
      "example": "AppText.bodyMd(\\n  text: 'Welcome',\\n  textColor: TextColors.colorText,\\n)"
    },
    {
      "className": "AppTextButton",
      "description": "Text-only button. Use for tertiary actions.",
      "importPath": "package:tagaddod_ui_kit/widgets/button/app_text_button.dart",
      "example": "AppTextButton()"
    },
    {
      "className": "AppTextField",
      "description": "Text input with label, validation, and helper text.",
      "importPath": "package:tagaddod_ui_kit/widgets/app_text_field.dart",
      "example": "AppTextField.large(\\n  labelText: 'Email',\\n  hintText: 'Enter your email',\\n  textEditingController: controller,\\n  keyboardType: TextInputType.emailAddress,\\n)"
    },
    {
      "className": "AppTonalButton",
      "description": "Tonal button. Use for medium-emphasis actions.",
      "importPath": "package:tagaddod_ui_kit/widgets/button/app_tonal_button.dart",
      "example": "AppTonalButton()"
    },
    {
      "className": "AppTonalIconButton",
      "description": "AppTonalIconButton component",
      "importPath": "package:tagaddod_ui_kit/widgets/icon_button/app_tonal_icon_button.dart",
      "example": "AppTonalIconButton()"
    },
    {
      "className": "BarPercentIndicator",
      "description": "Linear bar progress indicator.",
      "importPath": "package:tagaddod_ui_kit/widgets/bar_percent_indicator.dart",
      "example": "BarPercentIndicator()"
    },
    {
      "className": "CirclePercentIndicator",
      "description": "Circular progress indicator.",
      "importPath": "package:tagaddod_ui_kit/widgets/circle_percent_indicator.dart",
      "example": "CirclePercentIndicator()"
    },
    {
      "className": "DottedRoundedBorder",
      "description": "DottedRoundedBorder component",
      "importPath": "package:tagaddod_ui_kit/widgets/app_dotted_box.dart",
      "example": "DottedRoundedBorder()"
    },
    {
      "className": "ErrorMessage",
      "description": "Toast message for error notifications.",
      "importPath": "package:tagaddod_ui_kit/widgets/Toast_message/error_message.dart",
      "example": "ErrorMessage()"
    },
    {
      "className": "MultiSegmentCircularProgress",
      "description": "MultiSegmentCircularProgress component",
      "importPath": "package:tagaddod_ui_kit/widgets/multi_segment_circular_progress.dart",
      "example": "MultiSegmentCircularProgress()"
    },
    {
      "className": "MultiSegmentLinearProgress",
      "description": "MultiSegmentLinearProgress component",
      "importPath": "package:tagaddod_ui_kit/widgets/multi_segment_progress_line.dart",
      "example": "MultiSegmentLinearProgress()"
    },
    {
      "className": "NumberContainer",
      "description": "NumberContainer component",
      "importPath": "package:tagaddod_ui_kit/widgets/number_container.dart",
      "example": "NumberContainer()"
    },
    {
      "className": "NumberCounter",
      "description": "Animated number counter component.",
      "importPath": "package:tagaddod_ui_kit/widgets/number_counter.dart",
      "example": "NumberCounter()"
    },
    {
      "className": "AppRadioButton",
      "description": "Radio button input with custom styling.",
      "importPath": "package:tagaddod_ui_kit/widgets/app_radio_button.dart",
      "example": "AppRadioButton<String>(\\n  value: 'option1',\\n  groupValue: selectedValue,\\n  onChanged: (value) => setState(() => selectedValue = value),\\n)"
    },
    {
      "className": "ScrollableTabBar",
      "description": "Scrollable tab bar for navigation.",
      "importPath": "package:tagaddod_ui_kit/widgets/scrollable_tab_bar.dart",
      "example": "ScrollableTabBar()"
    },
    {
      "className": "StepperFlow",
      "description": "Multi-step flow component.",
      "importPath": "package:tagaddod_ui_kit/widgets/stepper_flow.dart",
      "example": "StepperFlow()"
    },
    {
      "className": "SuccessMessage",
      "description": "Toast message for success notifications.",
      "importPath": "package:tagaddod_ui_kit/widgets/Toast_message/success_message.dart",
      "example": "SuccessMessage()"
    },
    {
      "className": "TopAppBar",
      "description": "Top app bar with title and actions.",
      "importPath": "package:tagaddod_ui_kit/widgets/top_app_bar.dart",
      "example": "TopAppBar()"
    }
  ]
}
''';
