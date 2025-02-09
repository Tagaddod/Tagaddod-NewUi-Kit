import 'package:flutter/material.dart';
import 'package:tagaddod_ui_kit/widgets/app_badge.dart';
import 'package:tagaddod_ui_kit/widgets/app_text.dart';

class SampleAppBadge extends StatelessWidget {
  const SampleAppBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        children: [
          //small Badges
          AppText.bodyLgSemiBold(text: "Sample Small App Badges"),
          SizedBox(height: 15),
          SampleSmallAppBadges(),
          Divider(),
          //sample Medium app badges
          AppText.bodyLgSemiBold(text: "Sample Medium App Badges"),
          SizedBox(height: 15),
          SampleMediumAppBadges(),
          SizedBox(height: 15),
        ],
      ),
    );
  }
}

class SampleSmallAppBadges extends StatelessWidget {
  const SampleSmallAppBadges({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          //small badges
          const AppSmallState(
            text: "Disabled",
          ),

          SizedBox(
            width: MediaQuery.sizeOf(context).width * 0.5,
            child: const Divider(
              thickness: 1,
            ),
          ),

          //default state
          const AppSmallState(
            text: "Default",
          ),
          SizedBox(
            width: MediaQuery.sizeOf(context).width * 0.5,
            child: const Divider(
              thickness: 1,
            ),
          ),

          const AppSmallState(
            text: "Info",
          ),
          SizedBox(
            width: MediaQuery.sizeOf(context).width * 0.5,
            child: const Divider(
              thickness: 1,
            ),
          ),

          const AppSmallState(
            text: "Success",
          ),
          SizedBox(
            width: MediaQuery.sizeOf(context).width * 0.5,
            child: const Divider(
              thickness: 1,
            ),
          ),
          const AppSmallState(
            text: "Warning",
          ),
          SizedBox(
            width: MediaQuery.sizeOf(context).width * 0.5,
            child: const Divider(
              thickness: 1,
            ),
          ),
          const AppSmallState(
            text: "Critical",
          ),
        ]);
  }
}

class AppSmallState extends StatelessWidget {
  final String text;
  const AppSmallState({
    super.key,
    this.text = "Success",
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        AppText.bodyLg(text: text),
        const SizedBox(
          width: 50,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                const AppText.bodyLgMedium(text: "Strong is False"),
                const SizedBox(width: 15),
                AppBadge.small(
                  isStrong: false,
                  badgeType: getBadgeType(text),
                  textLabel: "Label",
                  svgIconPath: "assets/svg/error.svg",
                ),
              ],
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                const AppText.bodyLgMedium(text: "Strong is true"),
                const SizedBox(width: 15),
                AppBadge.small(
                  isStrong: true,
                  badgeType: getBadgeType(text),
                  textLabel: "Label",
                  svgIconPath: "assets/svg/error.svg",
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

//medium states
class AppMediumState extends StatelessWidget {
  final String text;
  const AppMediumState({
    super.key,
    this.text = "Success",
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        AppText.bodyLg(text: text),
        const SizedBox(
          width: 50,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                const AppText.bodyLgMedium(text: "Strong is False"),
                const SizedBox(width: 15),
                AppBadge.medium(
                  isStrong: false,
                  badgeType: getBadgeType(text),
                  textLabel: "Label",
                  svgIconPath: "assets/svg/error.svg",
                ),
              ],
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                const AppText.bodyLgMedium(text: "Strong is true"),
                const SizedBox(width: 15),
                AppBadge.medium(
                  isStrong: true,
                  badgeType: getBadgeType(text),
                  textLabel: "Label",
                  svgIconPath: "assets/svg/error.svg",
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

getBadgeType(String text) {
  return text == 'Success'
      ? AppBadgeType.success
      : text == 'Default'
          ? AppBadgeType.defaultBadge
          : text == 'Disabled'
              ? AppBadgeType.disabled
              : text == 'Info'
                  ? AppBadgeType.info
                  : text == 'Warning'
                      ? AppBadgeType.warning
                      : text == 'Critical'
                          ? AppBadgeType.critical
                          : AppBadgeType.defaultBadge;
}

//sample medium app badges
class SampleMediumAppBadges extends StatelessWidget {
  const SampleMediumAppBadges({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      //small badges
      const AppMediumState(
        text: "Disabled",
      ),

      SizedBox(
        width: MediaQuery.sizeOf(context).width * 0.5,
        child: const Divider(
          thickness: 1,
        ),
      ),

      //default state
      const AppMediumState(
        text: "Default",
      ),
      SizedBox(
        width: MediaQuery.sizeOf(context).width * 0.5,
        child: const Divider(
          thickness: 1,
        ),
      ),

      const AppMediumState(
        text: "Info",
      ),
      SizedBox(
        width: MediaQuery.sizeOf(context).width * 0.5,
        child: const Divider(
          thickness: 1,
        ),
      ),

      const AppMediumState(
        text: "Success",
      ),
      SizedBox(
        width: MediaQuery.sizeOf(context).width * 0.5,
        child: const Divider(
          thickness: 1,
        ),
      ),
      const AppMediumState(
        text: "Warning",
      ),
      SizedBox(
        width: MediaQuery.sizeOf(context).width * 0.5,
        child: const Divider(
          thickness: 1,
        ),
      ),
      const AppMediumState(
        text: "Critical",
      ),
    ]);
  }
}
