import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:rayzi/app/data/APP_variables/AppVariable.dart';

import '../API Models/block_userlist_model.dart';
import 'app_url.dart';

class BlockUserListServices extends GetxService {
  Future<BlockUserListModel?> blockUserlistServices() async {
    String url = Constant.getDomainFromURL(Constant.BASE_URL);

    final queryParameters = {
      "userId": userID,
    };

    final response = await http.get(
      Uri.https(url, Constant.blockUserList, queryParameters),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        "key": Constant.SECRET_KEY,
      },
    );
    if (response.statusCode == 200) {
      log("Report response:- ${response.body}");
      return BlockUserListModel.fromJson(jsonDecode(response.body));
    } else {
      log("Report StatusCode :- ${response.statusCode}");
    }
    return null;
  }
}
