import 'dart:convert';

UpdateFcmModel updateFcmModelFromJson(String str) => UpdateFcmModel.fromJson(json.decode(str));
String updateFcmModelToJson(UpdateFcmModel data) => json.encode(data.toJson());

class UpdateFcmModel {
  UpdateFcmModel({
    bool? status,
    String? message,
  }) {
    _status = status;
    _message = message;
  }

  UpdateFcmModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
  }
  bool? _status;
  String? _message;
  UpdateFcmModel copyWith({
    bool? status,
    String? message,
  }) =>
      UpdateFcmModel(
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
