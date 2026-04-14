import 'package:flutter/material.dart';

class RailModeToggle extends StatelessWidget {
  const RailModeToggle({
    super.key,
    required this.arch,
    required this.onChanged,
  });

  final bool arch;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0x10FFFFFF),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0x10FFFFFF)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  arch ? 'Architecture mode' : 'Screen mode',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  arch
                      ? 'Multi-file feature scaffold'
                      : 'Single screen + live preview',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: const Color(0xFF7A8078),
                  ),
                ),
              ],
            ),
          ),
          Switch(value: arch, onChanged: onChanged),
        ],
      ),
    );
  }
}
