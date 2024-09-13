import 'package:get/get.dart';

class FakeUserProfileController extends GetxController {
  var followUnfollow;
  var indicater;
  var followStatus;
  final count = 0.obs;
  @override
  void onInit() {
    followUnfollow = true;
    indicater = false;
    super.onInit();
  }

  void changevalue() {
    indicater = true;
    Future.delayed(
      const Duration(seconds: 1),
      () {
        if (followUnfollow == true) {
          followUnfollow = false;
          followStatus = true;
        } else {
          followUnfollow = true;
          followStatus = false;
        }
        indicater = false;
        update();
      },
    );
    update();
  }

  void increment() => count.value++;
}
