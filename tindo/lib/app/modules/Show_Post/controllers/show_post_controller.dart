import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:rayzi/app/API%20Models/getall_post_model.dart';
import 'package:rayzi/app/API%20Models/getgift_model.dart';
import 'package:rayzi/app/API%20Models/post_giftsend_model.dart' as postgift;
import 'package:rayzi/app/API_Services/getgift_services.dart';
import 'package:rayzi/app/API_Services/sendlike_services.dart';
import 'package:rayzi/app/data/Colors.dart';

import '../../../API_Services/block_request_services.dart';
import '../../../API_Services/create_post_services.dart';
import '../../../API_Services/getall_post_services.dart';
import '../../../API_Services/postgiftsend_service.dart';
import '../../../API_Services/report_services.dart';
import '../../../data/APP_variables/AppVariable.dart';

class ShowPostController extends GetxController {
  //TODO: Implement ShowPostController

  File? proImage;
  TextEditingController discription = TextEditingController();
  var postLoding = false.obs;

  /// gift ///
  var items = [1, 5, 10, 15, 20, 25, 30, 35, 40, 45, 50];
  var dropdownvalue = 1.obs;
  var selectedGiftIndex;
  SingingCharacter? character = SingingCharacter.sexualContent;
  var report = "sexual Content".obs;

  ///API///
  GetAllPostModel? getAllPostModel;
  var isLoding = true.obs;
  var postData;
  List listofPost = <UserPost>[].obs;
  var notData = false.obs;

  var getGiftList = <Gift>[].obs;

  var showLikeList = <UserLike>[].obs;
  var commentCount = <int>[].obs;
  var giftLoading = true.obs;
  var giftshow = false.obs;

  postgift.PostGiftSendServiceModel? postGiftSendServiceModel;

  @override
  void onInit() {
    selectedGiftIndex = 0.obs;
    super.onInit();
    getPost();
  }

  Future getPost() async {
    isLoding.value = true;
    Map<String, dynamic> data = await GetAllPostServices().getAllpostServices(postType: 0);
    postData = data["userPost"];
    listofPost = postData;
    getAllPostModel = GetAllPostModel.fromJson(data);
    // for (var element in getAllPostModel!.userPost!) {
    //   commentCount.add(element.comment!.toInt());
    // }
    commentCount.clear();
    for (int i = 0; i < getAllPostModel!.userPost!.length; i++) {
      commentCount.add(getAllPostModel!.userPost![i].comment!.toInt());
    }
      log("Comment Count :: $commentCount");

    if (listofPost.isEmpty) {
      notData.value = true;
    }
    isLoding.value = false;
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
    var data = await ReportServices()
        .postReportServices(postID: postID, report: report.value, image: postimage, reportType: "0");
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
      getPost();
    }
  }

  Future send() async {
    postLoding.value = true;
    await CreatePostServices().createPostServices(discription.text, proImage!);
    postLoding.value = false;
    getPost();
    update();
    Get.back();
  }

  /// ==== SendLike ==== \\\
  Future<void> sendLike(int index, String postID) async {
    postData[index]["isLike"] = postData[index]["isLike"] == false ? true : false;

    if (postData[index]["isLike"] == true) {
      getAllPostModel!.userPost![index].userLike!
          .add(UserLike(userId: userID, profileImage: userProfile.value, name: userName, postId: postID));
    } else {
      getAllPostModel!.userPost![index].userLike!.removeLast();
    }
    update();
    await SendLikeServices().sendLike(postData[index]["_id"].toString());
    // getPost();
    update();
  }

  /// ==== FetchGiftList ==== \\\
  Future fetchGiftlist() async {
    try {
      giftLoading(true);
      var getGiftData = await GetGiftService.getGift();
      getGiftList.value = getGiftData.gift!;
      log("Get Gift Data Is :- ${jsonEncode(getGiftData)}");
    } finally {
      giftLoading(false);
    }
  }

  /// ==== send gift === \\\\
  Future sendGift({required String giftId, required String postId, required int index, required coin}) async {
    getAllPostModel!.userPost![index].userGift?.add(UserGift(
        gift: "", id: giftId, userId: userID, profileImage: userProfile.value, name: userName, postId: postId));
    postGiftSendServiceModel = await PostGiftSendService.postGiftSend(
      giftId: giftId,
      userId: userID,
      postId: postId,
      coin: coin,
    );
    log("Post Gift Data Is :- ${jsonEncode(postGiftSendServiceModel)}");
  }

  setGift() async {
    giftshow.value = true;
    Get.back();
    update();
    await Future.delayed(const Duration(seconds: 1)).then((value) {
      giftshow.value = false;
    });

    update();
  }
}
