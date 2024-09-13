class NotificationModel {
  bool? status;
  String? message;
  List<Notification>? notification;

  NotificationModel({this.status, this.message, this.notification});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['notification'] != null) {
      notification = <Notification>[];
      json['notification'].forEach((v) {
        notification!.add(Notification.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (notification != null) {
      data['notification'] = notification!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Notification {
  String? sId;
  String? receiverId;
  int? type;
  String? userId;
  String? createdAt;
  String? updatedAt;
  String? name;
  String? profileImage;
  String? giftImage;
  String? postImage;
  String? from;
  String? to;
  bool? friends;
  String? comment;
  String? image;
  String? message;
  String? title;

  Notification(
      {this.sId,
      this.receiverId,
      this.type,
      this.userId,
      this.createdAt,
      this.updatedAt,
      this.name,
      this.profileImage,
      this.giftImage,
      this.postImage,
      this.from,
      this.to,
      this.friends,
      this.comment,
      this.image,
      this.message,
      this.title});

  Notification.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    receiverId = json['receiverId'];
    type = json['type'];
    userId = json['userId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    name = json['name'];
    profileImage = json['profileImage'];
    giftImage = json['giftImage'];
    postImage = json['postImage'];
    from = json['from'];
    to = json['to'];
    friends = json['friends'];
    comment = json['comment'];
    image = json['image'];
    message = json['message'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['receiverId'] = receiverId;
    data['type'] = type;
    data['userId'] = userId;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['name'] = name;
    data['profileImage'] = profileImage;
    data['giftImage'] = giftImage;
    data['postImage'] = postImage;
    data['from'] = from;
    data['to'] = to;
    data['friends'] = friends;
    data['comment'] = comment;
    data['image'] = image;
    data['message'] = message;
    data['title'] = title;
    return data;
  }
}
