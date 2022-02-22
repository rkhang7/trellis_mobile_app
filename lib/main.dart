import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:trellis_mobile_app/routes/app_pages.dart';
import 'package:trellis_mobile_app/routes/app_routes.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
  configLoading();
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.white
    ..backgroundColor = Colors.blue
    ..indicatorColor = Colors.white
    ..textColor = Colors.white
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = true
    ..textPadding = EdgeInsets.zero
    ..fontSize = 16
    ..dismissOnTap = false;
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(1440, 3040),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: () => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        getPages: AppPages.getPages,

        // set font for all project
        theme: ThemeData(
          textTheme: GoogleFonts.robotoTextTheme(
            Theme.of(context).textTheme,
          ),
        ),
        initialRoute: AppRoutes.SPLASH_SCREEN,
        builder: EasyLoading.init(),
        localizationsDelegates: const [GlobalMaterialLocalizations.delegate],
        supportedLocales: const [
          Locale('vi', "VN"),
        ],
      ),
    );
  }
}
