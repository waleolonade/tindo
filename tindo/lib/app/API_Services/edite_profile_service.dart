import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:rayzi/app/API_Services/app_url.dart';

import '../data/APP_variables/AppVariable.dart';

class UpdateUserService {
  static var client = http.Client();

  static updateUser({
    required String name,
    required String bio,
    required String gender,
    required String dob,
  }) async {
    try {
      log("NAME = $name");
      log("bio = $bio");
      log("gende = $gender");
      log("dob = $dob");
      log("user = $userID");
      String url = Constant.getDomainFromURL(Constant.BASE_URL);

      final queryParameters = {
        "userId": userID,
      };

      final uri =
          Uri.https(url, Constant.editProfile, queryParameters);

      var request = http.MultipartRequest("PATCH", uri);

      if (userUpdateImage == null) {
        log("IMGENULLL");
      } else {
        var addImage = await http.MultipartFile.fromPath(
            'profileImage', userUpdateImage!.path);
        request.files.add(addImage);
      }

      request.headers.addAll({"key": Constant.SECRET_KEY});

      Map<String, String> requestBody = <String, String>{
        "name": name,
        "gender": gender,
        "bio": bio,
        "dob": dob,
      };

      request.fields.addAll(requestBody);
      var res1 = await request.send();
      var res = await http.Response.fromStream(res1);
      if (res.statusCode == 200) {
        var data = jsonDecode(res.body);
        await getstorage.write("UserName", data["user"]["name"]);
        await getstorage.write("UserBio", data["user"]["bio"]);
        await getstorage.write('Gender', data["user"]["gender"]);
        await getstorage.write("UserDOB", data["user"]["dob"]);
        await getstorage.write("UserProfile", data["user"]["profileImage"]);
        userName = getstorage.read("UserName");
        userBio = getstorage.read("UserBio");
        userGender = getstorage.read("Gender");
        userDOB = getstorage.read("UserDOB");
        userProfile.value = getstorage.read("UserProfile");

        return jsonDecode(res.body);
      } else {
        log("STATUSCODE:-${res.statusCode.toString()}");
        log(res.reasonPhrase.toString());
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
