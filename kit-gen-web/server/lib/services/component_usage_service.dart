import '../models/widget_info.dart';

class ComponentUsageService {
  List<WidgetInfo> extract({
    required List<WidgetInfo> manifestWidgets,
    required List<WidgetInfo> preferredWidgets,
    required String code,
  }) {
    if (code.trim().isEmpty) return preferredWidgets;

    final matches = <_UsedWidget>[];
    for (final widget in manifestWidgets) {
      final pattern = RegExp(
        '\\b${RegExp.escape(widget.className)}(?:\\.|\\s*\\()',
      );
      final match = pattern.firstMatch(code);
      if (match == null) continue;
      matches.add(
        _UsedWidget(widget: widget, firstOffset: match.start),
      );
    }

    if (matches.isEmpty) return preferredWidgets;
    matches.sort(
      (a, b) => a.firstOffset.compareTo(b.firstOffset),
    );
    return matches.map((match) => match.widget).toList();
  }
}

class _UsedWidget {
  final WidgetInfo widget;
  final int firstOffset;

  const _UsedWidget({
    required this.widget,
    required this.firstOffset,
  });
}
