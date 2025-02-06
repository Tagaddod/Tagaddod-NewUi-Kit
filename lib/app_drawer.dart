import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tagaddod_ui_kit/samples/icon_button/sample_app_filled_icon_button.dart';
import 'package:tagaddod_ui_kit/samples/icon_button/sample_app_outlined_icon_button.dart';
import 'package:tagaddod_ui_kit/samples/icon_button/sample_app_standard_icon_button.dart';
import 'package:tagaddod_ui_kit/samples/icon_button/sample_app_tonal_icon_button.dart';
import 'package:tagaddod_ui_kit/samples/sample_app_filled_button.dart';
import 'package:tagaddod_ui_kit/samples/sample_app_outlined_button.dart';
import 'package:tagaddod_ui_kit/samples/sample_app_text_button.dart';
import 'package:tagaddod_ui_kit/samples/sample_app_tonal_button.dart';
import 'package:tagaddod_ui_kit/samples/text_field/sample_text_field.dart';

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
          ListTile(
            title: const Text("App filled icon Button"),
            onTap: () {
              onSelectWidget(getAppFilledIconButton(context));
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text("App tonal icon Button"),
            onTap: () {
              onSelectWidget(getAppTonalIconButton(context));
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text("App outline icon Button"),
            onTap: () {
              onSelectWidget(getAppOutlinedIconButton(context));
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text("App standard icon Button"),
            onTap: () {
              onSelectWidget(getAppStandardIconButton(context));
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text("App Text Field"),
            onTap: () {
              onSelectWidget(getAppTextField(context));
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}

//get app text fields
Widget getAppTextField(BuildContext context) {
  return const SampleAppTextField();
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

Widget getAppFilledIconButton(BuildContext context) {
  return const SampleAppFilledIconButton();
}

Widget getAppOutlinedIconButton(BuildContext context) {
  return const SampleAppOutlinedIconButton();
}

Widget getAppStandardIconButton(BuildContext context) {
  return const SampleAppStandardIconButton();
}

Widget getAppTonalIconButton(BuildContext context) {
  return const SampleAppTonalIconButton();
}

class PlaceholderWidget extends StatelessWidget {
  const PlaceholderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text("Select a button from the drawer");
  }
}
