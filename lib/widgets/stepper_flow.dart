import 'package:flutter/material.dart';
import 'package:tagaddod_ui_kit/colors/primtives/colors.dart';
import 'package:tagaddod_ui_kit/colors/semantic/text_colors.dart';
import 'package:tagaddod_ui_kit/typography/semantics/body_styles.dart';
import 'package:tagaddod_ui_kit/widgets/app_stepper.dart';

class StepperFlow extends StatelessWidget {
  final int activeIndex;
  final List<StepView> steps;
  final Widget? icon;
  final Color? backgroundColor,
      nameColor,
      titleColor,
      subtitleColor,
      stepActiveColor,
      stepInactiveColor;

  const StepperFlow(
      {required this.steps,
      required this.activeIndex,
      this.subtitleColor,
      this.backgroundColor,
      this.nameColor,
      this.titleColor,
      this.stepInactiveColor,
      this.stepActiveColor,
      this.icon,
      super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: backgroundColor ?? AppColors.colorGray1600,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Row(
                      children: [
                        icon ?? const SizedBox(width: 0),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(steps[activeIndex].stepName ?? '',
                            style: BodyStyles.bodyMdSemiBold.copyWith(
                                color: subtitleColor ??
                                    TextColors.colorTextOnBgFill))
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: AppStepper(
                        numOfSteps: steps.length,
                        activeIndex: activeIndex,
                        activeColor: stepActiveColor,
                        disableColor: stepInactiveColor),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Text(steps[activeIndex].stepTitle ?? '',
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 28,
                            color: titleColor ?? TextColors.colorTextOnBgFill)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: Text(steps[activeIndex].stepSubtitle ?? '',
                        style: BodyStyles.bodyMd.copyWith(
                            color:
                                subtitleColor ?? TextColors.colorTextOnBgFill)),
                  ),
                  const SizedBox(
                    height: 20,
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: steps[activeIndex].stepBody,
          )
        ],
      ),
    );
  }
}

class StepView {
  final String? stepName;
  final String? stepTitle;
  final String? stepSubtitle;
  final Widget stepBody;

  StepView(
      {required this.stepBody,
      this.stepName,
      this.stepSubtitle,
      this.stepTitle});
}
