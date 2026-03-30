# Tagaddod UI Kit

Shared Flutter UI component library for all Tagaddod applications.

> **NEW:** Kit-Gen AI code generator included! Generate Flutter screens using only kit components.
> 
> See **[kit-gen-dart/](kit-gen-dart/)** for the CLI tool.

## Overview

This package provides a comprehensive set of reusable Flutter widgets that implement Tagaddod's design system. All Tagaddod apps should use these components to ensure visual consistency and reduce development time.

## Package Name

```yaml
tagaddod_ui_kit
```

## Components

### Buttons
- `AppFilledButton` - Primary filled buttons (.medium, .large)
- `AppOutlinedButton` - Secondary outlined buttons
- `AppTextButton` - Tertiary text-only buttons
- `AppTonalButton` - Medium-emphasis tonal buttons
- `AppFilledIconButton` - Icon-only filled buttons
- `AppOutlinedIconButton` - Icon-only outlined buttons
- `AppStandardIconButton` - Icon-only standard buttons
- `AppTonalIconButton` - Icon-only tonal buttons

### Inputs
- `AppTextField` - Text input with validation (.medium, .large)
- `AppCheckBox` - Checkbox input
- `AppRadioButton` - Radio button input
- `AppSwitch` - Toggle switch

### Navigation
- `AppBottomNavigationBar` - Bottom navigation bar
- `TopAppBar` - Top app bar
- `ScrollableTabBar` - Scrollable tab bar

### Typography
- `AppText` - Text display with semantic variants (heading, body, caption)

### Indicators
- `AppBadge` - Status badges (.small, .medium)
- `CirclePercentIndicator` - Circular progress
- `BarPercentIndicator` - Linear progress
- `MultiSegmentCircularProgress` - Multi-segment circular progress
- `MultiSegmentLinearProgress` - Multi-segment linear progress
- `AppStepper` - Step indicator
- `StepperFlow` - Multi-step flow

### Modals & Overlays
- `AppModalDialog` - Modal dialog
- `AppBottomSheet` - Bottom sheet
- `AppLoadingView` - Loading overlay
- `SuccessMessage` - Success toast
- `ErrorMessage` - Error toast

### Layout & Display
- `AppDivider` - Divider line
- `AppExpandableView` - Expandable content
- `NumberContainer` - Number display container
- `NumberCounter` - Animated number counter
- `AppIcon` - SVG icon renderer
- `AppLogo` - App logo

## Design System

### Colors
- `TextColors` - Semantic text colors
- `BgColors` - Semantic background colors
- `BorderColors` - Semantic border colors
- `IconColors` - Semantic icon colors

### Typography
- `HeadingStyles` - Heading text styles
- `BodyStyles` - Body text styles
- `CaptionStyles` - Caption text styles

### Button Types
- `ButtonType.defaultButton` - Brand/primary
- `ButtonType.successButton` - Success/positive
- `ButtonType.criticalButton` - Error/destructive
- `ButtonType.neutralButton` - Neutral/secondary

## Installation

Add to your `pubspec.yaml`:

```yaml
dependencies:
  tagaddod_ui_kit:
    path: ../Tagaddod-NewUi-Kit
```

Or for published package:

```yaml
dependencies:
  tagaddod_ui_kit: ^1.0.0
```

## Usage

```dart
import 'package:tagaddod_ui_kit/widgets/button/app_filled_button.dart';
import 'package:tagaddod_ui_kit/widgets/app_text.dart';
import 'package:tagaddod_ui_kit/colors/semantic/text_colors.dart';

// Use components
AppFilledButton.large(
  btnText: 'Sign In',
  onTap: () => handleSignIn(),
  buttonType: ButtonType.defaultButton,
)

AppText.bodyMd(
  text: 'Welcome back!',
  textColor: TextColors.colorText,
)
```

## Kit-Gen: AI Code Generator

**Kit-Gen** is an AI-powered CLI tool that generates Flutter code using only Tagaddod UI Kit components.

### Install

```bash
dart pub global activate --source git https://github.com/Tagaddod/Tagaddod-NewUi-Kit.git --git-path kit-gen-dart
kit-gen config set-key
```

### Use

```bash
kit-gen gen -r "Create a login screen with email and password fields"
```

See **[kit-gen-dart/README.md](kit-gen-dart/README.md)** for full documentation.

## Development

### Adding New Components

1. Create widget file in `lib/widgets/`
2. Follow existing patterns (named constructors for sizes)
3. Use semantic design tokens
4. Keep files under 90 lines
5. Add to `app_drawer.dart` for preview
6. Regenerate kit-gen manifest: `cd kit-gen-dart && dart run kit_gen manifest`

### Coding Standards

- Use Cubit for state management
- Follow clean architecture
- Separate widgets into classes (not methods)
- Keep files under 90 lines
- Use semantic tokens (never hardcode colors/sizes)

## Architecture

```
lib/
├── widgets/          # UI components
├── colors/           # Color tokens (primitives + semantic)
├── typography/       # Typography tokens (primitives + semantic)
├── dimensions/       # Spacing and sizing tokens
├── utils/            # Utilities and helpers
└── samples/          # Component examples/demos
```

## Contributing

1. Create feature branch
2. Add/update components following standards
3. Test in sample app
4. Update kit-gen manifest
5. Submit PR

## License

Private - Tagaddod Internal Use Only

## Support

Contact: Flutter Team Lead
