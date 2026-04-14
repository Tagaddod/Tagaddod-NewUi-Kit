import 'package:flutter/material.dart';

class RailTeamsNote extends StatelessWidget {
  const RailTeamsNote({super.key});

  static const _bullets = [
    ('Product', 'Preview first, then decide'),
    ('Flutter', 'Strong starting point for screens'),
    ('Marketing', 'Explore surfaces without code'),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: _bullets
          .map((b) => _BulletRow(title: b.$1, body: b.$2))
          .toList(),
    );
  }
}

class _BulletRow extends StatelessWidget {
  const _BulletRow({required this.title, required this.body});

  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 6,
            height: 6,
            margin: const EdgeInsets.only(top: 7),
            decoration: const BoxDecoration(
              color: Color(0xFFD8B894),
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: const Color(0xFF8A9187),
                ),
                children: [
                  TextSpan(
                    text: '$title  ',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  TextSpan(text: body),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
