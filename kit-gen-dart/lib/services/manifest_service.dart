import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart' as path;

class ManifestService {
  final String kitPath;

  ManifestService(this.kitPath);

  Future<KitManifest> generateManifest() async {
    final widgetsDir = Directory(path.join(kitPath, 'lib', 'widgets'));
    final widgets = <WidgetInfo>[];

    await for (final entity in widgetsDir.list(recursive: true)) {
      if (entity is File && entity.path.endsWith('.dart')) {
        final widgetInfo = await _parseWidgetFile(entity);
        if (widgetInfo != null) {
          widgets.add(widgetInfo);
        }
      }
    }

    widgets.sort((a, b) => a.className.compareTo(b.className));

    return KitManifest(
      generatedAt: DateTime.now(),
      kitVersion: '1.0.0',
      packageName: 'tagaddod_ui_kit',
      widgets: widgets,
    );
  }

  Future<WidgetInfo?> _parseWidgetFile(File file) async {
    final content = await file.readAsString();
    final classMatch = RegExp(
      r'class\s+(\w+)\s+extends\s+(StatelessWidget|StatefulWidget|FormField)',
    ).firstMatch(content);

    if (classMatch == null) return null;

    final className = classMatch.group(1)!;
    if (className.startsWith('_')) return null;

    final relativePath =
        path.relative(file.path, from: path.join(kitPath, 'lib'));
    final importPath = 'package:tagaddod_ui_kit/$relativePath';

    final description = _getDescription(className);
    final example = _getExample(className);

    return WidgetInfo(
      className: className,
      description: description,
      importPath: importPath,
      example: example,
    );
  }

  String _getDescription(String className) {
    final descriptions = {
      'AppFilledButton':
          'Primary filled button with multiple sizes. Use for main CTAs.',
      'AppOutlinedButton': 'Outlined button. Use for secondary actions.',
      'AppTextButton': 'Text-only button. Use for tertiary actions.',
      'AppTonalButton': 'Tonal button. Use for medium-emphasis actions.',
      'AppTextField': 'Text input with label, validation, and helper text.',
      'AppText': 'Typography component with semantic variants.',
      'AppIcon': 'SVG icon renderer with color filter support.',
      'AppBadge': 'Badge for status indicators and labels.',
      'AppCheckBox': 'Checkbox input with custom styling.',
      'AppRadioButton': 'Radio button input with custom styling.',
      'AppSwitch': 'Toggle switch component.',
      'AppBottomNavigationBar': 'Bottom navigation bar.',
      'TopAppBar': 'Top app bar with title and actions.',
      'AppBottomSheet': 'Bottom sheet modal component.',
      'AppModalDialog': 'Modal dialog with header and content.',
      'AppDivider': 'Horizontal or vertical divider line.',
      'AppExpandableView': 'Expandable/collapsible content container.',
      'AppLoadingView': 'Loading spinner overlay.',
      'AppStepper': 'Step-by-step progress indicator.',
      'StepperFlow': 'Multi-step flow component.',
      'ScrollableTabBar': 'Scrollable tab bar for navigation.',
      'NumberCounter': 'Animated number counter component.',
      'CirclePercentIndicator': 'Circular progress indicator.',
      'BarPercentIndicator': 'Linear bar progress indicator.',
      'SuccessMessage': 'Toast message for success notifications.',
      'ErrorMessage': 'Toast message for error notifications.',
    };

    return descriptions[className] ?? '$className component';
  }

  String _getExample(String className) {
    final examples = {
      'AppFilledButton': '''AppFilledButton.large(
  btnText: 'Submit',
  onTap: () {},
  buttonType: ButtonType.defaultButton,
)''',
      'AppTextField': '''AppTextField.large(
  labelText: 'Email',
  hintText: 'Enter your email',
  textEditingController: controller,
  keyboardType: TextInputType.emailAddress,
)''',
      'AppText': '''AppText.bodyMd(
  text: 'Welcome',
  textColor: TextColors.colorText,
)''',
      'AppIcon': '''AppIcon(
  svgIconPath: 'assets/svg/icon.svg',
  width: 24,
  height: 24,
)''',
      'AppBadge': '''AppBadge.small(
  textLabel: 'New',
  badgeType: AppBadgeType.info,
)''',
      'AppCheckBox': '''AppCheckBox(
  value: isChecked,
  onChanged: (value) => setState(() => isChecked = value),
)''',
      'AppSwitch': '''AppSwitch(
  value: isEnabled,
  onChanged: (value) => setState(() => isEnabled = value),
)''',
    };

    return examples[className] ?? '$className()';
  }
}

class KitManifest {
  final DateTime generatedAt;
  final String kitVersion;
  final String packageName;
  final List<WidgetInfo> widgets;

  KitManifest({
    required this.generatedAt,
    required this.kitVersion,
    required this.packageName,
    required this.widgets,
  });

  Map<String, dynamic> toJson() => {
        'generatedAt': generatedAt.toIso8601String(),
        'kitVersion': kitVersion,
        'packageName': packageName,
        'widgets': widgets.map((w) => w.toJson()).toList(),
      };

  factory KitManifest.fromJson(Map<String, dynamic> json) => KitManifest(
        generatedAt: DateTime.parse(json['generatedAt']),
        kitVersion: json['kitVersion'],
        packageName: json['packageName'],
        widgets: (json['widgets'] as List)
            .map((w) => WidgetInfo.fromJson(w))
            .toList(),
      );
}

class WidgetInfo {
  final String className;
  final String description;
  final String importPath;
  final String example;

  WidgetInfo({
    required this.className,
    required this.description,
    required this.importPath,
    required this.example,
  });

  Map<String, dynamic> toJson() => {
        'className': className,
        'description': description,
        'importPath': importPath,
        'example': example,
      };

  factory WidgetInfo.fromJson(Map<String, dynamic> json) => WidgetInfo(
        className: json['className'],
        description: json['description'],
        importPath: json['importPath'],
        example: json['example'],
      );
}
