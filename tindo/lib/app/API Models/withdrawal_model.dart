import 'dart:convert';

WithdrawalModel withdrawalModelFromJson(String str) => WithdrawalModel.fromJson(json.decode(str));
String withdrawalModelToJson(WithdrawalModel data) => json.encode(data.toJson());

class WithdrawalModel {
  WithdrawalModel({
    bool? status,
    String? message,
  }) {
    _status = status;
    _message = message;
  }

  WithdrawalModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
  }
  bool? _status;
  String? _message;
  WithdrawalModel copyWith({
    bool? status,
    String? message,
  }) =>
      WithdrawalModel(
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
