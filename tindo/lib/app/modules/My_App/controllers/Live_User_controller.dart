import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../API_Services/userprofile_services.dart';
import '../../../data/APP_variables/AppVariable.dart';
import '../../../data/Model/CenterTab_Model/HostComment_Model.dart';

class LiveUsercontroller extends GetxController {
  TextEditingController commentController = TextEditingController();
  CameraController? cameraController;
  //
  // Duration duration = Duration();
  // Timer? timer;
//
  bool isRearCameraSelected = true;
  var selectedGiftIndex;
  var selecteTab;

  ///
  var postData;
  var isLoding = true.obs;
  var isfollow = true.obs;

  //////  ==== TIMER ====  //////////
  RxInt hours = 0.obs;
  RxInt minutes = 0.obs;
  RxInt seconds = 0.obs;
  Timer? _timer;

  @override
  void onInit() {
    selectedGiftIndex = 0.obs;
    selecteTab = 1.obs;
    // TODO: implement onInit
    start();
    super.onInit();
  }

  void start() {
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (seconds.value < 59) {
        seconds.value++;
      } else {
        seconds.value = 0;
        if (minutes.value < 59) {
          minutes.value++;
        } else {
          minutes.value = 0;
          hours.value++;
        }
      }
    });
  }

  void sendComment(
      {required String user,
      required String image,
      required String message,
      required String useRID}) {
    dummyCommentList.add(HostComment(
      message: message,
      user: user,
      image: image,
      userID: useRID,
    ));
    commentController.clear();
    update();
  }

  Future profileget(String userID2) async {
    postData = await UserProfileServices().userProfileServices(userID, userID2);
    if (postData["status"] == true) {
      if (postData["userProfile"]["friends"].toString() == "Following" ||
          postData["userProfile"]["friends"].toString() == "Friends") {
        isfollow.value = true;
        isLoding.value = false;
      } else {
        isfollow.value = false;
        isLoding.value = false;
      }
    }
    update();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _timer?.cancel();
    super.dispose();
  }
}
