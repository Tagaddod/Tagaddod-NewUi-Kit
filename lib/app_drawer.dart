import 'package:flutter/material.dart';
import 'package:tagaddod_ui_kit/samples/sample_app_filled_button.dart';
import 'package:tagaddod_ui_kit/samples/sample_app_outlined_button.dart';
import 'package:tagaddod_ui_kit/samples/sample_app_text_button.dart';
import 'package:tagaddod_ui_kit/samples/sample_app_tonal_button.dart';

class AppDrawer extends StatelessWidget {
  final Function(Widget) onSelectWidget;

  const AppDrawer({super.key, required this.onSelectWidget});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
            child: Center(
              child: Text(
                "Select a Button",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ),
          ListTile(
            title: const Text("App Filled Button"),
            onTap: () {
              onSelectWidget(getAppFilledButton(context));
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text("App Tonal Button"),
            onTap: () {
              onSelectWidget(getAppTonalButton(context));
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text("App Outlined Button"),
            onTap: () {
              onSelectWidget(getAppOutlinedButton(context));
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text("App Text Button"),
            onTap: () {
              onSelectWidget(getAppTextButton(context));
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}

//get appFilled button
Widget getAppFilledButton(BuildContext context) {
  return const SampleAppFilledButton();
}

//get appFilled button
Widget getAppTonalButton(BuildContext context) {
  return const SampleAppTonalButton();
}

//get appFilled button
Widget getAppOutlinedButton(BuildContext context) {
  return const SampleAppOutlinedButton();
}

//get appFilled button
Widget getAppTextButton(BuildContext context) {
  return const SampleAppTextButton();
}

class PlaceholderWidget extends StatelessWidget {
  const PlaceholderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text("Select a button from the drawer");
  }
}
