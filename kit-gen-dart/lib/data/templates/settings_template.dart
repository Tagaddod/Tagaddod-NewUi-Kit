import 'screen_template.dart';

const settingsTemplate = ScreenTemplate(
  name: 'Settings Screen',
  description: 'Settings list with switches and navigation rows',
  code: _part1 + _part2,
);

const _part1 = r"""
import 'package:flutter/material.dart';
import 'package:tagaddod_ui_kit/widgets/top_app_bar.dart';
import 'package:tagaddod_ui_kit/widgets/app_text.dart';
import 'package:tagaddod_ui_kit/widgets/app_switch.dart';
import 'package:tagaddod_ui_kit/widgets/app_divider.dart';
import 'package:tagaddod_ui_kit/widgets/app_icon.dart';
import 'package:tagaddod_ui_kit/colors/semantic/text_colors.dart';
import 'package:tagaddod_ui_kit/colors/semantic/icon_colors.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});
  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notifications = true;
  bool _darkMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopAppBar(title: AppText.bodyLgSemiBold(text: 'Settings', textColor: TextColors.colorText)),
      body: ListView(children: [
        _tile('Notifications', _notifications, (v) => setState(() => _notifications = v)),
        const AppDivider(),
        _tile('Dark Mode', _darkMode, (v) => setState(() => _darkMode = v)),
        const AppDivider(),
        _nav('Account'), const AppDivider(),
        _nav('Privacy'), const AppDivider(),
        _nav('About'),
      ]),
    );
  }
""";

const _part2 = r"""
  Widget _tile(String title, bool value, ValueChanged<bool> cb) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(children: [
        Expanded(child: AppText.bodyMd(text: title, textColor: TextColors.colorText)),
        AppSwitch(value: value, onChanged: cb),
      ]),
    );
  }

  Widget _nav(String title) {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Row(children: [
          Expanded(child: AppText.bodyMd(text: title, textColor: TextColors.colorText)),
          AppIcon(svgIconPath: 'assets/svg/chevron_right.svg', width: 20, height: 20,
            colorFilter: ColorFilter.mode(IconColors.colorIcon, BlendMode.srcIn)),
        ]),
      ),
    );
  }
}
""";
