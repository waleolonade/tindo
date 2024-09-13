import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:rayzi/app/API_Services/app_url.dart';

import '../API Models/post_giftsend_model.dart';

class PostGiftSendService extends GetxService {
  static var client = http.Client();

  static Future<PostGiftSendServiceModel> postGiftSend(
      {required String giftId,
      required String userId,
      required String postId,
      required int coin}) async {

    try {
      String url = Constant.getDomainFromURL(Constant.BASE_URL);
      final queryParameters = {
        "giftId": giftId,
        "userId": userId,
        "postId": postId,
        "coin": coin.toString(),
      };

      final uri =
          Uri.https(url, Constant.sendGiftUrl, queryParameters);

      http.Response response =
          await client.post(uri, headers: {"key": Constant.SECRET_KEY});

      var data = jsonDecode(response.body);

      log("Send Gift Response :- ${response.statusCode}");

      if (response.statusCode == 200) {
        return PostGiftSendServiceModel.fromJson(data);
      } else {
        log(response.body);
      }
      return PostGiftSendServiceModel.fromJson(data);
    } catch (e) {
      throw Exception(e);
    }
  }
}
