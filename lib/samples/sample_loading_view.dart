import 'package:flutter/material.dart';
import 'package:tagaddod_ui_kit/widgets/app_loading_view.dart';

class SampleLoadingView extends StatelessWidget {
  const SampleLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppLoadingView(loadingText: "loading");
  }
}
