import 'dart:convert';

BlockRequestModel blockRequestModelFromJson(String str) => BlockRequestModel.fromJson(json.decode(str));
String blockRequestModelToJson(BlockRequestModel data) => json.encode(data.toJson());

class BlockRequestModel {
  BlockRequestModel({
    bool? status,
    String? message,
    bool? isBlock,
  }) {
    _status = status;
    _message = message;
    _isBlock = isBlock;
  }

  BlockRequestModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _isBlock = json['isBlock'];
  }
  bool? _status;
  String? _message;
  bool? _isBlock;
  BlockRequestModel copyWith({
    bool? status,
    String? message,
    bool? isBlock,
  }) =>
      BlockRequestModel(
        status: status ?? _status,
        message: message ?? _message,
        isBlock: isBlock ?? _isBlock,
      );
  bool? get status => _status;
  String? get message => _message;
  bool? get isBlock => _isBlock;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    map['isBlock'] = _isBlock;
    return map;
  }
}
