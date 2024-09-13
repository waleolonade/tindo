import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:rayzi/app/API%20Models/makecall_model.dart';
import 'package:rayzi/app/data/APP_variables/AppVariable.dart';
import 'package:rayzi/app/modules/Messages/views/RandomMwtching.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

import 'app_url.dart';

class MakeCallServices extends GetxService {
  Future<MakeCallModel?> mekeCallServices({
    required String callerUserID,
    required String receiverUserID,
    required String callerImage,
    required String callerName,
    required String receiverImage,
    required String receiverName,
  }) async {
    final body = jsonEncode({
      "callerUserId": callerUserID,
      "receiverUserId": receiverUserID,
      "callerImage": callerImage,
      "callerName": callerName,
    });
    log(body);
    final response = await http.post(
      Uri.parse(Constant.BASE_URL + Constant.makeCallUri),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        "key": Constant.SECRET_KEY
      },
      body: body,
    );

    if (response.statusCode == 200) {
      var data = await jsonDecode(response.body);
      log("========>>>>${response.body}");
      if (data["status"] == true) {
        log("======================>>>> Make call Api DONE");
        socket = io.io(
          Constant.BASE_URL,
          io.OptionBuilder().setTransports(['websocket']).setQuery(
              {"callRoom": data["callId"]["callerId"]}).build(),
        );
        socket.connect();
        log("+++++++++++${data["callId"]}");
        socket.emit("callRequest", data["callId"]);
        log("======================>>>> Call Request Socket Emit");
        log("!!!!!!!!${data["callId"]["channel"]}!!!!!!!${data["callId"]["token"]}!!!!!${data["callId"]["receiverId"]}!!!!!${data["callId"]["callId"]}");
        Get.to(()=>RandomMatching(
          matchImage: receiverImage,
          matchName: receiverName,
          channel: '${data["callId"]["channel"]}',
          token: '${data["callId"]["token"]}',
          receiverId: '${data["callId"]["receiverId"]}',
          callId: '${data["callId"]["callId"]}',
          callerId: '${data["callId"]["callerId"]}',
        ));
      }
      return MakeCallModel.fromJson(jsonDecode(response.body));
    } else {
      log("StattusCode:-${response.statusCode}");
    }
    return null;
  }
}
