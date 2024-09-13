import 'dart:developer';

import 'package:get/get.dart';
import 'package:rayzi/app/API%20Models/delet_notification_model.dart';
import 'package:rayzi/app/API%20Models/notification_model.dart';
import 'package:rayzi/app/API_Services/delete_notification_services.dart';
import 'package:rayzi/app/API_Services/follow_request_services.dart';
import 'package:rayzi/app/API_Services/notification_services.dart';

import '../../../data/APP_variables/AppVariable.dart';

class NotificationScreenController extends GetxController {
  var isloding = true.obs;
  NotificationModel? notificationModel;
  DeletNotificationModel? deletNotificationModel;
  var isDataNull = false.obs;
  @override
  void onInit() {
    // TODO: implement onInit
    notificationData();
    super.onInit();
  }

  Future notificationData() async {
    log("UserID =======>>:- $userID");
    isloding.value = true;
    var data = await NotificationServices().notificationServics();
    notificationModel = data;
    if (notificationModel!.status == true) {
      isloding.value = false;
      if (notificationModel!.notification!.isEmpty) {
        isDataNull.value = true;
      }
    }
  }

  Future deleteNotification() async {
    var data = await DeleteNotificationServices().deleteNotification();
    deletNotificationModel = data;
    if (deletNotificationModel!.status == true) {
      notificationData();
    }
  }

  Future followRequest(int index) async {
    var data = await FollowRequestServices().followRequestServices(
        notificationModel!.notification![index].userId.toString());
    if (data!.status == true) {
      if (notificationModel!.notification![index].friends == true) {
        notificationModel!.notification![index].friends = false;
      } else {
        notificationModel!.notification![index].friends = true;
      }
      update();
    }
  }
}
