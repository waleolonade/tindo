import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:rayzi/app/API%20Models/getall_post_model.dart';
import 'package:rayzi/app/API%20Models/post_giftsend_model.dart' as postgift;
import 'package:rayzi/app/API_Services/delet_post_services.dart';
import 'package:rayzi/app/API_Services/getall_post_services.dart';
import 'package:rayzi/app/API_Services/postgiftsend_service.dart';
import 'package:rayzi/app/API_Services/sendlike_services.dart';
import 'package:rayzi/app/data/APP_variables/AppVariable.dart';

class UserPostController extends GetxController {
  GetAllPostModel? getAllPostModel;
  postgift.PostGiftSendServiceModel? postGiftSendServiceModel;
  var isLoding = true.obs;
  var postData;
  var commentCount = <int>[].obs;
  var giftshow = false.obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getPost();
  }

  Future getPost() async {
    isLoding.value = true;
    var data = await GetAllPostServices()
        .getAllpostServices(postType: 1, secoundUserId: userID);
    postData = data!["userPost"];
    getAllPostModel = GetAllPostModel.fromJson(data);
    getAllPostModel!.userPost!.forEach((element) {
      commentCount.add(element.comment!.toInt());
    });
    isLoding.value = false;
    update();
  }

  /// ==== SendLike ==== \\\
  Future<void> sendLike(int index, String postID) async {
    postData[index]["isLike"] =
        postData[index]["isLike"] == false ? true : false;

    if (postData[index]["isLike"] == true) {
      getAllPostModel!.userPost![index].userLike!.add(UserLike(
          userId: userID,
          profileImage: userProfile.value,
          name: userName,
          postId: postID));
    } else {
      getAllPostModel!.userPost![index].userLike!.removeLast();
    }
    update();
    await SendLikeServices().sendLike(postData[index]["_id"].toString());
    // getPost();
    update();
  }

  /// ==== send gift === \\\\
  Future sendGift(
      {required String giftId,
      required String postId,
      required int index,
      required coin}) async {
    getAllPostModel!.userPost![index].userGift?.add(UserGift(
        gift: "",
        id: giftId,
        userId: userID,
        profileImage: userProfile.value,
        name: userName,
        postId: postId));
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

  //// ======= Delet Post ========= \\\\\
  Future deletePostIs(String postId) async {
    var data = await DeletePostService.deletePost(postId);
    if (data["status"] == true) {
      getPost();
    } else {
      log("====== ${data["status"]}");
    }
  }
}
