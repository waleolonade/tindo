import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:rayzi/app/API%20Models/update_fcm_model.dart';
import 'package:rayzi/app/API_Services/app_url.dart';
import 'package:rayzi/app/API_Services/update_fcm_services.dart';

import '../API Models/login_model.dart';
import '../data/APP_variables/AppVariable.dart';

class LoginServices extends GetxService {
  loginServices({
    required String identity,
    required int platformType,
    required String fcmToken,
    required String loginType,
    required String email,
    required String username,
    required String country,
    required String gender,
    File? profileImage,
  }) async {
    try {
      var uri = Uri.parse(Constant.BASE_URL + Constant.userLogin);
      log("Login URI :: $uri");

      var request = http.MultipartRequest("POST", uri);

      log("Login Profile Image :: $profileImage");

      http.MultipartFile addImage;
      if (profileImage != null) {
        addImage = await http.MultipartFile.fromPath('profileImage', profileImage.path);

        log("addImage :: ${addImage.filename}");
        request.files.add(addImage);
      }
      request.headers.addAll({'Content-Type': 'application/json; charset=UTF-8', "key": Constant.SECRET_KEY});

      request.headers.addAll({"key": Constant.SECRET_KEY});

      Map<String, String> requestBody = <String, String>{
        "identity": identity,
        "platformType": "$platformType",
        "fcm_token": fcmToken,
        "loginType": loginType,
        "email": email,
        "name": username,
        "country": country,
        "gender": gender,
      };
      log("Login Request Body :: $requestBody");

      request.fields.addAll(requestBody);
      var res1 = await request.send();
      var response = await http.Response.fromStream(res1);

      if (response.statusCode == 200) {
        log("Quick login Response body :: ${response.body}");
        var userdata = jsonDecode(response.body);
        if (userdata["user"]["_id"] != null) {
          getstorage.write("UserID", userdata["user"]["_id"]);
          getstorage.write("UserProfile", userdata["user"]["profileImage"]);
          getstorage.write('UserName', userdata["user"]["name"]);
          getstorage.write('Gender', userdata["user"]["gender"]);
          getstorage.write("Country", userdata["user"]["country"]);
          getstorage.write("UserCoins", userdata["user"]["coin"]);
          getstorage.write("UserBio", userdata["user"]["bio"].toString());
          getstorage.write("UserDOB", userdata["user"]["dob"].toString());
          getstorage.write("userDiamond", userdata["user"]["diamond"]);
          getstorage.write('login', true);

          userID = getstorage.read("UserID");
          userName = getstorage.read("UserName");
          userProfile.value = getstorage.read("UserProfile");
          if (getstorage.read("UserCoins") is int) {
            userCoins.value = getstorage.read("UserCoins");
          } else {
            userCoins.value = double.parse(getstorage.read("UserCoins").toString()).toInt();
          }
          userGender = getstorage.read("Gender");
          userBio = getstorage.read("UserBio");
          userDOB = getstorage.read("UserDOB");
          userDiamond = getstorage.read("userDiamond");
          updateFCM();
        }
        return LoginModel.fromJson(jsonDecode(response.body));
      } else {
        log("login response: ${response.statusCode.toString()}");
      }
    } catch (e) {
      throw Exception(e);
    }
    return null;
  }

  UpdateFcmModel? updateFcmModel;
  Future updateFCM() async {
    var data = await UpdateFCMServices().updateFCMServices();
    updateFcmModel = data;
  }
}
