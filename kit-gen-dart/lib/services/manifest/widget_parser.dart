import 'param_parser.dart';

class WidgetSignatureParser {
  List<String> extractConstructors(
      String content, String className) {
    final constructors = <String>[];

    final namedPattern = RegExp('$className\\.(\\w+)\\s*\\(');
    for (final m in namedPattern.allMatches(content)) {
      final name = m.group(1)!;
      if (name.startsWith('_')) continue;
      final sig = '$className.$name()';
      if (!constructors.contains(sig)) constructors.add(sig);
    }

    if (constructors.isEmpty) {
      final defaultPattern = RegExp(
        '(?:const\\s+)?$className\\s*\\(\\s*\\{',
      );
      if (defaultPattern.hasMatch(content)) {
        constructors.add('$className()');
      }
    }

    return constructors;
  }

  String extractParameters(String content, String className) {
    final ctorPattern = RegExp(
      '(?:const\\s+)?$className(?:\\.\\w+)?\\s*\\('
      '([^)]*(?:\\([^)]*\\)[^)]*)*)\\)',
      dotAll: true,
    );

    final match = ctorPattern.firstMatch(content);
    if (match == null) return '';

    final body = match.group(1) ?? '';
    final cleaned =
        body.replaceAll(RegExp(r'[\{\}]'), '').trim();
    if (cleaned.isEmpty) return '';

    final params = <String>[];
    for (final raw in splitParams(cleaned)) {
      final param = parseOneParam(raw.trim());
      if (param != null &&
          param != 'key: Key?' &&
          !param.startsWith('super.')) {
        params.add(param);
      }
    }

    return params.join(', ');
  }

  String buildExample(
      String className, List<String> constructors) {
    if (constructors.isEmpty) return '$className()';
    return constructors.first.replaceAll('()', '(\n)');
  }
}
