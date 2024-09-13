import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../API Models/user_golive_model.dart';
import 'app_url.dart';

class UserGoLive extends GetxService {
  Future<UserGoLiveModel?> userGoLiveService({
    required String userId,
    File? couverImage,
  }) async {
    var uri = Uri.parse(Constant.BASE_URL + Constant.liveUser);
    log(userId);
    var request = http.MultipartRequest("POST", uri);

    if (couverImage == null) {
    } else {
      var addImage = await http.MultipartFile.fromPath('coverImage', couverImage.path);
      request.files.add(addImage);
    }
    request.headers.addAll({"key": Constant.SECRET_KEY});

    Map<String, String> requestBody = <String, String>{
      "userId": userId,
    };
    request.fields.addAll(requestBody);
    var res1 = await request.send();
    var res = await http.Response.fromStream(res1);


    if (res.statusCode == 200) {
      return UserGoLiveModel.fromJson(jsonDecode(res.body));
    } else {
      log("response.statuscode== ${res.statusCode}");
    }
    return null;
  }
}
