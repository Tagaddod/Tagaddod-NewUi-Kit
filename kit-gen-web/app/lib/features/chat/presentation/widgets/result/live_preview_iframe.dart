// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;
import 'dart:ui_web' as ui;
import 'package:flutter/material.dart';

class LivePreviewIframe extends StatefulWidget {
  const LivePreviewIframe({super.key, required this.src});

  final String src;

  @override
  State<LivePreviewIframe> createState() => _LivePreviewIframeState();
}

class _LivePreviewIframeState extends State<LivePreviewIframe> {
  late final String _viewType;

  @override
  void initState() {
    super.initState();
    _viewType = 'live-preview-${widget.src.hashCode}';
    ui.platformViewRegistry.registerViewFactory(_viewType, (_) {
      final frame = html.IFrameElement()
        ..src = widget.src
        ..style.border = 'none'
        ..style.width = '100%'
        ..style.height = '100%'
        ..style.setProperty('pointer-events', 'auto')
        ..tabIndex = 0;
      return frame;
    });
  }

  @override
  Widget build(BuildContext context) {
    return HtmlElementView(viewType: _viewType);
  }
}
