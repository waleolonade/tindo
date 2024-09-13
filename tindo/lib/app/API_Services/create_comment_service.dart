import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

import '../API Models/create_comment_model.dart';
import '../data/APP_variables/AppVariable.dart';
import 'app_url.dart';

class CreateCommentService {
  static Future<CreateCommentModel> createComment(
    String comment,
    String postId,
  ) async {
    try {
      String url = Constant.getDomainFromURL(Constant.BASE_URL);
      final queryParameters = {
        "postId": postId,
        "userId": userID,
      };

      var payload = jsonEncode({
        "comment": comment,
      }.map((key, value) => MapEntry(key, value.toString())));

      final response = await http.post(
          Uri.https(url, Constant.createComment, queryParameters),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            "key": Constant.SECRET_KEY,
          },
          body: payload);

      var data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        log("====${response.body}");

        return CreateCommentModel.fromJson(data);
      } else {
        log(response.statusCode.toString());
      }

      return CreateCommentModel.fromJson(data);
    } catch (e) {
      throw Exception(e);
    }
  }
}
