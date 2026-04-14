import 'dart:convert';
import 'package:flutter/material.dart';
import '../../domain/generation_payload.dart';
import 'result/live_preview_iframe.dart';
import 'screen_spec_preview.dart';

class CenterPhoneContent extends StatelessWidget {
  const CenterPhoneContent({super.key, required this.result});

  final GenerationPayload result;

  @override
  Widget build(BuildContext context) {
    final preview = result.preview;
    final spec = result.screenSpec;

    if (preview.hasLivePreview) {
      return LivePreviewIframe(src: preview.previewUrl!);
    }
    if (spec.isRenderable) {
      return ScreenSpecPreview(screenSpec: spec);
    }
    if (preview.hasImage) {
      return Image.memory(
        base64Decode(preview.imageBase64!),
        fit: BoxFit.cover,
        gaplessPlayback: true,
      );
    }
    return const _PlaceholderState();
  }
}

class _PlaceholderState extends StatelessWidget {
  const _PlaceholderState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(28),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 48,
              width: 48,
              decoration: BoxDecoration(
                color: const Color(0xFFF3E6D9),
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Icon(Icons.phone_iphone_rounded, color: Color(0xFFB85D2D)),
            ),
            const SizedBox(height: 14),
            Text(
              'Preview\nnot ready',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: const Color(0xFFB0A898),
                fontWeight: FontWeight.w600,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
