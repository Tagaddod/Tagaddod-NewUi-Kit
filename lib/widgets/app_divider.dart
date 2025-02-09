import 'package:flutter/material.dart';
import 'package:tagaddod_ui_kit/colors/semantic/border_colors.dart';

class AppDivider extends StatelessWidget {
  final Color? color;
  final double? height;
  final double? thickness;
  final double? endIndent;
  final double? indent;
  const AppDivider(
      {super.key,
      this.color = BorderColors.colorBorderSecondary,
      this.height,
      this.thickness,
      this.endIndent,
      this.indent});

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: color,
      height: height,
      thickness: thickness,
      endIndent: endIndent,
      indent: indent,
    );
  }
}
