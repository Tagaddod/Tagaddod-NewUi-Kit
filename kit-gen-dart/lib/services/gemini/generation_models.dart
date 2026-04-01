import 'kit_gap.dart';

class GenerationResult {
  final String screenCode;
  final List<KitGap> kitGapsList;
  final int inputTokens;
  final int outputTokens;
  final String rawResponse;

  GenerationResult({
    required this.screenCode,
    required this.kitGapsList,
    required this.inputTokens,
    required this.outputTokens,
    this.rawResponse = '',
  });

  bool get hasGaps => kitGapsList.isNotEmpty;

  String get kitGapsText =>
      kitGapsList.map((g) => g.toString()).join('\n\n');

  double get estimatedCost {
    return (inputTokens * 0.30 / 1000000) +
        (outputTokens * 2.50 / 1000000);
  }
}

class GeneratedFile {
  final String path;
  final String code;

  GeneratedFile({required this.path, required this.code});
}

class ArchGenerationResult {
  final List<GeneratedFile> files;
  final List<KitGap> kitGapsList;
  final int inputTokens;
  final int outputTokens;
  final String rawResponse;

  ArchGenerationResult({
    required this.files,
    required this.kitGapsList,
    required this.inputTokens,
    required this.outputTokens,
    this.rawResponse = '',
  });

  bool get hasGaps => kitGapsList.isNotEmpty;

  double get estimatedCost {
    return (inputTokens * 0.30 / 1000000) +
        (outputTokens * 2.50 / 1000000);
  }
}
