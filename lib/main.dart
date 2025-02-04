import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tagaddod_ui_kit/colors/semantic/text_colors.dart';
import 'package:tagaddod_ui_kit/utils/button_type.dart';
import 'package:tagaddod_ui_kit/widgets/app_filled_button.dart';
import 'package:tagaddod_ui_kit/widgets/app_outlined_button.dart';
import 'package:tagaddod_ui_kit/widgets/app_tonal_button.dart';

void main() async {
  await ScreenUtil.ensureScreenSize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        builder: (_, child) {
          return MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
            home: Scaffold(
                body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AppFilledButton.large(
                  btnText: "Tagaddod",
                  onTap: () {},
                  textColor: TextColors.colorWhite,
                  iconPath: "assets/svg/add.svg",
                  width: MediaQuery.of(context).size.width * 0.8,
                  buttonType: ButtonType.neutralButton,
                ),
                const SizedBox(
                  height: 50,
                ),

                //tonal button
                AppTonalButton.large(
                  btnText: "Tonal Button",
                  onTap: () {},
                  buttonType: ButtonType.criticalButton,
                ),
                AppOutlinedButton.large(
                  btnText: " Button",
                  onTap: () {},
                  buttonType: ButtonType.criticalButton,
                )
              ],
            )),
          );
        });
  }
}
