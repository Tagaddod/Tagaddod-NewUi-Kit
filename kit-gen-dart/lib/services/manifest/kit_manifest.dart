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

  factory KitManifest.fromJson(Map<String, dynamic> json) =>
      KitManifest(
        generatedAt: DateTime.parse(json['generatedAt']),
        kitVersion: json['kitVersion'],
        packageName: json['packageName'],
        widgets: (json['widgets'] as List)
            .map((w) => WidgetInfo.fromJson(w))
            .toList(),
      );
}
