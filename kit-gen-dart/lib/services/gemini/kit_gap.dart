class KitGap {
  final String widgetName;
  final String description;
  final String? reason;
  final String? suggestedComponentName;
  final int? priority;
  final String? proposedImplementation;

  KitGap({
    required this.widgetName,
    required this.description,
    this.reason,
    this.suggestedComponentName,
    this.priority,
    this.proposedImplementation,
  });

  factory KitGap.fromJson(Map<String, dynamic> json) => KitGap(
        widgetName: json['widget_name'] as String,
        description: json['description'] as String,
        reason: json['reason'] as String?,
        suggestedComponentName:
            json['suggested_component_name'] as String?,
        priority: json['priority'] as int?,
        proposedImplementation:
            json['proposed_implementation'] as String?,
      );

  @override
  String toString() {
    final buf = StringBuffer('• $widgetName: $description');
    if (reason != null) {
      buf.writeln('\n  Why:\n$reason');
    }
    if (suggestedComponentName != null) {
      buf.writeln('\n  Suggested component:\n$suggestedComponentName');
    }
    if (priority != null) {
      buf.writeln('\n  Priority:\n$priority');
    }
    if (proposedImplementation != null) {
      buf.writeln('\n  Proposed:\n$proposedImplementation');
    }
    return buf.toString();
  }
}
