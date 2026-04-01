class GenerationPayload {
  final String mode;
  final String requirement;
  final String screenCode;
  final List<GeneratedCodeFile> files;
  final List<MatchedComponent> matchedComponents;
  final List<GenerationKitGap> kitGaps;
  final ValidationStatus validation;
  final PreviewArtifact preview;
  final UsageMetrics tokens;
  final UsageMetrics timings;

  const GenerationPayload({
    required this.mode,
    required this.requirement,
    required this.screenCode,
    required this.files,
    required this.matchedComponents,
    required this.kitGaps,
    required this.validation,
    required this.preview,
    required this.tokens,
    required this.timings,
  });

  bool get isArchitectureMode => mode == 'arch';

  factory GenerationPayload.fromJson(Map<String, dynamic> json) {
    return GenerationPayload(
      mode: json['mode'] as String? ?? 'single',
      requirement: json['requirement'] as String? ?? '',
      screenCode: (json['screenCode'] ?? json['code']) as String? ?? '',
      files: (json['files'] as List<dynamic>? ?? const [])
          .map(
            (item) => GeneratedCodeFile.fromJson(
              item as Map<String, dynamic>,
            ),
          )
          .toList(),
      matchedComponents:
          (json['matchedComponents'] as List<dynamic>? ?? const [])
              .map(
                (item) => MatchedComponent.fromJson(
                  item as Map<String, dynamic>,
                ),
              )
              .toList(),
      kitGaps: (json['kitGaps'] as List<dynamic>? ?? const [])
          .map(
            (item) => GenerationKitGap.fromJson(
              item as Map<String, dynamic>,
            ),
          )
          .toList(),
      validation: ValidationStatus.fromJson(
        json['validation'] as Map<String, dynamic>? ?? const {},
      ),
      preview: PreviewArtifact.fromJson(
        json['preview'] as Map<String, dynamic>? ?? const {},
      ),
      tokens: UsageMetrics.fromJson(
        json['tokens'] as Map<String, dynamic>? ?? const {},
      ),
      timings: UsageMetrics.fromJson(
        json['timings'] as Map<String, dynamic>? ?? const {},
      ),
    );
  }
}

class GeneratedCodeFile {
  final String path;
  final String code;

  const GeneratedCodeFile({
    required this.path,
    required this.code,
  });

  factory GeneratedCodeFile.fromJson(Map<String, dynamic> json) {
    return GeneratedCodeFile(
      path: json['path'] as String? ?? '',
      code: json['code'] as String? ?? '',
    );
  }
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

  factory MatchedComponent.fromJson(Map<String, dynamic> json) {
    return MatchedComponent(
      className: json['className'] as String? ?? '',
      description: json['description'] as String? ?? '',
      importPath: json['importPath'] as String? ?? '',
    );
  }
}

class GenerationKitGap {
  final String widgetName;
  final String description;
  final String? reason;
  final String? suggestedComponentName;
  final int? priority;
  final String? proposedImplementation;

  const GenerationKitGap({
    required this.widgetName,
    required this.description,
    this.reason,
    this.suggestedComponentName,
    this.priority,
    this.proposedImplementation,
  });

  factory GenerationKitGap.fromJson(Map<String, dynamic> json) {
    return GenerationKitGap(
      widgetName: json['widget_name'] as String? ?? '',
      description: json['description'] as String? ?? '',
      reason: json['reason'] as String?,
      suggestedComponentName:
          json['suggested_component_name'] as String?,
      priority: json['priority'] as int?,
      proposedImplementation:
          json['proposed_implementation'] as String?,
    );
  }
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

  factory ValidationStatus.fromJson(Map<String, dynamic> json) {
    return ValidationStatus(
      ran: json['ran'] as bool? ?? false,
      passed: json['passed'] as bool? ?? false,
      errors: (json['errors'] as List<dynamic>? ?? const [])
          .map((error) => '$error')
          .toList(),
      repaired: json['repaired'] as bool? ?? false,
    );
  }
}

class PreviewArtifact {
  final String status;
  final String source;
  final String? imageBase64;
  final int? width;
  final int? height;
  final String? message;

  const PreviewArtifact({
    required this.status,
    required this.source,
    this.imageBase64,
    this.width,
    this.height,
    this.message,
  });

  bool get hasImage =>
      imageBase64 != null && imageBase64!.isNotEmpty;

  bool get isRealPreview => source == 'flutter_render';

  bool get isConceptFallback => source == 'concept';

  factory PreviewArtifact.fromJson(Map<String, dynamic> json) {
    return PreviewArtifact(
      status: json['status'] as String? ?? 'unavailable',
      source: json['source'] as String? ?? 'none',
      imageBase64: json['imageBase64'] as String?,
      width: json['width'] as int?,
      height: json['height'] as int?,
      message: json['message'] as String?,
    );
  }
}

class UsageMetrics {
  final Map<String, int> values;

  const UsageMetrics(this.values);

  factory UsageMetrics.fromJson(Map<String, dynamic> json) {
    return UsageMetrics(
      json.map(
        (key, value) => MapEntry(key, value as int? ?? 0),
      ),
    );
  }

  int operator [](String key) => values[key] ?? 0;

  bool get isEmpty => values.isEmpty;
}
