import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:rayzi/app/API%20Models/location_model.dart';
import 'package:rayzi/app/API_Services/app_url.dart';

class UserLocation extends GetxService {
  String country = "";
  static Future<LocationModel?> userLocation() async {
    final resposne = await http.get(Uri.parse(ApiUrl.userLocationURL));

    if (resposne.statusCode == 200) {
      return LocationModel.fromJson(jsonDecode(resposne.body));
    } else {
      return null;
    }
  }
}
