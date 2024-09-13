import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:rayzi/app/data/APP_variables/AppVariable.dart';

import '../API Models/chat_thumblist_model.dart';
import 'app_url.dart';

class ChatThumbListServices extends GetxService {
  Future<ChatThumbListModel?> chatThumbList() async {
    String url = Constant.getDomainFromURL(Constant.BASE_URL);
    final queryParameters = {"userId": userID};
    log("All messages list ::queryParameters ${queryParameters}");

    final response = await http.get(
      Uri.https(url, Constant.chatThumbListUrl, queryParameters),
      headers: {"key": Constant.SECRET_KEY},
    );

    if (response.statusCode == 200) {
      log("All messages list :: ${response.body}");
      return ChatThumbListModel.fromJson(jsonDecode(response.body));
    } else {
      log("Status Code:-${response.statusCode}");
    }
    return null;
  }
}
