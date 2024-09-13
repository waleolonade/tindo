import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:rayzi/app/API%20Models/success_purchase_model.dart';
import 'package:rayzi/app/data/APP_variables/AppVariable.dart';

import 'app_url.dart';

class SuccessPurchasService extends GetxService {
   successPurchas({required String coinPlanId, required String paymentGateway}) async {
    final url = Uri.parse(Constant.BASE_URL + Constant.successPurchaseUri);

    final headers = {
      'key': Constant.SECRET_KEY,
      "Content-Type": "application/json; charset=UTF-8",
    };

    final body = jsonEncode({
      'userId': userID,
      "coinPlanId": coinPlanId,
      "paymentGateway": paymentGateway,
    });

    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      log("Response Body :: ${response.body}");
      return SuccessPurchaseModel.fromJson(data);
    } else {
      throw Exception('Failed to search movie title.');
    }
  }
}
