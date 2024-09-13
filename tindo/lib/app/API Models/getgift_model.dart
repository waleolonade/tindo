import 'dart:convert';

GetGiftModel getGiftModelFromJson(String str) => GetGiftModel.fromJson(json.decode(str));
String getGiftModelToJson(GetGiftModel data) => json.encode(data.toJson());
class GetGiftModel {
  GetGiftModel({
      bool? status, 
      String? message, 
      List<Gift>? gift,}){
    _status = status;
    _message = message;
    _gift = gift;
}

  GetGiftModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['gift'] != null) {
      _gift = [];
      json['gift'].forEach((v) {
        _gift?.add(Gift.fromJson(v));
      });
    }
  }
  bool? _status;
  String? _message;
  List<Gift>? _gift;
GetGiftModel copyWith({  bool? status,
  String? message,
  List<Gift>? gift,
}) => GetGiftModel(  status: status ?? _status,
  message: message ?? _message,
  gift: gift ?? _gift,
);
  bool? get status => _status;
  String? get message => _message;
  List<Gift>? get gift => _gift;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_gift != null) {
      map['gift'] = _gift?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}


Gift giftFromJson(String str) => Gift.fromJson(json.decode(str));
String giftToJson(Gift data) => json.encode(data.toJson());
class Gift {
  Gift({
      String? id, 
      num? type, 
      num? platFormType, 
      String? image, 
      num? coin, 
      String? createdAt, 
      String? updatedAt,}){
    _id = id;
    _type = type;
    _platFormType = platFormType;
    _image = image;
    _coin = coin;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  Gift.fromJson(dynamic json) {
    _id = json['_id'];
    _type = json['type'];
    _platFormType = json['platFormType'];
    _image = json['image'];
    _coin = json['coin'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
  }
  String? _id;
  num? _type;
  num? _platFormType;
  String? _image;
  num? _coin;
  String? _createdAt;
  String? _updatedAt;
Gift copyWith({  String? id,
  num? type,
  num? platFormType,
  String? image,
  num? coin,
  String? createdAt,
  String? updatedAt,
}) => Gift(  id: id ?? _id,
  type: type ?? _type,
  platFormType: platFormType ?? _platFormType,
  image: image ?? _image,
  coin: coin ?? _coin,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
);
  String? get id => _id;
  num? get type => _type;
  num? get platFormType => _platFormType;
  String? get image => _image;
  num? get coin => _coin;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['type'] = _type;
    map['platFormType'] = _platFormType;
    map['image'] = _image;
    map['coin'] = _coin;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    return map;
  }

}