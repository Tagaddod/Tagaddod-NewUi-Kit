import 'package:test/test.dart';
import 'package:kit_gen_web_server/models/preview_result.dart';
import 'package:kit_gen_web_server/services/preview_harness_service.dart';

void main() {
  test('preview harness renders a simple generated screen', () async {
    final service = PreviewHarnessService();
    final workspace = await service.createWorkspace();

    addTearDown(() => workspace.dispose());

    await workspace.writeCode(_sampleScreen);

    final validationErrors = await service.analyze(workspace);
    expect(validationErrors, isEmpty);

    final preview = await service.render(workspace);
    expect(preview, isA<PreviewResult>());
    expect(preview.status, 'rendered');
    expect(preview.source, 'flutter_render');
    expect(preview.imageBase64, isNotEmpty);
  });
}

const _sampleScreen = '''
import 'package:flutter/material.dart';
import 'package:tagaddod_ui_kit/widgets/app_text.dart';

class GeneratedPreviewScreen extends StatelessWidget {
  const GeneratedPreviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: AppText.bodyMd(text: 'Preview Harness Test'),
      ),
    );
  }
}
''';
