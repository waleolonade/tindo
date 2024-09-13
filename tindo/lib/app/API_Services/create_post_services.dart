import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:rayzi/app/API_Services/app_url.dart';
import 'package:rayzi/app/data/APP_variables/AppVariable.dart';

import '../API Models/create_post_model.dart';

class CreatePostServices extends GetxService {
  Future<CreatePostModel?> createPostServices(
      String description, File postImage) async {
    var request = http.MultipartRequest(
        "POST", Uri.parse(Constant.BASE_URL + Constant.createPostUrl));
    var addImage =
        await http.MultipartFile.fromPath('postImage', postImage.path);
    request.files.add(addImage);
    Map<String, String> requestBody = <String, String>{
      "userId": userID,
      "description": description,
    };

    request.headers.addAll({"key": Constant.SECRET_KEY});
    request.fields.addAll(requestBody);

    var res1 = await request.send();
    var res = await http.Response.fromStream(res1);

    if (res.statusCode == 200) {
      return CreatePostModel.fromJson(jsonDecode(res.body));
    } else {
      log(res.statusCode.toString());
      return CreatePostModel.fromJson(jsonDecode(res.body));
    }

    /// ==== OLD ======= \\\\\
    // var body = jsonEncode(<String, dynamic>{
    //   "userId": userID,
    //   "description": description,
    // });
    // final response = await http.post(
    //     Uri.parse(Constant.BASE_URL + Constant.createPostUrl),
    //     headers: {"key": Constant.SECRET_KEY},
    //     body: body);
    //
    // /// ==== OLD ======= \\\\\
    //
    // if (response.statusCode == 200) {
    //   log("==========>>>>${response.body}");
    //   return CreatePostModel.fromJson(jsonDecode(response.body));
    // } else {
    //   log("statusCode :- ${response.statusCode}");
    // }
    // return null;
  }
}
