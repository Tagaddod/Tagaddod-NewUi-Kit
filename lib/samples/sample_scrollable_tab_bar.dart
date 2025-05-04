import 'package:flutter/material.dart';
import 'package:tagaddod_ui_kit/widgets/scrollable_tab_bar.dart';

class SampleScrollableTabBar extends StatefulWidget {
  @override
  State<SampleScrollableTabBar> createState() => _SampleScrollableTabBarState();
}

class _SampleScrollableTabBarState extends State<SampleScrollableTabBar> {
  int selectedTab = 0;

  final List<String> tabTitles = [
    "Home",
    "Explore",
    "Trending",
    "Favorites",
    "Settings",
    "Profile",
    "More"
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ScrollableTabBar(
          tabs: tabTitles,
          selectedIndex: selectedTab,
          onTabSelected: (index) {
            setState(() {
              selectedTab = index;
            });
          },
        ),
        Expanded(
          child: Center(
            child: Text(
              "Selected Tab: ${tabTitles[selectedTab]}",
              style: TextStyle(fontSize: 24),
            ),
          ),
        ),
      ],
    );
  }
}
