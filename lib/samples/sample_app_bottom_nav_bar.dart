import 'package:flutter/material.dart';
import 'package:tagaddod_ui_kit/typography/primitives/typography.dart'
    as typography;
import 'package:tagaddod_ui_kit/widgets/app_icon.dart';
import 'package:tagaddod_ui_kit/widgets/bottom_navigation_bar.dart';

class SampleAppBottomNavBar extends StatelessWidget {
  const SampleAppBottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        //2 items
        SampleBottomWith2Items(),
        const SizedBox(
          height: 20,
        ),
        //3 items
        SampleBottomWith3Items(),
        const SizedBox(
          height: 20,
        ),
        //4 items
        SampleBottomWith4Items(),
      ],
    );
  }
}

class SampleBottomWith2Items extends StatelessWidget {
  SampleBottomWith2Items({
    super.key,
  });

  final ValueNotifier<int> selectedIndex = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(fontFamily: typography.Typography.fontFamilySansEnglish),
      child: ValueListenableBuilder<int>(
        valueListenable: selectedIndex,
        builder: (context, value, child) => AppBottomNavigationBar(
          onTap: (p0) {
            selectedIndex.value = p0;
          },
          selectedIndex: value,
          items: [
            AppBottomNavigationBarItem(
              icon: const AppIcon(
                svgIconPath: "assets/svg/nav_icon.svg",
                width: 18,
                height: 18,
              ),
              label: "Home",
            ),
            AppBottomNavigationBarItem(
              icon: const AppIcon(
                svgIconPath: "assets/svg/nav_icon.svg",
                width: 18,
                height: 18,
              ),
              label: "Settings",
            ),
          ],
        ),
      ),
    );
  }
}

class SampleBottomWith3Items extends StatelessWidget {
  SampleBottomWith3Items({
    super.key,
  });

  final ValueNotifier<int> selectedIndex = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(fontFamily: typography.Typography.fontFamilySansEnglish),
      child: ValueListenableBuilder<int>(
        valueListenable: selectedIndex,
        builder: (context, value, child) => AppBottomNavigationBar(
          onTap: (p0) {
            selectedIndex.value = p0;
          },
          selectedIndex: value,
          items: [
            AppBottomNavigationBarItem(
              icon: const AppIcon(
                svgIconPath: "assets/svg/nav_icon.svg",
                width: 18,
                height: 18,
              ),
              label: "Home",
            ),
            AppBottomNavigationBarItem(
              icon: const AppIcon(
                svgIconPath: "assets/svg/nav_icon.svg",
                width: 18,
                height: 18,
              ),
              label: "Settings",
            ),
            AppBottomNavigationBarItem(
              icon: const AppIcon(
                svgIconPath: "assets/svg/nav_icon.svg",
                width: 18,
                height: 18,
              ),
              label: "Home",
            ),
          ],
        ),
      ),
    );
  }
}

class SampleBottomWith4Items extends StatelessWidget {
  SampleBottomWith4Items({
    super.key,
  });

  final ValueNotifier<int> selectedIndex = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(fontFamily: typography.Typography.fontFamilySansArabic),
      child: ValueListenableBuilder<int>(
        valueListenable: selectedIndex,
        builder: (context, value, child) => AppBottomNavigationBar(
          onTap: (p0) {
            selectedIndex.value = p0;
          },
          selectedIndex: value,
          items: [
            AppBottomNavigationBarItem(
              icon: const AppIcon(
                svgIconPath: "assets/svg/nav_icon.svg",
                width: 18,
                height: 18,
              ),
              label: "صفحه",
            ),
            AppBottomNavigationBarItem(
              icon: const AppIcon(
                svgIconPath: "assets/svg/nav_icon.svg",
                width: 18,
                height: 18,
              ),
              label: "صفحه",
            ),
            AppBottomNavigationBarItem(
              icon: const AppIcon(
                svgIconPath: "assets/svg/nav_icon.svg",
                width: 18,
                height: 18,
              ),
              label: "صفحه",
            ),
            AppBottomNavigationBarItem(
              icon: const AppIcon(
                svgIconPath: "assets/svg/nav_icon.svg",
                width: 18,
                height: 18,
              ),
              label: "صفحه",
            ),
          ],
        ),
      ),
    );
  }
}
