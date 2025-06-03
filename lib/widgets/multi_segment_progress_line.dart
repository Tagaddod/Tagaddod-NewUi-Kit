import 'package:flutter/material.dart';
import 'package:tagaddod_ui_kit/colors/primtives/colors.dart';
import 'package:tagaddod_ui_kit/colors/semantic/bg_colors.dart';
import 'package:tagaddod_ui_kit/colors/semantic/border_colors.dart';
import 'package:tagaddod_ui_kit/colors/semantic/text_colors.dart';
import 'package:tagaddod_ui_kit/widgets/app_text.dart';

class MultiSegmentLinearProgress extends StatelessWidget {
  final double width;
  final double height;
  final int totalTasks;
  final int completedTasks;
  final int pendingTasks;
  final int failedTasks;
  final Color completedColor;
  final Color pendingColor;
  final Color failedColor;
  final Color remainingColor;
  final double borderRadius;

  const MultiSegmentLinearProgress({
    super.key,
    required this.width,
    required this.height,
    required this.totalTasks,
    required this.completedTasks,
    required this.pendingTasks,
    required this.failedTasks,
    this.completedColor = BgColors.colorBgFillSuccess,
    this.pendingColor = BgColors.colorBgFillWarning,
    this.failedColor = BgColors.colorBgFillCritical,
    this.remainingColor = const Color(0xFFE5E5E5),
    this.borderRadius = 5.0,
  });

  @override
  Widget build(BuildContext context) {
    if (totalTasks <= 0) {
      return Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          color: remainingColor,
          border: Border.all(
            color: BorderColors.colorBorderSecondary,
            width: 1,
          ),
        ),
      );
    }

    final completedPercent = completedTasks / totalTasks;
    final pendingPercent = pendingTasks / totalTasks;
    final failedPercent = failedTasks / totalTasks;
    final remainingPercent =
        (totalTasks - completedTasks - pendingTasks - failedTasks) / totalTasks;

    // Calculate cumulative widths for positioning
    final completedWidth = width * completedPercent;
    final pendingWidth = width * pendingPercent;
    final failedWidth = width * failedPercent;
    final remainingWidth = width * remainingPercent;

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        color: remainingColor,
        border: Border.all(
          color: BorderColors.colorBorderSecondary,
          width: 1,
        ),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Progress bar with segments
          ClipRRect(
            borderRadius: BorderRadius.circular(borderRadius),
            child: Stack(
              children: [
                // Background (remaining) - full width
                Container(
                  width: width,
                  height: height,
                  color: remainingColor,
                ),

                // Completed segment - starts from right
                if (completedPercent > 0)
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      width: completedWidth,
                      height: height,
                      decoration: BoxDecoration(
                        color: completedColor,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(borderRadius),
                          bottomRight: Radius.circular(borderRadius),
                          topLeft: completedPercent >= 1.0
                              ? Radius.circular(borderRadius)
                              : Radius.zero,
                          bottomLeft: completedPercent >= 1.0
                              ? Radius.circular(borderRadius)
                              : Radius.zero,
                        ),
                      ),
                    ),
                  ),

                // Pending segment - after completed
                if (pendingPercent > 0)
                  Positioned(
                    right: completedWidth,
                    top: 0,
                    child: Container(
                      width: pendingWidth,
                      height: height,
                      decoration: BoxDecoration(
                        color: pendingColor,
                        borderRadius: BorderRadius.only(
                          topLeft: (completedPercent + pendingPercent) >= 1.0
                              ? Radius.circular(borderRadius)
                              : Radius.zero,
                          bottomLeft: (completedPercent + pendingPercent) >= 1.0
                              ? Radius.circular(borderRadius)
                              : Radius.zero,
                        ),
                      ),
                    ),
                  ),

                // Failed segment - after pending
                if (failedPercent > 0)
                  Positioned(
                    right: completedWidth + pendingWidth,
                    top: 0,
                    child: Container(
                      width: failedWidth,
                      height: height,
                      decoration: BoxDecoration(
                        color: failedColor,
                        borderRadius: BorderRadius.only(
                          topLeft: (completedPercent +
                                      pendingPercent +
                                      failedPercent) >=
                                  1.0
                              ? Radius.circular(borderRadius)
                              : Radius.zero,
                          bottomLeft: (completedPercent +
                                      pendingPercent +
                                      failedPercent) >=
                                  1.0
                              ? Radius.circular(borderRadius)
                              : Radius.zero,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),

          // Percentage indicator - positioned outside ClipRRect to avoid clipping
          if (completedPercent > 0)
            Positioned(
              right: completedWidth - 45,
              top: -(height / 2) - 2,
              child: Container(
                width: 40,
                height: height * 2,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: completedColor,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: AppColors.colorWhite,
                    width: 2,
                  ),
                ),
                child: AppText.captionSm(
                  text: '${(completedPercent * 100).toInt()}%',
                  textAlign: TextAlign.center,
                  textColor: TextColors.colorTextOnBgFill,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
