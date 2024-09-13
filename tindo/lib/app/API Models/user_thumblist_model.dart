import 'dart:convert';

UserThumbListModel userThumbListModelFromJson(String str) =>
    UserThumbListModel.fromJson(json.decode(str));
String userThumbListModelToJson(UserThumbListModel data) =>
    json.encode(data.toJson());

class UserThumbListModel {
  UserThumbListModel({
    bool? status,
    String? message,
    List<User>? user,
  }) {
    _status = status;
    _message = message;
    _user = user;
  }

  UserThumbListModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['user'] != null) {
      _user = [];
      json['user'].forEach((v) {
        _user?.add(User.fromJson(v));
      });
    }
  }
  bool? _status;
  String? _message;
  List<User>? _user;
  UserThumbListModel copyWith({
    bool? status,
    String? message,
    List<User>? user,
  }) =>
      UserThumbListModel(
        status: status ?? _status,
        message: message ?? _message,
        user: user ?? _user,
      );
  bool? get status => _status;
  String? get message => _message;
  List<User>? get user => _user;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_user != null) {
      map['user'] = _user?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

User userFromJson(String str) => User.fromJson(json.decode(str));
String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    String? id,
    num? diamond,
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
    bool? isFake,
    String? video,
    num? totalUser,
    String? friends,
  }) {
    _id = id;
    _diamond = diamond;
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
    _isFake = isFake;
    _video = video;
    _totalUser = totalUser;
    _friends = friends;
  }

  User.fromJson(dynamic json) {
    _id = json['_id'];
    _diamond = json['diamond'];
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
    _isFake = json['isFake'];
    _video = json['video'];
    _totalUser = json['totalUser'];
    _friends = json['friends'];
  }
  String? _id;
  num? _diamond;
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
  bool? _isFake;
  String? _video;
  num? _totalUser;
  String? _friends;
  User copyWith({
    String? id,
    num? diamond,
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
    bool? isFake,
    String? video,
    num? totalUser,
    String? friends,
  }) =>
      User(
        id: id ?? _id,
        diamond: diamond ?? _diamond,
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
        isFake: isFake ?? _isFake,
        video: video ?? _video,
        totalUser: totalUser ?? _totalUser,
        friends: friends ?? _friends,
      );
  String? get id => _id;
  num? get diamond => _diamond;
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
  bool? get isFake => _isFake;
  String? get video => _video;
  num? get totalUser => _totalUser;
  String? get friends => _friends;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['diamond'] = _diamond;
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
    map['isFake'] = _isFake;
    map['video'] = _video;
    map['totalUser'] = _totalUser;
    map['friends'] = _friends;
    return map;
  }
}
