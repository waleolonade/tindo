import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:rayzi/app/API_Services/app_url.dart';
import 'package:http/http.dart' as http;
import 'package:rayzi/app/modules/My_App/views/my_app_view.dart';

class DeleteAccountController extends GetxController {
  var isLoading = true.obs;

  Future<void> deleteAccount(String userId) async {
    Get.dialog(Center(
      child: const CircularProgressIndicator(
        color: Colors.pinkAccent,
      ),
    ));
    try {
      String uri = Constant.getDomainFromURL(Constant.BASE_URL);
      final queryParameters = {"userId": userId};
      var url = Uri.https(uri, Constant.deleteAccount, queryParameters);
      log("Delete Account url ::$url");
      final header = {"Key": Constant.SECRET_KEY};
      var response = await http.delete(url, headers: header);
      log("delete Account Response :: ${response.body}");
      if (response.statusCode == 200) {
        await Fluttertoast.showToast(
          msg: "Account Delete SuccessFully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black.withOpacity(0.35),
          textColor: Colors.white,
          fontSize: 16.0,
        );

        Get.offAll(const MyApp());
      }
    } catch (e) {
      log("Api Response Error :: $e");
    }
  }
}
