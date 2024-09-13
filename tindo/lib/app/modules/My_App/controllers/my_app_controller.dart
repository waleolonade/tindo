import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:path_provider/path_provider.dart';

import '../../../API_Services/login_services.dart';
import '../../../API_Services/userlocation_services.dart';
import '../../../data/APP_variables/AppVariable.dart';
import '../views/my_app_view.dart';

class MyAppController extends GetxController {
  //TODO: Implement MyAppController

  final googleSignIn = GoogleSignIn();
  GoogleSignInAccount? _user;
  GoogleSignInAccount get user => _user!;
  var tabIndex = 0;
  int? platform;
  String? userCountry;
  @override
  void onInit() {
    super.onInit();
    if (Platform.isAndroid) {
      platform = 0;
    } else if (Platform.isIOS) {
      platform = 1;
    }
  }

  void changeTabIndex(int index) {
    tabIndex = index;
    update();
  }

  Future userLocation() async {
    var contry = await UserLocation.userLocation();
    log("${contry!.country}");
    userCountry = contry.country!;
    update();
  }

  Future googleLogin() async {
    userLocation();
    try {
      final googleUser = await googleSignIn.signIn();
      if (googleUser == null) return null;
      _user = googleUser;
      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
      await FirebaseAuth.instance.signInWithCredential(credential);
      if (FirebaseAuth.instance.currentUser != null) {

        ///=====call API====== ///

        googleLoginImage.shuffle();

        ByteData byteData = await rootBundle.load(googleLoginImage.first);
        Uint8List uint8list = byteData.buffer.asUint8List();
        Directory tempDir = await getTemporaryDirectory();
        File file = await File('${tempDir.path}${DateTime.now().microsecondsSinceEpoch}.jpg').writeAsBytes(uint8list);

        await LoginServices().loginServices(
          identity: androidId,
          platformType: platform!,
          fcmToken: fcmToken,
          loginType: "1",
          email: user.email,
          username: user.displayName!,
          country: userCountry!,
          profileImage: file,
          gender: '',
        );
      }
      Get.offAll(const MyApp());
    } on FirebaseAuthException catch (e) {
      log(e.code);
    }
  }

  Future logOut() async {
    try {
      await googleSignIn.disconnect();
      FirebaseAuth.instance.signOut();
    } on FirebaseAuthException catch (e) {
      log(e.code);
    }
  }
}
