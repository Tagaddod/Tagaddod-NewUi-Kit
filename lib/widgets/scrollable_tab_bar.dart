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
      this.activeColor = Colors.black,
      this.inactiveColor = BgColors.colorBgSurfaceHover,
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
              margin: const EdgeInsets.symmetric(horizontal: 4),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                  color: isSelected ? indicatorColor : Colors.transparent,
                  borderRadius: BorderRadius.circular(120),
                  border: Border.all(color: borderColor)),
              child: Text(
                tabs[index],
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
