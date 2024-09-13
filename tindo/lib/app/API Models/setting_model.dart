import 'dart:convert';

Settingmodel settingmodelFromJson(String str) =>
    Settingmodel.fromJson(json.decode(str));
String settingmodelToJson(Settingmodel data) => json.encode(data.toJson());

class Settingmodel {
  Settingmodel({
    bool? status,
    String? message,
    Setting? setting,
  }) {
    _status = status;
    _message = message;
    _setting = setting;
  }

  Settingmodel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _setting =
        json['setting'] != null ? Setting.fromJson(json['setting']) : null;
  }
  bool? _status;
  String? _message;
  Setting? _setting;
  Settingmodel copyWith({
    bool? status,
    String? message,
    Setting? setting,
  }) =>
      Settingmodel(
        status: status ?? _status,
        message: message ?? _message,
        setting: setting ?? _setting,
      );
  bool? get status => _status;
  String? get message => _message;
  Setting? get setting => _setting;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_setting != null) {
      map['setting'] = _setting?.toJson();
    }
    return map;
  }
}

Setting settingFromJson(String str) => Setting.fromJson(json.decode(str));
String settingToJson(Setting data) => json.encode(data.toJson());

class Setting {
  Setting({
    String? id,
    String? agoraKey,
    String? agoraCertificate,
    String? privacyPolicyLink,
    String? privacyPolicyText,
    String? termAndCondition,
    String? googlePlayEmail,
    String? googlePlayKey,
    bool? googlePlaySwitch,
    bool? stripeSwitch,
    String? stripePublishableKey,
    String? stripeSecretKey,
    bool? isAppActive,
    String? welcomeMessage,
    num? chargeForMessage,
    num? coin,
    num? diamond,
    num? videoCallCharge,
    num? withdrawLimit,
    bool? razorPay,
    String? razorPayId,
    String? razorSecretKey,
    String? redirectAppUrl,
    String? redirectMessage,
    String? contactSupport,
    String? howToWithdraw,
  }) {
    _id = id;
    _agoraKey = agoraKey;
    _agoraCertificate = agoraCertificate;
    _privacyPolicyLink = privacyPolicyLink;
    _privacyPolicyText = privacyPolicyText;
    _termAndCondition = termAndCondition;
    _googlePlayEmail = googlePlayEmail;
    _googlePlayKey = googlePlayKey;
    _googlePlaySwitch = googlePlaySwitch;
    _stripeSwitch = stripeSwitch;
    _stripePublishableKey = stripePublishableKey;
    _stripeSecretKey = stripeSecretKey;
    _isAppActive = isAppActive;
    _welcomeMessage = welcomeMessage;
    _chargeForMessage = chargeForMessage;
    _coin = coin;
    _diamond = diamond;
    _videoCallCharge = videoCallCharge;
    _withdrawLimit = withdrawLimit;
    _razorPay = razorPay;
    _razorPayId = razorPayId;
    _razorSecretKey = razorSecretKey;
    _redirectAppUrl = redirectAppUrl;
    _redirectMessage = redirectMessage;
    _contactSupport = contactSupport;
    _howToWithdraw = howToWithdraw;
  }

  Setting.fromJson(dynamic json) {
    _id = json['_id'];
    _agoraKey = json['agoraKey'];
    _agoraCertificate = json['agoraCertificate'];
    _privacyPolicyLink = json['privacyPolicyLink'];
    _privacyPolicyText = json['privacyPolicyText'];
    _termAndCondition = json['termAndCondition'];
    _googlePlayEmail = json['googlePlayEmail'];
    _googlePlayKey = json['googlePlayKey'];
    _googlePlaySwitch = json['googlePlaySwitch'];
    _stripeSwitch = json['stripeSwitch'];
    _stripePublishableKey = json['stripePublishableKey'];
    _stripeSecretKey = json['stripeSecretKey'];
    _isAppActive = json['isAppActive'];
    _welcomeMessage = json['welcomeMessage'];
    _chargeForMessage = json['chargeForMessage'];
    _coin = json['coin'];
    _diamond = json['diamond'];
    _videoCallCharge = json['videoCallCharge'];
    _withdrawLimit = json['withdrawLimit'];
    _razorPay = json['razorPay'];
    _razorPayId = json['razorPayId'];
    _razorSecretKey = json['razorSecretKey'];
    _redirectAppUrl = json['redirectAppUrl'];
    _redirectMessage = json['redirectMessage'];
    _contactSupport = json['contactSupport'];
    _howToWithdraw = json['howToWithdraw'];
  }
  String? _id;
  String? _agoraKey;
  String? _agoraCertificate;
  String? _privacyPolicyLink;
  String? _privacyPolicyText;
  String? _termAndCondition;
  String? _googlePlayEmail;
  String? _googlePlayKey;
  bool? _googlePlaySwitch;
  bool? _stripeSwitch;
  String? _stripePublishableKey;
  String? _stripeSecretKey;
  bool? _isAppActive;
  String? _welcomeMessage;
  num? _chargeForMessage;
  num? _coin;
  num? _diamond;
  num? _videoCallCharge;
  num? _withdrawLimit;
  bool? _razorPay;
  String? _razorPayId;
  String? _razorSecretKey;
  String? _redirectAppUrl;
  String? _redirectMessage;
  String? _contactSupport;
  String? _howToWithdraw;
  Setting copyWith({
    String? id,
    String? agoraKey,
    String? agoraCertificate,
    String? privacyPolicyLink,
    String? privacyPolicyText,
    String? termAndCondition,
    String? googlePlayEmail,
    String? googlePlayKey,
    bool? googlePlaySwitch,
    bool? stripeSwitch,
    String? stripePublishableKey,
    String? stripeSecretKey,
    bool? isAppActive,
    String? welcomeMessage,
    num? chargeForMessage,
    num? coin,
    num? diamond,
    num? videoCallCharge,
    num? withdrawLimit,
    bool? razorPay,
    String? razorPayId,
    String? razorSecretKey,
    String? redirectAppUrl,
    String? redirectMessage,
    String? contactSupport,
    String? howToWithdraw,
  }) =>
      Setting(
        id: id ?? _id,
        agoraKey: agoraKey ?? _agoraKey,
        agoraCertificate: agoraCertificate ?? _agoraCertificate,
        privacyPolicyLink: privacyPolicyLink ?? _privacyPolicyLink,
        privacyPolicyText: privacyPolicyText ?? _privacyPolicyText,
        termAndCondition: termAndCondition ?? _termAndCondition,
        googlePlayEmail: googlePlayEmail ?? _googlePlayEmail,
        googlePlayKey: googlePlayKey ?? _googlePlayKey,
        googlePlaySwitch: googlePlaySwitch ?? _googlePlaySwitch,
        stripeSwitch: stripeSwitch ?? _stripeSwitch,
        stripePublishableKey: stripePublishableKey ?? _stripePublishableKey,
        stripeSecretKey: stripeSecretKey ?? _stripeSecretKey,
        isAppActive: isAppActive ?? _isAppActive,
        welcomeMessage: welcomeMessage ?? _welcomeMessage,
        chargeForMessage: chargeForMessage ?? _chargeForMessage,
        coin: coin ?? _coin,
        diamond: diamond ?? _diamond,
        videoCallCharge: videoCallCharge ?? _videoCallCharge,
        withdrawLimit: withdrawLimit ?? _withdrawLimit,
        razorPay: razorPay ?? _razorPay,
        razorPayId: razorPayId ?? _razorPayId,
        razorSecretKey: razorSecretKey ?? _razorSecretKey,
        redirectAppUrl: redirectAppUrl ?? _redirectAppUrl,
        redirectMessage: redirectMessage ?? _redirectMessage,
        contactSupport: contactSupport ?? _contactSupport,
        howToWithdraw: howToWithdraw ?? _howToWithdraw,
      );
  String? get id => _id;
  String? get agoraKey => _agoraKey;
  String? get agoraCertificate => _agoraCertificate;
  String? get privacyPolicyLink => _privacyPolicyLink;
  String? get privacyPolicyText => _privacyPolicyText;
  String? get termAndCondition => _termAndCondition;
  String? get googlePlayEmail => _googlePlayEmail;
  String? get googlePlayKey => _googlePlayKey;
  bool? get googlePlaySwitch => _googlePlaySwitch;
  bool? get stripeSwitch => _stripeSwitch;
  String? get stripePublishableKey => _stripePublishableKey;
  String? get stripeSecretKey => _stripeSecretKey;
  bool? get isAppActive => _isAppActive;
  String? get welcomeMessage => _welcomeMessage;
  num? get chargeForMessage => _chargeForMessage;
  num? get coin => _coin;
  num? get diamond => _diamond;
  num? get videoCallCharge => _videoCallCharge;
  num? get withdrawLimit => _withdrawLimit;
  bool? get razorPay => _razorPay;
  String? get razorPayId => _razorPayId;
  String? get razorSecretKey => _razorSecretKey;
  String? get redirectAppUrl => _redirectAppUrl;
  String? get redirectMessage => _redirectMessage;
  String? get contactSupport => _contactSupport;
  String? get howToWithdraw => _howToWithdraw;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['agoraKey'] = _agoraKey;
    map['agoraCertificate'] = _agoraCertificate;
    map['privacyPolicyLink'] = _privacyPolicyLink;
    map['privacyPolicyText'] = _privacyPolicyText;
    map['termAndCondition'] = _termAndCondition;
    map['googlePlayEmail'] = _googlePlayEmail;
    map['googlePlayKey'] = _googlePlayKey;
    map['googlePlaySwitch'] = _googlePlaySwitch;
    map['stripeSwitch'] = _stripeSwitch;
    map['stripePublishableKey'] = _stripePublishableKey;
    map['stripeSecretKey'] = _stripeSecretKey;
    map['isAppActive'] = _isAppActive;
    map['welcomeMessage'] = _welcomeMessage;
    map['chargeForMessage'] = _chargeForMessage;
    map['coin'] = _coin;
    map['diamond'] = _diamond;
    map['videoCallCharge'] = _videoCallCharge;
    map['withdrawLimit'] = _withdrawLimit;
    map['razorPay'] = _razorPay;
    map['razorPayId'] = _razorPayId;
    map['razorSecretKey'] = _razorSecretKey;
    map['redirectAppUrl'] = _redirectAppUrl;
    map['redirectMessage'] = _redirectMessage;
    map['contactSupport'] = _contactSupport;
    map['howToWithdraw'] = _howToWithdraw;
    return map;
  }
}
