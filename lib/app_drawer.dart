import 'package:flutter/material.dart';
import 'package:tagaddod_ui_kit/colors/primtives/colors.dart';
import 'package:tagaddod_ui_kit/samples/app_bar/sample_top_app_bar.dart';
import 'package:tagaddod_ui_kit/samples/badges/sample_app_badge.dart';
import 'package:tagaddod_ui_kit/samples/bar_percent_indicator/sample_bar_percent_indicator.dart';
import 'package:tagaddod_ui_kit/samples/checkbox/sample_app_check_box.dart';
import 'package:tagaddod_ui_kit/samples/circle_percent_indicator/sample_circle_percent_indicator.dart';
import 'package:tagaddod_ui_kit/samples/icon_button/sample_app_filled_icon_button.dart';
import 'package:tagaddod_ui_kit/samples/icon_button/sample_app_outlined_icon_button.dart';
import 'package:tagaddod_ui_kit/samples/icon_button/sample_app_standard_icon_button.dart';
import 'package:tagaddod_ui_kit/samples/icon_button/sample_app_tonal_icon_button.dart';
import 'package:tagaddod_ui_kit/samples/number_container/sample_number_container.dart';
import 'package:tagaddod_ui_kit/samples/number_counter/sample_number_counter.dart';
import 'package:tagaddod_ui_kit/samples/sample_app_bottom_nav_bar.dart';
import 'package:tagaddod_ui_kit/samples/sample_app_filled_button.dart';
import 'package:tagaddod_ui_kit/samples/sample_app_outlined_button.dart';
import 'package:tagaddod_ui_kit/samples/sample_app_radio_button.dart';
import 'package:tagaddod_ui_kit/samples/sample_app_stepper/sample_app_stepper.dart';
import 'package:tagaddod_ui_kit/samples/sample_app_switch.dart';
import 'package:tagaddod_ui_kit/samples/sample_app_text_button.dart';
import 'package:tagaddod_ui_kit/samples/sample_app_tonal_button.dart';
import 'package:tagaddod_ui_kit/samples/sample_scrollable_tab_bar.dart';
import 'package:tagaddod_ui_kit/samples/sample_stepper_flow.dart';
import 'package:tagaddod_ui_kit/samples/sample_toast_message/sample_toast_message.dart';
import 'package:tagaddod_ui_kit/samples/text_field/sample_text_field.dart';
import 'package:tagaddod_ui_kit/widgets/app_divider.dart';
import 'package:tagaddod_ui_kit/widgets/app_modal_dialog/app_modal_dialog.dart';
import 'package:tagaddod_ui_kit/widgets/app_text.dart';
import 'package:tagaddod_ui_kit/widgets/button/app_filled_button.dart';

class AppDrawer extends StatelessWidget {
  final Function(Widget) onSelectWidget;

  const AppDrawer({super.key, required this.onSelectWidget});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
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
            //app badge
            ListTile(
              title: const Text("App Badge "),
              onTap: () {
                onSelectWidget(getAppBadge(context));
                Navigator.pop(context);
              },
            ),

            //app check bo
            ListTile(
              title: const Text("App Check Box"),
              onTap: () {
                onSelectWidget(getAppCheckBox(context));
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
            //modal
            ListTile(
              title: const Text("App Modal Dialog"),
              onTap: () {
                Navigator.pop(context);
                showModalBottomSheet(
                  context: context,
                  builder: (context) => getAppModalDialog(context),
                );
              },
            ),

            //sample switch button
            ListTile(
              title: const Text("App Switch "),
              onTap: () {
                onSelectWidget(getAppSwitch(context));
                Navigator.pop(context);
              },
            ),

            //Divider
            //sample switch button
            ListTile(
              title: const Text("Divider"),
              onTap: () {
                onSelectWidget(getDivider(context));
                Navigator.pop(context);
              },
            ),

            //sample app radio  button
            ListTile(
              title: const Text("App Radio Button "),
              onTap: () {
                onSelectWidget(getAppRadioButton(context));
                Navigator.pop(context);
              },
            ),
            //bottom navigation bar
            ListTile(
              title: const Text("App Bottom Navigation Bar"),
              onTap: () {
                onSelectWidget(getAppBottomNavigationBar(context));
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text("number counter"),
              onTap: () {
                onSelectWidget(getNumberCounter(context));
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text("number container"),
              onTap: () {
                onSelectWidget(getNumberContainer(context));

                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text("top app bar"),
              onTap: () {
                onSelectWidget(getTopAppBar(context));

                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text("bar percent indicator"),
              onTap: () {
                onSelectWidget(getProgressPercentageBar(context));

                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text("circle percent indicator "),
              onTap: () {
                onSelectWidget(getCirclePercentIndicator(context));

                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text("show Toast messages "),
              onTap: () {
                onSelectWidget(showToast(context));

                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text("App stepper "),
              onTap: () {
                onSelectWidget(getAppStepper(context));

                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text("scrollable tab bar  "),
              onTap: () {
                onSelectWidget(getScrollableTabBar(context));

                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text("Stepper flow  "),
              onTap: () {
                onSelectWidget(getStepperFlow(context));

                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget getStepperFlow(BuildContext context) {
    return SampleStepperFlow();
  }

  Widget getScrollableTabBar(BuildContext context) {
    return SampleScrollableTabBar();
  }

  Widget getAppStepper(BuildContext context) {
    return const SampleAppStepper();
  }

  Widget showToast(BuildContext context) {
    return const SampleToastMessage();
  }

  Widget getCirclePercentIndicator(BuildContext context) {
    return const SampleCirclePercentIndicator();
  }

  Widget getProgressPercentageBar(BuildContext context) {
    return const SampleBarPercentIndicator();
  }

  Widget getAppCheckBox(BuildContext context) {
    return const SampleAppCheckBox();
  }

  Widget getAppSwitch(BuildContext context) {
    return SampleAppSwitch();
  }

  Widget getDivider(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        AppText.bodyLg(text: "Divider Samples"),
        AppDivider(),
        SizedBox(
          height: 20,
        ),
        AppDivider(
          color: AppColors.colorRed1000,
        ),
      ],
    );
  }

  Widget getAppRadioButton(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SampleAppRadioButton(),
      ],
    );
  }

  Widget getAppBottomNavigationBar(BuildContext context) {
    return const SampleAppBottomNavBar();
  }
}

//get App Badge
Widget getAppBadge(BuildContext context) {
  return const SampleAppBadge();
}

//get app modal dialog
Widget getAppModalDialog(BuildContext context) {
  return AppModalDialog(
    modalHeaderTitle: "Title",
    bodyWidget: const Center(child: Text("This IS My Modal Body widget")),
    footerWidget: AppFilledButton.large(
      btnText: "Label",
      width: MediaQuery.sizeOf(context).width * 0.7,
      onTap: () {},
    ),
  );
}

//get app text fields
Widget getAppTextField(BuildContext context) {
  return const SampleAppTextField();
}

Widget getNumberCounter(BuildContext context) {
  return const SampleNumberCounter();
}

Widget getNumberContainer(BuildContext context) {
  return const SampleNumberContainer();
}

Widget getTopAppBar(BuildContext context) {
  return const SampleTopAppBar();
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
