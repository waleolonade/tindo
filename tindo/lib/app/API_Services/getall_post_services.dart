import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:rayzi/app/API_Services/app_url.dart';
import 'package:rayzi/app/data/APP_variables/AppVariable.dart';

class GetAllPostServices extends GetxService {
  /// postType == ALL==0 And ProfilePost==1
  getAllpostServices({required int postType, String? secoundUserId}) async {

    String url = Constant.getDomainFromURL(Constant.BASE_URL);
    Map<String, String?> queryParameters;
    if (postType == 0) {
      queryParameters = {"loginUser": userID};
    } else {
      queryParameters = {"loginUser": userID, "userId": secoundUserId};
    }
    log("queryParameters::::$queryParameters");
    log("Constant.queryUrl::::${url}${Constant.getPostUrl}");

    final response =
        await http.get(Uri.https(url, Constant.getPostUrl, queryParameters), headers: {"key": Constant.SECRET_KEY});
    log("Constant.statusCode::::${response.statusCode}");

    if (response.statusCode == 200) {
      log("Constant.response::::${response.body}");

      log("Get All posts body ::  ${response.body}");
      return jsonDecode(response.body);
    } else {
      log("response statusCode := ${response.statusCode}");
    }
    return null;
  }
}
