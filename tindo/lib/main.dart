import 'dart:developer';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:platform_device_id/platform_device_id.dart';
import 'package:rayzi/app/data/Colors.dart';
import 'app/data/APP_variables/AppVariable.dart';
import 'app/data/APP_variables/payment_releted.dart';
import 'app/routes/app_pages.dart';
import 'dart:ui' as ui;

Future<void> backgroundNotification(RemoteMessage message) async {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  ErrorWidget.builder = (FlutterErrorDetails details) {
    return Container();
  };
  RenderErrorBox.backgroundColor = Colors.transparent;
  RenderErrorBox.textStyle = ui.TextStyle(color: Colors.transparent);
  await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  log('Got a message whilst in the foreground!');
  log('Message data: ${message.data}');

  if (message.notification != null) {
    log('Message also contained a notification: ${message.notification}');
  }
  const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings("@drawable/ic_launcher");
  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  flutterLocalNotificationsPlugin?.initialize(const InitializationSettings(android: initializationSettingsAndroid),
      onDidReceiveBackgroundNotificationResponse: (message) {
    log("background opened response");
  });
  var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
    '0',
    'tindo',
    channelDescription: 'hello',
    importance: Importance.max,
    icon: "@drawable/ic_launcher",
    priority: Priority.high,
  );

  var platformChannelSpecifics = NotificationDetails(
    android: androidPlatformChannelSpecifics,
  );
  await flutterLocalNotificationsPlugin?.show(
    message.hashCode,
    message.notification!.title.toString(),
    message.notification!.body.toString(),
    platformChannelSpecifics,
    payload: 'Custom_Sound',
  );
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();
  //// ==== Branch IO ====== \\\\
  if (Platform.isAndroid) {
    // FlutterBranchSdk.validateSDKIntegration();
  }
  //// ====== Identity ======== \\\\\\\
  androidId = (await PlatformDeviceId.getDeviceId)!;
  log("Android Id :: $androidId");
  //// ====== fcm Token ======== \\\\\\\
  ///************** FCM token ************************\\\
  try {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    await messaging.getToken().then((value) {
      fcmToken = value!;
      log("Fcm Token :: $fcmToken");
    });
  } catch (e) {
    log("Error FCM token: $e");
  }
  FirebaseMessaging.onBackgroundMessage(backgroundNotification);
  log("FCM == $fcmToken");

  //// ====== StripePey ======== \\\\\\\
  Stripe.publishableKey = stripPublishableKey;

  if (getstorage.read('login') == null) {
    getstorage.write('login', false);
  }
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(
    GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Tindo",
        darkTheme: ThemeData(
          scaffoldBackgroundColor: ThemeColor.white,
          appBarTheme: AppBarTheme(backgroundColor: ThemeColor.white),
        ),
        themeMode: ThemeMode.dark,
        initialRoute: AppPages.initial,
        getPages: AppPages.routes,
       ),
    ),
  );
}

// User Id :: 64c8fb4d21ebc033de318884