import 'dart:convert';

CreateChatTopicModel createChatTopicModelFromJson(String str) =>
    CreateChatTopicModel.fromJson(json.decode(str));
String createChatTopicModelToJson(CreateChatTopicModel data) =>
    json.encode(data.toJson());

class CreateChatTopicModel {
  CreateChatTopicModel({
    bool? status,
    String? message,
    ChatTopic? chatTopic,
  }) {
    _status = status;
    _message = message;
    _chatTopic = chatTopic;
  }

  CreateChatTopicModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _chatTopic = json['chatTopic'] != null
        ? ChatTopic.fromJson(json['chatTopic'])
        : null;
  }
  bool? _status;
  String? _message;
  ChatTopic? _chatTopic;
  CreateChatTopicModel copyWith({
    bool? status,
    String? message,
    ChatTopic? chatTopic,
  }) =>
      CreateChatTopicModel(
        status: status ?? _status,
        message: message ?? _message,
        chatTopic: chatTopic ?? _chatTopic,
      );
  bool? get status => _status;
  String? get message => _message;
  ChatTopic? get chatTopic => _chatTopic;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_chatTopic != null) {
      map['chatTopic'] = _chatTopic?.toJson();
    }
    return map;
  }
}

ChatTopic chatTopicFromJson(String str) => ChatTopic.fromJson(json.decode(str));
String chatTopicToJson(ChatTopic data) => json.encode(data.toJson());

class ChatTopic {
  ChatTopic({
    String? id,
    String? chat,
    String? userId1,
    String? userId2,
    String? createdAt,
    String? updatedAt,
  }) {
    _id = id;
    _chat = chat;
    _userId1 = userId1;
    _userId2 = userId2;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  ChatTopic.fromJson(dynamic json) {
    _id = json['_id'];
    _chat = json['chat'];
    _userId1 = json['userId1'];
    _userId2 = json['userId2'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
  }
  String? _id;
  String? _chat;
  String? _userId1;
  String? _userId2;
  String? _createdAt;
  String? _updatedAt;
  ChatTopic copyWith({
    String? id,
    String? chat,
    String? userId1,
    String? userId2,
    String? createdAt,
    String? updatedAt,
  }) =>
      ChatTopic(
        id: id ?? _id,
        chat: chat ?? _chat,
        userId1: userId1 ?? _userId1,
        userId2: userId2 ?? _userId2,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
      );
  String? get id => _id;
  String? get chat => _chat;
  String? get userId1 => _userId1;
  String? get userId2 => _userId2;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['chat'] = _chat;
    map['userId1'] = _userId1;
    map['userId2'] = _userId2;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    return map;
  }
}
