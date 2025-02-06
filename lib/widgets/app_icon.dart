import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppIcon extends StatelessWidget {
  final String svgIconPath;
  final double? width;
  final double? height;
  final VoidCallback? onTap;
  final BoxFit fit;
  final AlignmentGeometry alignment;

  final ColorFilter? colorFilter;
  const AppIcon(
      {super.key,
      required this.svgIconPath,
      this.alignment = Alignment.center,
      this.width,
      this.height,
      this.colorFilter,
      this.fit = BoxFit.contain,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SvgPicture.asset(svgIconPath,
          alignment: alignment,
          fit: fit,
          width: width,
          height: height,
          colorFilter: colorFilter),
    );
  }
}
