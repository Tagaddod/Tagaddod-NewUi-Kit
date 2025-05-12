import 'package:flutter/material.dart';
import 'package:tagaddod_ui_kit/typography/semantics/body_styles.dart';

class AppLoadingView extends StatelessWidget {
  final Color? color;
  final String? loadingText;
  final TextStyle? textStyle;

  const AppLoadingView(
      {this.color, this.textStyle, this.loadingText, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircularProgressIndicator(
          color: color ?? Colors.black,
        ),
        (loadingText != null)
            ? Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text(
                  loadingText!,
                  style: textStyle ??
                      BodyStyles.bodySmMedium(context)
                          .copyWith(color: color ?? Colors.black),
                ),
              )
            : const SizedBox(
                height: 0,
              )
      ],
    );
  }
}
