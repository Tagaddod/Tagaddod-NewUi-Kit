import 'dart:convert';
import 'gemini/gemini_http.dart';
import 'gemini/gemini_schemas.dart';
import 'gemini/kit_gap.dart';
import 'gemini/generation_models.dart';

export 'gemini/kit_gap.dart';
export 'gemini/generation_models.dart';

class GeminiService {
  final String apiKey;
  GeminiService(this.apiKey);

  Future<GenerationResult> generateCode(
    String requirement, String systemPrompt,
  ) async {
    final data = await callGemini(
      apiKey: apiKey,
      requirement: requirement,
      systemPrompt: systemPrompt,
      schema: singleResponseSchema,
    );
    final text = extractText(data);
    final usage = extractUsage(data);
    final parsed = jsonDecode(text) as Map<String, dynamic>;

    return GenerationResult(
      screenCode: parsed['screen_code'] as String? ?? '',
      kitGapsList: _parseGaps(parsed['kit_gaps']),
      inputTokens: usage.$1,
      outputTokens: usage.$2,
      rawResponse: text,
    );
  }

  Future<ArchGenerationResult> generateArchCode(
    String requirement, String systemPrompt,
  ) async {
    final data = await callGemini(
      apiKey: apiKey,
      requirement: requirement,
      systemPrompt: systemPrompt,
      schema: archResponseSchema,
    );
    final text = extractText(data);
    final usage = extractUsage(data);
    final parsed = jsonDecode(text) as Map<String, dynamic>;

    final files = (parsed['files'] as List<dynamic>?)
            ?.map((f) => GeneratedFile(
                  path: f['path'] as String,
                  code: f['code'] as String,
                ))
            .toList() ??
        [];

    return ArchGenerationResult(
      files: files,
      kitGapsList: _parseGaps(parsed['kit_gaps']),
      inputTokens: usage.$1,
      outputTokens: usage.$2,
      rawResponse: text,
    );
  }

  List<KitGap> _parseGaps(dynamic json) =>
      (json as List<dynamic>?)
          ?.map((g) =>
              KitGap.fromJson(g as Map<String, dynamic>))
          .toList() ??
      [];
}
