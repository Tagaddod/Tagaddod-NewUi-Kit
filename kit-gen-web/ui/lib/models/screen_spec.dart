class ScreenSpec {
  final String screenType;
  final String title;
  final String subtitle;
  final String? topBarTitle;
  final List<ScreenSpecSection> sections;

  const ScreenSpec({
    required this.screenType,
    required this.title,
    required this.subtitle,
    required this.topBarTitle,
    required this.sections,
  });

  const ScreenSpec.empty()
      : screenType = 'generic',
        title = '',
        subtitle = '',
        topBarTitle = null,
        sections = const [];

  factory ScreenSpec.fromJson(Map<String, dynamic> json) => ScreenSpec(
        screenType: json['screen_type'] as String? ?? 'generic',
        title: json['title'] as String? ?? '',
        subtitle: json['subtitle'] as String? ?? '',
        topBarTitle: json['top_bar_title'] as String?,
        sections: (json['sections'] as List<dynamic>? ?? const [])
            .whereType<Map<String, dynamic>>()
            .map(ScreenSpecSection.fromJson)
            .toList(),
      );
}

class ScreenSpecSection {
  final String kind;
  final String title;
  final String subtitle;
  final List<ScreenSpecItem> items;

  const ScreenSpecSection({
    required this.kind,
    required this.title,
    required this.subtitle,
    required this.items,
  });

  factory ScreenSpecSection.fromJson(Map<String, dynamic> json) =>
      ScreenSpecSection(
        kind: json['kind'] as String? ?? 'content',
        title: json['title'] as String? ?? '',
        subtitle: json['subtitle'] as String? ?? '',
        items: (json['items'] as List<dynamic>? ?? const [])
            .whereType<Map<String, dynamic>>()
            .map(ScreenSpecItem.fromJson)
            .toList(),
      );
}

class ScreenSpecItem {
  final String kind;
  final String label;
  final String? value;
  final String? componentName;

  const ScreenSpecItem({
    required this.kind,
    required this.label,
    this.value,
    this.componentName,
  });

  factory ScreenSpecItem.fromJson(Map<String, dynamic> json) => ScreenSpecItem(
        kind: json['kind'] as String? ?? 'placeholder',
        label: json['label'] as String? ?? '',
        value: json['value'] as String?,
        componentName: json['component_name'] as String?,
      );
}
