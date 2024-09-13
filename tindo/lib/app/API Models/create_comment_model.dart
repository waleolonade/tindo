import 'dart:convert';

CreateCommentModel createCommentModelFromJson(String str) => CreateCommentModel.fromJson(json.decode(str));
String createCommentModelToJson(CreateCommentModel data) => json.encode(data.toJson());
class CreateCommentModel {
  CreateCommentModel({
      bool? status, 
      String? message, 
      Comment? comment,}){
    _status = status;
    _message = message;
    _comment = comment;
}

  CreateCommentModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _comment = json['comment'] != null ? Comment.fromJson(json['comment']) : null;
  }
  bool? _status;
  String? _message;
  Comment? _comment;
CreateCommentModel copyWith({  bool? status,
  String? message,
  Comment? comment,
}) => CreateCommentModel(  status: status ?? _status,
  message: message ?? _message,
  comment: comment ?? _comment,
);
  bool? get status => _status;
  String? get message => _message;
  Comment? get comment => _comment;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_comment != null) {
      map['comment'] = _comment?.toJson();
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
      String? userId, 
      String? comment, 
      String? createdAt, 
      String? updatedAt,}){
    _id = id;
    _postId = postId;
    _userId = userId;
    _comment = comment;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  Comment.fromJson(dynamic json) {
    _id = json['_id'];
    _postId = json['postId'];
    _userId = json['userId'];
    _comment = json['comment'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
  }
  String? _id;
  String? _postId;
  String? _userId;
  String? _comment;
  String? _createdAt;
  String? _updatedAt;
Comment copyWith({  String? id,
  String? postId,
  String? userId,
  String? comment,
  String? createdAt,
  String? updatedAt,
}) => Comment(  id: id ?? _id,
  postId: postId ?? _postId,
  userId: userId ?? _userId,
  comment: comment ?? _comment,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
);
  String? get id => _id;
  String? get postId => _postId;
  String? get userId => _userId;
  String? get comment => _comment;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['postId'] = _postId;
    map['userId'] = _userId;
    map['comment'] = _comment;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    return map;
  }

}