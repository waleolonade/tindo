import 'dart:convert';

PostGiftSendServiceModel postGiftSendServiceModelFromJson(String str) =>
    PostGiftSendServiceModel.fromJson(json.decode(str));
String postGiftSendServiceModelToJson(PostGiftSendServiceModel data) =>
    json.encode(data.toJson());

class PostGiftSendServiceModel {
  PostGiftSendServiceModel({
    bool? status,
    String? message,
    UserGift? userGift,
  }) {
    _status = status;
    _message = message;
    _userGift = userGift;
  }

  PostGiftSendServiceModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _userGift =
        json['userGift'] != null ? UserGift.fromJson(json['userGift']) : null;
  }
  bool? _status;
  String? _message;
  UserGift? _userGift;
  PostGiftSendServiceModel copyWith({
    bool? status,
    String? message,
    UserGift? userGift,
  }) =>
      PostGiftSendServiceModel(
        status: status ?? _status,
        message: message ?? _message,
        userGift: userGift ?? _userGift,
      );
  bool? get status => _status;
  String? get message => _message;
  UserGift? get userGift => _userGift;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_userGift != null) {
      map['userGift'] = _userGift?.toJson();
    }
    return map;
  }
}

UserGift userGiftFromJson(String str) => UserGift.fromJson(json.decode(str));
String userGiftToJson(UserGift data) => json.encode(data.toJson());

class UserGift {
  UserGift({
    String? id,
    String? postId,
    String? userId,
    String? giftId,
    String? createdAt,
    String? updatedAt,
  }) {
    _id = id;
    _postId = postId;
    _userId = userId;
    _giftId = giftId;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  UserGift.fromJson(dynamic json) {
    _id = json['_id'];
    _postId = json['postId'];
    _userId = json['userId'];
    _giftId = json['giftId'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
  }
  String? _id;
  String? _postId;
  String? _userId;
  String? _giftId;
  String? _createdAt;
  String? _updatedAt;
  UserGift copyWith({
    String? id,
    String? postId,
    String? userId,
    String? giftId,
    String? createdAt,
    String? updatedAt,
  }) =>
      UserGift(
        id: id ?? _id,
        postId: postId ?? _postId,
        userId: userId ?? _userId,
        giftId: giftId ?? _giftId,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
      );
  String? get id => _id;
  String? get postId => _postId;
  String? get userId => _userId;
  String? get giftId => _giftId;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['postId'] = _postId;
    map['userId'] = _userId;
    map['giftId'] = _giftId;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    return map;
  }
}
