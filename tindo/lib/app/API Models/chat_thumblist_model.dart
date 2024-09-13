import 'dart:convert';

ChatThumbListModel chatThumbListModelFromJson(String str) =>
    ChatThumbListModel.fromJson(json.decode(str));
String chatThumbListModelToJson(ChatThumbListModel data) =>
    json.encode(data.toJson());

class ChatThumbListModel {
  ChatThumbListModel({
    bool? status,
    String? message,
    List<ChatList>? chatList,
  }) {
    _status = status;
    _message = message;
    _chatList = chatList;
  }

  ChatThumbListModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['chatList'] != null) {
      _chatList = [];
      json['chatList'].forEach((v) {
        _chatList?.add(ChatList.fromJson(v));
      });
    }
  }
  bool? _status;
  String? _message;
  List<ChatList>? _chatList;
  ChatThumbListModel copyWith({
    bool? status,
    String? message,
    List<ChatList>? chatList,
  }) =>
      ChatThumbListModel(
        status: status ?? _status,
        message: message ?? _message,
        chatList: chatList ?? _chatList,
      );
  bool? get status => _status;
  String? get message => _message;
  List<ChatList>? get chatList => _chatList;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_chatList != null) {
      map['chatList'] = _chatList?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

ChatList chatListFromJson(String str) => ChatList.fromJson(json.decode(str));
String chatListToJson(ChatList data) => json.encode(data.toJson());

class ChatList {
  ChatList({
    String? video,
    String? topic,
    String? message,
    num? messageType,
    String? date,
    String? chatDate,
    String? userId,
    String? name,
    String? profileImage,
    String? country,
    bool? isFake,
    String? time,
  }) {
    _video = video;
    _topic = topic;
    _message = message;
    _messageType = messageType;
    _date = date;
    _chatDate = chatDate;
    _userId = userId;
    _name = name;
    _profileImage = profileImage;
    _country = country;
    _isFake = isFake;
    _time = time;
  }

  ChatList.fromJson(dynamic json) {
    _video = json['video'];
    _topic = json['topic'];
    _message = json['message'];
    _messageType = json['messageType'];
    _date = json['date'];
    _chatDate = json['chatDate'];
    _userId = json['userId'];
    _name = json['name'];
    _profileImage = json['profileImage'];
    _country = json['country'];
    _isFake = json['isFake'];
    _time = json['time'];
  }
  String? _video;
  String? _topic;
  String? _message;
  num? _messageType;
  String? _date;
  String? _chatDate;
  String? _userId;
  String? _name;
  String? _profileImage;
  String? _country;
  bool? _isFake;
  String? _time;
  ChatList copyWith({
    String? video,
    String? topic,
    String? message,
    num? messageType,
    String? date,
    String? chatDate,
    String? userId,
    String? name,
    String? profileImage,
    String? country,
    bool? isFake,
    String? time,
  }) =>
      ChatList(
        video: video ?? _video,
        topic: topic ?? _topic,
        message: message ?? _message,
        messageType: messageType ?? _messageType,
        date: date ?? _date,
        chatDate: chatDate ?? _chatDate,
        userId: userId ?? _userId,
        name: name ?? _name,
        profileImage: profileImage ?? _profileImage,
        country: country ?? _country,
        isFake: isFake ?? _isFake,
        time: time ?? _time,
      );
  String? get video => _video;
  String? get topic => _topic;
  String? get message => _message;
  num? get messageType => _messageType;
  String? get date => _date;
  String? get chatDate => _chatDate;
  String? get userId => _userId;
  String? get name => _name;
  String? get profileImage => _profileImage;
  String? get country => _country;
  bool? get isFake => _isFake;
  String? get time => _time;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['video'] = _video;
    map['topic'] = _topic;
    map['message'] = _message;
    map['messageType'] = _messageType;
    map['date'] = _date;
    map['chatDate'] = _chatDate;
    map['userId'] = _userId;
    map['name'] = _name;
    map['profileImage'] = _profileImage;
    map['country'] = _country;
    map['isFake'] = _isFake;
    map['time'] = _time;
    return map;
  }
}
