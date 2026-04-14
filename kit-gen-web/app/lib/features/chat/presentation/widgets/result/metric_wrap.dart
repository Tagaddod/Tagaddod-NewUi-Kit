import 'package:flutter/material.dart';
import '../../../domain/generation_payload.dart';
import 'metric_chip.dart';

class MetricWrap extends StatelessWidget {
  const MetricWrap({super.key, required this.result});

  final GenerationPayload result;

  @override
  Widget build(BuildContext context) {
    final chips = <Widget>[
      MetricChip(label: 'Input', value: '${result.tokens['input']} tokens'),
      MetricChip(label: 'Output', value: '${result.tokens['output']} tokens'),
      ...result.timings.values.entries.map(
        (e) => MetricChip(
          label: _label(e.key),
          value: '${e.value} ms',
        ),
      ),
    ];
    return Wrap(spacing: 8, runSpacing: 8, children: chips);
  }

  String _label(String key) {
    return key
        .replaceAll('Ms', '')
        .replaceAllMapped(RegExp(r'([A-Z])'), (m) => ' ${m.group(1)}')
        .trim();
  }
}
