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

  Map<String, dynamic> toJson() => {
        'widget_name': widgetName,
        'description': description,
        if (reason != null) 'reason': reason,
        if (suggestedComponentName != null)
          'suggested_component_name': suggestedComponentName,
        if (priority != null) 'priority': priority,
        if (proposedImplementation != null)
          'proposed_implementation': proposedImplementation,
      };

  factory KitGap.fromJson(Map<String, dynamic> json) => KitGap(
        widgetName: json['widget_name'] as String,
        description: json['description'] as String,
        reason: json['reason'] as String?,
        suggestedComponentName:
            json['suggested_component_name'] as String?,
        priority: json['priority'] as int?,
        proposedImplementation: json['proposed_implementation'] as String?,
      );
}
