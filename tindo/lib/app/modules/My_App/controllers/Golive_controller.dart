import 'dart:io';

import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:get/get.dart';
import 'package:rayzi/app/API%20Models/user_golive_model.dart';
import 'package:rayzi/app/API_Services/user_golive_services.dart';
import 'package:rayzi/app/modules/home/views/Live%20Streaming/Live_UserScreen.dart';

class GoLiveController extends GetxController {
  UserGoLiveModel? userGoLiveModel;
  RxBool isLoading = false.obs;
  Future userGoLive({required String userId, File? coverImage}) async {
    try {
      isLoading(true);
      if (coverImage != null) {
        userGoLiveModel = await UserGoLive().userGoLiveService(userId: userId, couverImage: coverImage);
      } else {
        userGoLiveModel = await UserGoLive().userGoLiveService(userId: userId);
      }
      await Get.to(()=>LiveUserScreen(
        token: userGoLiveModel!.liveHost!.token!,
        liveRoomId: userGoLiveModel!.liveHost!.liveStreamingId!,
        clientRole: ClientRole.Broadcaster,
        channelName: userGoLiveModel!.liveHost!.channel!,
        liveHostId: userGoLiveModel!.liveHost!.userId!,
        mongoID: userGoLiveModel!.liveHost!.id!,
      ));
    } finally {
      isLoading(false);
    }
  }
}
