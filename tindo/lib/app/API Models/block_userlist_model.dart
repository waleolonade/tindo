import 'dart:convert';

/// status : true
/// message : "Success"
/// block : [{"_id":"644280016d455b5ecf1e2682","from":"64198788ee1a1f68482b2aac","to":"643fde4bd1a41449c6973b7e","profileImage":"storage/1681907275449delete-user-4.jpg","name":"anik","isFake":true}]

BlockUserListModel blockUserListModelFromJson(String str) =>
    BlockUserListModel.fromJson(json.decode(str));
String blockUserListModelToJson(BlockUserListModel data) =>
    json.encode(data.toJson());

class BlockUserListModel {
  BlockUserListModel({
    bool? status,
    String? message,
    List<Block>? block,
  }) {
    _status = status;
    _message = message;
    _block = block;
  }

  BlockUserListModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['block'] != null) {
      _block = [];
      json['block'].forEach((v) {
        _block?.add(Block.fromJson(v));
      });
    }
  }
  bool? _status;
  String? _message;
  List<Block>? _block;
  BlockUserListModel copyWith({
    bool? status,
    String? message,
    List<Block>? block,
  }) =>
      BlockUserListModel(
        status: status ?? _status,
        message: message ?? _message,
        block: block ?? _block,
      );
  bool? get status => _status;
  String? get message => _message;
  List<Block>? get block => _block;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_block != null) {
      map['block'] = _block?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// _id : "644280016d455b5ecf1e2682"
/// from : "64198788ee1a1f68482b2aac"
/// to : "643fde4bd1a41449c6973b7e"
/// profileImage : "storage/1681907275449delete-user-4.jpg"
/// name : "anik"
/// isFake : true

Block blockFromJson(String str) => Block.fromJson(json.decode(str));
String blockToJson(Block data) => json.encode(data.toJson());

class Block {
  Block({
    String? id,
    String? from,
    String? to,
    String? profileImage,
    String? name,
    bool? isFake,
  }) {
    _id = id;
    _from = from;
    _to = to;
    _profileImage = profileImage;
    _name = name;
    _isFake = isFake;
  }

  Block.fromJson(dynamic json) {
    _id = json['_id'];
    _from = json['from'];
    _to = json['to'];
    _profileImage = json['profileImage'];
    _name = json['name'];
    _isFake = json['isFake'];
  }
  String? _id;
  String? _from;
  String? _to;
  String? _profileImage;
  String? _name;
  bool? _isFake;
  Block copyWith({
    String? id,
    String? from,
    String? to,
    String? profileImage,
    String? name,
    bool? isFake,
  }) =>
      Block(
        id: id ?? _id,
        from: from ?? _from,
        to: to ?? _to,
        profileImage: profileImage ?? _profileImage,
        name: name ?? _name,
        isFake: isFake ?? _isFake,
      );
  String? get id => _id;
  String? get from => _from;
  String? get to => _to;
  String? get profileImage => _profileImage;
  String? get name => _name;
  bool? get isFake => _isFake;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['from'] = _from;
    map['to'] = _to;
    map['profileImage'] = _profileImage;
    map['name'] = _name;
    map['isFake'] = _isFake;
    return map;
  }
}
