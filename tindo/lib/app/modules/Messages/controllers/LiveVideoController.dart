import 'dart:async';

import 'package:get/get.dart';

class LiveVideoController extends GetxController {
  //////  ==== TIMER ====  //////////
  RxInt hours = 0.obs;
  RxInt minutes = 0.obs;
  RxInt seconds = 0.obs;
  Timer? timer;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    start();
  }

  void start() {
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
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

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }
}
