import 'dart:convert';

OldChatModel oldChatModelFromJson(String str) =>
    OldChatModel.fromJson(json.decode(str));
String oldChatModelToJson(OldChatModel data) => json.encode(data.toJson());

class OldChatModel {
  OldChatModel({
    bool? status,
    String? message,
    List<Chat>? chat,
  }) {
    _status = status;
    _message = message;
    _chat = chat;
  }

  OldChatModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['chat'] != null) {
      _chat = [];
      json['chat'].forEach((v) {
        _chat?.add(Chat.fromJson(v));
      });
    }
  }
  bool? _status;
  String? _message;
  List<Chat>? _chat;
  OldChatModel copyWith({
    bool? status,
    String? message,
    List<Chat>? chat,
  }) =>
      OldChatModel(
        status: status ?? _status,
        message: message ?? _message,
        chat: chat ?? _chat,
      );
  bool? get status => _status;
  String? get message => _message;
  List<Chat>? get chat => _chat;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_chat != null) {
      map['chat'] = _chat?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

Chat chatFromJson(String str) => Chat.fromJson(json.decode(str));
String chatToJson(Chat data) => json.encode(data.toJson());

class Chat {
  Chat({
    String? id,
    dynamic image,
    dynamic video,
    dynamic audio,
    bool? isRead,
    dynamic callType,
    String? callDuration,
    dynamic callId,
    String? senderId,
    num? messageType,
    String? message,
    String? topicId,
    String? date,
    String? createdAt,
    String? updatedAt,
  }) {
    _id = id;
    _image = image;
    _video = video;
    _audio = audio;
    _isRead = isRead;
    _callType = callType;
    _callDuration = callDuration;
    _callId = callId;
    _senderId = senderId;
    _messageType = messageType;
    _message = message;
    _topicId = topicId;
    _date = date;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  Chat.fromJson(dynamic json) {
    _id = json['_id'];
    _image = json['image'];
    _video = json['video'];
    _audio = json['audio'];
    _isRead = json['isRead'];
    _callType = json['callType'];
    _callDuration = json['callDuration'];
    _callId = json['callId'];
    _senderId = json['senderId'];
    _messageType = json['messageType'];
    _message = json['message'];
    _topicId = json['topicId'];
    _date = json['date'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
  }
  String? _id;
  dynamic _image;
  dynamic _video;
  dynamic _audio;
  bool? _isRead;
  dynamic _callType;
  String? _callDuration;
  dynamic _callId;
  String? _senderId;
  num? _messageType;
  String? _message;
  String? _topicId;
  String? _date;
  String? _createdAt;
  String? _updatedAt;
  Chat copyWith({
    String? id,
    dynamic image,
    dynamic video,
    dynamic audio,
    bool? isRead,
    dynamic callType,
    String? callDuration,
    dynamic callId,
    String? senderId,
    num? messageType,
    String? message,
    String? topicId,
    String? date,
    String? createdAt,
    String? updatedAt,
  }) =>
      Chat(
        id: id ?? _id,
        image: image ?? _image,
        video: video ?? _video,
        audio: audio ?? _audio,
        isRead: isRead ?? _isRead,
        callType: callType ?? _callType,
        callDuration: callDuration ?? _callDuration,
        callId: callId ?? _callId,
        senderId: senderId ?? _senderId,
        messageType: messageType ?? _messageType,
        message: message ?? _message,
        topicId: topicId ?? _topicId,
        date: date ?? _date,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
      );
  String? get id => _id;
  dynamic get image => _image;
  dynamic get video => _video;
  dynamic get audio => _audio;
  bool? get isRead => _isRead;
  dynamic get callType => _callType;
  String? get callDuration => _callDuration;
  dynamic get callId => _callId;
  String? get senderId => _senderId;
  num? get messageType => _messageType;
  String? get message => _message;
  String? get topicId => _topicId;
  String? get date => _date;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['image'] = _image;
    map['video'] = _video;
    map['audio'] = _audio;
    map['isRead'] = _isRead;
    map['callType'] = _callType;
    map['callDuration'] = _callDuration;
    map['callId'] = _callId;
    map['senderId'] = _senderId;
    map['messageType'] = _messageType;
    map['message'] = _message;
    map['topicId'] = _topicId;
    map['date'] = _date;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    return map;
  }
}
