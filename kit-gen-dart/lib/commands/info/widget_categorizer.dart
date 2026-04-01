import 'package:kit_gen/services/manifest_service.dart';

Map<String, List<WidgetInfo>> categorizeWidgets(
    List<WidgetInfo> widgets) {
  final categories = <String, List<WidgetInfo>>{
    'Buttons': [],
    'Inputs': [],
    'Navigation': [],
    'Indicators': [],
    'Layout': [],
    'Other': [],
  };

  for (final w in widgets) {
    final n = w.className;
    if (n.contains('Button')) {
      categories['Buttons']!.add(w);
    } else if (n.contains('TextField') ||
        n.contains('CheckBox') ||
        n.contains('Radio') ||
        n.contains('Switch')) {
      categories['Inputs']!.add(w);
    } else if (n.contains('Navigation') ||
        n.contains('AppBar') ||
        n.contains('Tab')) {
      categories['Navigation']!.add(w);
    } else if (n.contains('Progress') ||
        n.contains('Indicator') ||
        n.contains('Badge') ||
        n.contains('Stepper')) {
      categories['Indicators']!.add(w);
    } else if (n.contains('Container') ||
        n.contains('Divider') ||
        n.contains('Expandable')) {
      categories['Layout']!.add(w);
    } else {
      categories['Other']!.add(w);
    }
  }

  return categories;
}
