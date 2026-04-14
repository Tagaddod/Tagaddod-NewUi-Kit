import 'package:flutter/material.dart';
import 'chat_input_field.dart';

/// Thin named wrapper around [ChatInputField].
/// Quick-prompt chips were removed — the left rail already covers shortcuts.
class ChatInputBar extends StatelessWidget {
  const ChatInputBar({
    super.key,
    required this.controller,
    required this.onSend,
    required this.isLoading,
    required this.archMode,
  });

  final TextEditingController controller;
  final VoidCallback onSend;
  final bool isLoading;
  final bool archMode;

  @override
  Widget build(BuildContext context) {
    return ChatInputField(
      controller: controller,
      onSend: onSend,
      isLoading: isLoading,
      archMode: archMode,
    );
  }
}
