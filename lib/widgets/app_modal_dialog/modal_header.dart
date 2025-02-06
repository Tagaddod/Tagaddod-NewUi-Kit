import 'package:flutter/material.dart';
import 'package:tagaddod_ui_kit/widgets/app_icon.dart';
import 'package:tagaddod_ui_kit/widgets/app_text.dart';

class AppModalHeader extends StatelessWidget {
  final String modalHeaderTitle;
  final String? svgIconPath;
  final bool showModalHeader;
  final bool showModalHeaderTitle;
  final bool showModalHeaderIcon;
  final bool showModalHeaderDivider;
  final VoidCallback? onTap;
  const AppModalHeader(
      {Key? key,
      this.modalHeaderTitle = '',
      this.svgIconPath,
      this.showModalHeader = true,
      this.showModalHeaderTitle = true,
      this.onTap,
      this.showModalHeaderIcon = true,
      this.showModalHeaderDivider = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Visibility(
        visible: showModalHeader,
        child: Row(
          children: [
            Visibility(
                visible: showModalHeaderTitle,
                child: AppText.bodyLgSemiBold(text: modalHeaderTitle)),
            const Spacer(),
            Visibility(
              visible: showModalHeaderIcon,
              child: AppIcon(
                svgIconPath: svgIconPath ?? "assets/svg/close.svg",
                onTap: onTap ?? () => Navigator.pop(context),
              ),
            )
          ],
        ),
      ),
    );
  }
}
