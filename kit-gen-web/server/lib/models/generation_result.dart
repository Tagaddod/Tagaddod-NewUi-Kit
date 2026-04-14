import 'kit_gap.dart';
import 'screen_spec.dart';

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
  final ScreenSpec? screenSpec;
  final int inputTokens;
  final int outputTokens;
  final String rawResponse;

  GenerationResult({
    required this.screenCode,
    required this.files,
    required this.kitGaps,
    required this.screenSpec,
    required this.inputTokens,
    required this.outputTokens,
    required this.rawResponse,
  });
}
