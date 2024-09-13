import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:rayzi/app/API_Services/getgift_services.dart';

import '../../../API Models/getgift_model.dart';

class LiveStreamingController extends GetxController {
  var selectedGiftIndex;
  var items = [1, 5, 10, 15, 20, 25, 30, 35, 40, 45, 50];
  var dropdownvalue = 1.obs;
  var giftLoading = true.obs;
  var getGiftList = <Gift>[].obs;
  @override
  void onInit() {
    selectedGiftIndex = 0.obs;
    // TODO: implement onInit
    super.onInit();
    fetchGiftlist();
  }

  Future fetchGiftlist() async {
    try {
      giftLoading(true);
      var getGiftData = await GetGiftService.getGift();
      getGiftList.value = getGiftData.gift!;
      log("Get Gift Data Is :- ${jsonEncode(getGiftData)}");
      giftLoading.value = false;
    } finally {
      giftLoading(false);
    }
  }
}
