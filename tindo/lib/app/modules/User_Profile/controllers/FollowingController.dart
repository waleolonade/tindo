import 'dart:developer';

import 'package:get/get.dart';
import 'package:rayzi/app/API_Services/follow_request_services.dart';
import 'package:rayzi/app/API_Services/followingt_services.dart';

import '../../../API Models/following_model.dart';

class FollowingScreenController extends GetxController {
  List<UserFollow> followingList = [];
  var status = false.obs;
  var isLoding = true.obs;
  var listNull = false.obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    followingUserList();
  }

  Future followingUserList() async {
    var data = await FollowingServices().followingServices("following");
    log("=================$data");
    followingList = data!.userFollow!;
    if (data.status == true) {
      isLoding.value = false;
      if (followingList.isEmpty) {
        listNull.value = true;
      }
    }
    update();
  }

  Future followRequest(int index) async {
    var data = await FollowRequestServices().followRequestServices(
      followingList[index].to!.id.toString(),
    );
    if (data!.status == true) {
      followingUserList();
      status = false.obs;
      Get.back();
    }
  }
}
