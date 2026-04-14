import 'package:flutter/material.dart';
import '../../domain/prompt_preset.dart';
import 'prompt_preset_card.dart';

class WorkspaceLanding extends StatelessWidget {
  const WorkspaceLanding({
    super.key,
    required this.onUsePrompt,
    this.compact = false,
  });

  final ValueChanged<String> onUsePrompt;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final columns = compact ? 1 : 2;
    final presets = PromptPreset.defaults;

    return SingleChildScrollView(
      padding: EdgeInsets.all(compact ? 18 : 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _Hero(compact: compact),
          SizedBox(height: compact ? 20 : 28),
          Text(
            'Start from a pattern',
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 14),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: columns,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              mainAxisExtent: compact ? 148 : 160,
            ),
            itemCount: presets.length,
            itemBuilder: (_, i) => PromptPresetCard(
              preset: presets[i],
              onTap: () => onUsePrompt(presets[i].prompt),
            ),
          ),
        ],
      ),
    );
  }
}

class _Hero extends StatelessWidget {
  const _Hero({required this.compact});

  final bool compact;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(compact ? 20 : 26),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF18201A), Color(0xFF252E27)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Build a product surface in seconds',
            style: theme.textTheme.headlineSmall?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w900,
              height: 1.15,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Describe what you want. Kit-Gen grounds it in the Tagaddod UI kit and returns a live preview, Flutter code, and component insights.',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: const Color(0xFF8A9187),
              height: 1.5,
            ),
          ),
          const SizedBox(height: 18),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: const [
              _HeroChip(icon: Icons.visibility_outlined, label: 'Live preview'),
              _HeroChip(icon: Icons.widgets_outlined, label: 'Kit-grounded code'),
              _HeroChip(
                icon: Icons.library_add_check_outlined,
                label: 'Gap analysis',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _HeroChip extends StatelessWidget {
  const _HeroChip({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0x16FFFFFF),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: const Color(0xFFD8B894)),
          const SizedBox(width: 6),
          Text(
            label,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: const Color(0xFFCFD4CA),
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
