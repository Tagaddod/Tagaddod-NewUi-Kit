import '../models/widget_info.dart';

class SystemPromptBuilder {
  final List<WidgetInfo> widgets;
  final List<String> availableWidgetNames;
  final bool usedFullManifest;

  SystemPromptBuilder({
    required this.widgets,
    required this.availableWidgetNames,
    required this.usedFullManifest,
  });

  String build({
    required bool arch,
    String? contextCode,
  }) {
    final ctx = contextCode == null || contextCode.trim().isEmpty
        ? ''
        : '\n\n## Existing Style Reference\n'
            'Follow the same structural patterns as this example:\n'
            '```dart\n$contextCode\n```';

    final manifestScope = usedFullManifest
        ? 'The detailed manifest below contains the full Tagaddod UI kit.'
        : 'The detailed manifest below is the shortlist most relevant '
            'to this request. Use ONLY the widgets that appear there.';

    return '''
You are a Flutter code generator for Tagaddod.

Generate production-ready Flutter UI code grounded in the Tagaddod UI kit.

## Non-Negotiable Rules
- Use ONLY widgets from the detailed manifest below.
- Use ONLY the constructors and parameters listed for each widget.
- Use the exact import paths listed in the manifest.
- Return plain Dart code strings in JSON. Do not wrap code in markdown fences.
- Every response must remain mobile-screen focused.

## Tagaddod Component Index
Known kit widgets: ${availableWidgetNames.join(', ')}

## Single-Screen Contract
- Return one complete Dart file in `screen_code`.
- The root public widget class MUST be `GeneratedPreviewScreen`.
- Do NOT include `main()`.
- Do NOT include `MaterialApp` or `CupertinoApp`.
- It is fine to use `Scaffold` inside `GeneratedPreviewScreen`.
- Keep the screen renderable inside a fixed mobile preview frame.

## Kit Gap Rules
- If the request needs a capability that the Tagaddod kit does not support, add it to `kit_gaps`.
- Do NOT invent missing widgets in the generated code.
- Each kit gap should include:
  - `widget_name`
  - `description`
  - `reason`
  - `suggested_component_name`
  - `priority` from 1 to 3
  - optional `proposed_implementation`

## Response Format
${arch ? _archResponseRules : _singleResponseRules}

## Manifest Scope
$manifestScope

## Detailed Component Manifest
${_formatManifest()}$ctx
''';
  }

  String _formatManifest() {
    final buffer = StringBuffer();
    for (final widget in widgets) {
      buffer.writeln('### ${widget.className}');
      buffer.writeln('Import: ${widget.importPath}');
      if (widget.constructors.isNotEmpty) {
        buffer.writeln(
          'Constructors: ${widget.constructors.join(', ')}',
        );
      }
      if (widget.parameters.isNotEmpty) {
        buffer.writeln('Parameters: ${widget.parameters}');
      }
      buffer.writeln('Description: ${widget.description}');
      buffer.writeln('Example:');
      buffer.writeln('```dart');
      buffer.writeln(widget.example);
      buffer.writeln('```');
      buffer.writeln();
    }
    return buffer.toString();
  }
}

const _singleResponseRules = '''
Return JSON:
{
  "screen_code": "...",
  "kit_gaps": []
}''';

const _archResponseRules = '''
Return JSON:
{
  "files": [
    { "path": "feature_screen.dart", "code": "..." },
    { "path": "cubit/feature_cubit.dart", "code": "..." },
    { "path": "cubit/feature_state.dart", "code": "..." }
  ],
  "kit_gaps": []
}

For architecture mode:
- Generate complete imports for every file.
- Keep the output code-first.
- Preview rendering is not required.''';
