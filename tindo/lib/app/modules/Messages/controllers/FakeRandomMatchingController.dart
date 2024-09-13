import 'package:get/get.dart';
import 'package:rayzi/app/modules/Messages/views/Fakevideocall.dart';

class FakeRandomMetchingController extends GetxController {
  var text = 'Calling...'.obs;
  @override
  void onInit() {
    calling();

    super.onInit();
  }

  void next({required String videoUrl}) {
    Future.delayed(const Duration(seconds: 6), () {
      if (isClosed) {
        return;
      } else {
        Get.off(FakeLivevideoCall(
          videoUrl: videoUrl,
        ));
      }
    });
  }

  void calling() async {
    await Future.delayed(const Duration(seconds: 2), () {}).then((value) {
      if (isClosed) return;
      text.value = "Ringing....";
    });
  }
}
