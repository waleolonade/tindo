import 'dart:developer';

import 'package:get/get.dart';
import 'package:rayzi/app/API%20Models/getuser_profile_model.dart';

import '../../../API_Services/userprofile_services.dart';
import '../../../data/APP_variables/AppVariable.dart';

class UserProfileController extends GetxController {
  //TODO: Implement UserProfileController
  // var followUnfollow;
  // var indicater;
  //var followStatus;
//  var profileData;
  var isLoding = true.obs;
  var postLoding = false.obs;
  // RxList<UserPost> ?userPost;
  var profileData;
  RxBool isPostNull = false.obs;
  GetUserProfileModel? getUserProfileModel;

  @override
  void onInit() {
    //followUnfollow = true;
    //indicater = false;
    profileget();
    super.onInit();
  }

   profileget() async {
    log("message:::::::::::");
    profileData =
        await UserProfileServices().userProfileServices(userID, userID);
    getUserProfileModel = GetUserProfileModel.fromJson(profileData);

    if (getUserProfileModel!.userProfile!.userPost!.isEmpty) {
      isPostNull.value = true;
    } else {
      isPostNull.value = false;
    }
    if (profileData["status"] == true) {
      // userPost = profileModel.userProfile.userPost.obs;
      isLoding.value = false;
      if(profileData["userProfile"]["coin"] is int){
        userCoins.value = profileData["userProfile"]["coin"];
        log("message::::::${userCoins.value}");
      }else{
        userCoins.value = double.parse(profileData["userProfile"]["coin"].toString()).toInt();
        log("message::::::${userCoins.value}");
      }      update();
      log("=====${profileData["status"]}");
    }
  }
}
