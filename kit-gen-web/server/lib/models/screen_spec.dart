class ScreenSpec {
  final String screenType;
  final String title;
  final String subtitle;
  final String? topBarTitle;
  final bool useLogo;
  final List<ScreenSpecSection> sections;

  const ScreenSpec({
    required this.screenType,
    required this.title,
    required this.subtitle,
    required this.topBarTitle,
    required this.useLogo,
    required this.sections,
  });

  const ScreenSpec.empty()
    : screenType = 'generic',
      title = '',
      subtitle = '',
      topBarTitle = null,
      useLogo = false,
      sections = const [];

  bool get isRenderable =>
      title.trim().isNotEmpty ||
      sections.any(
        (section) =>
            section.title.trim().isNotEmpty ||
            section.subtitle.trim().isNotEmpty ||
            section.items.isNotEmpty,
      );

  factory ScreenSpec.fromJson(Map<String, dynamic> json) {
    return ScreenSpec(
      screenType: json['screen_type'] as String? ?? 'generic',
      title: json['title'] as String? ?? '',
      subtitle: json['subtitle'] as String? ?? '',
      topBarTitle: json['top_bar_title'] as String?,
      useLogo: json['use_logo'] as bool? ?? false,
      sections: (json['sections'] as List<dynamic>? ?? const [])
          .whereType<Map<String, dynamic>>()
          .map(ScreenSpecSection.fromJson)
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'screen_type': screenType,
    'title': title,
    'subtitle': subtitle,
    'top_bar_title': topBarTitle,
    'use_logo': useLogo,
    'sections': sections.map((section) => section.toJson()).toList(),
  };
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

  factory ScreenSpecSection.fromJson(Map<String, dynamic> json) {
    return ScreenSpecSection(
      kind: json['kind'] as String? ?? 'content',
      title: json['title'] as String? ?? '',
      subtitle: json['subtitle'] as String? ?? '',
      items: (json['items'] as List<dynamic>? ?? const [])
          .whereType<Map<String, dynamic>>()
          .map(ScreenSpecItem.fromJson)
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'kind': kind,
    'title': title,
    'subtitle': subtitle,
    'items': items.map((item) => item.toJson()).toList(),
  };
}

class ScreenSpecItem {
  final String kind;
  final String label;
  final String? value;
  final String? hint;
  final String? componentName;
  final String? emphasis;
  final String? resolution;
  final bool? checked;
  final bool? obscured;

  const ScreenSpecItem({
    required this.kind,
    required this.label,
    this.value,
    this.hint,
    this.componentName,
    this.emphasis,
    this.resolution,
    this.checked,
    this.obscured,
  });

  factory ScreenSpecItem.fromJson(Map<String, dynamic> json) {
    return ScreenSpecItem(
      kind: json['kind'] as String? ?? 'placeholder',
      label: json['label'] as String? ?? '',
      value: json['value'] as String?,
      hint: json['hint'] as String?,
      componentName: json['component_name'] as String?,
      emphasis: json['emphasis'] as String?,
      resolution: json['resolution'] as String?,
      checked: json['checked'] as bool?,
      obscured: json['obscured'] as bool?,
    );
  }

  Map<String, dynamic> toJson() => {
    'kind': kind,
    'label': label,
    'value': value,
    'hint': hint,
    'component_name': componentName,
    'emphasis': emphasis,
    'resolution': resolution,
    'checked': checked,
    'obscured': obscured,
  };
}
