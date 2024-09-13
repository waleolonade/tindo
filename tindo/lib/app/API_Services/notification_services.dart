import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:rayzi/app/API%20Models/notification_model.dart';
import 'package:rayzi/app/API_Services/app_url.dart';
import 'package:rayzi/app/data/APP_variables/AppVariable.dart';

class NotificationServices extends GetxService {
  Future<NotificationModel?> notificationServics() async {
    String url = Constant.getDomainFromURL(Constant.BASE_URL);

    final queryParameters = {"userId": userID};

    final response = await http.get(
      Uri.https(url, Constant.notificationUri, queryParameters),
      headers: {"key": Constant.SECRET_KEY},
    );
    if (response.statusCode == 200) {
      return NotificationModel.fromJson(jsonDecode(response.body));
    } else {
      log("statusCode:- ${response.statusCode}");
    }
    return null;
  }
}
