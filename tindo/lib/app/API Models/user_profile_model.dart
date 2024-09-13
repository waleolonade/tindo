import 'dart:convert';

UserProfileModel userProfileModelFromJson(String str) =>
    UserProfileModel.fromJson(json.decode(str));
String userProfileModelToJson(UserProfileModel data) =>
    json.encode(data.toJson());

class UserProfileModel {
  UserProfileModel({
    bool? status,
    String? message,
    UserProfile? userProfile,
  }) {
    _status = status;
    _message = message;
    _userProfile = userProfile;
  }

  UserProfileModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _userProfile = json['userProfile'] != null
        ? UserProfile.fromJson(json['userProfile'])
        : null;
  }
  bool? _status;
  String? _message;
  UserProfile? _userProfile;
  UserProfileModel copyWith({
    bool? status,
    String? message,
    UserProfile? userProfile,
  }) =>
      UserProfileModel(
        status: status ?? _status,
        message: message ?? _message,
        userProfile: userProfile ?? _userProfile,
      );
  bool? get status => _status;
  String? get message => _message;
  UserProfile? get userProfile => _userProfile;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_userProfile != null) {
      map['userProfile'] = _userProfile?.toJson();
    }
    return map;
  }
}

UserProfile userProfileFromJson(String str) =>
    UserProfile.fromJson(json.decode(str));
String userProfileToJson(UserProfile data) => json.encode(data.toJson());

class UserProfile {
  UserProfile({
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
    num? coin,
    String? country,
    bool? isOnline,
    bool? isBusy,
    bool? isLive,
    bool? isBlock,
    String? identity,
    String? fcmToken,
    num? loginType,
    String? gender,
    String? createdAt,
    num? diamond,
    List<UserPost>? userPost,
    num? totalLike,
    num? totalPost,
    num? following,
    num? followers,
    String? friends,
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
    _coin = coin;
    _country = country;
    _isOnline = isOnline;
    _isBusy = isBusy;
    _isLive = isLive;
    _isBlock = isBlock;
    _identity = identity;
    _fcmToken = fcmToken;
    _loginType = loginType;
    _gender = gender;
    _createdAt = createdAt;
    _diamond = diamond;
    _userPost = userPost;
    _totalLike = totalLike;
    _totalPost = totalPost;
    _following = following;
    _followers = followers;
    _friends = friends;
  }

  UserProfile.fromJson(dynamic json) {
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
    _coin = json['coin'];
    _country = json['country'];
    _isOnline = json['isOnline'];
    _isBusy = json['isBusy'];
    _isLive = json['isLive'];
    _isBlock = json['isBlock'];
    _identity = json['identity'];
    _fcmToken = json['fcm_token'];
    _loginType = json['loginType'];
    _gender = json['gender'];
    _createdAt = json['createdAt'];
    _diamond = json['diamond'];
    if (json['userPost'] != null) {
      _userPost = [];
      json['userPost'].forEach((v) {
        _userPost?.add(UserPost.fromJson(v));
      });
    }
    _totalLike = json['totalLike'];
    _totalPost = json['TotalPost'];
    _following = json['following'];
    _followers = json['followers'];
    _friends = json['friends'];
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
  num? _coin;
  String? _country;
  bool? _isOnline;
  bool? _isBusy;
  bool? _isLive;
  bool? _isBlock;
  String? _identity;
  String? _fcmToken;
  num? _loginType;
  String? _gender;
  String? _createdAt;
  num? _diamond;
  List<UserPost>? _userPost;
  num? _totalLike;
  num? _totalPost;
  num? _following;
  num? _followers;
  String? _friends;
  UserProfile copyWith({
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
    num? coin,
    String? country,
    bool? isOnline,
    bool? isBusy,
    bool? isLive,
    bool? isBlock,
    String? identity,
    String? fcmToken,
    num? loginType,
    String? gender,
    String? createdAt,
    num? diamond,
    List<UserPost>? userPost,
    num? totalLike,
    num? totalPost,
    num? following,
    num? followers,
    String? friends,
  }) =>
      UserProfile(
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
        coin: coin ?? _coin,
        country: country ?? _country,
        isOnline: isOnline ?? _isOnline,
        isBusy: isBusy ?? _isBusy,
        isLive: isLive ?? _isLive,
        isBlock: isBlock ?? _isBlock,
        identity: identity ?? _identity,
        fcmToken: fcmToken ?? _fcmToken,
        loginType: loginType ?? _loginType,
        gender: gender ?? _gender,
        createdAt: createdAt ?? _createdAt,
        diamond: diamond ?? _diamond,
        userPost: userPost ?? _userPost,
        totalLike: totalLike ?? _totalLike,
        totalPost: totalPost ?? _totalPost,
        following: following ?? _following,
        followers: followers ?? _followers,
        friends: friends ?? _friends,
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
  num? get coin => _coin;
  String? get country => _country;
  bool? get isOnline => _isOnline;
  bool? get isBusy => _isBusy;
  bool? get isLive => _isLive;
  bool? get isBlock => _isBlock;
  String? get identity => _identity;
  String? get fcmToken => _fcmToken;
  num? get loginType => _loginType;
  String? get gender => _gender;
  String? get createdAt => _createdAt;
  num? get diamond => _diamond;
  List<UserPost>? get userPost => _userPost;
  num? get totalLike => _totalLike;
  num? get totalPost => _totalPost;
  num? get following => _following;
  num? get followers => _followers;
  String? get friends => _friends;

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
    map['coin'] = _coin;
    map['country'] = _country;
    map['isOnline'] = _isOnline;
    map['isBusy'] = _isBusy;
    map['isLive'] = _isLive;
    map['isBlock'] = _isBlock;
    map['identity'] = _identity;
    map['fcm_token'] = _fcmToken;
    map['loginType'] = _loginType;
    map['gender'] = _gender;
    map['createdAt'] = _createdAt;
    map['diamond'] = _diamond;
    if (_userPost != null) {
      map['userPost'] = _userPost?.map((v) => v.toJson()).toList();
    }
    map['totalLike'] = _totalLike;
    map['TotalPost'] = _totalPost;
    map['following'] = _following;
    map['followers'] = _followers;
    map['friends'] = _friends;
    return map;
  }
}

UserPost userPostFromJson(String str) => UserPost.fromJson(json.decode(str));
String userPostToJson(UserPost data) => json.encode(data.toJson());

class UserPost {
  UserPost({
    String? id,
    String? description,
    String? userId,
    String? postImage,
    String? createdAt,
    num? like,
  }) {
    _id = id;
    _description = description;
    _userId = userId;
    _postImage = postImage;
    _createdAt = createdAt;
    _like = like;
  }

  UserPost.fromJson(dynamic json) {
    _id = json['_id'];
    _description = json['description'];
    _userId = json['userId'];
    _postImage = json['postImage'];
    _createdAt = json['createdAt'];
    _like = json['like'];
  }
  String? _id;
  String? _description;
  String? _userId;
  String? _postImage;
  String? _createdAt;
  num? _like;
  UserPost copyWith({
    String? id,
    String? description,
    String? userId,
    String? postImage,
    String? createdAt,
    num? like,
  }) =>
      UserPost(
        id: id ?? _id,
        description: description ?? _description,
        userId: userId ?? _userId,
        postImage: postImage ?? _postImage,
        createdAt: createdAt ?? _createdAt,
        like: like ?? _like,
      );
  String? get id => _id;
  String? get description => _description;
  String? get userId => _userId;
  String? get postImage => _postImage;
  String? get createdAt => _createdAt;
  num? get like => _like;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['description'] = _description;
    map['userId'] = _userId;
    map['postImage'] = _postImage;
    map['createdAt'] = _createdAt;
    map['like'] = _like;
    return map;
  }
}
