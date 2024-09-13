import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:rayzi/app/API%20Models/oldchat_model.dart';

import 'app_url.dart';

class OldChatServices extends GetxService {
  Future<OldChatModel?> oldChatServices({required String topicId}) async {
    String url = Constant.getDomainFromURL(Constant.BASE_URL);
    final queryParameters = {"topicId": topicId};

    final response = await http.get(
      Uri.https(url, Constant.oldChatUri, queryParameters),
      headers: {"key": Constant.SECRET_KEY},
    );
    if (response.statusCode == 200) {
      log("=======respons = ${response.body}");
      return OldChatModel.fromJson(jsonDecode(response.body));
    } else {
      log("response:-${response.statusCode}");
    }
    return null;
  }
}
