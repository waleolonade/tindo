import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:rayzi/app/API_Services/app_url.dart';

class ShowCommentService extends GetxService {
  Future showComment(String postId) async {
    String url = Constant.getDomainFromURL(Constant.BASE_URL);

    final queryParameters = {
      "postId": postId,
    };

    final response = await http.get(
        Uri.https(url, Constant.showComment, queryParameters),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          "key": Constant.SECRET_KEY,
        });

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return data;
    } else {
      log(response.body);
    }
    return null;
  }
}
