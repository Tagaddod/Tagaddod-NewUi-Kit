import 'package:flutter/material.dart';

class PhoneFrame extends StatelessWidget {
  const PhoneFrame({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFF111314),
        borderRadius: BorderRadius.circular(40),
        boxShadow: const [
          BoxShadow(
            color: Color(0x22000000),
            blurRadius: 32,
            offset: Offset(0, 16),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 22,
            margin: const EdgeInsets.only(bottom: 8),
            alignment: Alignment.center,
            child: Container(
              width: 88,
              height: 6,
              decoration: BoxDecoration(
                color: const Color(0xFF2A2E32),
                borderRadius: BorderRadius.circular(999),
              ),
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: AspectRatio(
              aspectRatio: 9 / 19.5,
              child: ColoredBox(
                color: const Color(0xFFF6F1E8),
                child: child,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
