import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:rayzi/app/API_Services/app_url.dart';
import 'package:rayzi/app/data/APP_variables/AppVariable.dart';

import '../API Models/following_model.dart';

class FollowingServices extends GetxService {
  Future<FollowingModel?> followingServices(String type) async {
    String url = Constant.getDomainFromURL(Constant.BASE_URL);

    final queryParameters = {"userId": userID, "type": type};
    final response = await http.get(
      Uri.https(url, Constant.followListUrl, queryParameters),
      headers: {"key": Constant.SECRET_KEY},
    );
    if (response.statusCode == 200) {
      return FollowingModel.fromJson(jsonDecode(response.body));
    } else {
      log("statusCode:- ${response.statusCode}");
    }

    return null;
  }
}
