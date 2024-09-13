import 'package:get/get.dart';

class RelatesComment {
  String userName;
  String userProfile;
  String userDiscription;
  String date;

  RelatesComment({
    required this.userName,
    required this.userProfile,
    required this.date,
    required this.userDiscription,
  });
}

RxList<RelatesComment> relatesCommentData = <RelatesComment>[].obs;
