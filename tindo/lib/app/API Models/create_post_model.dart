import 'dart:convert';

CreatePostModel createPostModelFromJson(String str) =>
    CreatePostModel.fromJson(json.decode(str));
String createPostModelToJson(CreatePostModel data) =>
    json.encode(data.toJson());

class CreatePostModel {
  CreatePostModel({
    bool? status,
    String? message,
    Post? post,
  }) {
    _status = status;
    _message = message;
    _post = post;
  }

  CreatePostModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _post = json['post'] != null ? Post.fromJson(json['post']) : null;
  }
  bool? _status;
  String? _message;
  Post? _post;
  CreatePostModel copyWith({
    bool? status,
    String? message,
    Post? post,
  }) =>
      CreatePostModel(
        status: status ?? _status,
        message: message ?? _message,
        post: post ?? _post,
      );
  bool? get status => _status;
  String? get message => _message;
  Post? get post => _post;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_post != null) {
      map['post'] = _post?.toJson();
    }
    return map;
  }
}

Post postFromJson(String str) => Post.fromJson(json.decode(str));
String postToJson(Post data) => json.encode(data.toJson());

class Post {
  Post({
    String? description,
    num? like,
    num? comment,
    num? gift,
    String? id,
    String? userId,
    String? postImage,
    String? createdAt,
    String? updatedAt,
  }) {
    _description = description;
    _like = like;
    _comment = comment;
    _gift = gift;
    _id = id;
    _userId = userId;
    _postImage = postImage;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  Post.fromJson(dynamic json) {
    _description = json['description'];
    _like = json['like'];
    _comment = json['comment'];
    _gift = json['gift'];
    _id = json['_id'];
    _userId = json['userId'];
    _postImage = json['postImage'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
  }
  String? _description;
  num? _like;
  num? _comment;
  num? _gift;
  String? _id;
  String? _userId;
  String? _postImage;
  String? _createdAt;
  String? _updatedAt;
  Post copyWith({
    String? description,
    num? like,
    num? comment,
    num? gift,
    String? id,
    String? userId,
    String? postImage,
    String? createdAt,
    String? updatedAt,
  }) =>
      Post(
        description: description ?? _description,
        like: like ?? _like,
        comment: comment ?? _comment,
        gift: gift ?? _gift,
        id: id ?? _id,
        userId: userId ?? _userId,
        postImage: postImage ?? _postImage,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
      );
  String? get description => _description;
  num? get like => _like;
  num? get comment => _comment;
  num? get gift => _gift;
  String? get id => _id;
  String? get userId => _userId;
  String? get postImage => _postImage;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['description'] = _description;
    map['like'] = _like;
    map['comment'] = _comment;
    map['gift'] = _gift;
    map['_id'] = _id;
    map['userId'] = _userId;
    map['postImage'] = _postImage;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    return map;
  }
}
