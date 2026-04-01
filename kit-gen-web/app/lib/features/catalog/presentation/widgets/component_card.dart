import 'package:flutter/material.dart';
import '../../domain/component_item.dart';

class ComponentCard extends StatelessWidget {
  const ComponentCard({super.key, required this.item});
  final ComponentItem item;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(item.className),
      subtitle: Text(item.description, maxLines: 2, overflow: TextOverflow.ellipsis),
      childrenPadding: const EdgeInsets.all(8),
      children: [
        SelectableText('Import: ${item.importPath}'),
        const SizedBox(height: 6),
        SelectableText('Constructors: ${item.constructors.join(', ')}'),
        const SizedBox(height: 6),
        SelectableText('Parameters: ${item.parameters}'),
      ],
    );
  }
}
