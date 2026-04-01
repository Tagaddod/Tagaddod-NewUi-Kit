import 'dart:convert';
import 'package:flutter/material.dart';
import '../../../../core/widgets/copy_button.dart';

class MockupImageWidget extends StatelessWidget {
  const MockupImageWidget({super.key, this.base64Image});
  final String? base64Image;

  @override
  Widget build(BuildContext context) {
    if (base64Image == null || base64Image!.isEmpty) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Text(
            'Preview unavailable yet.\n'
            'It appears when image generation succeeds.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      );
    }
    final decoded = base64Decode(base64Image!);
    final dataUri = 'data:image/png;base64,$base64Image';
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Text('Live Preview',
                    style: Theme.of(context).textTheme.titleSmall),
                const Spacer(),
                CopyButton(text: dataUri, tooltip: 'Copy preview data URI'),
              ],
            ),
            const SizedBox(height: 8),
            Image.memory(decoded, fit: BoxFit.contain, height: 360),
          ],
        ),
      ),
    );
  }
}
