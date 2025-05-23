import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tagaddod_ui_kit/colors/semantic/border_colors.dart';
import 'package:tagaddod_ui_kit/widgets/app_modal_dialog/modal_header.dart';

class AppModalDialog extends StatelessWidget {
  final Widget? bodyWidget;
  final Widget? footerWidget;
  final String modalHeaderTitle;
  final String? svgIconPath;
  final bool showModalHeader;
  final bool showModalHeaderTitle;
  final bool showModalHeaderIcon;
  final bool showModalHeaderDivider;
  final double? spaceBetweenTitleAndDivider;
  final double? spaceBetweenBodyAndFooter;
  final VoidCallback? onTap;
  const AppModalDialog({
    super.key,
    this.modalHeaderTitle = "",
    this.bodyWidget,
    this.footerWidget,
    this.svgIconPath,
    this.onTap,
    this.showModalHeader = true,
    this.showModalHeaderTitle = true,
    this.showModalHeaderIcon = true,
    this.showModalHeaderDivider = true,
    this.spaceBetweenTitleAndDivider = 16,
    this.spaceBetweenBodyAndFooter = 16,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          //row title with x close button and able to be closed
          AppModalHeader(
            modalHeaderTitle: modalHeaderTitle,
            svgIconPath: svgIconPath,
            showModalHeader: showModalHeader,
            showModalHeaderTitle: showModalHeaderTitle,
            showModalHeaderIcon: showModalHeaderIcon,
            showModalHeaderDivider: showModalHeaderDivider,
            onTap: onTap,
          ),
          SizedBox(height: spaceBetweenTitleAndDivider),
          //divider
          Visibility(
            visible: showModalHeaderDivider,
            child: const Divider(
              height: 1,
              color: BorderColors.colorBorderTertiary,
            ),
          ),
          //body
          bodyWidget ?? const SizedBox(),
          SizedBox(height: spaceBetweenBodyAndFooter),

          //footer
          Expanded(child: footerWidget ?? const SizedBox()),
          SizedBox(
            height: 10.h,
          ),
        ],
      ),
    );
  }
}
