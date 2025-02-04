import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppIcon extends StatelessWidget {
  final String svgIconPath;
  final double? width;
  final double? height;
  final Color? color;
  final BoxFit fit;
  final AlignmentGeometry alignment;

  final ColorFilter? colorFilter;
  const AppIcon(
      {super.key,
      required this.svgIconPath,
      this.alignment = Alignment.center,
      this.width,
      this.height,
      this.color,
      this.colorFilter,
      this.fit = BoxFit.contain});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(svgIconPath,
        alignment: alignment,
        fit: fit,
        width: width,
        height: height,
        colorFilter: colorFilter);
  }
}
