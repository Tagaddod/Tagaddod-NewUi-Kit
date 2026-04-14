import 'package:flutter/material.dart';
import '../../domain/prompt_preset.dart';

class PromptPresetCard extends StatelessWidget {
  const PromptPresetCard({
    super.key,
    required this.preset,
    required this.onTap,
  });

  final PromptPreset preset;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: onTap,
      child: Ink(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: const Color(0xFFE8DDD3)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(9),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF3E6D9),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(preset.icon, size: 18, color: const Color(0xFFB85D2D)),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF0EFF8),
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Text(
                    preset.audience,
                    style: theme.textTheme.labelSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF3D3680),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              preset.label,
              style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              preset.prompt,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.bodySmall?.copyWith(
                color: const Color(0xFF6B7280),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
