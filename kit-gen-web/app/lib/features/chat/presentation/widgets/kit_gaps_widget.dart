import 'package:flutter/material.dart';
import '../../../../core/widgets/copy_button.dart';

class KitGapsWidget extends StatelessWidget {
  const KitGapsWidget({super.key, required this.gaps});
  final List<Map<String, dynamic>> gaps;

  @override
  Widget build(BuildContext context) {
    if (gaps.isEmpty) return const SizedBox.shrink();
    final text = gaps
        .map((g) => '${g['widget_name']}: ${g['description']}')
        .join('\n');
    return Card(
      color: Colors.orange.shade50,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text('Kit gaps',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                const Spacer(),
                CopyButton(text: text, tooltip: 'Copy gaps'),
              ],
            ),
            const SizedBox(height: 6),
            for (final g in gaps)
              SelectableText('• ${g['widget_name']}: ${g['description']}'),
          ],
        ),
      ),
    );
  }
}
