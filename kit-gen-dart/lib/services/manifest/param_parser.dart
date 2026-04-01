List<String> splitParams(String raw) {
  final parts = <String>[];
  var depth = 0;
  var current = StringBuffer();

  for (var i = 0; i < raw.length; i++) {
    final c = raw[i];
    if (c == '(' || c == '<') depth++;
    if (c == ')' || c == '>') depth--;
    if (c == ',' && depth == 0) {
      parts.add(current.toString());
      current = StringBuffer();
    } else {
      current.write(c);
    }
  }
  if (current.isNotEmpty) parts.add(current.toString());
  return parts;
}

String? parseOneParam(String raw) {
  if (raw.isEmpty) return null;

  final isRequired = raw.startsWith('required ');
  final cleaned = raw.replaceFirst('required ', '').trim();
  final hasDefault = cleaned.contains('=');
  final withoutDefault = cleaned.split('=').first.trim();
  final parts = withoutDefault.split(RegExp(r'\s+'));
  if (parts.length < 2) return null;

  final paramName = parts.last.replaceAll('this.', '');
  final type = parts.sublist(0, parts.length - 1).join(' ');

  final buf = StringBuffer('$paramName: $type');
  if (isRequired) buf.write(' (REQUIRED)');
  if (hasDefault) {
    final defaultVal =
        cleaned.split('=').sublist(1).join('=').trim();
    buf.write(' = $defaultVal');
  }
  return buf.toString();
}
