class ComponentItem {
  ComponentItem({
    required this.className,
    required this.description,
    required this.importPath,
    required this.constructors,
    required this.parameters,
    required this.example,
  });

  final String className;
  final String description;
  final String importPath;
  final List<String> constructors;
  final String parameters;
  final String example;

  factory ComponentItem.fromJson(Map<String, dynamic> json) => ComponentItem(
        className: json['className'] as String,
        description: json['description'] as String,
        importPath: json['importPath'] as String,
        constructors: (json['constructors'] as List<dynamic>?)?.map((e) => '$e').toList() ?? [],
        parameters: json['parameters'] as String? ?? '',
        example: json['example'] as String? ?? '',
      );
}
