import 'dart:convert';

LiveEndHistoryModel liveEndHistoryModelFromJson(String str) =>
    LiveEndHistoryModel.fromJson(json.decode(str));
String liveEndHistoryModelToJson(LiveEndHistoryModel data) =>
    json.encode(data.toJson());

class LiveEndHistoryModel {
  LiveEndHistoryModel({
    bool? status,
    String? message,
    LiveStreaming? liveStreaming,
  }) {
    _status = status;
    _message = message;
    _liveStreaming = liveStreaming;
  }

  LiveEndHistoryModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _liveStreaming = json['liveStreaming'] != null
        ? LiveStreaming.fromJson(json['liveStreaming'])
        : null;
  }
  bool? _status;
  String? _message;
  LiveStreaming? _liveStreaming;
  LiveEndHistoryModel copyWith({
    bool? status,
    String? message,
    LiveStreaming? liveStreaming,
  }) =>
      LiveEndHistoryModel(
        status: status ?? _status,
        message: message ?? _message,
        liveStreaming: liveStreaming ?? _liveStreaming,
      );
  bool? get status => _status;
  String? get message => _message;
  LiveStreaming? get liveStreaming => _liveStreaming;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_liveStreaming != null) {
      map['liveStreaming'] = _liveStreaming?.toJson();
    }
    return map;
  }
}

LiveStreaming liveStreamingFromJson(String str) =>
    LiveStreaming.fromJson(json.decode(str));
String liveStreamingToJson(LiveStreaming data) => json.encode(data.toJson());

class LiveStreaming {
  LiveStreaming({
    String? id,
    num? duration,
    num? userView,
    num? gift,
    num? comment,
    num? coin,
    num? diamond,
    String? userId,
    String? coverImage,
    String? profileImage,
    String? startTime,
    String? createdAt,
    String? updatedAt,
  }) {
    _id = id;
    _duration = duration;
    _userView = userView;
    _gift = gift;
    _comment = comment;
    _coin = coin;
    _diamond = diamond;
    _userId = userId;
    _coverImage = coverImage;
    _profileImage = profileImage;
    _startTime = startTime;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  LiveStreaming.fromJson(dynamic json) {
    _id = json['_id'];
    _duration = json['duration'];
    _userView = json['userView'];
    _gift = json['gift'];
    _comment = json['comment'];
    _coin = json['coin'];
    _diamond = json['diamond'];
    _userId = json['userId'];
    _coverImage = json['coverImage'];
    _profileImage = json['profileImage'];
    _startTime = json['startTime'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
  }
  String? _id;
  num? _duration;
  num? _userView;
  num? _gift;
  num? _comment;
  num? _coin;
  num? _diamond;
  String? _userId;
  String? _coverImage;
  String? _profileImage;
  String? _startTime;
  String? _createdAt;
  String? _updatedAt;
  LiveStreaming copyWith({
    String? id,
    num? duration,
    num? userView,
    num? gift,
    num? comment,
    num? coin,
    num? diamond,
    String? userId,
    String? coverImage,
    String? profileImage,
    String? startTime,
    String? createdAt,
    String? updatedAt,
  }) =>
      LiveStreaming(
        id: id ?? _id,
        duration: duration ?? _duration,
        userView: userView ?? _userView,
        gift: gift ?? _gift,
        comment: comment ?? _comment,
        coin: coin ?? _coin,
        diamond: diamond ?? _diamond,
        userId: userId ?? _userId,
        coverImage: coverImage ?? _coverImage,
        profileImage: profileImage ?? _profileImage,
        startTime: startTime ?? _startTime,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
      );
  String? get id => _id;
  num? get duration => _duration;
  num? get userView => _userView;
  num? get gift => _gift;
  num? get comment => _comment;
  num? get coin => _coin;
  num? get diamond => _diamond;
  String? get userId => _userId;
  String? get coverImage => _coverImage;
  String? get profileImage => _profileImage;
  String? get startTime => _startTime;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['duration'] = _duration;
    map['userView'] = _userView;
    map['gift'] = _gift;
    map['comment'] = _comment;
    map['coin'] = _coin;
    map['diamond'] = _diamond;
    map['userId'] = _userId;
    map['coverImage'] = _coverImage;
    map['profileImage'] = _profileImage;
    map['startTime'] = _startTime;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    return map;
  }
}
