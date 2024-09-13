import 'package:get/get.dart';
import 'package:rayzi/app/API%20Models/liveend_history_model.dart';
import 'package:rayzi/app/API_Services/live_endhistory_services.dart';

class UserLiveEndController extends GetxController {
  var isLoding = true.obs;
  LiveEndHistoryModel? historyModel;
  Future userliveEnd({required String liveStreamingID}) async {
    var data = await LiveEndHistoryServices()
        .liveEndServices(liveStreamingID: liveStreamingID);
    historyModel = data;
    if (historyModel!.status == true) {
      isLoding.value = false;
    }
  }
}
