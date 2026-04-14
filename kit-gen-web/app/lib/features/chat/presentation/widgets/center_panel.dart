import 'dart:math';
import 'package:flutter/material.dart';
import '../../domain/generation_payload.dart';
import 'center_phone_content.dart';
import 'chat_input_bar.dart';
import 'generation_progress_widget.dart';
import 'result/live_preview_iframe.dart';
import 'result/phone_frame.dart';
import 'workspace_landing.dart';

class CenterPanel extends StatelessWidget {
  const CenterPanel({
    super.key,
    required this.controller,
    required this.loading,
    required this.latest,
    required this.activePrompt,
    required this.currentStage,
    required this.elapsedSeconds,
    required this.arch,
    required this.onSend,
    required this.onUsePrompt,
  });

  final TextEditingController controller;
  final bool loading;
  final GenerationPayload? latest;
  final String activePrompt;
  final String currentStage;
  final int elapsedSeconds;
  final bool arch;
  final VoidCallback onSend;
  final ValueChanged<String> onUsePrompt;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: const [
          BoxShadow(color: Color(0x0F000000), blurRadius: 32, offset: Offset(0, 12)),
        ],
      ),
      child: Column(
        children: [
          Expanded(child: _body()),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: ChatInputBar(
              controller: controller,
              onSend: onSend,
              isLoading: loading,
              archMode: arch,
            ),
          ),
        ],
      ),
    );
  }

  Widget _body() {
    if (loading) {
      return Center(
        child: GenerationProgressWidget(
          prompt: activePrompt,
          stage: currentStage,
          elapsedSeconds: elapsedSeconds,
        ),
      );
    }
    if (latest != null) {
      // Live preview: show the widget-previewer iframe at full height.
      // The previewer already renders its own phone frame — no outer frame needed.
      if (latest!.preview.hasLivePreview) {
        return _LivePreviewFull(src: latest!.preview.previewUrl!);
      }
      return _PhonePreview(result: latest!);
    }
    return WorkspaceLanding(onUsePrompt: onUsePrompt);
  }
}

/// Full-height iframe for the live widget-previewer.
/// The previewer includes its own phone frame, so we just clip to the panel.
class _LivePreviewFull extends StatelessWidget {
  const _LivePreviewFull({required this.src});
  final String src;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      child: LivePreviewIframe(src: src),
    );
  }
}

class _PhonePreview extends StatelessWidget {
  const _PhonePreview({required this.result});
  final GenerationPayload result;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraints) {
        final phoneW = min(300.0, (constraints.maxHeight - 32) * 9 / 21.0);
        return Center(
          child: SizedBox(
            width: phoneW,
            child: PhoneFrame(child: CenterPhoneContent(result: result)),
          ),
        );
      },
    );
  }
}
