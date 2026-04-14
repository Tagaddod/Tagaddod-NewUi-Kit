import 'package:flutter/material.dart';
import '../../../domain/generation_payload.dart';

class SearchBarSectionBody extends StatelessWidget {
  const SearchBarSectionBody({super.key, required this.section});

  final ScreenSpecSection section;

  @override
  Widget build(BuildContext context) {
    final placeholder = section.items.isNotEmpty
        ? section.items.first.label
        : 'Search...';
    final hasFilter = section.items.length > 1;

    return Row(
      children: [
        Expanded(
          child: Container(
            height: 48,
            padding: const EdgeInsets.symmetric(horizontal: 14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: const Color(0xFFE2D7CB)),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.search_rounded,
                  size: 20,
                  color: Color(0xFFADAFBD),
                ),
                const SizedBox(width: 10),
                Text(
                  placeholder,
                  style: const TextStyle(
                    fontSize: 15,
                    color: Color(0xFFADAFBD),
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ),
        if (hasFilter) ...[
          const SizedBox(width: 10),
          Container(
            height: 48,
            width: 48,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: const Color(0xFFE2D7CB)),
            ),
            child: const Icon(
              Icons.tune_rounded,
              size: 20,
              color: Color(0xFF686C83),
            ),
          ),
        ],
      ],
    );
  }
}
