import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:rayzi/app/API%20Models/send_chatfile_model.dart';
import 'package:rayzi/app/API_Services/app_url.dart';
import 'package:rayzi/app/data/APP_variables/AppVariable.dart';

class SendChatFileServices extends GetxService {
  Future<SendChatFileModel?> sendChatFile({
    required String topicId,
    required String messageType,
    required String senderId,
    required File sendData,
  }) async {
    try {
      log("===IMGEPATH=${sendData.path}");
      log("====MESSAGETYPE=$messageType");
      log("====Topic=$topicId");
      log("====sender=$senderId");
      var uri = Uri.parse(Constant.BASE_URL + Constant.sendChatFileUrl);
      log("====uri  =$uri");
      var request = http.MultipartRequest("POST", uri);
      var addImage;
      if (messageType == "2") {
        addImage = await http.MultipartFile.fromPath('image', sendData.path);
      } else if (messageType == "4") {
        addImage = await http.MultipartFile.fromPath('audio', sendData.path);
      }
      request.files.add(addImage);
      request.headers.addAll({'Content-Type': 'application/json; charset=UTF-8', "key": Constant.SECRET_KEY});
      Map<String, String> requestBody = <String, String>{
        "topicId": topicId,
        "messageType": messageType,
        "senderId": senderId,
      };

      request.fields.addAll(requestBody);
      var res1 = await request.send();
      var res = await http.Response.fromStream(res1);

      if (res.statusCode == 200) {
        var data = jsonDecode(res.body);
        if (data["status"] == true) {
          if (data["chat"]["messageType"] == 2) {
            socket.emit("chat", {
              "topicId": data["chat"]["topicId"],
              "senderId": senderId,
              "message": data["chat"]["image"],
              "messageType": data["chat"]["messageType"],
              "date": data["chat"]["date"],
            });
          } else if (data["chat"]["messageType"] == 4) {
            socket.emit("chat", {
              "topicId": data["chat"]["topicId"],
              "senderId": senderId,
              "message": data["chat"]["audio"],
              "messageType": data["chat"]["messageType"],
              "date": data["chat"]["date"],
            });
          }
        }
        return SendChatFileModel.fromJson(jsonDecode(res.body));
      } else {
        log("*******${res.statusCode}");
      }
    } catch (e) {
      log("*******");
      throw Exception(e);
    }
    return null;
  }
}
