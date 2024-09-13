import 'dart:convert';

DeletNotificationModel deletNotificationModelFromJson(String str) =>
    DeletNotificationModel.fromJson(json.decode(str));
String deletNotificationModelToJson(DeletNotificationModel data) =>
    json.encode(data.toJson());

class DeletNotificationModel {
  DeletNotificationModel({
    bool? status,
    String? message,
  }) {
    _status = status;
    _message = message;
  }

  DeletNotificationModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
  }
  bool? _status;
  String? _message;
  DeletNotificationModel copyWith({
    bool? status,
    String? message,
  }) =>
      DeletNotificationModel(
        status: status ?? _status,
        message: message ?? _message,
      );
  bool? get status => _status;
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    return map;
  }
}
