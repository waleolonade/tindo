import 'dart:developer';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:rayzi/app/API_Services/app_url.dart';
import 'package:rayzi/app/data/APP_variables/AppVariable.dart';

class SendLikeServices extends GetxService {
  sendLike(String postId) async {
    String url = Constant.getDomainFromURL(Constant.BASE_URL);
    final queryParameters = {"postId": postId, "userId": userID};
    final response = await http.post(
      Uri.https(url, Constant.sendLike, queryParameters),
      headers: {"key": Constant.SECRET_KEY},
    );

    if (response.statusCode == 200) {
      log("====>>>${response.body}");
      return response.body;
    } else {
      log("Status Code :- ${response.statusCode}");
    }
    return null;
  }
}
