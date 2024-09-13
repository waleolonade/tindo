import 'dart:convert';

LoginModel loginModelFromJson(String str) =>
    LoginModel.fromJson(json.decode(str));
String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  LoginModel({
    bool? status,
    String? message,
    User? user,
  }) {
    _status = status;
    _message = message;
    _user = user;
  }

  LoginModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _user = json['user'] != null ? User.fromJson(json['user']) : null;
  }
  bool? _status;
  String? _message;
  User? _user;
  LoginModel copyWith({
    bool? status,
    String? message,
    User? user,
  }) =>
      LoginModel(
        status: status ?? _status,
        message: message ?? _message,
        user: user ?? _user,
      );
  bool? get status => _status;
  String? get message => _message;
  User? get user => _user;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_user != null) {
      map['user'] = _user?.toJson();
    }
    return map;
  }
}

User userFromJson(String str) => User.fromJson(json.decode(str));
String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    String? id,
    String? name,
    String? bio,
    num? platformType,
    String? email,
    dynamic token,
    dynamic channel,
    dynamic liveStreamingId,
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
    _liveStreamingId = liveStreamingId;
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

  User.fromJson(dynamic json) {
    _id = json['_id'];
    _name = json['name'];
    _bio = json['bio'];
    _platformType = json['platformType'];
    _email = json['email'];
    _token = json['token'];
    _channel = json['channel'];
    _liveStreamingId = json['liveStreamingId'];
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
  dynamic _liveStreamingId;
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
  User copyWith({
    String? id,
    String? name,
    String? bio,
    num? platformType,
    String? email,
    dynamic token,
    dynamic channel,
    dynamic liveStreamingId,
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
      User(
        id: id ?? _id,
        name: name ?? _name,
        bio: bio ?? _bio,
        platformType: platformType ?? _platformType,
        email: email ?? _email,
        token: token ?? _token,
        channel: channel ?? _channel,
        liveStreamingId: liveStreamingId ?? _liveStreamingId,
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
  dynamic get liveStreamingId => _liveStreamingId;
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
    map['liveStreamingId'] = _liveStreamingId;
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
