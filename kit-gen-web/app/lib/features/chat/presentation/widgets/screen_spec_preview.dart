import 'package:flutter/material.dart';
import 'package:tagaddod_ui_kit/widgets/app_logo.dart';
import 'package:tagaddod_ui_kit/widgets/app_text.dart';
import 'package:tagaddod_ui_kit/widgets/top_app_bar.dart';
import '../../domain/generation_payload.dart';
import 'screen_spec/preview_section.dart';

class ScreenSpecPreview extends StatelessWidget {
  const ScreenSpecPreview({super.key, required this.screenSpec});

  final ScreenSpec screenSpec;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xFFF6F1E8),
      child: Column(
        children: [
          _TopBar(screenSpec: screenSpec),
          Expanded(
            child: IgnorePointer(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(16, 20, 16, 32),
                child: LayoutBuilder(builder: _buildContent),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context, BoxConstraints constraints) {
    final width =
        constraints.maxWidth.isFinite ? constraints.maxWidth : 280.0;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (screenSpec.useLogo) ...[
          Center(child: _LogoContainer()),
          const SizedBox(height: 20),
        ],
        if (screenSpec.title.trim().isNotEmpty) ...[
          AppText.headingMd(text: screenSpec.title),
          const SizedBox(height: 6),
        ],
        if (screenSpec.subtitle.trim().isNotEmpty) ...[
          AppText.bodyMd(
            text: screenSpec.subtitle,
            maxLines: 3,
            height: 1.45,
            textColor: const Color(0xFF686C83),
          ),
          const SizedBox(height: 20),
        ],
        ...screenSpec.sections.map(
          (s) => Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: PreviewSection(section: s, width: width),
          ),
        ),
      ],
    );
  }
}

class _TopBar extends StatelessWidget {
  const _TopBar({required this.screenSpec});

  final ScreenSpec screenSpec;

  @override
  Widget build(BuildContext context) {
    final title = screenSpec.topBarTitle?.trim().isNotEmpty == true
        ? screenSpec.topBarTitle!
        : screenSpec.title;

    return Container(
      color: Colors.white,
      child: TopAppBar(
        backgroundColor: Colors.white,
        centerTitle: false,
        automaticallyImplyLeading: false,
        prefix: screenSpec.useLogo
            ? const AppLogo(width: 28, height: 28)
            : const Icon(
                Icons.arrow_back_ios_new_rounded,
                size: 18,
                color: Color(0xFF16161D),
              ),
        title: AppText.bodyLgSemiBold(text: title),
      ),
    );
  }
}

class _LogoContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 74,
      width: 74,
      decoration: BoxDecoration(
        color: const Color(0xFFF3E6D9),
        borderRadius: BorderRadius.circular(22),
      ),
      child: const Center(child: AppLogo(width: 42, height: 42)),
    );
  }
}
