import 'dart:ui';

import 'package:flutter/material.dart';

class DottedRoundedBorder extends StatelessWidget {
  final double borderRadius;
  final double strokeWidth;
  final double dotSpacing;
  final Color color;
  final Widget? child;
  final double width;
  final double height;
  final EdgeInsets padding;

  const DottedRoundedBorder({
    super.key,
    this.borderRadius = 12,
    this.strokeWidth = 2,
    required this.width,
    required this.height,
    this.dotSpacing = 6,
    this.color = Colors.black,
    this.child,
    this.padding = const EdgeInsets.all(12),
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _DottedRoundedRectPainter(
        strokeWidth: strokeWidth,
        dotSpacing: dotSpacing,
        borderRadius: borderRadius,
        color: color,
      ),
      child: SizedBox(
        width: width,
        height: height,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(borderRadius),
          child: child,
        ),
      ),
    );
  }
}

class _DottedRoundedRectPainter extends CustomPainter {
  final double strokeWidth;
  final double dotSpacing;
  final double borderRadius;
  final Color color;

  _DottedRoundedRectPainter({
    required this.strokeWidth,
    required this.dotSpacing,
    required this.borderRadius,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..strokeWidth = strokeWidth
      ..color = color
      ..style = PaintingStyle.stroke;

    final path = Path()
      ..addRRect(RRect.fromRectAndRadius(
        Offset.zero & size,
        Radius.circular(borderRadius),
      ));

    final dashPath = _createDashedPath(path, dotSpacing);
    canvas.drawPath(dashPath, paint);
  }

  Path _createDashedPath(Path source, double dashLength) {
    final Path dest = Path();
    for (final PathMetric metric in source.computeMetrics()) {
      double distance = 0.0;
      while (distance < metric.length) {
        final next = distance + dashLength;
        dest.addPath(
          metric.extractPath(distance, next),
          Offset.zero,
        );
        distance = next + dashLength;
      }
    }
    return dest;
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
