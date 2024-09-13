import 'dart:convert';

/// status : true
/// message : "Successfully Request Show......!"

FollowingModel followingModelFromJson(String str) =>
    FollowingModel.fromJson(json.decode(str));
String followingModelToJson(FollowingModel data) => json.encode(data.toJson());

class FollowingModel {
  FollowingModel({
    bool? status,
    String? message,
    List<UserFollow>? userFollow,
  }) {
    _status = status;
    _message = message;
    _userFollow = userFollow;
  }

  FollowingModel.fromJson(dynamic json) {
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
  FollowingModel copyWith({
    bool? status,
    String? message,
    List<UserFollow>? userFollow,
  }) =>
      FollowingModel(
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
    String? from,
    To? to,
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
    _from = json['from'];
    _to = json['to'] != null ? To.fromJson(json['to']) : null;
    _createdAt = json['createdAt'];
  }
  String? _id;
  bool? _friends;
  String? _from;
  To? _to;
  String? _createdAt;
  UserFollow copyWith({
    String? id,
    bool? friends,
    String? from,
    To? to,
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
  String? get from => _from;
  To? get to => _to;
  String? get createdAt => _createdAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['friends'] = _friends;
    map['from'] = _from;
    if (_to != null) {
      map['to'] = _to?.toJson();
    }
    map['createdAt'] = _createdAt;
    return map;
  }
}

To toFromJson(String str) => To.fromJson(json.decode(str));
String toToJson(To data) => json.encode(data.toJson());

class To {
  To({
    String? id,
    Plan? plan,
    String? name,
    String? bio,
    num? platformType,
    String? email,
    String? token,
    String? channel,
    String? liveStreamingId,
    num? agoraUID,
    num? withdrawalDiamond,
    dynamic mobileNumber,
    String? profileImage,
    dynamic coverImage,
    String? dob,
    num? diamond,
    num? coin,
    String? country,
    bool? isOnline,
    bool? isBusy,
    bool? isLive,
    bool? isBlock,
    bool? isFake,
    bool? isCoinPlan,
    num? purchasedCoin,
    num? followers,
    num? following,
    num? uniqueId,
    String? date,
    String? identity,
    String? fcmToken,
    num? loginType,
    String? gender,
    String? createdAt,
    String? updatedAt,
  }) {
    _id = id;
    _plan = plan;
    _name = name;
    _bio = bio;
    _platformType = platformType;
    _email = email;
    _token = token;
    _channel = channel;
    _liveStreamingId = liveStreamingId;
    _agoraUID = agoraUID;
    _withdrawalDiamond = withdrawalDiamond;
    _mobileNumber = mobileNumber;
    _profileImage = profileImage;
    _coverImage = coverImage;
    _dob = dob;
    _diamond = diamond;
    _coin = coin;
    _country = country;
    _isOnline = isOnline;
    _isBusy = isBusy;
    _isLive = isLive;
    _isBlock = isBlock;
    _isFake = isFake;
    _isCoinPlan = isCoinPlan;
    _purchasedCoin = purchasedCoin;
    _followers = followers;
    _following = following;
    _uniqueId = uniqueId;
    _date = date;
    _identity = identity;
    _fcmToken = fcmToken;
    _loginType = loginType;
    _gender = gender;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  To.fromJson(dynamic json) {
    _id = json['_id'];
    _plan = json['plan'] != null ? Plan.fromJson(json['plan']) : null;
    _name = json['name'];
    _bio = json['bio'];
    _platformType = json['platformType'];
    _email = json['email'];
    _token = json['token'];
    _channel = json['channel'];
    _liveStreamingId = json['liveStreamingId'];
    _agoraUID = json['agoraUID'];
    _withdrawalDiamond = json['withdrawalDiamond'];
    _mobileNumber = json['mobileNumber'];
    _profileImage = json['profileImage'];
    _coverImage = json['coverImage'];
    _dob = json['dob'];
    _diamond = json['diamond'];
    _coin = json['coin'];
    _country = json['country'];
    _isOnline = json['isOnline'];
    _isBusy = json['isBusy'];
    _isLive = json['isLive'];
    _isBlock = json['isBlock'];
    _isFake = json['isFake'];
    _isCoinPlan = json['isCoinPlan'];
    _purchasedCoin = json['purchasedCoin'];
    _followers = json['followers'];
    _following = json['following'];
    _uniqueId = json['uniqueId'];
    _date = json['date'];
    _identity = json['identity'];
    _fcmToken = json['fcm_token'];
    _loginType = json['loginType'];
    _gender = json['gender'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
  }
  String? _id;
  Plan? _plan;
  String? _name;
  String? _bio;
  num? _platformType;
  String? _email;
  String? _token;
  String? _channel;
  String? _liveStreamingId;
  num? _agoraUID;
  num? _withdrawalDiamond;
  dynamic _mobileNumber;
  String? _profileImage;
  dynamic _coverImage;
  String? _dob;
  num? _diamond;
  num? _coin;
  String? _country;
  bool? _isOnline;
  bool? _isBusy;
  bool? _isLive;
  bool? _isBlock;
  bool? _isFake;
  bool? _isCoinPlan;
  num? _purchasedCoin;
  num? _followers;
  num? _following;
  num? _uniqueId;
  String? _date;
  String? _identity;
  String? _fcmToken;
  num? _loginType;
  String? _gender;
  String? _createdAt;
  String? _updatedAt;
  To copyWith({
    String? id,
    Plan? plan,
    String? name,
    String? bio,
    num? platformType,
    String? email,
    String? token,
    String? channel,
    String? liveStreamingId,
    num? agoraUID,
    num? withdrawalDiamond,
    dynamic mobileNumber,
    String? profileImage,
    dynamic coverImage,
    String? dob,
    num? diamond,
    num? coin,
    String? country,
    bool? isOnline,
    bool? isBusy,
    bool? isLive,
    bool? isBlock,
    bool? isFake,
    bool? isCoinPlan,
    num? purchasedCoin,
    num? followers,
    num? following,
    num? uniqueId,
    String? date,
    String? identity,
    String? fcmToken,
    num? loginType,
    String? gender,
    String? createdAt,
    String? updatedAt,
  }) =>
      To(
        id: id ?? _id,
        plan: plan ?? _plan,
        name: name ?? _name,
        bio: bio ?? _bio,
        platformType: platformType ?? _platformType,
        email: email ?? _email,
        token: token ?? _token,
        channel: channel ?? _channel,
        liveStreamingId: liveStreamingId ?? _liveStreamingId,
        agoraUID: agoraUID ?? _agoraUID,
        withdrawalDiamond: withdrawalDiamond ?? _withdrawalDiamond,
        mobileNumber: mobileNumber ?? _mobileNumber,
        profileImage: profileImage ?? _profileImage,
        coverImage: coverImage ?? _coverImage,
        dob: dob ?? _dob,
        diamond: diamond ?? _diamond,
        coin: coin ?? _coin,
        country: country ?? _country,
        isOnline: isOnline ?? _isOnline,
        isBusy: isBusy ?? _isBusy,
        isLive: isLive ?? _isLive,
        isBlock: isBlock ?? _isBlock,
        isFake: isFake ?? _isFake,
        isCoinPlan: isCoinPlan ?? _isCoinPlan,
        purchasedCoin: purchasedCoin ?? _purchasedCoin,
        followers: followers ?? _followers,
        following: following ?? _following,
        uniqueId: uniqueId ?? _uniqueId,
        date: date ?? _date,
        identity: identity ?? _identity,
        fcmToken: fcmToken ?? _fcmToken,
        loginType: loginType ?? _loginType,
        gender: gender ?? _gender,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
      );
  String? get id => _id;
  Plan? get plan => _plan;
  String? get name => _name;
  String? get bio => _bio;
  num? get platformType => _platformType;
  String? get email => _email;
  String? get token => _token;
  String? get channel => _channel;
  String? get liveStreamingId => _liveStreamingId;
  num? get agoraUID => _agoraUID;
  num? get withdrawalDiamond => _withdrawalDiamond;
  dynamic get mobileNumber => _mobileNumber;
  String? get profileImage => _profileImage;
  dynamic get coverImage => _coverImage;
  String? get dob => _dob;
  num? get diamond => _diamond;
  num? get coin => _coin;
  String? get country => _country;
  bool? get isOnline => _isOnline;
  bool? get isBusy => _isBusy;
  bool? get isLive => _isLive;
  bool? get isBlock => _isBlock;
  bool? get isFake => _isFake;
  bool? get isCoinPlan => _isCoinPlan;
  num? get purchasedCoin => _purchasedCoin;
  num? get followers => _followers;
  num? get following => _following;
  num? get uniqueId => _uniqueId;
  String? get date => _date;
  String? get identity => _identity;
  String? get fcmToken => _fcmToken;
  num? get loginType => _loginType;
  String? get gender => _gender;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    if (_plan != null) {
      map['plan'] = _plan?.toJson();
    }
    map['name'] = _name;
    map['bio'] = _bio;
    map['platformType'] = _platformType;
    map['email'] = _email;
    map['token'] = _token;
    map['channel'] = _channel;
    map['liveStreamingId'] = _liveStreamingId;
    map['agoraUID'] = _agoraUID;
    map['withdrawalDiamond'] = _withdrawalDiamond;
    map['mobileNumber'] = _mobileNumber;
    map['profileImage'] = _profileImage;
    map['coverImage'] = _coverImage;
    map['dob'] = _dob;
    map['diamond'] = _diamond;
    map['coin'] = _coin;
    map['country'] = _country;
    map['isOnline'] = _isOnline;
    map['isBusy'] = _isBusy;
    map['isLive'] = _isLive;
    map['isBlock'] = _isBlock;
    map['isFake'] = _isFake;
    map['isCoinPlan'] = _isCoinPlan;
    map['purchasedCoin'] = _purchasedCoin;
    map['followers'] = _followers;
    map['following'] = _following;
    map['uniqueId'] = _uniqueId;
    map['date'] = _date;
    map['identity'] = _identity;
    map['fcm_token'] = _fcmToken;
    map['loginType'] = _loginType;
    map['gender'] = _gender;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    return map;
  }
}

/// coinPlanId : null

Plan planFromJson(String str) => Plan.fromJson(json.decode(str));
String planToJson(Plan data) => json.encode(data.toJson());

class Plan {
  Plan({
    dynamic coinPlanId,
  }) {
    _coinPlanId = coinPlanId;
  }

  Plan.fromJson(dynamic json) {
    _coinPlanId = json['coinPlanId'];
  }
  dynamic _coinPlanId;
  Plan copyWith({
    dynamic coinPlanId,
  }) =>
      Plan(
        coinPlanId: coinPlanId ?? _coinPlanId,
      );
  dynamic get coinPlanId => _coinPlanId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['coinPlanId'] = _coinPlanId;
    return map;
  }
}
