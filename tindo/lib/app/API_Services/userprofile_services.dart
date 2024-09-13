import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:rayzi/app/API_Services/app_url.dart';

class UserProfileServices extends GetxService {
  userProfileServices(String userId, String secoundUser) async {
    String url = Constant.getDomainFromURL(Constant.BASE_URL);
    final queryParameters = {"loginUserId": userId, "profileUserId": secoundUser};

    final response = await http.get(Uri.https(url, Constant.userProfileUrl, queryParameters),
        headers: {"key": Constant.SECRET_KEY});
    if (response.statusCode == 200) {
      log("${response.statusCode}");
      log("Response Status code :: ${response.statusCode} Body :: ${response.body}");
      return jsonDecode(response.body);
    } else {
      return null;
    }
  }
}
