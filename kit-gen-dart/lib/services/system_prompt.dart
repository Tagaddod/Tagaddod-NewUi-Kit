import 'manifest_service.dart';
import 'prompt/prompt_rules.dart';
import 'prompt/import_paths.dart';
import 'prompt/arch_rules.dart';

class SystemPromptBuilder {
  final KitManifest manifest;

  SystemPromptBuilder(this.manifest);

  String build({String? contextCode}) {
    return '${_basePrompt(contextCode: contextCode)}'
        '\n\n## Response\n\n'
        'Return JSON: { "screen_code": "...", "kit_gaps": [] }'
        '\n\n## Component Manifest\n\n${_formatManifest()}';
  }

  String buildArch({String? contextCode}) {
    return '${_basePrompt(contextCode: contextCode)}'
        '\n\n$archRules'
        '\n\n## Component Manifest\n\n${_formatManifest()}';
  }

  String _basePrompt({String? contextCode}) {
    final ctx = contextCode != null
        ? '\n\n## Existing Code Style\n\n'
            'Follow the same patterns as this screen:\n\n'
            '```dart\n$contextCode\n```'
        : '';

    return '''You are a Flutter code generator for Tagaddod. Generate complete, working Flutter screen code using ONLY the Tagaddod UI kit components listed below.

$constructorRules

$parameterRules

$importPathRules

$codeRules

## Kit Gaps

If a required component is NOT in the manifest, add it to kit_gaps. Do NOT use it in screen_code.

## Single-Screen Contract

- The root public widget class MUST be `GeneratedPreviewScreen`.
- Do NOT include `main()`.
- Do NOT include `MaterialApp` or `CupertinoApp`.
- Return a single mobile-screen widget that can be wrapped by a preview harness.$ctx''';
  }

  String _formatManifest() {
    final buffer = StringBuffer();
    for (final widget in manifest.widgets) {
      buffer.writeln('### ${widget.className}');
      buffer.writeln('Import: ${widget.importPath}');
      if (widget.constructors.isNotEmpty) {
        buffer.writeln(
            'Constructors: ${widget.constructors.join(', ')}');
      }
      if (widget.parameters.isNotEmpty) {
        buffer.writeln('Parameters: ${widget.parameters}');
      }
      buffer.writeln(widget.description);
      buffer.writeln('Example:');
      buffer.writeln('```dart');
      buffer.writeln(widget.example);
      buffer.writeln('```');
      buffer.writeln();
    }
    return buffer.toString();
  }
}
