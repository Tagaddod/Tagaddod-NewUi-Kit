import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tagaddod_ui_kit/colors/semantic/bg_colors.dart';
import 'package:tagaddod_ui_kit/colors/semantic/text_colors.dart';
import 'dart:math' as math;

class MultiSegmentCircularProgress extends StatelessWidget {
  final double size;
  final double strokeWidth;
  final int totalTasks;
  final int completedTasks;
  final int pendingTasks;
  final int failedTasks;
  final Color completedColor;
  final Color pendingColor;
  final Color failedColor;
  final Color remainingColor;

  const MultiSegmentCircularProgress({
    super.key,
    required this.size,
    required this.strokeWidth,
    required this.totalTasks,
    required this.completedTasks,
    required this.pendingTasks,
    required this.failedTasks,
    this.completedColor = BgColors.colorBgFillSuccess,
    this.pendingColor = BgColors.colorBgFillWarning,
    this.failedColor = BgColors.colorBgFillCritical,
    this.remainingColor = Colors.grey,
  });

  @override
  Widget build(BuildContext context) {
    final completedPercent = totalTasks > 0 ? completedTasks / totalTasks : 0.0;
    final pendingPercent = totalTasks > 0 ? pendingTasks / totalTasks : 0.0;
    final failedPercent = totalTasks > 0 ? failedTasks / totalTasks : 0.0;
    final remainingPercent = totalTasks > 0
        ? (totalTasks - completedTasks - pendingTasks - failedTasks) /
            totalTasks
        : 1.0;

    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        children: [
          // Background circle
          Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: remainingColor.withOpacity(0.3),
                width: strokeWidth,
              ),
            ),
          ),
          // Custom painter for segments
          CustomPaint(
            size: Size(size, size),
            painter: MultiSegmentCircularProgressPainter(
              completedPercent: completedPercent,
              pendingPercent: pendingPercent,
              failedPercent: failedPercent,
              remainingPercent: remainingPercent,
              completedColor: completedColor,
              pendingColor: pendingColor,
              failedColor: failedColor,
              remainingColor: remainingColor,
              strokeWidth: strokeWidth,
            ),
          ),
          // Center text showing completed/total
          Center(
            child: Text(
              '${((completedTasks / totalTasks) * 100).toInt()}%',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.bold,
                color: TextColors.colorText,
                height: 1.2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MultiSegmentCircularProgressPainter extends CustomPainter {
  final double completedPercent;
  final double pendingPercent;
  final double failedPercent;
  final double remainingPercent;
  final Color completedColor;
  final Color pendingColor;
  final Color failedColor;
  final Color remainingColor;
  final double strokeWidth;

  MultiSegmentCircularProgressPainter({
    required this.completedPercent,
    required this.pendingPercent,
    required this.failedPercent,
    required this.remainingPercent,
    required this.completedColor,
    required this.pendingColor,
    required this.failedColor,
    required this.remainingColor,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;

    double startAngle = -math.pi / 2; // Start from top

    // Draw completed segment
    if (completedPercent > 0) {
      final sweepAngle = 2 * math.pi * completedPercent;
      final paint = Paint()
        ..color = completedColor
        ..strokeWidth = strokeWidth
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round;

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sweepAngle,
        false,
        paint,
      );
      startAngle += sweepAngle;
    }

    // Draw pending segment
    if (pendingPercent > 0) {
      final sweepAngle = 2 * math.pi * pendingPercent;
      final paint = Paint()
        ..color = pendingColor
        ..strokeWidth = strokeWidth
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round;

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sweepAngle,
        false,
        paint,
      );
      startAngle += sweepAngle;
    }

    // Draw failed segment
    if (failedPercent > 0) {
      final sweepAngle = 2 * math.pi * failedPercent;
      final paint = Paint()
        ..color = failedColor
        ..strokeWidth = strokeWidth
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round;

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sweepAngle,
        false,
        paint,
      );
      startAngle += sweepAngle;
    }

    // Draw remaining segment
    if (remainingPercent > 0) {
      final sweepAngle = 2 * math.pi * remainingPercent;
      final paint = Paint()
        ..color = remainingColor
        ..strokeWidth = strokeWidth
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round;

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sweepAngle,
        false,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
