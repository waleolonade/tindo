import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rayzi/app/data/APP_variables/AppVariable.dart';
import 'package:rayzi/app/modules/Show_Post/controllers/GetSingleController.dart';
import 'package:rayzi/app/modules/Show_Post/controllers/show_post_controller.dart';
import 'package:rayzi/app/modules/User_Profile/controllers/SecoundUserPostController.dart';
import 'package:rayzi/app/modules/User_Profile/controllers/UserPostController.dart';

import '../../../API Models/create_comment_model.dart';
import '../../../API_Services/create_comment_service.dart';
import '../../../API_Services/show_comment_service.dart';
import '../../../data/Model/RelateScreen_Model/RelateScreeen_Comment.dart';

class CommentScreenController extends GetxController {
  TextEditingController commentfield = TextEditingController();
  final ScrollController scrollController = ScrollController();
  ShowPostController showPostController = Get.put(ShowPostController());
  final UserPostController _userPostController = Get.put(UserPostController());
  GetSinglePostController singlePostController = Get.put(GetSinglePostController());
  SecoundPostController secoundPostController = Get.put(SecoundPostController());

  CreateCommentModel? createCommentModel;
  List? commentList;
  var isLoding = true.obs;

  void sendComment({required String postId, required int index, required int postScreenType}) {
    /// postScreenType = 0 ===>>Alll Post
    /// postScreenType = 1 ===>>LoginUser Post
    /// postScreenType = 2 ===>>SecoundUser Post
    relatesCommentData.add(RelatesComment(
      userName: userName,
      userProfile: userProfile.value,
      date: "Just Now",
      userDiscription: commentfield.text,
    ));
    sendComment1(comment: commentfield.text.toString(), postId: postId);
    if (postScreenType == 0) {
      showPostController.commentCount[index] = showPostController.commentCount[index] + 1;
    } else if (postScreenType == 1) {
      _userPostController.commentCount[index] = _userPostController.commentCount[index] + 1;
    } else if (postScreenType == 2) {
      secoundPostController.commentCount[index] = secoundPostController.commentCount[index] + 1;
    } else if (postScreenType == 3) {
      singlePostController.commentCount[index] = singlePostController.commentCount[index] + 1;
    }
    scrollController.animateTo(scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
    commentfield.clear();
    update();
  }

  Future getUserlist(String postId) async {
    var data = await ShowCommentService().showComment(postId);
    if (data["status"] == true) {
      relatesCommentData.clear();
      commentList = data["comment"];
      log("-------$commentList");
      commentList!.forEach((element) {
        relatesCommentData.add(RelatesComment(
            userName: "${element["name"]}",
            userProfile: "${element["profileImage"]}",
            date: "${element["date"]}",
            userDiscription: "${element["comment"]}"));
      });

      log("======/#3333$relatesCommentData");

      isLoding.value = false;
    }
  }

  Future sendComment1({required String comment, required String postId}) async {
    createCommentModel = await CreateCommentService.createComment(
      comment,
      postId,
    );

    log("Create Comment Data Is : ${jsonEncode(createCommentModel)}");
  }
}
