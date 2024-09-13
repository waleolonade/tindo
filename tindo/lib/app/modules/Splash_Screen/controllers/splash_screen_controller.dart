import 'dart:async';
import 'dart:developer';

import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:rayzi/app/API%20Models/setting_model.dart';
import 'package:rayzi/app/API%20Models/update_fcm_model.dart';
import 'package:rayzi/app/API%20Models/user_profile_model.dart';
import 'package:rayzi/app/API_Services/app_url.dart';
import 'package:rayzi/app/API_Services/update_fcm_services.dart';
import 'package:rayzi/app/API_Services/userprofile_services.dart';
import 'package:rayzi/app/Branch_IO/BranchIOController.dart';
import 'package:rayzi/app/data/APP_variables/AppVariable.dart';
import 'package:rayzi/app/modules/Messages/views/Message_Show.dart';
import 'package:rayzi/app/modules/Messages/views/VideoCallreceive.dart';
import 'package:rayzi/app/modules/home/views/Live%20Streaming/LiveStreamingScreen.dart';
import 'package:rayzi/app/modules/home/views/notification_screen.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

import '../../../API_Services/setting_services.dart';
import '../../../data/APP_variables/payment_releted.dart';
import '../../My_App/views/my_app_view.dart';

class SplashScreenController extends GetxController {
  BranchIOController branchIOController = Get.put(BranchIOController());
  //TODO: Implement SplashScreenController
  var success = false.obs;
  var notActive = false.obs;
  var userBlock = false.obs;
  var profileData;
  var coinget = false.obs;
  UserProfileModel? userProfileModel;
  Settingmodel? settingmodel;
  UpdateFcmModel? updatefcmModel;

  @override
  void onInit() {
    super.onInit();
    initFirebase();
    settingCall();
    if (getstorage.read('login') == true) {
      userID = getstorage.read("UserID");
      userName = getstorage.read("UserName");
      userProfile.value = getstorage.read("UserProfile");
      if(getstorage.read("UserCoins") is int){
        userCoins.value = getstorage.read("UserCoins");
      }else{
        userCoins.value = double.parse(getstorage.read("UserCoins").toString()).toInt();
      }
      userGender = getstorage.read("Gender");
      userBio = getstorage.read("UserBio");
      userDOB = getstorage.read("UserDOB");
      userProfile.value = getstorage.read("UserProfile");
      updateFCM();
    }
    socket = io.io(
        Constant.BASE_URL, io.OptionBuilder().setTransports(['websocket']).setQuery({"globalRoom": userID}).build());
    socket.connect();
    socket.onConnect((data) {
      socket.on("callRequest", (data) {
        if (bgCall.value) {
          log("==============================");
        } else {
          Get.to(() => VideoCallreceive(
                callerName: '${data["callerName"]}',
                callerImage: '${data["callerImage"]}',
                callID: '${data["callId"]}',
                receiveCallData: data,
              ));
        }
      });
    });
  }

  Future settingCall() async {
    var data = await SettingService.settingService();
    settingmodel = data;
    log("${data!.status}");
    success = data.status!.obs;
    log("Success value :: ${success.value}");
    log("Setting is active or not :: ${settingmodel!.setting!.isAppActive}");
    if (success.value && settingmodel!.setting!.isAppActive == true) {
      plusCoins = settingmodel!.setting!.coin!.toInt();
      plusdiamond = settingmodel!.setting!.diamond!.toInt();
      withdrawLimit = settingmodel!.setting!.withdrawLimit!.toInt();
      videoCallCharge = settingmodel!.setting!.videoCallCharge!.toInt();
      //// ==== StripPay ===== \\\\\
      stripActive = settingmodel!.setting!.stripeSwitch!;
      stripPublishableKey = settingmodel!.setting!.stripePublishableKey.toString();
      stripSecrateKey = settingmodel!.setting!.stripeSecretKey.toString();
      Stripe.publishableKey = stripPublishableKey;
      log("Stripe keys :: $stripPublishableKey \n $stripSecrateKey");
      //// ==== GooglePay ===== \\\\
      googlepayActive = settingmodel!.setting!.googlePlaySwitch!;
      ///// ====== RazorPay ==== \\\\
      razorPayActive = settingmodel!.setting!.razorPay!;
      razorPayKey = settingmodel!.setting!.razorSecretKey.toString();
      settingmodel!.setting!.agoraCertificate!;
      appId = settingmodel!.setting!.agoraKey!;
      privacyPolicyLink = "${settingmodel!.setting!.privacyPolicyLink}";
      termAndCondition = "${settingmodel!.setting!.termAndCondition}";
      contactSupport = "${settingmodel!.setting!.contactSupport}";
      howToWithdraw = "${settingmodel!.setting!.howToWithdraw}";
      log("plusCoins:- $plusCoins plusdiamond:- $plusdiamond videoCallCharge:-$videoCallCharge");
      profileData = await UserProfileServices().userProfileServices(userID, userID);
      if (profileData["message"] == "Login user not exist") {
        getstorage.write("login",false);
        Get.offAll(const MyApp());
      } else if (getstorage.read('login') == true) {
        branchIOController.listenDynamicLinks();
        profileGet();
      } else {
        Get.offAll(const MyApp());
      }

    } else {
      notActive.value = true;
    }
  }

  Future updateFCM() async {
    var data = await UpdateFCMServices().updateFCMServices();
    updatefcmModel = data;
  }

  //// ====== FireBase Notification ======= \\\\\
  Future profileGet() async {
    profileData = await UserProfileServices().userProfileServices(userID, userID);
    if (profileData["status"] == true &&
        getstorage.read('login') == true &&
        profileData["userProfile"]["isBlock"] == false) {

      if(profileData["userProfile"]["coin"] is int){
        userCoins.value = profileData["userProfile"]["coin"];
      }else{
        userCoins.value = double.parse(profileData["userProfile"]["coin"].toString()).toInt();
      }
      
      
      userDiamond = int.parse("${profileData["userProfile"]["diamond"]}");
      getstorage.write("UserCoins", userCoins.value);
      getstorage.write("userDiamond", userDiamond);
      if (notificationVisit.value == false && branchIOVisit.value == false) {
        Get.offAll(const MyApp());
      }
    } else if (getstorage.read('login') == false && profileData["userProfile"]["isBlock"] == false) {
      Get.offAll(const MyApp());
    } else {
      if (profileData["userProfile"]["isBlock"] == true) {
        userBlock.value = true;
      }
      log("============>>> Status =${profileData["status"]}");
    }
  }

  initFirebase() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    try {
      FirebaseMessaging messaging = FirebaseMessaging.instance;
      await messaging.getToken().then((value) {
        fcmToken = value ?? '';
        log("Fcm Token :: $fcmToken");
      });
    } catch (e) {
      log("Error FCM token: $e");
    }
    RemoteMessage? initialMessage = await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage != null) {
      log("notificationVisit with start :- ${notificationVisit.value}");
      notificationVisit.value = !notificationVisit.value;
      log("notificationVisit with SetState :- ${notificationVisit.value}");
      handleMessage(initialMessage);
    }

    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      log("this is event log :- $event");
      handleMessage(event);
    });

    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) {
        log('Got a message whilst in the foreground!');
        log('Message data: ${message.data}');

        if (message.notification != null) {
          log('Message also contained a notification: ${message.notification}');
        }
        const AndroidInitializationSettings initializationSettingsAndroid =
            AndroidInitializationSettings('mipmap/ic_launcher');
        flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
        flutterLocalNotificationsPlugin
            ?.initialize(const InitializationSettings(android: initializationSettingsAndroid),
                onDidReceiveNotificationResponse: (payload) {
          log("payload is:- $payload");
          handleMessage(message);
        });
        _showNotificationWithSound(message);
      },
    );
  }

  Future<void> handleMessage(RemoteMessage message) async {
    if (message.data['type'] == 'ADMIN') {
      Get.to(() => const NotificationScreen());
    } else if (message.data['type'] == 'CHAT') {
      Get.to(() => MessageShow(
          images: message.data['senderProfileImage'],
          name: message.data['senderName'],
          userId2: message.data["senderId"],
          chatRoomId: message.data["chatRoom"],
          senderId: userID));
    } else if (message.data['type'] == 'LIVE') {
      log("followstatus :: ${message.data["followstatus"]}");

      Get.to(
        () => LiveStreamingScreen(
          token: "${message.data["token"]}",
          channelName: "${message.data["channel"]}",
          liveUserId: "${message.data["_id"]}",
          clientRole: ClientRole.Audience,
          liveStreamingId: "${message.data["liveStreamingId"]}",
          liveUserName: "${message.data["name"]}",
          liveUserImage: "${message.data["profileImage"]}",
          mongoId: "${message.data["mongoId"]}",
          userCoin: '${message.data["diamond"]}',
          followStatus: '',
        ),
      );
    }
  }

  Future _showNotificationWithSound(RemoteMessage message) async {
    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
      '0',
      'tindo',
      channelDescription: 'hello',
      //  icon: 'mipmap/ic_launcher',
      importance: Importance.max,
      priority: Priority.high,
    );

    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );
    await flutterLocalNotificationsPlugin?.show(
      message.hashCode,
      message.notification!.body.toString(),
      message.notification!.title.toString(),
      platformChannelSpecifics,
      payload: 'Custom_Sound',
    );
  }
}
