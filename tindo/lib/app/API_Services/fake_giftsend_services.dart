import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:rayzi/app/data/APP_variables/AppVariable.dart';

import 'app_url.dart';

class FakeGiftSend extends GetxService {
  Future fakeGiftSend(
      {required String giftId, required String receiverId}) async {
    String url = Constant.getDomainFromURL(Constant.BASE_URL);
    final queryParameters = {
      "senderId": userID,
      "receiverId": receiverId,
      "giftId": giftId
    };

    final response = await http.post(
      Uri.https(url, Constant.fakeGift, queryParameters),
      headers: {"key": Constant.SECRET_KEY},
    );

    if (response.statusCode == 200) {
      log("==========${jsonDecode(response.body)}");
    } else {
      log("statusCode:- ${response.statusCode}");
    }

    return null;
  }
}
