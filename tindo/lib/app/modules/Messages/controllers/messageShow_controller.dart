import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:rayzi/app/API%20Models/getgift_model.dart';
import 'package:rayzi/app/API%20Models/makecall_model.dart';
import 'package:rayzi/app/API%20Models/send_chatfile_model.dart';
import 'package:rayzi/app/API_Services/create_chattopic_services.dart';
import 'package:rayzi/app/API_Services/getgift_services.dart';
import 'package:rayzi/app/API_Services/makecall_services.dart';
import 'package:rayzi/app/API_Services/sendchatfile_services.dart';
import 'package:rayzi/app/data/APP_variables/AppVariable.dart';
import 'package:rayzi/app/data/Model/Message_Sceen_Model/DummyChatModel.dart';

import '../../../API Models/createchat_topic_model.dart';
import '../../../API Models/oldchat_model.dart';
import '../../../API_Services/oldchat_services.dart';

class MessageShowController extends GetxController {
  var selectedGiftIndex;
  File? proImage;
  //List<DummyChatModel> messages = [];
  final ScrollController scrollController = ScrollController();
  TextEditingController textEditingController = TextEditingController();
  final TextEditingController messageTaxtController = TextEditingController();

  bool isButtonDisabled = true;

  var items = [1, 5, 10, 15, 20, 25, 30, 35, 40, 45, 50];
  var dropdownvalue = 1.obs;
//  var sendVale = 1.obs;

  ///Gift
  var getGiftList = <Gift>[].obs;
  var giftLoading = true.obs;

  ///Chat Topic
  CreateChatTopicModel? chatTopicModel;
  String? topicId;

  /// old Chat
  OldChatModel? oldChatModel;
  var oldChatList = <ChatShowModel>[].obs;
  var oldcharIsLoding = true.obs;
  var oldchatAllDataloding = true.obs;

  /// Date ///
  String messagestaus = "";
  String messageShowstaus = "ABC";
  List<String> dateYt = [];
  List<int> position = [];

  ///Make Call
  MakeCallModel? makeCallModel;

  ///send ChatFile
  SendChatFileModel? sendChatFileModel;

  @override
  void onInit() {
    selectedGiftIndex = 0.obs;
    messageTaxtController.addListener(() {
      validateField(messageTaxtController.text);
    });

    super.onInit();
  }

  /// Camera and Gallary Image Picker
  Future cameraImage() async {
    try {
      final imagepike =
          await ImagePicker().pickImage(source: ImageSource.camera);
      if (imagepike == null) return;
      final imageTeam = File(imagepike.path);
      proImage = imageTeam;
      if (proImage != null) {
        log("==========$proImage");
        sendChatFile("2", proImage!);
      }
      Get.back();
      update();
    } on PlatformException catch (e) {
      log("$e");
    }
  }

  Future pickImage() async {
    try {
      final imagepike =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (imagepike == null) return;

      final imageTeam = File(imagepike.path);
      proImage = imageTeam;
      if (proImage != null) {
        log("==========$proImage");
        sendChatFile("2", proImage!);
      }
      Get.back();
      update();
    } on PlatformException catch (e) {
      log("fail$e");
    }
  }

  /// Message Send and recived function
  void sendMessage(String message) async {
    setMessage("0", message);
    await Future.delayed(
        const Duration(seconds: 2), () => setMessage("1", message));
    update();
  }

  void setMessage(String type, String message) {
    // DummyChatModel dummyChatModel = DummyChatModel(
    //   type: type,
    //   message: message,
    //   time: DateFormat.jm().format(DateTime.now()),
    // );
    //
    // messages.add(dummyChatModel);
    scrollController.animateTo(scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
    update();
  }

  /// OnTab Message send
  void onTabSend() {
    log("_____++++");
    if (messageTaxtController.text.isNotEmpty) {
      sendMessage(
        messageTaxtController.text,
      );
      log("_____++++111");
      messageTaxtController.clear();
      update();
    }
  }

  ///Text fiel validation
  void validateField(text) {
    if (messageTaxtController.text.isEmpty ||
        messageTaxtController.text.isBlank == true) {
      isButtonDisabled = true;
      update();
    } else {
      isButtonDisabled = false;
      update();
    }
  }

  /// ==== FetchGiftList ==== \\\
  Future fetchGiftlist() async {
    try {
      log("++++");
      giftLoading(true);
      var getGiftData = await GetGiftService.getGift();
      getGiftList.value = getGiftData.gift!;
      log("Get Gift Data Is :- ${jsonEncode(getGiftData)}");
    } finally {
      giftLoading(false);
      log("++++");
    }
  }

  /// Create Chat Topic
  Future chatTopic({required String userID2}) async {
    var data =
        await CreateChatTopicServices().createChatTopic(userId2: userID2);
    chatTopicModel = data;
    if (data!.status == true) {
      log("==================================${chatTopicModel!.chatTopic!.id.toString()}");
      oldChat(topicId: chatTopicModel!.chatTopic!.id.toString());
      topicId = chatTopicModel!.chatTopic!.id.toString();
      log("=====TOPIC====$topicId");
    }
  }

  /// old chat
  Future oldChat({required String topicId}) async {
    log("===============ChatTOPIc == $topicId");
    var data = await OldChatServices().oldChatServices(topicId: topicId);
    oldChatModel = data;
    //oldChatList.value = oldChatModel!.chat!;
    if (data!.status == true) {
      oldChatModel!.chat!.forEach((element) {
        ///// ====== MESSAGE TIME ======= \\\\\
        String date = element.date!;
        List<String> dateParts = date.split(", ");
        List<String> time = dateParts[1].toString().split(":");
        List<String> pmdate = time[2].toString().split(" ");
        String finalTime = "${time[0]}:${time[1]} ${pmdate[1]}";

        //// ==== TODAY YESTERDAY ==== \\\\
        var now = DateTime.now();
        final yesterDay = DateTime.now().subtract(const Duration(days: 1));
        String nowDate = DateFormat.yMd().format(now);
        String yesterDate = DateFormat.yMd().format(yesterDay);

        if (nowDate == dateParts[0]) {
          dateYt.add("Today");
        } else if (yesterDate == dateParts[0]) {
          dateYt.add("Yesterday");
        } else {
          List datePartslist = dateParts[0].split("/");
          dateYt.add(
              "${datePartslist[1]}/${datePartslist[0]}/${datePartslist[2]}");
        }

        if (element.messageType!.toInt() == 0) {
          oldChatList.add(ChatShowModel(
              messageType: element.messageType!.toInt(),
              message: "${element.message}",
              profilePic: "",
              messageTime: finalTime,
              senderID: "${element.senderId}"));
        } else if (element.messageType!.toInt() == 1) {
          oldChatList.add(ChatShowModel(
              messageType: element.messageType!.toInt(),
              message: "${element.message}",
              profilePic: "",
              messageTime: finalTime,
              senderID: "${element.senderId}"));
        } else if (element.messageType!.toInt() == 2) {
          oldChatList.add(ChatShowModel(
              messageType: element.messageType!.toInt(),
              message: "${element.image}",
              profilePic: "",
              messageTime: finalTime,
              senderID: "${element.senderId}"));
        } else if (element.messageType!.toInt() == 4) {
          oldChatList.add(ChatShowModel(
              messageType: element.messageType!.toInt(),
              message: "${element.audio}",
              profilePic: "",
              messageTime: finalTime,
              senderID: "${element.senderId}"));
        } else if (element.messageType!.toInt() == 5) {
          oldChatList.add(ChatShowModel(
            messageType: element.messageType!.toInt(),
            message: "${element.callDuration}",
            profilePic: "",
            messageTime: finalTime,
            senderID: "${element.senderId}",
            callType: element.callType,
          ));
        }
      });

      for (int i = 0; i < dateYt.length; i++) {
        log("********$messageShowstaus********$messagestaus");
        if (i > 0) {
          messageShowstaus = dateYt[i];
        }
        if (messagestaus != messageShowstaus) {
          messagestaus = dateYt[i];
          log("====== $messagestaus ======");
          position.add(1);
        } else {
          position.add(0);
        }
        if (i == 0) {
          messageShowstaus = dateYt[i];
        }
      }
      oldchatAllDataloding = false.obs;
      oldcharIsLoding.value = false;
      update();
      // if (oldchatAllDataloding.value == false) {
      //   await Future.delayed(Duration(seconds: 2));
      //   WidgetsBinding.instance.addPostFrameCallback((_) {
      //     scrollController.animateTo(
      //       scrollController.position.maxScrollExtent,
      //       duration: Duration(milliseconds: 500),
      //       curve: Curves.easeOut,
      //     );
      //   });
      //   oldcharIsLoding.value = false;
      //   update();
      // }
    } else {
      log("OLD Chat =====>>>>>>>>>>>>> Status False");
    }
    update();
  }

  /// send ChatFile
  Future sendChatFile(String messageType, File sendData) async {
    log("++++++$topicId");
    var data = await SendChatFileServices().sendChatFile(
        topicId: "$topicId",
        messageType: messageType,
        senderId: userID,
        sendData: sendData);
    sendChatFileModel = data;
    if (sendChatFileModel!.status == true) {
      log("+++++++++++++++++++____hiiiiiiiiiiiiiiiiiiiiii");
    }
  }

  /// Make Call
  Future makeCall(
      {required String callerUserID,
      required String receiverUserID,
      required String receiverImage,
      required String receiverName}) async {
    var data = await MakeCallServices().mekeCallServices(
        callerUserID: callerUserID,
        receiverUserID: receiverUserID,
        callerImage: userProfile.value,
        callerName: userName,
        receiverImage: receiverImage,
        receiverName: receiverName);
    makeCallModel = data;
  }
}
