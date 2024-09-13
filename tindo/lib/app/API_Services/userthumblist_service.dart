import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:rayzi/app/data/APP_variables/AppVariable.dart';

import '../API Models/user_thumblist_model.dart';
import 'app_url.dart';

class UserThumbListService extends GetxService {
  Future<UserThumbListModel?> userThumblistService() async {
    String url = Constant.getDomainFromURL(Constant.BASE_URL);
    final queryParameters = {"loginUserId": userID};

    final response = await http.get(Uri.https(url, Constant.userThumbListUrl, queryParameters),
        headers: {"key": Constant.SECRET_KEY});

    if (response.statusCode == 200) {
      log("User thumb list Data :: ${response.body}");
      return UserThumbListModel.fromJson(jsonDecode(response.body));
    } else {
      log("User thumb list statuscode :: ${response.statusCode}");
    }
    return null;
  }
}

// https://work12.digicean.com/liveUser/liveHostList
