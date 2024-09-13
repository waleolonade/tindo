import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:rayzi/app/data/APP_variables/AppVariable.dart';

import '../API Models/report_model.dart';
import 'app_url.dart';

class ReportServices extends GetxService {
  Future<ReportModel?> postReportServices({
    required String postID,
    required String reportType,
    required String report,
    required String image,
  }) async {
    var payload = jsonEncode({
      "report": report,
      "image": image,
    }.map((key, value) => MapEntry(key, value.toString())));

    // final queryParameters = (reportType == 0)
    //     ? {"postId": postID, "userId": userID, "reportType": runtimeType}
    //     : {"profileId": postID, "userId": userID, "reportType": runtimeType};
    String url = Constant.getDomainFromURL(Constant.BASE_URL);
    final queryParameters = (reportType == "0")
        ? {
            "postId": postID,
            "userId": userID,
            "reportType": reportType,
          }
        : {
            "profileId": postID,
            "userId": userID,
            "reportType": reportType,
          };
    log("====PostID==$postID===Reporty==$reportType=====report====$report===Image===$image");

    log("=======URL= ${Uri.https(url, Constant.postReport, queryParameters)}");

    final response = await http.post(Uri.https(url, Constant.postReport, queryParameters),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          "key": Constant.SECRET_KEY,
        },
        body: payload);

    log("===========${response.statusCode}========${response.body}");
    if (response.statusCode == 200) {
      log("Report response:- ${response.body}");
      return ReportModel.fromJson(jsonDecode(response.body));
    } else {
      log("Report StatusCode :- ${response.statusCode}");
    }
    return null;
  }
}
