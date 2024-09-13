import 'dart:io';

import 'package:camera/camera.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

/// ====== LIVE USER THUMLIST WAVE ======= \\\
String waveLottie = "lottie/wave.json";

/// ====== CAMERA FUNCTION ======= \\\
List<CameraDescription> cameras = [];

/// ====== GETX STORAGE ======= \\\
var getstorage = GetStorage();

/// ====== Reportsheet ======= \\\
enum SingingCharacter { sexualContent, ViolentContent, childAbuse, Spam, Other }

///// ====== login variables ======= \\\\\\
String androidId = "";
String fcmToken = "";
String userID = "";
String userName = "";
String userGender = "";
RxString userProfile = "".obs;
RxInt userCoins = 0.obs;
int userDiamond = 0;
String userBio = "";
String userDOB = "";
File? userUpdateImage;

///// ====== SOCKETS ======= \\\\\\
late io.Socket socket;
late io.Socket liveSocket;
late io.Socket liveStreamingSocket;

///// ====== AGORA ======= \\\\\\
final infoString = <String>[];
String appId = "";
String appCertificate = "";
int plusCoins = 0;
int plusdiamond = 0;
int videoCallCharge = 0;
int withdrawLimit = 0;
bool googlepayActive = true;

//// ======== Notification ======== \\\\\\
FirebaseMessaging? messaging;
FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin;
RxBool notificationVisit = false.obs;

//// ======== BranchIO ======== \\\\\\
RxBool branchIOVisit = false.obs;

String privacyPolicyLink = "";
String termAndCondition = "";
String contactSupport = "";
String howToWithdraw = "";
var bgCall = false.obs;


//// ======== Quick Login Image ======== \\\\\\
List<String> quickLoginFemale = [
  "Images/quick_login_image/female/1.jpg",
  "Images/quick_login_image/female/2.jpg",
  "Images/quick_login_image/female/3.jpg",
  "Images/quick_login_image/female/4.jpg",
  "Images/quick_login_image/female/5.jpg",
  "Images/quick_login_image/female/6.jpg",
  "Images/quick_login_image/female/7.jpg",
  "Images/quick_login_image/female/8.jpg",
  "Images/quick_login_image/female/9.jpg",
  "Images/quick_login_image/female/10.jpg",
];

List<String> quickLoginMale = [
  "Images/quick_login_image/male/1.jpg",
  "Images/quick_login_image/male/2.jpg",
  "Images/quick_login_image/male/3.jpg",
  "Images/quick_login_image/male/4.jpg",
  "Images/quick_login_image/male/5.jpg",
  "Images/quick_login_image/male/6.jpg",
  "Images/quick_login_image/male/7.jpg",
  "Images/quick_login_image/male/8.jpg",
  "Images/quick_login_image/male/9.jpg",
  "Images/quick_login_image/male/10.jpg",
];

//// ======== Google Login Image ======== \\\\\\
List<String> googleLoginImage = [
  "Images/quick_login_image/female/1.jpg",
  "Images/quick_login_image/female/2.jpg",
  "Images/quick_login_image/female/3.jpg",
  "Images/quick_login_image/female/4.jpg",
  "Images/quick_login_image/female/5.jpg",
  "Images/quick_login_image/female/6.jpg",
  "Images/quick_login_image/female/7.jpg",
  "Images/quick_login_image/female/8.jpg",
  "Images/quick_login_image/female/9.jpg",
  "Images/quick_login_image/female/10.jpg",
  "Images/quick_login_image/male/1.jpg",
  "Images/quick_login_image/male/2.jpg",
  "Images/quick_login_image/male/3.jpg",
  "Images/quick_login_image/male/4.jpg",
  "Images/quick_login_image/male/5.jpg",
  "Images/quick_login_image/male/6.jpg",
  "Images/quick_login_image/male/7.jpg",
  "Images/quick_login_image/male/8.jpg",
  "Images/quick_login_image/male/9.jpg",
  "Images/quick_login_image/male/10.jpg",
];