class WidgetInfo {
  final String className;
  final String description;
  final String importPath;
  final String example;
  final List<String> constructors;
  final String parameters;

  WidgetInfo({
    required this.className,
    required this.description,
    required this.importPath,
    required this.example,
    this.constructors = const [],
    this.parameters = '',
  });

  Map<String, dynamic> toJson() => {
        'className': className,
        'description': description,
        'importPath': importPath,
        'constructors': constructors,
        'parameters': parameters,
        'example': example,
      };

  factory WidgetInfo.fromJson(Map<String, dynamic> json) => WidgetInfo(
        className: json['className'] as String,
        description: json['description'] as String,
        importPath: json['importPath'] as String,
        example: json['example'] as String,
        constructors: (json['constructors'] as List<dynamic>?)?.map((e) => '$e').toList() ?? [],
        parameters: json['parameters'] as String? ?? '',
      );
}
