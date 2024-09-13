import 'dart:convert';

SendLikeModel sendLikeModelFromJson(String str) =>
    SendLikeModel.fromJson(json.decode(str));
String sendLikeModelToJson(SendLikeModel data) => json.encode(data.toJson());

class SendLikeModel {
  SendLikeModel({
    bool? status,
    String? message,
    bool? like,
  }) {
    _status = status;
    _message = message;
    _like = like;
  }

  SendLikeModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _like = json['like'];
  }
  bool? _status;
  String? _message;
  bool? _like;
  SendLikeModel copyWith({
    bool? status,
    String? message,
    bool? like,
  }) =>
      SendLikeModel(
        status: status ?? _status,
        message: message ?? _message,
        like: like ?? _like,
      );
  bool? get status => _status;
  String? get message => _message;
  bool? get like => _like;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    map['like'] = _like;
    return map;
  }
}
