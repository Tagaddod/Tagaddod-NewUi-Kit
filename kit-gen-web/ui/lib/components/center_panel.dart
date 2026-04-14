import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart';
import '../models/generation_payload.dart';
import 'phone_frame.dart';
import 'progress_card.dart';
import 'prompt_input.dart';
import 'workspace_landing.dart';

class CenterPanel extends StatelessComponent {
  final bool loading;
  final GenerationPayload? result;
  final String currentStage;
  final int elapsed;
  final String activePrompt;
  final void Function(String) onSend;
  final void Function(String) onUsePrompt;

  const CenterPanel({
    required this.loading,
    required this.result,
    required this.currentStage,
    required this.elapsed,
    required this.activePrompt,
    required this.onSend,
    required this.onUsePrompt,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return div(
      [
        div([_buildBody()], classes: 'center-body'),
        PromptInput(loading: loading, onSend: onSend),
      ],
      classes: 'center',
    );
  }

  Component _buildBody() {
    if (loading) {
      return ProgressCard(
        stage: currentStage,
        elapsed: elapsed,
        prompt: activePrompt,
      );
    }
    final r = result;
    if (r != null) {
      final url = r.preview.hasLivePreview ? r.preview.previewUrl : null;
      return PhoneFrame(previewUrl: url);
    }
    return WorkspaceLanding(onUsePrompt: onUsePrompt);
  }
}
