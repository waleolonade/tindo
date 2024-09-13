class ChatShowModel {
  int messageType;
  String message;
  String messageTime;
  String profilePic;
  String senderID;
  int? callType;
  ChatShowModel({
    required this.messageType,
    required this.message,
    required this.profilePic,
    required this.messageTime,
    required this.senderID,
    this.callType,
  });
}
