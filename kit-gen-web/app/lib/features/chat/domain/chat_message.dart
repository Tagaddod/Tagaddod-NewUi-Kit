import 'generation_payload.dart';

class ChatMessage {
  final bool isUser;
  final String text;
  final GenerationPayload? generation;
  final bool isError;

  const ChatMessage._({
    required this.isUser,
    required this.text,
    this.generation,
    this.isError = false,
  });

  factory ChatMessage.user(String text) => ChatMessage._(
        isUser: true,
        text: text,
      );

  factory ChatMessage.generated(GenerationPayload generation) =>
      ChatMessage._(
        isUser: false,
        text: generation.requirement,
        generation: generation,
      );

  factory ChatMessage.error(String text) => ChatMessage._(
        isUser: false,
        text: text,
        isError: true,
      );
}
