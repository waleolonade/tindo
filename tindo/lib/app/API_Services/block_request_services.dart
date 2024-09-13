import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:rayzi/app/data/APP_variables/AppVariable.dart';

import '../API Models/block_request_model.dart';
import 'app_url.dart';

class BlockRequestServices extends GetxService {
  Future<BlockRequestModel?> blockRequestServices(String blockUser) async {
    String url = Constant.getDomainFromURL(Constant.BASE_URL);
    log("========>>>>BlockUser:-$blockUser==========>>>>$userID");
    final queryParameters = {"from": userID, "to": blockUser};
    final response = await http.post(
      Uri.https(url, Constant.blockRequest, queryParameters),
      headers: {"key": Constant.SECRET_KEY},
    );
    if (response.statusCode == 200) {
      log("========>>>>${response.body}");
      return BlockRequestModel.fromJson(jsonDecode(response.body));
    } else {
      log("response statusCode = ${response.statusCode}");
    }
    return null;
  }
}
