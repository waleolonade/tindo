import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../API Models/setting_model.dart';
import 'app_url.dart';

class SettingService extends GetxService {
  static Future<Settingmodel?> settingService() async {
    final response = await http.get(
      Uri.parse(Constant.BASE_URL + Constant.settingUrl),
      headers: {"key": Constant.SECRET_KEY},
    );

    log("Setting api url :: ${Constant.BASE_URL + Constant.settingUrl}");

    log("Setting api body :: ${response.body}");
    if (response.statusCode == 200) {
      return Settingmodel.fromJson(jsonDecode(response.body));
    } else {
      return null;
    }
  }
}
