import 'kit_gap.dart';

class GeneratedFile {
  final String path;
  final String code;
  GeneratedFile({required this.path, required this.code});

  Map<String, dynamic> toJson() => {'path': path, 'code': code};
  factory GeneratedFile.fromJson(Map<String, dynamic> json) =>
      GeneratedFile(path: json['path'] as String, code: json['code'] as String);
}

class GenerationResult {
  final String screenCode;
  final List<GeneratedFile> files;
  final List<KitGap> kitGaps;
  final int inputTokens;
  final int outputTokens;
  final String rawResponse;

  GenerationResult({
    required this.screenCode,
    required this.files,
    required this.kitGaps,
    required this.inputTokens,
    required this.outputTokens,
    required this.rawResponse,
  });
}
