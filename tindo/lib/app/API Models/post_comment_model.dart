import 'dart:convert';

PostCommentModel postCommentModelFromJson(String str) =>
    PostCommentModel.fromJson(json.decode(str));
String postCommentModelToJson(PostCommentModel data) =>
    json.encode(data.toJson());

class PostCommentModel {
  PostCommentModel({
    bool? status,
    String? message,
    List<Comment>? comment,
  }) {
    _status = status;
    _message = message;
    _comment = comment;
  }

  PostCommentModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['comment'] != null) {
      _comment = [];
      json['comment'].forEach((v) {
        _comment?.add(Comment.fromJson(v));
      });
    }
  }
  bool? _status;
  String? _message;
  List<Comment>? _comment;
  PostCommentModel copyWith({
    bool? status,
    String? message,
    List<Comment>? comment,
  }) =>
      PostCommentModel(
        status: status ?? _status,
        message: message ?? _message,
        comment: comment ?? _comment,
      );
  bool? get status => _status;
  String? get message => _message;
  List<Comment>? get comment => _comment;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_comment != null) {
      map['comment'] = _comment?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

Comment commentFromJson(String str) => Comment.fromJson(json.decode(str));
String commentToJson(Comment data) => json.encode(data.toJson());

class Comment {
  Comment({
    String? id,
    String? postId,
    String? comment,
    String? createdAt,
    String? userId,
    String? profileImage,
    String? name,
  }) {
    _id = id;
    _postId = postId;
    _comment = comment;
    _createdAt = createdAt;
    _userId = userId;
    _profileImage = profileImage;
    _name = name;
  }

  Comment.fromJson(dynamic json) {
    _id = json['_id'];
    _postId = json['postId'];
    _comment = json['comment'];
    _createdAt = json['createdAt'];
    _userId = json['userId'];
    _profileImage = json['profileImage'];
    _name = json['name'];
  }
  String? _id;
  String? _postId;
  String? _comment;
  String? _createdAt;
  String? _userId;
  String? _profileImage;
  String? _name;
  Comment copyWith({
    String? id,
    String? postId,
    String? comment,
    String? createdAt,
    String? userId,
    String? profileImage,
    String? name,
  }) =>
      Comment(
        id: id ?? _id,
        postId: postId ?? _postId,
        comment: comment ?? _comment,
        createdAt: createdAt ?? _createdAt,
        userId: userId ?? _userId,
        profileImage: profileImage ?? _profileImage,
        name: name ?? _name,
      );
  String? get id => _id;
  String? get postId => _postId;
  String? get comment => _comment;
  String? get createdAt => _createdAt;
  String? get userId => _userId;
  String? get profileImage => _profileImage;
  String? get name => _name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['postId'] = _postId;
    map['comment'] = _comment;
    map['createdAt'] = _createdAt;
    map['userId'] = _userId;
    map['profileImage'] = _profileImage;
    map['name'] = _name;
    return map;
  }
}
