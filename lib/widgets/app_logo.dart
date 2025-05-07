import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tagaddod_ui_kit/assests/assets.dart';

class AppLogo extends StatelessWidget {
  final double? width;
  final double? height;
  final String? appIconPath;
  final ColorFilter? colorFilter;
  final Alignment alignment;
  final Clip clipBehavior;
  final Widget Function(BuildContext, Object, StackTrace)? errorBuilder;
  final BoxFit fit;
  final Widget Function(BuildContext, Widget, int, bool)? frameBuilder;
  final Widget Function(BuildContext)? placeholderBuilder;
  final Widget Function(BuildContext, Object, StackTrace)?
      placeholderErrorBuilder;
  final double? placeholderHeight;
  final double? placeholderWidth;

  const AppLogo(
      {super.key,
      this.width,
      this.height,
      this.appIconPath,
      this.colorFilter,
      this.alignment = Alignment.center,
      this.clipBehavior = Clip.none,
      this.errorBuilder,
      this.fit = BoxFit.contain,
      this.frameBuilder,
      this.placeholderBuilder,
      this.placeholderErrorBuilder,
      this.placeholderHeight,
      this.placeholderWidth});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      appIconPath ?? AppAssets.appLogoSvg,
      width: width,
      height: height,
      colorFilter: colorFilter,
      alignment: alignment,
      clipBehavior: clipBehavior,
      errorBuilder: errorBuilder,
      fit: fit,
      placeholderBuilder: placeholderBuilder,
    );
  }
}
