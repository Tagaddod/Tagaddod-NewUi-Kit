import 'manifest_service.dart';

class SystemPromptBuilder {
  final KitManifest manifest;

  SystemPromptBuilder(this.manifest);

  String build() {
    return '''You are a Flutter UI code generator for Tagaddod. Your job is to generate complete, working Flutter screen code using ONLY the Tagaddod UI kit components listed below.

## Rules

1. ONLY use widgets from the manifest. Never import or use widgets outside the kit.
2. Generate a COMPLETE, runnable Flutter widget — not just imports or stubs.
3. Use StatefulWidget when there is user input or local state, otherwise StatelessWidget.
4. Separate every logical section into its own widget class (never use helper methods to build UI).
5. Keep each class under 90 lines.
6. Use Cubit for state management when the screen has complex logic.
7. Use semantic tokens for all colors, text styles, and spacing:
   - Colors: TextColors, BgColors, BorderColors, IconColors
   - Typography: BodyStyles, HeadingStyles, CaptionStyles
   - Button variants: ButtonType.defaultButton, ButtonType.successButton, ButtonType.criticalButton, ButtonType.neutralButton

## Kit Gaps

If the requirement needs a component that is NOT in the manifest:
- Do NOT use it in the screen code
- Add it to the kit_gaps list with a name, description, and proposed implementation

## Response Format

Return a JSON object with:
- screen_code: The full Dart/Flutter code as a string
- kit_gaps: Array of missing components (empty array if none)

## Component Manifest

${_formatManifest()}''';
  }

  String _formatManifest() {
    final buffer = StringBuffer();

    for (final widget in manifest.widgets) {
      buffer.writeln('### ${widget.className}');
      buffer.writeln('Import: ${widget.importPath}');
      buffer.writeln('Use case: ${widget.description}');
      buffer.writeln('Example:');
      buffer.writeln('```dart');
      buffer.writeln(widget.example);
      buffer.writeln('```');
      buffer.writeln();
    }

    return buffer.toString();
  }
}
