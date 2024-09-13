import 'dart:developer';

import 'package:get/get.dart';
import 'package:rayzi/app/API%20Models/block_userlist_model.dart';
import 'package:rayzi/app/API_Services/block_userlist_services.dart';

import '../../../API_Services/block_request_services.dart';

class BlockedUserController extends GetxController {
  BlockUserListModel? blockUserListModel;
  var isLoading = true.obs;
  @override
  void onInit() {
    // TODO: implement onInit
    blockuserData();

    super.onInit();
  }

  Future blockuserData() async {
    isLoading.value = true;
    blockUserListModel = await BlockUserListServices().blockUserlistServices();
    if (blockUserListModel!.status == true) {
      isLoading.value = false;
      log("blockUserListModel:::${blockUserListModel?.block}");
    }
    update();
  }

  Future blockRequest({required String blockUser}) async {
    var data = await BlockRequestServices().blockRequestServices(blockUser);
    if (data!.status == true) {
      Get.back();
      blockuserData();
    }
  }
}
