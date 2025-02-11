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
      child: SvgPicture.asset(
        svgIconPath,
        alignment: alignment,
        fit: fit,
        width: width ?? 16,
        height: height ?? 16,
        colorFilter: colorFilter,
      ),
    );
  }

  AppIcon copyWith({
    String? svgIconPath,
    double? width,
    double? height,
    VoidCallback? onTap,
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ColorFilter? colorFilter,
  }) {
    return AppIcon(
      svgIconPath: svgIconPath ?? this.svgIconPath,
      width: width ?? this.width,
      height: height ?? this.height,
      onTap: onTap ?? this.onTap,
      fit: fit ?? this.fit,
      alignment: alignment ?? this.alignment,
      colorFilter: colorFilter ?? this.colorFilter,
    );
  }
}
