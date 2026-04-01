import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kit_gen_web_app/features/chat/domain/generation_payload.dart';
import 'package:kit_gen_web_app/features/chat/presentation/widgets/assistant_result_card.dart';

void main() {
  testWidgets('assistant result card defaults to business view and can switch to developer view', (tester) async {
    const result = GenerationPayload(
      mode: 'single',
      requirement: 'Create a login screen with email and password fields.',
      screenCode: "class GeneratedPreviewScreen extends StatelessWidget { const GeneratedPreviewScreen({super.key}); @override Widget build(BuildContext context) => const Placeholder(); }",
      files: [],
      matchedComponents: [
        MatchedComponent(
          className: 'AppTextField',
          description: 'Text input',
          importPath: 'package:tagaddod_ui_kit/widgets/app_text_field.dart',
        ),
        MatchedComponent(
          className: 'AppFilledButton',
          description: 'Primary button',
          importPath: 'package:tagaddod_ui_kit/widgets/button/app_filled_button.dart',
        ),
      ],
      kitGaps: [
        GenerationKitGap(
          widgetName: 'PasswordStrengthMeter',
          description: 'A reusable password strength indicator.',
          reason: 'This unlocks richer authentication screens.',
          suggestedComponentName: 'AppPasswordStrengthMeter',
          priority: 2,
        ),
      ],
      validation: ValidationStatus(
        ran: true,
        passed: true,
        errors: [],
        repaired: false,
      ),
      preview: PreviewArtifact(
        status: 'rendered',
        source: 'flutter_render',
        imageBase64: 'iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAADUlEQVQIHWP4//8/AwAI/AL+KDv6GQAAAABJRU5ErkJggg==',
        width: 900,
        height: 1200,
        message: 'Real Flutter preview rendered from the generated screen.',
      ),
      tokens: UsageMetrics({'input': 400, 'output': 220}),
      timings: UsageMetrics({'generationMs': 1400, 'previewMs': 900}),
    );

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: SingleChildScrollView(
            child: AssistantResultCard(result: result),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Business View'), findsOneWidget);
    expect(find.text('Requirement Summary'), findsOneWidget);
    expect(find.text('Components Used From Tagaddod UI Kit'), findsOneWidget);
    expect(find.text('Suggested Additions To The Library'), findsOneWidget);

    await tester.tap(find.text('Developer View'));
    await tester.pumpAndSettle();

    expect(find.text('Validation'), findsOneWidget);
    expect(find.text('Diagnostics'), findsOneWidget);
    expect(find.text('generated_preview_screen.dart'), findsOneWidget);
  });
}
