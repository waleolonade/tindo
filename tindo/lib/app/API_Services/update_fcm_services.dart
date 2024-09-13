import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:rayzi/app/API%20Models/update_fcm_model.dart';
import 'package:rayzi/app/API_Services/app_url.dart';
import 'package:rayzi/app/data/APP_variables/AppVariable.dart';

class UpdateFCMServices extends GetxService {
  Future<UpdateFcmModel?> updateFCMServices() async {
    String url = Constant.getDomainFromURL(Constant.BASE_URL);
    final queryParameters = {"userId": userID, "fcm_token": fcmToken};
    final response = await http.patch(
      Uri.https(url, Constant.updateFCMUri, queryParameters),
      headers: {"key": Constant.SECRET_KEY},
    );

    if (response.statusCode == 200) {
      log("========>>>>${response.body}");
      return UpdateFcmModel.fromJson(jsonDecode(response.body));
    } else {
      log("FCM StattusCode:-${response.statusCode}");
    }
    return null;
  }
}
