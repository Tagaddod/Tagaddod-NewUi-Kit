import 'package:flutter/material.dart';
import 'package:tagaddod_ui_kit/colors/semantic/icon_colors.dart';
import 'package:tagaddod_ui_kit/colors/semantic/text_colors.dart';
import 'package:tagaddod_ui_kit/typography/primitives/typography.dart'
    as typography;
import 'package:tagaddod_ui_kit/typography/semantics/caption_styles.dart';
import 'package:tagaddod_ui_kit/widgets/app_icon.dart';

class AppBottomNavigationBar extends StatelessWidget {
  final List<AppBottomNavigationBarItem> items;
  final int selectedIndex;
  final Color? backgroundColor;
  final double? elevation;
  final Function(int)? onTap;
  final double iconSize;
  final Color? fixedColor;
  final double selectedFontSize;
  final double unselectedFontSize;
  final IconThemeData? selectedIconTheme;
  final IconThemeData? unselectedIconTheme;
  final BottomNavigationBarType? type;
  final Color? selectedItemColor;
  final Color? unselectedItemColor;
  final bool? showUnselectedLabels;
  final bool? showSelectedLabels;
  final TextStyle? selectedLabelStyle;
  final TextStyle? unselectedLabelStyle;
  final MouseCursor? mouseCursor;
  const AppBottomNavigationBar(
      {super.key,
      required this.items,
      this.selectedIndex = 0,
      this.backgroundColor,
      this.type = BottomNavigationBarType.fixed,
      this.onTap,
      this.elevation,
      this.iconSize = 24,
      this.fixedColor,
      this.selectedFontSize = 14,
      this.unselectedFontSize = 12,
      this.selectedIconTheme,
      this.unselectedIconTheme,
      this.selectedItemColor,
      this.unselectedItemColor,
      this.showUnselectedLabels,
      this.showSelectedLabels,
      this.selectedLabelStyle,
      this.unselectedLabelStyle,
      this.mouseCursor});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: items
          .map((e) => BottomNavigationBarItem(
                icon: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    e.icon.copyWith(
                        colorFilter: selectedIndex == items.indexOf(e)
                            ? null
                            : const ColorFilter.mode(
                                IconColors.colorIconSecondary,
                                BlendMode.srcIn)),
                    const SizedBox(
                      height: 3,
                    )
                  ],
                ),
                label: e.label,
              ))
          .toList(),
      currentIndex: selectedIndex,
      onTap: onTap,
      type: type,
      backgroundColor: backgroundColor,
      elevation: elevation,
      iconSize: iconSize,
      fixedColor: fixedColor,
      selectedFontSize: selectedFontSize,
      unselectedFontSize: unselectedFontSize,
      selectedIconTheme: selectedIconTheme ??
          const IconThemeData(color: TextColors.colorTextLink),
      unselectedIconTheme: unselectedIconTheme ??
          const IconThemeData(color: TextColors.colorTextSecondary),
      selectedItemColor: selectedItemColor ?? TextColors.colorTextLink,
      unselectedItemColor: unselectedItemColor ?? TextColors.colorTextSecondary,
      showUnselectedLabels: showUnselectedLabels,
      showSelectedLabels: showSelectedLabels,
      selectedLabelStyle: selectedLabelStyle ??
          CaptionStyles.captionSmSemiBold
              .copyWith(color: TextColors.colorTextLink),
      unselectedLabelStyle: unselectedLabelStyle ??
          const TextStyle(
            color: TextColors.colorTextSecondary,
            fontSize: typography.Typography.fontSize250,
            fontWeight: typography.Typography.fontWeightRegular,
          ),
      mouseCursor: mouseCursor,
    );
  }
}

class AppBottomNavigationBarItem {
  final AppIcon icon;
  final String label;
  final bool isSelected;

  AppBottomNavigationBarItem({
    required this.icon,
    required this.label,
    this.isSelected = false,
  });
}
