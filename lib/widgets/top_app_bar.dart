import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tagaddod_ui_kit/colors/semantic/text_colors.dart';
import 'package:tagaddod_ui_kit/typography/semantics/body_styles.dart';

class TopAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? title;
  final Widget? suffix;
  final Widget? prefix;
  final bool? centerTitle;

  final double? titleSpacing;

  final TextStyle? titleTextStyle;

  final ShapeBorder? shape;
  final Color? backgroundColor;
  final SystemUiOverlayStyle? systemUiOverlayStyle;
  final bool automaticallyImplyLeading;

  const TopAppBar(
      {this.title,
      this.prefix,
      this.suffix,
      this.backgroundColor,
      this.systemUiOverlayStyle,
      this.shape,
      this.centerTitle,
      this.titleSpacing,
      this.titleTextStyle,
      this.automaticallyImplyLeading = true,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: AppBar(
        title: title,
        leading: prefix,
        centerTitle: centerTitle,
        titleSpacing: titleSpacing,
        titleTextStyle: titleTextStyle ??
            BodyStyles.bodyLgSemiBold.copyWith(color: TextColors.colorText),
        shape: shape,
        backgroundColor: backgroundColor,
        systemOverlayStyle: systemUiOverlayStyle,
        automaticallyImplyLeading: automaticallyImplyLeading,
        actions: suffix == null ? [] : [suffix!],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
