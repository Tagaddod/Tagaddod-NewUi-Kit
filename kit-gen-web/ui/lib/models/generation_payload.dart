import 'generation_models.dart';
import 'preview_artifact.dart';
import 'screen_spec.dart';
import 'usage_metrics.dart';

class GenerationPayload {
  final String mode;
  final String requirement;
  final String screenCode;
  final List<GeneratedCodeFile> files;
  final List<MatchedComponent> matchedComponents;
  final List<GenerationKitGap> kitGaps;
  final ValidationStatus validation;
  final PreviewArtifact preview;
  final ScreenSpec screenSpec;
  final UsageMetrics tokens;
  final UsageMetrics timings;

  const GenerationPayload({
    required this.mode,
    required this.requirement,
    required this.screenCode,
    required this.files,
    required this.matchedComponents,
    required this.kitGaps,
    required this.validation,
    required this.preview,
    required this.screenSpec,
    required this.tokens,
    required this.timings,
  });

  bool get isArchMode => mode == 'arch';
  bool get hasCode => screenCode.trim().isNotEmpty || files.isNotEmpty;

  String get primaryCode =>
      files.isNotEmpty ? files.first.code : screenCode;

  String get primaryTitle =>
      files.isNotEmpty ? files.first.path : 'generated_preview_screen.dart';

  factory GenerationPayload.fromJson(Map<String, dynamic> json) =>
      GenerationPayload(
        mode: json['mode'] as String? ?? 'single',
        requirement: json['requirement'] as String? ?? '',
        screenCode: (json['screenCode'] ?? json['code']) as String? ?? '',
        files: (json['files'] as List<dynamic>? ?? const [])
            .map((f) => GeneratedCodeFile.fromJson(f as Map<String, dynamic>))
            .toList(),
        matchedComponents:
            (json['matchedComponents'] as List<dynamic>? ?? const [])
                .map((c) =>
                    MatchedComponent.fromJson(c as Map<String, dynamic>))
                .toList(),
        kitGaps: (json['kitGaps'] as List<dynamic>? ?? const [])
            .map((g) =>
                GenerationKitGap.fromJson(g as Map<String, dynamic>))
            .toList(),
        validation: ValidationStatus.fromJson(
            json['validation'] as Map<String, dynamic>? ?? const {}),
        preview: PreviewArtifact.fromJson(
            json['preview'] as Map<String, dynamic>? ?? const {}),
        screenSpec: ScreenSpec.fromJson(
            json['screenSpec'] as Map<String, dynamic>? ?? const {}),
        tokens: UsageMetrics.fromJson(
            json['tokens'] as Map<String, dynamic>? ?? const {}),
        timings: UsageMetrics.fromJson(
            json['timings'] as Map<String, dynamic>? ?? const {}),
      );
}
