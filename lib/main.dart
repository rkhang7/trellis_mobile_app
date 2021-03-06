import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trellis_mobile_app/message.dart';

import 'package:trellis_mobile_app/routes/app_pages.dart';
import 'package:trellis_mobile_app/routes/app_routes.dart';
import 'package:trellis_mobile_app/service/language_service.dart';
import 'package:trellis_mobile_app/utils/colors.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterDownloader.initialize(debug: true, ignoreSsl: true);
  await Firebase.initializeApp();
  await GetStorage.init();
  AwesomeNotifications().initialize(
    null,
    [
      NotificationChannel(
          channelKey: 'basic_channel',
          channelName: 'Basic notifications',
          channelDescription: 'Notification channel for basic tests',
          defaultColor: const Color(0xFF9D50DD),
          ledColor: Colors.white)
    ],
  );

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(MyApp());
  configLoading();
}

void notify() async {
  // local notification
  AwesomeNotifications().createNotification(
      content: NotificationContent(
          id: 10,
          channelKey: 'basic_channel',
          title: 'Simple Notification',
          body: 'Simple body',
          bigPicture: 'assets://images/protocoderlogo.png'));
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message: ${message.data}");
  //call awesomenotification to how the push notification.
  AwesomeNotifications().createNotificationFromJsonData(message.data);
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

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final LanguageService languageService = LanguageService();
  @override
  void initState() {
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) {
      if (message != null) {}
    });

    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) {
        RemoteNotification? notification = message.notification;

        AwesomeNotifications().createNotification(
            content: NotificationContent(
          id: 10,
          channelKey: 'basic_channel',
          title: notification!.title,
          body: notification.body,
          bigPicture: notification.android!.imageUrl,
        ));
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(1440, 3040),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: () => GetMaterialApp(
        translations: Messages(), // your translations
        locale: languageService
            .language, // translations will be displayed in that locale
        fallbackLocale: const Locale('en',
            'US'), // specify the fallback locale in case an invalid locale is selected.

        debugShowCheckedModeBanner: false,
        getPages: AppPages.getPages,

        // set font for all project
        theme: ThemeData(
          textTheme: GoogleFonts.robotoTextTheme(
            Theme.of(context).textTheme,
          ),
        ),
        initialRoute: AppRoutes.SPLASH_SCREEN,
        builder: (ctx, child) {
          child = EasyLoading.init()(ctx, child);
          ScreenUtil.setContext(ctx);

          return child;
        },
        localizationsDelegates: const [GlobalMaterialLocalizations.delegate],
      ),
    );
  }
}
