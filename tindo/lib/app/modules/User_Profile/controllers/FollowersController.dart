import 'dart:developer';

import 'package:get/get.dart';
import 'package:rayzi/app/API%20Models/followers_model.dart';
import 'package:rayzi/app/API_Services/follow_request_services.dart';

import '../../../API_Services/followers_services.dart';

class FollowersController extends GetxController {
  List data = <UserFollow>[].obs;
  var isNoData = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    followerUserList();
    super.onInit();
  }

  Future followerUserList() async {
    var data1 = await FollowersServices().followersServices("followers");
    data = data1["userFollow"];
    if (data.isEmpty) {
      isNoData.value = true;
      log("DATA :_ $data");
      update();
    }
    log("DATA :_ $data");
    update();
  }

  Future followRequest(int index) async {
    FollowRequestServices().followRequestServices(
      data[index]["from"]["_id"].toString(),
    );
  }

  void isFollowss(int index) {
    data[index]["friends"] = data[index]["friends"] == false ? true : false;
    update();
  }
}
