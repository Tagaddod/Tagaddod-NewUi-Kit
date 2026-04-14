import 'package:flutter/material.dart';
import 'rail_mode_toggle.dart';

class ControlRail extends StatelessWidget {
  const ControlRail({
    super.key,
    required this.arch,
    required this.onArchChanged,
    required this.onUsePrompt,
  });

  final bool arch;
  final ValueChanged<bool> onArchChanged;
  final ValueChanged<String> onUsePrompt;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF18201A),
        borderRadius: BorderRadius.circular(24),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _Badge(),
          const SizedBox(height: 12),
          Text(
            'Kit-Gen',
            style: theme.textTheme.headlineSmall?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w900,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Requirement → preview → code.',
            style: theme.textTheme.bodySmall?.copyWith(color: const Color(0xFF8A9187)),
          ),
          const SizedBox(height: 20),
          RailModeToggle(arch: arch, onChanged: onArchChanged),
        ],
      ),
    );
  }
}

class _Badge extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: const Color(0x18FFFFFF),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        'Tagaddod Lab',
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
          color: const Color(0xFFCFD4CA),
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

