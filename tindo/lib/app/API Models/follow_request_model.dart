import 'dart:convert';

FollowRequestModel followRequestFromJson(String str) =>
    FollowRequestModel.fromJson(json.decode(str));
String followRequestToJson(FollowRequestModel data) =>
    json.encode(data.toJson());

class FollowRequestModel {
  FollowRequestModel({
    bool? status,
    String? message,
    bool? isFollow,
  }) {
    _status = status;
    _message = message;
    _isFollow = isFollow;
  }

  FollowRequestModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _isFollow = json['isFollow'];
  }
  bool? _status;
  String? _message;
  bool? _isFollow;
  FollowRequestModel copyWith({
    bool? status,
    String? message,
    bool? isFollow,
  }) =>
      FollowRequestModel(
        status: status ?? _status,
        message: message ?? _message,
        isFollow: isFollow ?? _isFollow,
      );
  bool? get status => _status;
  String? get message => _message;
  bool? get isFollow => _isFollow;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    map['isFollow'] = _isFollow;
    return map;
  }
}
