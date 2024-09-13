import 'dart:developer';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:rayzi/app/API%20Models/createchat_topic_model.dart';
import 'package:rayzi/app/API%20Models/getuser_profile_model.dart';
import 'package:rayzi/app/API_Services/block_request_services.dart';
import 'package:rayzi/app/API_Services/create_chattopic_services.dart';
import 'package:rayzi/app/API_Services/follow_request_services.dart';
import 'package:rayzi/app/API_Services/report_services.dart';
import 'package:rayzi/app/API_Services/userprofile_services.dart';
import 'package:rayzi/app/data/APP_variables/AppVariable.dart';
import 'package:rayzi/app/data/Colors.dart';

class SecondUserProfileController extends GetxController {
  var followUnfollow;
  var indicater;
  var followStatus;
  var profileData;
  RxBool isPostNull = false.obs;
  GetUserProfileModel? getUserProfileModel;

  ///API
  var isLoding = true.obs;
  var isfollow = true.obs;
  var postData;

  ///Gift
  var selectedGiftIndex;
  var isButtonDisabled = true.obs;
  var items = [
    '  x5',
    ' x10',
    ' x15',
    ' x20',
    ' x25',
    ' x30',
    ' x35',
    ' x40',
    ' x45',
    ' x50',
  ];
  var dropdownvalue = '  x5'.obs;

  /// Report
  SingingCharacter? character = SingingCharacter.sexualContent;
  var report = "sexual Content".obs;

  ///Chat Topic
  CreateChatTopicModel? chatTopicModel;

  @override
  void onInit() {
    followUnfollow = true;
    indicater = false;
    selectedGiftIndex = 0.obs;

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

  void reportRedio(SingingCharacter? value, int reportindex) {
    character = value;
    if (reportindex == 0) {
      report.value = "sexual Content";
    } else if (reportindex == 1) {
      report.value = "Violent Content";
    } else if (reportindex == 2) {
      report.value = "child abuse";
    } else if (reportindex == 3) {
      report.value = "spam";
    } else if (reportindex == 4) {
      report.value = "Other";
    }
    update();
  }

  Future sendReport({
    required String postID,
    required String postimage,
  }) async {
    var data = await ReportServices().postReportServices(postID: postID, report: report.value, image: postimage, reportType: "1");
    if (data!.status == true) {
      Fluttertoast.showToast(
          msg: "Send Report",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: ThemeColor.white,
          textColor: ThemeColor.blackback,
          fontSize: 16.0);
      Get.back();
    }
  }

  Future blockRequest({required String blockUser}) async {
    var data = await BlockRequestServices().blockRequestServices(blockUser);
    if (data!.status == true) {
      Get.back();
      Fluttertoast.showToast(
          msg: "${postData["userProfile"]["name"].toString()} is Block",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: ThemeColor.white,
          textColor: ThemeColor.blackback,
          fontSize: 16.0);
    }
  }

  Future profileget(String userID2) async {
    log("+++$userID+++++$userID2");
    postData = await UserProfileServices().userProfileServices(userID, userID2);
    getUserProfileModel = GetUserProfileModel.fromJson(postData);
    if (getUserProfileModel!.userProfile!.userPost!.isEmpty) {
      isPostNull.value = true;
    } else {
      isPostNull.value = false;
    }
    if (postData["status"] == true) {
      if (postData["userProfile"]["friends"].toString() == "Following" ||
          postData["userProfile"]["friends"].toString() == "Friends") {
        isfollow.value = true;
        isLoding.value = false;
      } else {
        isfollow.value = false;
        isLoding.value = false;
      }
    }
    chatTopic(userID2: postData["userProfile"]["_id"].toString());
    update();
  }

  /// Create Chat Topic
  Future chatTopic({required String userID2}) async {
    var data = await CreateChatTopicServices().createChatTopic(userId2: userID2);
    chatTopicModel = data;
    if (data!.status == true) {
      // isLoading.value = false;
      log("==================================${chatTopicModel!.chatTopic!.id.toString()}");
    }
  }

  // Future oldChat({required String topicId}) async {
  //   var data = await OldChatServices().oldChatServices(topicId: topicId);
  //   oldChatModel = data;
  // }

  Future followRequest() async {
    if (isfollow.value) {
      isfollow.value = false;
    } else {
      isfollow.value = true;
    }
    await FollowRequestServices().followRequestServices(
      postData["userProfile"]["_id"].toString(),
    );
    update();
  }
}
