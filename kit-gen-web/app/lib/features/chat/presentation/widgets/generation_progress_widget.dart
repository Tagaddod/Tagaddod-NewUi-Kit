import 'package:flutter/material.dart';

class GenerationProgressWidget extends StatelessWidget {
  const GenerationProgressWidget({
    super.key,
    required this.prompt,
    required this.stage,
    required this.elapsedSeconds,
  });

  final String prompt;
  final String stage;
  final int elapsedSeconds;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(top: 10, bottom: 10, right: 80),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              const SizedBox(
                height: 16,
                width: 16,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
              const SizedBox(width: 10),
              Text('Generating...', style: Theme.of(context).textTheme.titleSmall),
              const Spacer(),
              Text('${elapsedSeconds}s'),
            ]),
            const SizedBox(height: 10),
            Text('Working on: $prompt', maxLines: 2, overflow: TextOverflow.ellipsis),
            const SizedBox(height: 8),
            Text('Current step: $stage'),
          ],
        ),
      ),
    );
  }
}
