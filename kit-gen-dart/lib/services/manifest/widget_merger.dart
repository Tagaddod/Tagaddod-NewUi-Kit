import 'widget_info.dart';

WidgetInfo mergeWidgetInfo(WidgetInfo parsed, WidgetInfo? existing) {
  if (existing == null) return parsed;
  return WidgetInfo(
    className: parsed.className,
    description: existing.description.isNotEmpty
        ? existing.description
        : parsed.description,
    importPath: parsed.importPath,
    example: existing.example.isNotEmpty
        ? existing.example
        : parsed.example,
    constructors: parsed.constructors.isNotEmpty
        ? parsed.constructors
        : existing.constructors,
    parameters: parsed.parameters.isNotEmpty
        ? parsed.parameters
        : existing.parameters,
  );
}
