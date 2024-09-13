import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../API Models/get_withdraw_model.dart';
import 'app_url.dart';

class GetWithdrawService extends GetxService {
  Future<GetWithdrawModel?> getWithdrawService() async {
    final response = await http.get(Uri.parse(Constant.BASE_URL + Constant.getWithdrawalUri), headers: {"key": Constant.SECRET_KEY});

    log("GetWithdrawService response :: ${response.body}");
    if (response.statusCode == 200) {
      return GetWithdrawModel.fromJson(jsonDecode(response.body));
    } else {
      log('GetWithdraw StatusCode :- ${response.statusCode}');
    }
    return null;
  }
}
