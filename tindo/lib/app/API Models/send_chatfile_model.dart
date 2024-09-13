import 'dart:convert';

SendChatFileModel sendChatFileModelFromJson(String str) =>
    SendChatFileModel.fromJson(json.decode(str));
String sendChatFileModelToJson(SendChatFileModel data) =>
    json.encode(data.toJson());

class SendChatFileModel {
  SendChatFileModel({
    bool? status,
    String? message,
    Chat? chat,
  }) {
    _status = status;
    _message = message;
    _chat = chat;
  }

  SendChatFileModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _chat = json['chat'] != null ? Chat.fromJson(json['chat']) : null;
  }
  bool? _status;
  String? _message;
  Chat? _chat;
  SendChatFileModel copyWith({
    bool? status,
    String? message,
    Chat? chat,
  }) =>
      SendChatFileModel(
        status: status ?? _status,
        message: message ?? _message,
        chat: chat ?? _chat,
      );
  bool? get status => _status;
  String? get message => _message;
  Chat? get chat => _chat;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_chat != null) {
      map['chat'] = _chat?.toJson();
    }
    return map;
  }
}

Chat chatFromJson(String str) => Chat.fromJson(json.decode(str));
String chatToJson(Chat data) => json.encode(data.toJson());

class Chat {
  Chat({
    String? image,
    dynamic video,
    dynamic audio,
    bool? isRead,
    dynamic callType,
    String? callDuration,
    dynamic callId,
    String? id,
    String? senderId,
    String? topicId,
    String? date,
    num? messageType,
    String? message,
    String? createdAt,
    String? updatedAt,
  }) {
    _image = image;
    _video = video;
    _audio = audio;
    _isRead = isRead;
    _callType = callType;
    _callDuration = callDuration;
    _callId = callId;
    _id = id;
    _senderId = senderId;
    _topicId = topicId;
    _date = date;
    _messageType = messageType;
    _message = message;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  Chat.fromJson(dynamic json) {
    _image = json['image'];
    _video = json['video'];
    _audio = json['audio'];
    _isRead = json['isRead'];
    _callType = json['callType'];
    _callDuration = json['callDuration'];
    _callId = json['callId'];
    _id = json['_id'];
    _senderId = json['senderId'];
    _topicId = json['topicId'];
    _date = json['date'];
    _messageType = json['messageType'];
    _message = json['message'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
  }
  String? _image;
  dynamic _video;
  dynamic _audio;
  bool? _isRead;
  dynamic _callType;
  String? _callDuration;
  dynamic _callId;
  String? _id;
  String? _senderId;
  String? _topicId;
  String? _date;
  num? _messageType;
  String? _message;
  String? _createdAt;
  String? _updatedAt;
  Chat copyWith({
    String? image,
    dynamic video,
    dynamic audio,
    bool? isRead,
    dynamic callType,
    String? callDuration,
    dynamic callId,
    String? id,
    String? senderId,
    String? topicId,
    String? date,
    num? messageType,
    String? message,
    String? createdAt,
    String? updatedAt,
  }) =>
      Chat(
        image: image ?? _image,
        video: video ?? _video,
        audio: audio ?? _audio,
        isRead: isRead ?? _isRead,
        callType: callType ?? _callType,
        callDuration: callDuration ?? _callDuration,
        callId: callId ?? _callId,
        id: id ?? _id,
        senderId: senderId ?? _senderId,
        topicId: topicId ?? _topicId,
        date: date ?? _date,
        messageType: messageType ?? _messageType,
        message: message ?? _message,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
      );
  String? get image => _image;
  dynamic get video => _video;
  dynamic get audio => _audio;
  bool? get isRead => _isRead;
  dynamic get callType => _callType;
  String? get callDuration => _callDuration;
  dynamic get callId => _callId;
  String? get id => _id;
  String? get senderId => _senderId;
  String? get topicId => _topicId;
  String? get date => _date;
  num? get messageType => _messageType;
  String? get message => _message;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['image'] = _image;
    map['video'] = _video;
    map['audio'] = _audio;
    map['isRead'] = _isRead;
    map['callType'] = _callType;
    map['callDuration'] = _callDuration;
    map['callId'] = _callId;
    map['_id'] = _id;
    map['senderId'] = _senderId;
    map['topicId'] = _topicId;
    map['date'] = _date;
    map['messageType'] = _messageType;
    map['message'] = _message;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    return map;
  }
}
