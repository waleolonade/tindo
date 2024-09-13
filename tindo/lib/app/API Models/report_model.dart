import 'dart:convert';

ReportModel reportModelFromJson(String str) =>
    ReportModel.fromJson(json.decode(str));
String reportModelToJson(ReportModel data) => json.encode(data.toJson());

class ReportModel {
  ReportModel({
    bool? status,
    String? message,
    Report? report,
  }) {
    _status = status;
    _message = message;
    _report = report;
  }

  ReportModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _report = json['report'] != null ? Report.fromJson(json['report']) : null;
  }
  bool? _status;
  String? _message;
  Report? _report;
  ReportModel copyWith({
    bool? status,
    String? message,
    Report? report,
  }) =>
      ReportModel(
        status: status ?? _status,
        message: message ?? _message,
        report: report ?? _report,
      );
  bool? get status => _status;
  String? get message => _message;
  Report? get report => _report;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_report != null) {
      map['report'] = _report?.toJson();
    }
    return map;
  }
}

Report reportFromJson(String str) => Report.fromJson(json.decode(str));
String reportToJson(Report data) => json.encode(data.toJson());

class Report {
  Report({
    dynamic postId,
    String? profileId,
    String? id,
    num? reportType,
    String? userId,
    String? report,
    String? image,
    String? createdAt,
    String? updatedAt,
  }) {
    _postId = postId;
    _profileId = profileId;
    _id = id;
    _reportType = reportType;
    _userId = userId;
    _report = report;
    _image = image;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  Report.fromJson(dynamic json) {
    _postId = json['postId'];
    _profileId = json['profileId'];
    _id = json['_id'];
    _reportType = json['reportType'];
    _userId = json['userId'];
    _report = json['report'];
    _image = json['image'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
  }
  dynamic _postId;
  String? _profileId;
  String? _id;
  num? _reportType;
  String? _userId;
  String? _report;
  String? _image;
  String? _createdAt;
  String? _updatedAt;
  Report copyWith({
    dynamic postId,
    String? profileId,
    String? id,
    num? reportType,
    String? userId,
    String? report,
    String? image,
    String? createdAt,
    String? updatedAt,
  }) =>
      Report(
        postId: postId ?? _postId,
        profileId: profileId ?? _profileId,
        id: id ?? _id,
        reportType: reportType ?? _reportType,
        userId: userId ?? _userId,
        report: report ?? _report,
        image: image ?? _image,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
      );
  dynamic get postId => _postId;
  String? get profileId => _profileId;
  String? get id => _id;
  num? get reportType => _reportType;
  String? get userId => _userId;
  String? get report => _report;
  String? get image => _image;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['postId'] = _postId;
    map['profileId'] = _profileId;
    map['_id'] = _id;
    map['reportType'] = _reportType;
    map['userId'] = _userId;
    map['report'] = _report;
    map['image'] = _image;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    return map;
  }
}
