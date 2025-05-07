import 'package:flutter/material.dart';
import 'package:tagaddod_ui_kit/colors/primtives/colors.dart';
import 'package:tagaddod_ui_kit/colors/semantic/bg_colors.dart';
import 'package:tagaddod_ui_kit/colors/semantic/border_colors.dart';
import 'package:tagaddod_ui_kit/colors/semantic/text_colors.dart';
import 'package:tagaddod_ui_kit/typography/semantics/body_styles.dart';

class ScrollableTabBar extends StatelessWidget {
  final List<String> tabs;
  final int selectedIndex;
  final ValueChanged<int> onTabSelected;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? paddingInside;
  final double? width, height;
  final TextAlign textAlign;

  final double borderRadius;
  final Color activeColor,
      indicatorColor,
      inactiveColor,
      borderColor,
      activeTextColor,
      inactiveTextColor;

  const ScrollableTabBar(
      {Key? key,
      required this.tabs,
      required this.selectedIndex,
      required this.onTabSelected,
      this.paddingInside,
      this.activeColor = Colors.black,
      this.width,
      this.height,
      this.inactiveColor = BgColors.colorBgSurfaceHover,
      this.margin,
      this.textAlign = TextAlign.center,
      this.borderRadius = 8,
      this.indicatorColor = AppColors.colorGray1600,
      this.borderColor = BorderColors.colorBorderSecondary,
      this.activeTextColor = TextColors.colorTextOnBgFill,
      this.inactiveTextColor = TextColors.colorText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(tabs.length, (index) {
          final isSelected = index == selectedIndex;
          return GestureDetector(
            onTap: () => onTabSelected(index),
            child: Container(
              width: width,
              height: height,
              margin: margin ?? const EdgeInsets.symmetric(horizontal: 4),
              padding: paddingInside ?? const EdgeInsets.all(12),
              decoration: BoxDecoration(
                  color: isSelected ? indicatorColor : Colors.transparent,
                  borderRadius: BorderRadius.circular(borderRadius),
                  border: Border.all(color: borderColor)),
              child: Text(
                tabs[index],
                textAlign: textAlign,
                style: BodyStyles.bodySmMedium.copyWith(
                  color: isSelected ? activeTextColor : inactiveTextColor,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
