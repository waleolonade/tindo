import 'dart:convert';

FollowersModel followersModelFromJson(String str) =>
    FollowersModel.fromJson(json.decode(str));
String followersModelToJson(FollowersModel data) => json.encode(data.toJson());

class FollowersModel {
  FollowersModel({
    bool? status,
    String? message,
    List<UserFollow>? userFollow,
  }) {
    _status = status;
    _message = message;
    _userFollow = userFollow;
  }

  FollowersModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['userFollow'] != null) {
      _userFollow = [];
      json['userFollow'].forEach((v) {
        _userFollow?.add(UserFollow.fromJson(v));
      });
    }
  }
  bool? _status;
  String? _message;
  List<UserFollow>? _userFollow;
  FollowersModel copyWith({
    bool? status,
    String? message,
    List<UserFollow>? userFollow,
  }) =>
      FollowersModel(
        status: status ?? _status,
        message: message ?? _message,
        userFollow: userFollow ?? _userFollow,
      );
  bool? get status => _status;
  String? get message => _message;
  List<UserFollow>? get userFollow => _userFollow;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_userFollow != null) {
      map['userFollow'] = _userFollow?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

UserFollow userFollowFromJson(String str) =>
    UserFollow.fromJson(json.decode(str));
String userFollowToJson(UserFollow data) => json.encode(data.toJson());

class UserFollow {
  UserFollow({
    String? id,
    bool? friends,
    List<From>? from,
    String? to,
    String? createdAt,
  }) {
    _id = id;
    _friends = friends;
    _from = from;
    _to = to;
    _createdAt = createdAt;
  }

  UserFollow.fromJson(dynamic json) {
    _id = json['_id'];
    _friends = json['friends'];
    if (json['from'] != null) {
      _from = [];
      json['from'].forEach((v) {
        _from?.add(From.fromJson(v));
      });
    }
    _to = json['to'];
    _createdAt = json['createdAt'];
  }
  String? _id;
  bool? _friends;
  List<From>? _from;
  String? _to;
  String? _createdAt;
  UserFollow copyWith({
    String? id,
    bool? friends,
    List<From>? from,
    String? to,
    String? createdAt,
  }) =>
      UserFollow(
        id: id ?? _id,
        friends: friends ?? _friends,
        from: from ?? _from,
        to: to ?? _to,
        createdAt: createdAt ?? _createdAt,
      );
  String? get id => _id;
  bool? get friends => _friends;
  List<From>? get from => _from;
  String? get to => _to;
  String? get createdAt => _createdAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['friends'] = _friends;
    if (_from != null) {
      map['from'] = _from?.map((v) => v.toJson()).toList();
    }
    map['to'] = _to;
    map['createdAt'] = _createdAt;
    return map;
  }
}

From fromFromJson(String str) => From.fromJson(json.decode(str));
String fromToJson(From data) => json.encode(data.toJson());

class From {
  From({
    String? id,
    String? name,
    String? bio,
    num? platformType,
    String? email,
    dynamic token,
    dynamic channel,
    dynamic mobileNumber,
    String? profileImage,
    dynamic coverImage,
    String? dob,
    num? earnDiamond,
    num? coin,
    String? country,
    bool? isOnline,
    bool? isBusy,
    bool? isLive,
    bool? isBlock,
    num? followers,
    num? following,
    String? identity,
    String? fcmToken,
    num? loginType,
    String? gender,
    String? createdAt,
    String? updatedAt,
  }) {
    _id = id;
    _name = name;
    _bio = bio;
    _platformType = platformType;
    _email = email;
    _token = token;
    _channel = channel;
    _mobileNumber = mobileNumber;
    _profileImage = profileImage;
    _coverImage = coverImage;
    _dob = dob;
    _earnDiamond = earnDiamond;
    _coin = coin;
    _country = country;
    _isOnline = isOnline;
    _isBusy = isBusy;
    _isLive = isLive;
    _isBlock = isBlock;
    _followers = followers;
    _following = following;
    _identity = identity;
    _fcmToken = fcmToken;
    _loginType = loginType;
    _gender = gender;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  From.fromJson(dynamic json) {
    _id = json['_id'];
    _name = json['name'];
    _bio = json['bio'];
    _platformType = json['platformType'];
    _email = json['email'];
    _token = json['token'];
    _channel = json['channel'];
    _mobileNumber = json['mobileNumber'];
    _profileImage = json['profileImage'];
    _coverImage = json['coverImage'];
    _dob = json['dob'];
    _earnDiamond = json['earnDiamond'];
    _coin = json['coin'];
    _country = json['country'];
    _isOnline = json['isOnline'];
    _isBusy = json['isBusy'];
    _isLive = json['isLive'];
    _isBlock = json['isBlock'];
    _followers = json['followers'];
    _following = json['following'];
    _identity = json['identity'];
    _fcmToken = json['fcm_token'];
    _loginType = json['loginType'];
    _gender = json['gender'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
  }
  String? _id;
  String? _name;
  String? _bio;
  num? _platformType;
  String? _email;
  dynamic _token;
  dynamic _channel;
  dynamic _mobileNumber;
  String? _profileImage;
  dynamic _coverImage;
  String? _dob;
  num? _earnDiamond;
  num? _coin;
  String? _country;
  bool? _isOnline;
  bool? _isBusy;
  bool? _isLive;
  bool? _isBlock;
  num? _followers;
  num? _following;
  String? _identity;
  String? _fcmToken;
  num? _loginType;
  String? _gender;
  String? _createdAt;
  String? _updatedAt;
  From copyWith({
    String? id,
    String? name,
    String? bio,
    num? platformType,
    String? email,
    dynamic token,
    dynamic channel,
    dynamic mobileNumber,
    String? profileImage,
    dynamic coverImage,
    String? dob,
    num? earnDiamond,
    num? coin,
    String? country,
    bool? isOnline,
    bool? isBusy,
    bool? isLive,
    bool? isBlock,
    num? followers,
    num? following,
    String? identity,
    String? fcmToken,
    num? loginType,
    String? gender,
    String? createdAt,
    String? updatedAt,
  }) =>
      From(
        id: id ?? _id,
        name: name ?? _name,
        bio: bio ?? _bio,
        platformType: platformType ?? _platformType,
        email: email ?? _email,
        token: token ?? _token,
        channel: channel ?? _channel,
        mobileNumber: mobileNumber ?? _mobileNumber,
        profileImage: profileImage ?? _profileImage,
        coverImage: coverImage ?? _coverImage,
        dob: dob ?? _dob,
        earnDiamond: earnDiamond ?? _earnDiamond,
        coin: coin ?? _coin,
        country: country ?? _country,
        isOnline: isOnline ?? _isOnline,
        isBusy: isBusy ?? _isBusy,
        isLive: isLive ?? _isLive,
        isBlock: isBlock ?? _isBlock,
        followers: followers ?? _followers,
        following: following ?? _following,
        identity: identity ?? _identity,
        fcmToken: fcmToken ?? _fcmToken,
        loginType: loginType ?? _loginType,
        gender: gender ?? _gender,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
      );
  String? get id => _id;
  String? get name => _name;
  String? get bio => _bio;
  num? get platformType => _platformType;
  String? get email => _email;
  dynamic get token => _token;
  dynamic get channel => _channel;
  dynamic get mobileNumber => _mobileNumber;
  String? get profileImage => _profileImage;
  dynamic get coverImage => _coverImage;
  String? get dob => _dob;
  num? get earnDiamond => _earnDiamond;
  num? get coin => _coin;
  String? get country => _country;
  bool? get isOnline => _isOnline;
  bool? get isBusy => _isBusy;
  bool? get isLive => _isLive;
  bool? get isBlock => _isBlock;
  num? get followers => _followers;
  num? get following => _following;
  String? get identity => _identity;
  String? get fcmToken => _fcmToken;
  num? get loginType => _loginType;
  String? get gender => _gender;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['name'] = _name;
    map['bio'] = _bio;
    map['platformType'] = _platformType;
    map['email'] = _email;
    map['token'] = _token;
    map['channel'] = _channel;
    map['mobileNumber'] = _mobileNumber;
    map['profileImage'] = _profileImage;
    map['coverImage'] = _coverImage;
    map['dob'] = _dob;
    map['earnDiamond'] = _earnDiamond;
    map['coin'] = _coin;
    map['country'] = _country;
    map['isOnline'] = _isOnline;
    map['isBusy'] = _isBusy;
    map['isLive'] = _isLive;
    map['isBlock'] = _isBlock;
    map['followers'] = _followers;
    map['following'] = _following;
    map['identity'] = _identity;
    map['fcm_token'] = _fcmToken;
    map['loginType'] = _loginType;
    map['gender'] = _gender;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    return map;
  }
}
