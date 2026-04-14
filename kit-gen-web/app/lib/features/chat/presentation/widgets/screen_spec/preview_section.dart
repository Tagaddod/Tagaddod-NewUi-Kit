import 'package:flutter/material.dart';
import 'package:tagaddod_ui_kit/widgets/app_text.dart';
import '../../../domain/generation_payload.dart';
import 'actions_section_body.dart';
import 'chips_section_body.dart';
import 'empty_state_section_body.dart';
import 'form_section_body.dart';
import 'info_rows_section_body.dart';
import 'list_section_body.dart';
import 'metrics_section_body.dart';
import 'nav_links_section_body.dart';
import 'profile_section_body.dart';
import 'search_bar_section_body.dart';
import 'stat_row_section_body.dart';
import 'tab_bar_section_body.dart';
import 'toggles_section_body.dart';

class PreviewSection extends StatelessWidget {
  const PreviewSection({
    super.key,
    required this.section,
    required this.width,
  });

  final ScreenSpecSection section;
  final double width;

  @override
  Widget build(BuildContext context) {
    final showHeader = section.kind != 'empty_state' &&
        section.kind != 'tab_bar' &&
        section.kind != 'search_bar';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (showHeader && section.title.trim().isNotEmpty) ...[
          Padding(
            padding: const EdgeInsets.only(left: 2, bottom: 8),
            child: AppText.bodyMdSemiBold(text: section.title),
          ),
        ],
        if (showHeader && section.subtitle.trim().isNotEmpty) ...[
          Padding(
            padding: const EdgeInsets.only(left: 2, bottom: 10),
            child: AppText.bodySm(
              text: section.subtitle,
              textColor: const Color(0xFF686C83),
            ),
          ),
        ],
        _buildBody(),
      ],
    );
  }

  Widget _buildBody() {
    return switch (section.kind) {
      'metrics' => MetricsSectionBody(section: section, width: width),
      'chips' => ChipsSectionBody(section: section),
      'toggles' => TogglesSectionBody(section: section),
      'list' => ListSectionBody(section: section),
      'profile' => ProfileSectionBody(section: section),
      'actions' => ActionsSectionBody(section: section, width: width),
      'search_bar' => SearchBarSectionBody(section: section),
      'tab_bar' => TabBarSectionBody(section: section),
      'stat_row' => StatRowSectionBody(section: section),
      'info_rows' => InfoRowsSectionBody(section: section),
      'nav_links' => NavLinksSectionBody(section: section),
      'empty_state' =>
        EmptyStateSectionBody(section: section, width: width),
      _ => FormSectionBody(section: section, width: width),
    };
  }
}
