class UsageMetrics {
  final Map<String, int> values;
  const UsageMetrics(this.values);

  factory UsageMetrics.fromJson(Map<String, dynamic> json) =>
      UsageMetrics(json.map((k, v) => MapEntry(k, v as int? ?? 0)));

  int operator [](String key) => values[key] ?? 0;
  bool get isEmpty => values.isEmpty;
}
