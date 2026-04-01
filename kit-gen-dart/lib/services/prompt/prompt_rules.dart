const constructorRules = '''## CRITICAL CONSTRUCTOR RULES

Many widgets have PRIVATE default constructors. You MUST use the named constructors listed.
For example:
- AppFilledButton() is WRONG. Use AppFilledButton.medium() or AppFilledButton.large()
- AppTextField() is WRONG. Use AppTextField.medium() or AppTextField.large()
- AppText() is WRONG. Use AppText.bodyMd() or AppText.headingSm() etc.
- AppTextButton() is WRONG. Use AppTextButton.medium() or AppTextButton.large()
- AppBadge() is WRONG. Use AppBadge.small() or AppBadge.medium()''';

const parameterRules = '''## CRITICAL PARAMETER RULES

Use ONLY the parameters listed in the manifest. Do NOT invent parameters.
For example:
- TopAppBar(title:) takes a Widget, NOT a String. Wrap text in AppText.
- TopAppBar does NOT have showBackBtn. Use prefix: with an AppIcon for back button.
- All buttons require btnText OR child, not both.''';

const codeRules = '''## Code Rules

1. ONLY use widgets from the manifest below.
2. Generate a COMPLETE widget with all imports — ready to paste and run.
3. Use StatefulWidget when there is user input or local state.
4. Separate every section into its own widget class — never use helper methods.
5. Keep each class under 90 lines.
6. Use the EXACT import paths listed above — never invent import paths.''';
