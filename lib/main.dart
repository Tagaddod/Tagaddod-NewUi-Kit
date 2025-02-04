import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tagaddod_ui_kit/tagaddod_kit.dart';

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
          final String defaultLocale = Platform.localeName;
          return Directionality(
            textDirection: defaultLocale == 'ar_EG'
                ? TextDirection.rtl
                : TextDirection.ltr,
            child: MaterialApp(
              locale: defaultLocale == 'ar_EG'
                  ? const Locale('ar', 'EG')
                  : const Locale('en', 'US'),
              title: 'Flutter Demo',
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                useMaterial3: true,
              ),
              home: const TagaddodKit(),
            ),
          );
        });
  }
}
