import 'package:flutter/material.dart';
import '../../domain/component_item.dart';
import '../widgets/catalog_search_bar.dart';
import '../widgets/category_section.dart';

class CatalogSidebar extends StatelessWidget {
  const CatalogSidebar({
    super.key,
    required this.items,
    required this.searchController,
    required this.onSearch,
  });

  final List<ComponentItem> items;
  final TextEditingController searchController;
  final ValueChanged<String> onSearch;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 360,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: Theme.of(context).colorScheme.surfaceContainerHighest),
      child: Column(
        children: [
          CatalogSearchBar(controller: searchController, onChanged: onSearch),
          const SizedBox(height: 8),
          Expanded(
            child: ListView(
              children: [
                CategorySection(title: 'Components', items: items),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
