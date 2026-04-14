import '../models/generation_result.dart';

/// Common interface for AI generation providers (Gemini, Anthropic, …).
/// Every provider must implement a single [generate] method; provider-specific
/// caching strategies are handled internally.
abstract class AiService {
  Future<GenerationResult> generate({
    required String prompt,
    required String systemPrompt,
    required bool arch,
  });
}
