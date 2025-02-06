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
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxWidth: 343.w, maxHeight: 376.h),
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
          const SizedBox(height: 16),
          //divider
          Visibility(
            visible: showModalHeaderDivider,
            child: const Divider(
              height: 1,
              color: BorderColors.colorBorderTertiary,
            ),
          ),
          //body
          Container(
            constraints: BoxConstraints(maxWidth: 343.w, maxHeight: 232.h),
            child: bodyWidget,
          ),
          const Spacer(),
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
