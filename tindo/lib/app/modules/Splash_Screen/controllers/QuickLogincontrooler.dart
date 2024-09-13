import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rayzi/app/API_Services/userlocation_services.dart';

import '../../../API Models/login_model.dart';
import '../../../API_Services/login_services.dart';
import '../../../data/APP_variables/AppVariable.dart';
import '../../My_App/views/my_app_view.dart';
import '../views/QuickLoginScreen.dart';

class QuickLoginController extends GetxController {
  var maleUser = true.obs;
  var femaleUser = false.obs;
  var isLoading = false.obs;

  var currentAddress = "";
  TextEditingController nameController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  List<String> nicName = [
    "Edward Bailey",
    "Thomas Bailey",
    "Lily Adams",
    "Isabella Kennedy",
    "Charlotte Bailey",
    "Kennedy Marshall",
    "Jackson Edward",
  ];

  ///Tologin
  int? platform;
  String logintype = "0";
  String gender = "";

  @override
  void onInit() {
    super.onInit();
    if (Platform.isAndroid) {
      platform = 0;
    } else if (Platform.isIOS) {
      platform = 1;
    }
    userLocation();
//    location();
  }

  Future userLocation() async {
    var contry = await UserLocation.userLocation();
    log("${contry!.country}");
    locationController.text = contry.country!;
    update();
  }

  Future<void> submit() async {
    if (femaleUser.value == true || maleUser.value == true) {
      if (nameController.text.isNotEmpty) {
        if (maleUser.value) {
          gender = "male";
        } else {
          gender = "female";
        }

        ///=====call API====== ///

        quickLoginFemale.shuffle();
        quickLoginMale.shuffle();

        ByteData byteData = await rootBundle.load(gender == "female" ? quickLoginFemale.first : quickLoginMale.first);
        Uint8List uint8list = byteData.buffer.asUint8List();
        Directory tempDir = await getTemporaryDirectory();
        File file = await File('${tempDir.path}${DateTime.now().microsecondsSinceEpoch}.jpg').writeAsBytes(uint8list);

        await LoginServices().loginServices(
          identity: androidId,
          platformType: platform!,
          fcmToken: fcmToken,
          loginType: logintype,
          email: androidId,
          username: nameController.text,
          country: locationController.text,
          gender: gender,
          profileImage: file,
        );
        Get.offAll(const MyApp());
      } else {
        Fluttertoast.showToast(
            msg: "Enter Your Name",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.white,
            textColor: Colors.black,
            fontSize: 16.0);
      }
    } else {
      Fluttertoast.showToast(
          msg: "Select Your gender",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.white,
          textColor: Colors.black,
          fontSize: 16.0);
    }
  }

  Future<void> checkQuickLogin() async {
    try {
      isLoading(true);
      LoginModel data = await LoginServices().loginServices(
        identity: androidId,
        platformType: platform!,
        fcmToken: fcmToken,
        loginType: '0',
        email: androidId,
        username: "",
        country: "",
        gender: "",
      );
      if (data.user!.name == "" || data.user!.country == "") {
        Get.to(() => const QuickLoginScreen());
      } else {
        Get.offAll(() => const MyApp());
      }
      log("User name get :: ${data.user!.name}");
    } finally {
      isLoading(false);
    }
  }

  // getAddressFromLatLng() async {
  //   try {
  //     List<Placemark> placemarks = await placemarkFromCoordinates(
  //         _currentPosition.latitude, _currentPosition.longitude);
  //
  //     Placemark place = placemarks[0];
  //
  //     currentAddress = "${place.country}";
  //     log("+++++++$currentAddress");
  //     update();
  //   } catch (e) {
  //     log(e);
  //   }
  // }

  /// Image Piker
  File? proImage;

  Future cameraImage() async {
    try {
      final imagepike = await ImagePicker().pickImage(source: ImageSource.camera);
      if (imagepike == null) return;

      final imageTeam = File(imagepike.path);
      proImage = imageTeam;
      update();
      Get.back();
    } on PlatformException catch (e) {
      log("$e");
    }
  }

  Future pickImage() async {
    try {
      final imagepike = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (imagepike == null) return;

      final imageTeam = File(imagepike.path);
      proImage = imageTeam;
      update();
      Get.back();
    } on PlatformException catch (e) {
      log("fail $e");
    }
  }

  void chooseName() {
    nicName.shuffle();
    nameController.text = nicName[0];
    update();
  }
}
