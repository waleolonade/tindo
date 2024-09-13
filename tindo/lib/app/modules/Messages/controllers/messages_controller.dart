import 'package:get/get.dart';
import 'package:rayzi/app/API%20Models/chat_thumblist_model.dart';
import 'package:rayzi/app/API_Services/chat_thumblist_services.dart';

class MessagesController extends GetxController {
  //TODO: Implement MessagesController
  ChatThumbListModel? chatListModel;
  var isLoading = true.obs;
  @override
  void onInit() {
    chatThumbList();
    super.onInit();
  }

  Future chatThumbList() async {
    isLoading(true);
    var data = await ChatThumbListServices().chatThumbList();
    chatListModel = data;
    if (data!.status == true) {
      isLoading.value = false;
    }
  }
}
