import 'dart:convert';

GetUserProfileModel getUserProfileModelFromJson(String str) =>
    GetUserProfileModel.fromJson(json.decode(str));
String getUserProfileModelToJson(GetUserProfileModel data) =>
    json.encode(data.toJson());

class GetUserProfileModel {
  GetUserProfileModel({
    bool? status,
    String? message,
    UserProfile? userProfile,
  }) {
    _status = status;
    _message = message;
    _userProfile = userProfile;
  }

  GetUserProfileModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _userProfile = json['userProfile'] != null
        ? UserProfile.fromJson(json['userProfile'])
        : null;
  }
  bool? _status;
  String? _message;
  UserProfile? _userProfile;
  GetUserProfileModel copyWith({
    bool? status,
    String? message,
    UserProfile? userProfile,
  }) =>
      GetUserProfileModel(
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
    String? profileImage,
    String? dob,
    num? diamond,
    num? coin,
    String? country,
    bool? isOnline,
    bool? isBusy,
    bool? isLive,
    bool? isBlock,
    num? uniqueId,
    String? identity,
    String? fcmToken,
    num? loginType,
    String? gender,
    String? createdAt,
    bool? isFake,
    List<UserPost>? userPost,
    String? token,
    String? channel,
    String? mobileNumber,
    String? coverImage,
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
    _profileImage = profileImage;
    _dob = dob;
    _diamond = diamond;
    _coin = coin;
    _country = country;
    _isOnline = isOnline;
    _isBusy = isBusy;
    _isLive = isLive;
    _isBlock = isBlock;
    _uniqueId = uniqueId;
    _identity = identity;
    _fcmToken = fcmToken;
    _loginType = loginType;
    _gender = gender;
    _createdAt = createdAt;
    _isFake = isFake;
    _userPost = userPost;
    _token = token;
    _channel = channel;
    _mobileNumber = mobileNumber;
    _coverImage = coverImage;
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
    _profileImage = json['profileImage'];
    _dob = json['dob'];
    _diamond = json['diamond'];
    _coin = json['coin'];
    _country = json['country'];
    _isOnline = json['isOnline'];
    _isBusy = json['isBusy'];
    _isLive = json['isLive'];
    _isBlock = json['isBlock'];
    _uniqueId = json['uniqueId'];
    _identity = json['identity'];
    _fcmToken = json['fcm_token'];
    _loginType = json['loginType'];
    _gender = json['gender'];
    _createdAt = json['createdAt'];
    _isFake = json['isFake'];
    if (json['userPost'] != null) {
      _userPost = [];
      json['userPost'].forEach((v) {
        _userPost?.add(UserPost.fromJson(v));
      });
    }
    _token = json['token'];
    _channel = json['channel'];
    _mobileNumber = json['mobileNumber'];
    _coverImage = json['coverImage'];
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
  String? _profileImage;
  String? _dob;
  num? _diamond;
  num? _coin;
  String? _country;
  bool? _isOnline;
  bool? _isBusy;
  bool? _isLive;
  bool? _isBlock;
  num? _uniqueId;
  String? _identity;
  String? _fcmToken;
  num? _loginType;
  String? _gender;
  String? _createdAt;
  bool? _isFake;
  List<UserPost>? _userPost;
  String? _token;
  String? _channel;
  String? _mobileNumber;
  String? _coverImage;
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
    String? profileImage,
    String? dob,
    num? diamond,
    num? coin,
    String? country,
    bool? isOnline,
    bool? isBusy,
    bool? isLive,
    bool? isBlock,
    num? uniqueId,
    String? identity,
    String? fcmToken,
    num? loginType,
    String? gender,
    String? createdAt,
    bool? isFake,
    List<UserPost>? userPost,
    String? token,
    String? channel,
    String? mobileNumber,
    String? coverImage,
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
        profileImage: profileImage ?? _profileImage,
        dob: dob ?? _dob,
        diamond: diamond ?? _diamond,
        coin: coin ?? _coin,
        country: country ?? _country,
        isOnline: isOnline ?? _isOnline,
        isBusy: isBusy ?? _isBusy,
        isLive: isLive ?? _isLive,
        isBlock: isBlock ?? _isBlock,
        uniqueId: uniqueId ?? _uniqueId,
        identity: identity ?? _identity,
        fcmToken: fcmToken ?? _fcmToken,
        loginType: loginType ?? _loginType,
        gender: gender ?? _gender,
        createdAt: createdAt ?? _createdAt,
        isFake: isFake ?? _isFake,
        userPost: userPost ?? _userPost,
        token: token ?? _token,
        channel: channel ?? _channel,
        mobileNumber: mobileNumber ?? _mobileNumber,
        coverImage: coverImage ?? _coverImage,
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
  String? get profileImage => _profileImage;
  String? get dob => _dob;
  num? get diamond => _diamond;
  num? get coin => _coin;
  String? get country => _country;
  bool? get isOnline => _isOnline;
  bool? get isBusy => _isBusy;
  bool? get isLive => _isLive;
  bool? get isBlock => _isBlock;
  num? get uniqueId => _uniqueId;
  String? get identity => _identity;
  String? get fcmToken => _fcmToken;
  num? get loginType => _loginType;
  String? get gender => _gender;
  String? get createdAt => _createdAt;
  bool? get isFake => _isFake;
  List<UserPost>? get userPost => _userPost;
  String? get token => _token;
  String? get channel => _channel;
  String? get mobileNumber => _mobileNumber;
  String? get coverImage => _coverImage;
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
    map['profileImage'] = _profileImage;
    map['dob'] = _dob;
    map['diamond'] = _diamond;
    map['coin'] = _coin;
    map['country'] = _country;
    map['isOnline'] = _isOnline;
    map['isBusy'] = _isBusy;
    map['isLive'] = _isLive;
    map['isBlock'] = _isBlock;
    map['uniqueId'] = _uniqueId;
    map['identity'] = _identity;
    map['fcm_token'] = _fcmToken;
    map['loginType'] = _loginType;
    map['gender'] = _gender;
    map['createdAt'] = _createdAt;
    map['isFake'] = _isFake;
    if (_userPost != null) {
      map['userPost'] = _userPost?.map((v) => v.toJson()).toList();
    }
    map['token'] = _token;
    map['channel'] = _channel;
    map['mobileNumber'] = _mobileNumber;
    map['coverImage'] = _coverImage;
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
