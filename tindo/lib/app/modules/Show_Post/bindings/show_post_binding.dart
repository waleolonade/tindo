import 'package:get/get.dart';

import '../controllers/show_post_controller.dart';

class ShowPostBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ShowPostController>(
      () => ShowPostController(),
    );
  }
}
