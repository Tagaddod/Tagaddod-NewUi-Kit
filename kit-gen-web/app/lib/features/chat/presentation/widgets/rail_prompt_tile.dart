import 'package:flutter/material.dart';
import '../../domain/prompt_preset.dart';

class RailPromptTile extends StatelessWidget {
  const RailPromptTile({
    super.key,
    required this.preset,
    required this.onTap,
  });

  final PromptPreset preset;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: Ink(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: const Color(0x10FFFFFF),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0x14FFFFFF)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(preset.icon, color: const Color(0xFFD8B894), size: 18),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                preset.label,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const Icon(
              Icons.arrow_forward_rounded,
              size: 14,
              color: Color(0xFF7A7F75),
            ),
          ],
        ),
      ),
    );
  }
}
