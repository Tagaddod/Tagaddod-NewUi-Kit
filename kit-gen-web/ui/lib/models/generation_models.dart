class GeneratedCodeFile {
  final String path;
  final String code;
  const GeneratedCodeFile({required this.path, required this.code});

  factory GeneratedCodeFile.fromJson(Map<String, dynamic> json) =>
      GeneratedCodeFile(
        path: json['path'] as String? ?? '',
        code: json['code'] as String? ?? '',
      );
}

class MatchedComponent {
  final String className;
  final String description;
  final String importPath;
  const MatchedComponent({
    required this.className,
    required this.description,
    required this.importPath,
  });

  factory MatchedComponent.fromJson(Map<String, dynamic> json) =>
      MatchedComponent(
        className: json['className'] as String? ?? '',
        description: json['description'] as String? ?? '',
        importPath: json['importPath'] as String? ?? '',
      );
}

class GenerationKitGap {
  final String widgetName;
  final String description;
  const GenerationKitGap({required this.widgetName, required this.description});

  factory GenerationKitGap.fromJson(Map<String, dynamic> json) =>
      GenerationKitGap(
        widgetName: json['widget_name'] as String? ?? '',
        description: json['description'] as String? ?? '',
      );
}

class ValidationStatus {
  final bool ran;
  final bool passed;
  final List<String> errors;
  final bool repaired;
  const ValidationStatus({
    required this.ran,
    required this.passed,
    required this.errors,
    required this.repaired,
  });

  factory ValidationStatus.fromJson(Map<String, dynamic> json) =>
      ValidationStatus(
        ran: json['ran'] as bool? ?? false,
        passed: json['passed'] as bool? ?? false,
        errors: (json['errors'] as List<dynamic>? ?? const [])
            .map((e) => '$e')
            .toList(),
        repaired: json['repaired'] as bool? ?? false,
      );
}
