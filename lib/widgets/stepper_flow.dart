import 'package:flutter/material.dart';
import 'package:tagaddod_ui_kit/colors/primtives/colors.dart';
import 'package:tagaddod_ui_kit/colors/semantic/text_colors.dart';
import 'package:tagaddod_ui_kit/widgets/app_stepper.dart';
import 'package:tagaddod_ui_kit/widgets/app_text.dart';

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
                        Expanded(
                            child: AppText.bodyMdSemiBold(
                                text: steps[activeIndex].stepName ?? '',
                                maxLines: 1,
                                textColor:
                                    titleColor ?? TextColors.colorTextOnBgFill))
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
                  (steps[activeIndex].stepTitle == null)
                      ? const SizedBox()
                      : Padding(
                          padding: const EdgeInsets.only(top: 16),
                          child: Text(steps[activeIndex].stepTitle ?? '',
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 28,
                                  color: titleColor ??
                                      TextColors.colorTextOnBgFill)),
                        ),
                  (steps[activeIndex].stepSubtitle == null)
                      ? const SizedBox()
                      : Padding(
                          padding: const EdgeInsets.only(top: 12),
                          child: AppText.bodyMd(
                              text: steps[activeIndex].stepSubtitle ?? '',
                              textColor: subtitleColor ??
                                  TextColors.colorTextOnBgFill),
                        ),
                  const SizedBox(
                    height: 20,
                  )
                ],
              ),
            ),
          ),
          steps[activeIndex].stepBody
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
