import 'package:flutter/material.dart';

class CatalogSearchBar extends StatelessWidget {
  const CatalogSearchBar({super.key, required this.controller, required this.onChanged});
  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      decoration: const InputDecoration(
        hintText: 'Search components...',
        prefixIcon: Icon(Icons.search),
      ),
    );
  }
}
