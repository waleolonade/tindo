import 'dart:convert';

GetSinglePostModel getSinglePostModelFromJson(String str) =>
    GetSinglePostModel.fromJson(json.decode(str));
String getSinglePostModelToJson(GetSinglePostModel data) =>
    json.encode(data.toJson());

class GetSinglePostModel {
  GetSinglePostModel({
    bool? status,
    String? message,
    List<UserPost>? userPost,
  }) {
    _status = status;
    _message = message;
    _userPost = userPost;
  }

  GetSinglePostModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['userPost'] != null) {
      _userPost = [];
      json['userPost'].forEach((v) {
        _userPost?.add(UserPost.fromJson(v));
      });
    }
  }
  bool? _status;
  String? _message;
  List<UserPost>? _userPost;
  GetSinglePostModel copyWith({
    bool? status,
    String? message,
    List<UserPost>? userPost,
  }) =>
      GetSinglePostModel(
        status: status ?? _status,
        message: message ?? _message,
        userPost: userPost ?? _userPost,
      );
  bool? get status => _status;
  String? get message => _message;
  List<UserPost>? get userPost => _userPost;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_userPost != null) {
      map['userPost'] = _userPost?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

UserPost userPostFromJson(String str) => UserPost.fromJson(json.decode(str));
String userPostToJson(UserPost data) => json.encode(data.toJson());

class UserPost {
  UserPost({
    String? id,
    String? description,
    String? postImage,
    String? date,
    String? createdAt,
    List<UserLike>? userLike,
    bool? isLike,
    num? like,
    num? comment,
    num? gift,
    List<UserGift>? userGift,
    String? userId,
    String? name,
    String? email,
    String? profileImage,
  }) {
    _id = id;
    _description = description;
    _postImage = postImage;
    _date = date;
    _createdAt = createdAt;
    _userLike = userLike;
    _isLike = isLike;
    _like = like;
    _comment = comment;
    _gift = gift;
    _userGift = userGift;
    _userId = userId;
    _name = name;
    _email = email;
    _profileImage = profileImage;
  }

  UserPost.fromJson(dynamic json) {
    _id = json['_id'];
    _description = json['description'];
    _postImage = json['postImage'];
    _date = json['date'];
    _createdAt = json['createdAt'];
    if (json['userLike'] != null) {
      _userLike = [];
      json['userLike'].forEach((v) {
        _userLike?.add(UserLike.fromJson(v));
      });
    }
    _isLike = json['isLike'];
    _like = json['like'];
    _comment = json['comment'];
    _gift = json['gift'];
    if (json['userGift'] != null) {
      _userGift = [];
      json['userGift'].forEach((v) {
        _userGift?.add(UserGift.fromJson(v));
      });
    }
    _userId = json['userId'];
    _name = json['name'];
    _email = json['email'];
    _profileImage = json['profileImage'];
  }
  String? _id;
  String? _description;
  String? _postImage;
  String? _date;
  String? _createdAt;
  List<UserLike>? _userLike;
  bool? _isLike;
  num? _like;
  num? _comment;
  num? _gift;
  List<UserGift>? _userGift;
  String? _userId;
  String? _name;
  String? _email;
  String? _profileImage;
  UserPost copyWith({
    String? id,
    String? description,
    String? postImage,
    String? date,
    String? createdAt,
    List<UserLike>? userLike,
    bool? isLike,
    num? like,
    num? comment,
    num? gift,
    List<UserGift>? userGift,
    String? userId,
    String? name,
    String? email,
    String? profileImage,
  }) =>
      UserPost(
        id: id ?? _id,
        description: description ?? _description,
        postImage: postImage ?? _postImage,
        date: date ?? _date,
        createdAt: createdAt ?? _createdAt,
        userLike: userLike ?? _userLike,
        isLike: isLike ?? _isLike,
        like: like ?? _like,
        comment: comment ?? _comment,
        gift: gift ?? _gift,
        userGift: userGift ?? _userGift,
        userId: userId ?? _userId,
        name: name ?? _name,
        email: email ?? _email,
        profileImage: profileImage ?? _profileImage,
      );
  String? get id => _id;
  String? get description => _description;
  String? get postImage => _postImage;
  String? get date => _date;
  String? get createdAt => _createdAt;
  List<UserLike>? get userLike => _userLike;
  bool? get isLike => _isLike;
  num? get like => _like;
  num? get comment => _comment;
  num? get gift => _gift;
  List<UserGift>? get userGift => _userGift;
  String? get userId => _userId;
  String? get name => _name;
  String? get email => _email;
  String? get profileImage => _profileImage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['description'] = _description;
    map['postImage'] = _postImage;
    map['date'] = _date;
    map['createdAt'] = _createdAt;
    if (_userLike != null) {
      map['userLike'] = _userLike?.map((v) => v.toJson()).toList();
    }
    map['isLike'] = _isLike;
    map['like'] = _like;
    map['comment'] = _comment;
    map['gift'] = _gift;
    if (_userGift != null) {
      map['userGift'] = _userGift?.map((v) => v.toJson()).toList();
    }
    map['userId'] = _userId;
    map['name'] = _name;
    map['email'] = _email;
    map['profileImage'] = _profileImage;
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
    String? name,
    String? profileImage,
    String? gift,
  }) {
    _id = id;
    _postId = postId;
    _userId = userId;
    _name = name;
    _profileImage = profileImage;
    _gift = gift;
  }

  UserGift.fromJson(dynamic json) {
    _id = json['_id'];
    _postId = json['postId'];
    _userId = json['userId'];
    _name = json['name'];
    _profileImage = json['profileImage'];
    _gift = json['gift'];
  }
  String? _id;
  String? _postId;
  String? _userId;
  String? _name;
  String? _profileImage;
  String? _gift;
  UserGift copyWith({
    String? id,
    String? postId,
    String? userId,
    String? name,
    String? profileImage,
    String? gift,
  }) =>
      UserGift(
        id: id ?? _id,
        postId: postId ?? _postId,
        userId: userId ?? _userId,
        name: name ?? _name,
        profileImage: profileImage ?? _profileImage,
        gift: gift ?? _gift,
      );
  String? get id => _id;
  String? get postId => _postId;
  String? get userId => _userId;
  String? get name => _name;
  String? get profileImage => _profileImage;
  String? get gift => _gift;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['postId'] = _postId;
    map['userId'] = _userId;
    map['name'] = _name;
    map['profileImage'] = _profileImage;
    map['gift'] = _gift;
    return map;
  }
}

UserLike userLikeFromJson(String str) => UserLike.fromJson(json.decode(str));
String userLikeToJson(UserLike data) => json.encode(data.toJson());

class UserLike {
  UserLike({
    String? id,
    String? postId,
    String? userId,
    String? name,
    String? profileImage,
  }) {
    _id = id;
    _postId = postId;
    _userId = userId;
    _name = name;
    _profileImage = profileImage;
  }

  UserLike.fromJson(dynamic json) {
    _id = json['_id'];
    _postId = json['postId'];
    _userId = json['userId'];
    _name = json['name'];
    _profileImage = json['profileImage'];
  }
  String? _id;
  String? _postId;
  String? _userId;
  String? _name;
  String? _profileImage;
  UserLike copyWith({
    String? id,
    String? postId,
    String? userId,
    String? name,
    String? profileImage,
  }) =>
      UserLike(
        id: id ?? _id,
        postId: postId ?? _postId,
        userId: userId ?? _userId,
        name: name ?? _name,
        profileImage: profileImage ?? _profileImage,
      );
  String? get id => _id;
  String? get postId => _postId;
  String? get userId => _userId;
  String? get name => _name;
  String? get profileImage => _profileImage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['postId'] = _postId;
    map['userId'] = _userId;
    map['name'] = _name;
    map['profileImage'] = _profileImage;
    return map;
  }
}
