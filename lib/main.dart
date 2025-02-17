import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tagaddod_ui_kit/tagaddod_kit.dart';
import 'package:tagaddod_ui_kit/typography/primitives/typography.dart'
    as typography;

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
            locale: const Locale('en'),
            builder: (context, child) {
              return Directionality(
                textDirection: TextDirection.ltr,
                child: child!,
              );
            },
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            title: 'Flutter Demo',
            debugShowCheckedModeBanner: false,
            supportedLocales: const [
              Locale('ar'),
              Locale('en'),
            ],
            theme: ThemeData(
              useMaterial3: true,
              fontFamily: typography.Typography.fontFamilySansEnglish,
            ),
            home: const TagaddodKit(),
          );
        });
  }
}
