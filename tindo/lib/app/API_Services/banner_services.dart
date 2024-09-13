import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../API Models/banner_model.dart';
import 'app_url.dart';

class BannerServices extends GetxService {
  Future<BannerModel?> bannerServices() async {
    final response = await http.get(
        Uri.parse(Constant.BASE_URL + Constant.bannerUrl),
        headers: {"key": Constant.SECRET_KEY});
    if (response.statusCode == 200) {
      return BannerModel.fromJson(jsonDecode(response.body));
    } else {
      log('StatusCode :- ${response.statusCode}');
    }
    return null;
  }
}
