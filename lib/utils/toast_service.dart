import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';

class ToastService {
  static OverlaySupportEntry? _entry;

  static void show({
    required Widget content,
    Duration duration = const Duration(seconds: 5),
    DismissDirection slideDismissDirection = DismissDirection.none,
    double elevation = 0,
    NotificationPosition notificationPosition = NotificationPosition.bottom,
    bool autoDismiss = true,
    Color backgroundColor = Colors.transparent,
  }) {
    _entry?.dismiss(); // Dismiss previous if still showing

    _entry = showSimpleNotification(
      content,
      background: backgroundColor,
      contentPadding: const EdgeInsets.symmetric(horizontal: 12),
      duration: duration,
      position: notificationPosition,
      elevation: elevation,
      slideDismissDirection: slideDismissDirection,
      autoDismiss: autoDismiss,
    );
  }

  static void dismiss() {
    _entry?.dismiss();
    _entry = null;
  }
}
