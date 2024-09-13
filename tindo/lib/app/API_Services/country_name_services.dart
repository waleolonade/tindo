import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../API Models/cuntry_model.dart';
import 'app_url.dart';

class CountryNameService extends GetxService {
  Future<CuntryModel?> countrynameService() async {
    final response = await http.get(
      Uri.parse(Constant.BASE_URL + Constant.countryUrl),
      headers: {"key": Constant.SECRET_KEY},
    );
    if (response.statusCode == 200) {
      return CuntryModel.fromJson(jsonDecode(response.body));
    }
    return null;
  }
}
