import 'widget_info.dart';

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
        generatedAt: DateTime.parse(json['generatedAt'] as String),
        kitVersion: json['kitVersion'] as String,
        packageName: json['packageName'] as String,
        widgets: (json['widgets'] as List<dynamic>)
            .map((w) => WidgetInfo.fromJson(w as Map<String, dynamic>))
            .toList(),
      );
}
