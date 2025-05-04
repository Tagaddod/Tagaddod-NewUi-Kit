import 'package:flutter/material.dart';
import 'package:tagaddod_ui_kit/utils/toast_service.dart';
import 'package:tagaddod_ui_kit/widgets/Toast_message/error_message.dart';
import 'package:tagaddod_ui_kit/widgets/Toast_message/success_message.dart';

class SampleToastMessage extends StatelessWidget {
  const SampleToastMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextButton(
            onPressed: () {
              ToastService.show(
                content: SuccessMessage(
                  title: "success message ",
                  subtitle: "Hello",
                ),
              );
            },
            child: Text("show success")),
        TextButton(
            onPressed: () {
              ToastService.show(
                content: SuccessMessage(
                  title: "success message ",
                  subtitle: "Hello",
                  showVerticalLine: true,
                ),
              );
            },
            child: Text("show success with vertical line ")),
        TextButton(
            onPressed: () {
              ToastService.show(
                content: ErrorMessage(
                  title: "Error message ",
                  subtitle: "Hello",
                ),
              );
            },
            child: Text("show Error")),
        TextButton(
            onPressed: () {
              ToastService.show(
                content: ErrorMessage(
                  title: "Error message ",
                  subtitle: "Hello",
                  showVerticalLine: true,
                ),
              );
            },
            child: Text("show Error with vertical line ")),
      ],
    );
  }
}
