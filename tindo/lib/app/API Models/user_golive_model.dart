import 'dart:convert';

UserGoLiveModel userGoLiveModelFromJson(String str) =>
    UserGoLiveModel.fromJson(json.decode(str));
String userGoLiveModelToJson(UserGoLiveModel data) =>
    json.encode(data.toJson());

class UserGoLiveModel {
  UserGoLiveModel({
    bool? status,
    String? message,
    LiveHost? liveHost,
  }) {
    _status = status;
    _message = message;
    _liveHost = liveHost;
  }

  UserGoLiveModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _liveHost =
        json['liveHost'] != null ? LiveHost.fromJson(json['liveHost']) : null;
  }
  bool? _status;
  String? _message;
  LiveHost? _liveHost;
  UserGoLiveModel copyWith({
    bool? status,
    String? message,
    LiveHost? liveHost,
  }) =>
      UserGoLiveModel(
        status: status ?? _status,
        message: message ?? _message,
        liveHost: liveHost ?? _liveHost,
      );
  bool? get status => _status;
  String? get message => _message;
  LiveHost? get liveHost => _liveHost;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_liveHost != null) {
      map['liveHost'] = _liveHost?.toJson();
    }
    return map;
  }
}

LiveHost liveHostFromJson(String str) => LiveHost.fromJson(json.decode(str));
String liveHostToJson(LiveHost data) => json.encode(data.toJson());

class LiveHost {
  LiveHost({
    String? id,
    num? diamond,
    List<View>? view,
    String? liveStreamingId,
    String? coverImage,
    String? name,
    String? country,
    String? profileImage,
    String? token,
    String? channel,
    num? coin,
    String? userId,
    String? dob,
    String? createdAt,
    String? updatedAt,
  }) {
    _id = id;
    _diamond = diamond;
    _view = view;
    _liveStreamingId = liveStreamingId;
    _coverImage = coverImage;
    _name = name;
    _country = country;
    _profileImage = profileImage;
    _token = token;
    _channel = channel;
    _coin = coin;
    _userId = userId;
    _dob = dob;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  LiveHost.fromJson(dynamic json) {
    _id = json['_id'];
    _diamond = json['diamond'];
    if (json['view'] != null) {
      _view = [];
      json['view'].forEach((v) {
        _view?.add(View.fromJson(v));
      });
    }
    _liveStreamingId = json['liveStreamingId'];
    _coverImage = json['coverImage'];
    _name = json['name'];
    _country = json['country'];
    _profileImage = json['profileImage'];
    _token = json['token'];
    _channel = json['channel'];
    _coin = json['coin'];
    _userId = json['userId'];
    _dob = json['dob'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
  }
  String? _id;
  num? _diamond;
  List<View>? _view;
  String? _liveStreamingId;
  String? _coverImage;
  String? _name;
  String? _country;
  String? _profileImage;
  String? _token;
  String? _channel;
  num? _coin;
  String? _userId;
  String? _dob;
  String? _createdAt;
  String? _updatedAt;
  LiveHost copyWith({
    String? id,
    num? diamond,
    List<View>? view,
    String? liveStreamingId,
    String? coverImage,
    String? name,
    String? country,
    String? profileImage,
    String? token,
    String? channel,
    num? coin,
    String? userId,
    String? dob,
    String? createdAt,
    String? updatedAt,
  }) =>
      LiveHost(
        id: id ?? _id,
        diamond: diamond ?? _diamond,
        view: view ?? _view,
        liveStreamingId: liveStreamingId ?? _liveStreamingId,
        coverImage: coverImage ?? _coverImage,
        name: name ?? _name,
        country: country ?? _country,
        profileImage: profileImage ?? _profileImage,
        token: token ?? _token,
        channel: channel ?? _channel,
        coin: coin ?? _coin,
        userId: userId ?? _userId,
        dob: dob ?? _dob,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
      );
  String? get id => _id;
  num? get diamond => _diamond;
  List<View>? get view => _view;
  String? get liveStreamingId => _liveStreamingId;
  String? get coverImage => _coverImage;
  String? get name => _name;
  String? get country => _country;
  String? get profileImage => _profileImage;
  String? get token => _token;
  String? get channel => _channel;
  num? get coin => _coin;
  String? get userId => _userId;
  String? get dob => _dob;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['diamond'] = _diamond;
    if (_view != null) {
      map['view'] = _view?.map((v) => v.toJson()).toList();
    }
    map['liveStreamingId'] = _liveStreamingId;
    map['coverImage'] = _coverImage;
    map['name'] = _name;
    map['country'] = _country;
    map['profileImage'] = _profileImage;
    map['token'] = _token;
    map['channel'] = _channel;
    map['coin'] = _coin;
    map['userId'] = _userId;
    map['dob'] = _dob;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    return map;
  }
}

View viewFromJson(String str) => View.fromJson(json.decode(str));
String viewToJson(View data) => json.encode(data.toJson());

class View {
  View({
    String? userId,
    String? name,
    String? profileImage,
    String? liveStreamingId,
    bool? isAdd,
  }) {
    _userId = userId;
    _name = name;
    _profileImage = profileImage;
    _liveStreamingId = liveStreamingId;
    _isAdd = isAdd;
  }

  View.fromJson(dynamic json) {
    _userId = json['userId'];
    _name = json['name'];
    _profileImage = json['profileImage'];
    _liveStreamingId = json['liveStreamingId'];
    _isAdd = json['isAdd'];
  }
  String? _userId;
  String? _name;
  String? _profileImage;
  String? _liveStreamingId;
  bool? _isAdd;
  View copyWith({
    String? userId,
    String? name,
    String? profileImage,
    String? liveStreamingId,
    bool? isAdd,
  }) =>
      View(
        userId: userId ?? _userId,
        name: name ?? _name,
        profileImage: profileImage ?? _profileImage,
        liveStreamingId: liveStreamingId ?? _liveStreamingId,
        isAdd: isAdd ?? _isAdd,
      );
  String? get userId => _userId;
  String? get name => _name;
  String? get profileImage => _profileImage;
  String? get liveStreamingId => _liveStreamingId;
  bool? get isAdd => _isAdd;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['userId'] = _userId;
    map['name'] = _name;
    map['profileImage'] = _profileImage;
    map['liveStreamingId'] = _liveStreamingId;
    map['isAdd'] = _isAdd;
    return map;
  }
}
