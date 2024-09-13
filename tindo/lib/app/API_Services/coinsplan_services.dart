import 'dart:convert';
import 'dart:developer';

import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:http/http.dart' as http;
import 'package:rayzi/app/API_Services/app_url.dart';

import '../API Models/coinsplan_model.dart';

class CoinsPlanServices extends GetxService {
  Future<CoinsPlanModel?> coinsPlanSrevices() async {
    final response = await http.get(
        Uri.parse(Constant.BASE_URL + Constant.coinsPlanUrl),
        headers: {"key": Constant.SECRET_KEY});

    if (response.statusCode == 200) {
      log("Coinsplan StatusCode = ${response.body}");
      return CoinsPlanModel.fromJson(jsonDecode(response.body));
    } else {
      log("Coinsplan StatusCode = ${response.statusCode}");
    }
    return null;
  }
}
