import 'dart:convert';

MakeCallModel makeCallModelFromJson(String str) =>
    MakeCallModel.fromJson(json.decode(str));
String makeCallModelToJson(MakeCallModel data) => json.encode(data.toJson());

class MakeCallModel {
  MakeCallModel({
    bool? status,
    String? message,
    String? callId,
  }) {
    _status = status;
    _message = message;
    _callId = callId;
  }

  MakeCallModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _callId = json['callId'];
  }
  bool? _status;
  String? _message;
  String? _callId;
  MakeCallModel copyWith({
    bool? status,
    String? message,
    String? callId,
  }) =>
      MakeCallModel(
        status: status ?? _status,
        message: message ?? _message,
        callId: callId ?? _callId,
      );
  bool? get status => _status;
  String? get message => _message;
  String? get callId => _callId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    map['callId'] = _callId;
    return map;
  }
}
