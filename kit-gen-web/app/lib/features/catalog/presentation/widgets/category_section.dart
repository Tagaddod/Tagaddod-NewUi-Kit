import 'package:flutter/material.dart';
import '../../domain/component_item.dart';
import 'component_card.dart';

class CategorySection extends StatelessWidget {
  const CategorySection({super.key, required this.title, required this.items});
  final String title;
  final List<ComponentItem> items;

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        ),
        ...items.map((e) => ComponentCard(item: e)),
      ],
    );
  }
}
