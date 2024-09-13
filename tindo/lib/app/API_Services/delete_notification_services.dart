import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:rayzi/app/API%20Models/delet_notification_model.dart';
import 'package:rayzi/app/API_Services/app_url.dart';
import 'package:rayzi/app/data/APP_variables/AppVariable.dart';

class DeleteNotificationServices extends GetxService {
  Future<DeletNotificationModel?> deleteNotification() async {
    String url = Constant.getDomainFromURL(Constant.BASE_URL);

    final queryParameters = {
      "userId": userID,
    };

    final uri = Uri.https(
        url, Constant.deleteNotification, queryParameters);
    http.Response res = await http.delete(
      uri,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        "key": Constant.SECRET_KEY,
      },
    );
    if (res.statusCode == 200) {
      var data = jsonDecode(res.body);
      log("Story Delete Response:- ${res.statusCode}");
      log("Story Delete Data:- $data");
      return DeletNotificationModel.fromJson(data);
    } else {
      log("Delete Notification StatusCode :- ${res.statusCode}");
    }
    return null;
  }
}
