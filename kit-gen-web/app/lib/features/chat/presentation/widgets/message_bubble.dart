import 'package:flutter/material.dart';
import '../../domain/chat_message.dart';
import '../../../../core/widgets/copy_button.dart';
import 'assistant_result_card.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble({super.key, required this.message});
  final ChatMessage message;

  @override
  Widget build(BuildContext context) {
    if (message.isUser) {
      return Align(
        alignment: Alignment.centerRight,
        child: Container(
          margin: const EdgeInsets.only(top: 10, bottom: 10, left: 80),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(child: SelectableText(message.text)),
              CopyButton(text: message.text, tooltip: 'Copy prompt'),
            ],
          ),
        ),
      );
    }

    if (message.generation != null) {
      return AssistantResultCard(result: message.generation!);
    }

    return Container(
      margin: const EdgeInsets.only(top: 8, bottom: 8, right: 80),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.errorContainer,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.error_outline_rounded),
          const SizedBox(width: 12),
          Expanded(
            child: SelectableText(
              message.text,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          CopyButton(
            text: message.text,
            tooltip: 'Copy error',
          ),
        ],
      ),
    );
  }
}
