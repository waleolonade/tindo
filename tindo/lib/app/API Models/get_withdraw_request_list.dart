import 'dart:convert';
GetWithdrawRequestList getWithdrawRequestListFromJson(String str) => GetWithdrawRequestList.fromJson(json.decode(str));
String getWithdrawRequestListToJson(GetWithdrawRequestList data) => json.encode(data.toJson());
class GetWithdrawRequestList {
  GetWithdrawRequestList({
      bool? status, 
      String? message, 
      List<WithdrawRequest>? withdrawRequest,}){
    _status = status;
    _message = message;
    _withdrawRequest = withdrawRequest;
}

  GetWithdrawRequestList.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['withdrawRequest'] != null) {
      _withdrawRequest = [];
      json['withdrawRequest'].forEach((v) {
        _withdrawRequest?.add(WithdrawRequest.fromJson(v));
      });
    }
  }
  bool? _status;
  String? _message;
  List<WithdrawRequest>? _withdrawRequest;
GetWithdrawRequestList copyWith({  bool? status,
  String? message,
  List<WithdrawRequest>? withdrawRequest,
}) => GetWithdrawRequestList(  status: status ?? _status,
  message: message ?? _message,
  withdrawRequest: withdrawRequest ?? _withdrawRequest,
);
  bool? get status => _status;
  String? get message => _message;
  List<WithdrawRequest>? get withdrawRequest => _withdrawRequest;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_withdrawRequest != null) {
      map['withdrawRequest'] = _withdrawRequest?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

WithdrawRequest withdrawRequestFromJson(String str) => WithdrawRequest.fromJson(json.decode(str));
String withdrawRequestToJson(WithdrawRequest data) => json.encode(data.toJson());
class WithdrawRequest {
  WithdrawRequest({
      String? id, 
      num? status, 
      String? details, 
      String? userId, 
      num? diamond, 
      String? paymentGateway, 
      String? date, 
      String? createdAt, 
      String? updatedAt,}){
    _id = id;
    _status = status;
    _details = details;
    _userId = userId;
    _diamond = diamond;
    _paymentGateway = paymentGateway;
    _date = date;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  WithdrawRequest.fromJson(dynamic json) {
    _id = json['_id'];
    _status = json['status'];
    _details = json['details'];
    _userId = json['userId'];
    _diamond = json['diamond'];
    _paymentGateway = json['paymentGateway'];
    _date = json['date'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
  }
  String? _id;
  num? _status;
  String? _details;
  String? _userId;
  num? _diamond;
  String? _paymentGateway;
  String? _date;
  String? _createdAt;
  String? _updatedAt;
WithdrawRequest copyWith({  String? id,
  num? status,
  String? details,
  String? userId,
  num? diamond,
  String? paymentGateway,
  String? date,
  String? createdAt,
  String? updatedAt,
}) => WithdrawRequest(  id: id ?? _id,
  status: status ?? _status,
  details: details ?? _details,
  userId: userId ?? _userId,
  diamond: diamond ?? _diamond,
  paymentGateway: paymentGateway ?? _paymentGateway,
  date: date ?? _date,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
);
  String? get id => _id;
  num? get status => _status;
  String? get details => _details;
  String? get userId => _userId;
  num? get diamond => _diamond;
  String? get paymentGateway => _paymentGateway;
  String? get date => _date;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['status'] = _status;
    map['details'] = _details;
    map['userId'] = _userId;
    map['diamond'] = _diamond;
    map['paymentGateway'] = _paymentGateway;
    map['date'] = _date;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    return map;
  }

}