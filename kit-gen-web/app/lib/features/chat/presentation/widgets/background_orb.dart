import 'package:flutter/material.dart';

class BackgroundOrb extends StatelessWidget {
  const BackgroundOrb({super.key, required this.color, required this.size});

  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color.withValues(alpha: 0.28),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.18),
              blurRadius: 100,
              spreadRadius: 8,
            ),
          ],
        ),
      ),
    );
  }
}
