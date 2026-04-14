import 'generation_result.dart';
import 'kit_gap.dart';
import 'kit_manifest.dart';
import 'preview_result.dart';
import 'screen_spec.dart';
import 'validation_result.dart';
import 'widget_info.dart';

class ApiGenerationResponse {
  final String mode;
  final String requirement;
  final String screenCode;
  final List<GeneratedFile> files;
  final List<WidgetInfo> matchedComponents;
  final List<KitGap> kitGaps;
  final ValidationResult validation;
  final PreviewResult preview;
  final ScreenSpec screenSpec;
  final Map<String, int> tokens;
  final Map<String, int> timings;
  final KitManifest? manifest;

  const ApiGenerationResponse({
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
    this.manifest,
  });

  Map<String, dynamic> toJson() => {
    'mode': mode,
    'requirement': requirement,
    'screenCode': screenCode,
    'code': screenCode,
    'files': files.map((f) => f.toJson()).toList(),
    'matchedComponents': matchedComponents.map((w) => w.toJson()).toList(),
    'kitGaps': kitGaps.map((g) => g.toJson()).toList(),
    'validation': validation.toJson(),
    'preview': preview.toJson(),
    'screenSpec': screenSpec.toJson(),
    'tokens': tokens,
    'timings': timings,
    if (manifest != null) 'manifest': manifest!.toJson(),
  };
}
