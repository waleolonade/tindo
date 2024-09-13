import 'dart:developer';

import 'package:get/get.dart';

import '../../../API_Services/edite_profile_service.dart';

class EditProfileController extends GetxController {
  Future updateUser(String name, String bio, String gender, String dob) async {
    var data = await UpdateUserService.updateUser(
        name: name, bio: bio, gender: gender, dob: dob);
    log("Update Host: $data");
    Get.back();
  }
}
