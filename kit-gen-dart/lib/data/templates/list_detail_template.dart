import 'screen_template.dart';

const listDetailTemplate = ScreenTemplate(
  name: 'List Detail Screen',
  description: 'Master list with badges and navigation',
  code: r"""
import 'package:flutter/material.dart';
import 'package:tagaddod_ui_kit/widgets/top_app_bar.dart';
import 'package:tagaddod_ui_kit/widgets/app_text.dart';
import 'package:tagaddod_ui_kit/widgets/app_icon.dart';
import 'package:tagaddod_ui_kit/widgets/app_badge.dart';
import 'package:tagaddod_ui_kit/widgets/app_divider.dart';
import 'package:tagaddod_ui_kit/colors/semantic/text_colors.dart';
import 'package:tagaddod_ui_kit/colors/semantic/icon_colors.dart';

class ListScreen extends StatelessWidget {
  const ListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopAppBar(title: AppText.bodyLgSemiBold(text: 'Items', textColor: TextColors.colorText)),
      body: ListView.separated(
        itemCount: 10,
        separatorBuilder: (_, __) => const AppDivider(),
        itemBuilder: (context, i) => InkWell(
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Row(children: [
              Expanded(child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText.bodyMdSemiBold(text: 'Item ${i + 1}', textColor: TextColors.colorText),
                  const SizedBox(height: 4),
                  AppText.bodySm(text: 'Description ${i + 1}', textColor: TextColors.colorTextSecondary),
                ],
              )),
              AppBadge.small(textLabel: 'Active', badgeType: AppBadgeType.success),
              const SizedBox(width: 8),
              AppIcon(svgIconPath: 'assets/svg/chevron_right.svg', width: 20, height: 20,
                colorFilter: ColorFilter.mode(IconColors.colorIcon, BlendMode.srcIn)),
            ]),
          ),
        ),
      ),
    );
  }
}
""",
);
