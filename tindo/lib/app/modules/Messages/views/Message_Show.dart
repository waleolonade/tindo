import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:rayzi/app/API_Services/app_url.dart';
import 'package:rayzi/app/data/AppImages.dart';
import 'package:rayzi/app/data/Colors.dart';
import 'package:rayzi/app/data/Model/Message_Sceen_Model/DummyChatModel.dart';
import 'package:rayzi/app/modules/Messages/views/record_button.dart';
import 'package:rayzi/app/modules/My_App/controllers/my_app_controller.dart';
import 'package:rayzi/app/modules/My_App/views/my_app_view.dart';
import 'package:rayzi/app/modules/User_Profile/views/second_user_profile.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

import '../../../data/APP_variables/AppVariable.dart';
import '../controllers/messageShow_controller.dart';
import 'CoustomeWidget/ReceiveDummyMessage_Model.dart';
import 'CoustomeWidget/sendDummyMessage_Model.dart';

class MessageShow extends StatefulWidget {
  final String images;
  final String name;
  final String userId2;
  final String chatRoomId;
  final String senderId;

  const MessageShow({
    Key? key,
    required this.images,
    required this.name,
    required this.userId2,
    required this.chatRoomId,
    required this.senderId,
  }) : super(key: key);

  @override
  State<MessageShow> createState() => _MessageShowState();
}

class _MessageShowState extends State<MessageShow> with SingleTickerProviderStateMixin {
  MessageShowController messageShowController = Get.put(MessageShowController());
  MyAppController myAppController = Get.put(MyAppController());

  FocusNode focusNode = FocusNode();

  ///Voice Message ///
  late AnimationController animationController;
  @override
  void initState() {
    // TODO: implement initState
    connect();
    messageShowController.topicId = widget.chatRoomId;
    messageShowController.oldChat(topicId: widget.chatRoomId);
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   messageShowController.scrollController.animateTo(
    //     messageShowController.scrollController.position.maxScrollExtent,
    //     duration: Duration(milliseconds: 500),
    //     curve: Curves.easeOut,
    //   );
    // });
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  void connect() {
    log("on");
    log(widget.chatRoomId);
    socket = io.io(
      Constant.BASE_URL,
      io.OptionBuilder().setTransports(['websocket']).setQuery({"chatRoom": widget.chatRoomId}).build(),
    );
    socket.connect();
    socket.onConnect((data) {
      log("Connected");
      socket.on("chat", (msg) {
        log("........................$msg");

        //// ===== Final Time ==== \\\\
        String date = msg["date"];
        List<String> dateParts = date.split(", ");
        List<String> time = dateParts[1].toString().split(":");
        List<String> pmdate = time[2].toString().split(" ");
        String finalTime = "${time[0]}:${time[1]} ${pmdate[1]}";

        //// ==== TODAY YESTERDAY ==== \\\\
        var now = DateTime.now();
        final yesterday = DateTime.now().subtract(const Duration(days: 1));
        String nowDate = DateFormat.yMd().format(now);
        String previousDate = DateFormat.yMd().format(yesterday);
        log("=========$previousDate==========");

        if (nowDate == dateParts[0]) {
          log("+++++++++++++++++++TODAY++++++++++++");
          messageShowController.dateYt.add("Today");
        } else if (previousDate == dateParts[0]) {
          messageShowController.dateYt.add("Yesterday");
          log("+++++++++++++++++++Yesterday++++++++++++");
        } else {
          List datePartslist = dateParts[0].split("/");
          messageShowController.dateYt.add("${datePartslist[1]}/${datePartslist[0]}/${datePartslist[2]}");
        }

        log("======>>>${messageShowController.position}<<<=======");
        if (messageShowController.position.isEmpty) {
          messageShowController.position.add(1);
        } else if (messageShowController.dateYt.last == messageShowController.dateYt[messageShowController.dateYt.length - 2]) {
          messageShowController.position.add(0);
        } else {
          log("!!!!!!!!!!!!!!!!!!!!");
          messageShowController.position.add(1);
        }
        log("======>>>${messageShowController.position}");

        if (msg["messageType"] == 0) {
          setMessage(
            date: finalTime,
            message: msg["message"],
            messageType: msg["messageType"],
            senderId: msg["senderId"],
          );
        } else if (msg["messageType"] == 1) {
          log("++++++++DONE");
          setMessage(
              date: finalTime, message: "${msg["message"]}", messageType: msg["messageType"], senderId: "${msg["senderId"]}");
        } else if (msg["messageType"] == 2) {
          setMessage(
              date: finalTime, message: "${msg["message"]}", messageType: msg["messageType"], senderId: "${msg["senderId"]}");
        } else if (msg["messageType"] == 4) {
          setMessage(
              date: finalTime, message: "${msg["message"]}", messageType: msg["messageType"], senderId: "${msg["senderId"]}");
        }
        // setState(() {
        //   messageShowController.scrollController.animateTo(
        //       messageShowController.scrollController.position.maxScrollExtent,
        //       duration: const Duration(milliseconds: 300),
        //       curve: Curves.easeOut);
        // });
      });
    });
  }

  void sendMessage(String message) async {
    socket.emit("chat", {
      "topicId": widget.chatRoomId,
      "senderId": widget.senderId,
      "message": message,
      "messageType": 0,
      "receiverId": widget.userId2,
    });
    // messageShowController.scrollController.animateTo(
    //     messageShowController.scrollController.position.maxScrollExtent,
    //     duration: Duration(milliseconds: 300),
    //     curve: Curves.easeOut);
  }

  void setMessage({
    required String date,
    required String message,
    required int messageType,
    required String senderId,
  }) {
    ChatShowModel messageModel =
        ChatShowModel(messageType: messageType, message: message, profilePic: "", messageTime: date, senderID: senderId);
    setState(() {
      messageShowController.oldChatList.add(messageModel);
      log("===${messageShowController.oldChatList.last.senderID}");
      setState(() {
        messageShowController.scrollController.animateTo(0.0, duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.focusScope?.unfocus();
      },
      child: WillPopScope(
        onWillPop: () async {
          if (notificationVisit.value == true) {
            Get.offAll(const MyApp());
          } else {
            Get.back();
          }
          return false;
        },
        child: Scaffold(
          appBar: PreferredSize(
              preferredSize: Size(Get.width, 56),
              child: Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, top: 16),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                          onTap: () {
                            if (notificationVisit.value == true) {
                              Get.offAll(const MyApp());
                            } else {
                              Get.back();
                            }
                          },
                          child: ImageIcon(
                            const AssetImage(
                              "Images/new_dis/back.png",
                            ),
                            color: ThemeColor.blackback,
                            size: 26,
                          )),
                      GestureDetector(
                        onTap: () => Get.to(() => SecondUserProfileView(userID: widget.userId2)),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              backgroundColor: ThemeColor.white,
                              child: Padding(
                                padding: const EdgeInsets.all(1.5),
                                child: CircleAvatar(
                                  backgroundColor: ThemeColor.white,
                                  backgroundImage: NetworkImage(widget.images),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              widget.name,
                              style: TextStyle(
                                fontFamily: 'abold',
                                fontSize: 18,
                                color: ThemeColor.blackback,
                              ),
                            ),
                            const SizedBox(
                              width: 25,
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          if (userCoins.value >= videoCallCharge) {
                            userCoins.value = userCoins.value - videoCallCharge;
                            messageShowController.makeCall(
                                callerUserID: widget.senderId,
                                receiverUserID: widget.userId2,
                                receiverImage: widget.images,
                                receiverName: widget.name);
                          } else {
                            Fluttertoast.showToast(
                                msg: "Not Sufficient Coins",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: ThemeColor.white,
                                textColor: ThemeColor.pink,
                                fontSize: 16.0);
                          }
                        },
                        child: const ImageIcon(
                          AssetImage(
                            "Images/new_dis/video.png",
                          ),
                          size: 28,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              )),
          body: NotificationListener<OverscrollIndicatorNotification>(
            onNotification: (overscroll) {
              overscroll.disallowIndicator();
              return false;
            },
            child: Container(
              height: Get.height,
              width: Get.width,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  opacity: 0.8,
                  image: AssetImage("Images/Message/message_BG.png"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                children: [
                  Expanded(
                    child: Obx(
                      () => (messageShowController.oldcharIsLoding.value)
                          ? Center(
                              child: CircularProgressIndicator(
                              color: ThemeColor.pink,
                            ))
                          : GetBuilder<MessageShowController>(
                              builder: (controller) => ListView.builder(
                                controller: messageShowController.scrollController,
                                shrinkWrap: true,
                                reverse: true,
                                itemCount: messageShowController.oldChatList.length,
                                itemBuilder: (context, index) {
                                  final reversedIndex = messageShowController.oldChatList.length - 1 - index;
                                  if (messageShowController.oldChatList[reversedIndex].senderID != userID) {
                                    if (messageShowController.position[reversedIndex] == 1) {
                                      return Column(
                                        children: [
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            messageShowController.dateYt[reversedIndex],
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                              color: Color(0xff9F9F9F),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          ReceiveDummyMessage(
                                            message: messageShowController.oldChatList[reversedIndex].message,
                                            time: messageShowController.oldChatList[reversedIndex].messageTime,
                                            profilePic: widget.images,
                                            messageType: messageShowController.oldChatList[reversedIndex].messageType,
                                            callType: (messageShowController.oldChatList[reversedIndex].messageType == 5)
                                                ? messageShowController.oldChatList[reversedIndex].callType
                                                : 0,
                                          )
                                        ],
                                      );
                                    } else {
                                      return ReceiveDummyMessage(
                                        message: messageShowController.oldChatList[reversedIndex].message,
                                        time: messageShowController.oldChatList[reversedIndex].messageTime,
                                        profilePic: widget.images,
                                        messageType: messageShowController.oldChatList[reversedIndex].messageType,
                                      );
                                    }
                                  } else {
                                    if (messageShowController.position[reversedIndex] == 1) {
                                      return Column(
                                        children: [
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            messageShowController.dateYt[reversedIndex],
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                              color: Color(0xff9F9F9F),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          SendDummyMessage(
                                            message: messageShowController.oldChatList[reversedIndex].message,
                                            time: messageShowController.oldChatList[reversedIndex].messageTime,
                                            profilePic: userProfile.value,
                                            messageType: messageShowController.oldChatList[reversedIndex].messageType,
                                            index: reversedIndex,
                                          ),
                                        ],
                                      );
                                    } else {
                                      return SendDummyMessage(
                                        message: messageShowController.oldChatList[reversedIndex].message,
                                        time: messageShowController.oldChatList[reversedIndex].messageTime,
                                        profilePic: userProfile.value,
                                        messageType: messageShowController.oldChatList[reversedIndex].messageType,
                                        index: reversedIndex,
                                      );
                                    }
                                  }
                                },
                              ),
                            ),
                    ),
                  ),
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxHeight: 200, minHeight: 70),
                    child: Container(
                      // height: 70,
                      width: Get.width,
                      decoration: BoxDecoration(
                        color: ThemeColor.white,
                        border: Border(
                          top: BorderSide(color: ThemeColor.grayIcon.withOpacity(0.3), width: 1),
                        ),
                      ),
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: GetBuilder<MessageShowController>(
                        builder: (controller) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Get.bottomSheet(pickImages());
                                },
                                child: Container(
                                  height: Get.height / 23.5,
                                  width: Get.height / 23.5,
                                  padding: const EdgeInsets.all(2),
                                  child: ImageIcon(const AssetImage("Images/Message/gallery2.png"), color: ThemeColor.blackback),
                                ),
                              ),
                              ConstrainedBox(
                                constraints: const BoxConstraints(maxHeight: 200, minHeight: 20),
                                child: SizedBox(
                                  width: (messageShowController.isButtonDisabled) ? Get.width - 134.5 : Get.width - 100,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        left: 8.0,
                                        right: (messageShowController.isButtonDisabled) ? 0 : 8.0,
                                        top: 20,
                                        bottom: 20),
                                    child: TextFormField(
                                      controller: messageShowController.messageTaxtController,
                                      style: TextStyle(
                                          fontFamily: 'alight',
                                          fontSize: 16,
                                          color: ThemeColor.blackback,
                                          fontWeight: FontWeight.bold),
                                      focusNode: focusNode,
                                      cursorColor: const Color(0xff767676),
                                      minLines: 1,
                                      maxLines: 3,
                                      keyboardType: TextInputType.multiline,
                                      autofocus: false,
                                      autocorrect: false,
                                      decoration: InputDecoration(
                                        isDense: true,
                                        filled: true,
                                        fillColor: ThemeColor.greAlpha20.withOpacity(0.1),
                                        contentPadding: const EdgeInsets.only(top: 12, bottom: 12, left: 14, right: 14),
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(100), borderSide: BorderSide.none),
                                        hintText: "Type a Message....",
                                        hintStyle: TextStyle(fontFamily: 'amidum', fontSize: 14, color: ThemeColor.graylight),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              (messageShowController.isButtonDisabled)
                                  ? SizedBox(
                                      height: 40,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          RecordButton(
                                            controller: animationController,
                                            isFake: false,
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              messageShowController.fetchGiftlist();
                                              Get.bottomSheet(isScrollControlled: true, giftsheet());
                                            },
                                            child: SizedBox(
                                                height: 40,
                                                child: Padding(
                                                  padding: const EdgeInsets.only(top: 7, bottom: 7),
                                                  child: Image.asset(
                                                    "Images/Message/gift2.png",
                                                    color: ThemeColor.blackback,
                                                  ),
                                                )),
                                          ),
                                        ],
                                      ),
                                    )
                                  : GestureDetector(
                                      onTap: () async {
                                        // messageShowController.onTabSend();
                                        log("======${messageShowController.messageTaxtController.text.toString()}");
                                        sendMessage(messageShowController.messageTaxtController.text.toString());
                                        messageShowController.messageTaxtController.clear();
                                      },
                                      child: Container(
                                          height: 40,
                                          width: 40,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(100),
                                              gradient: LinearGradient(
                                                begin: Alignment.centerLeft,
                                                end: Alignment.centerRight,
                                                colors: [
                                                  ThemeColor.pink,
                                                  ThemeColor.purple,
                                                ],
                                              )),
                                          child: Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Image.asset(
                                              "Images/Message/sEND.png",
                                            ),
                                          )),
                                    ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  ///Image Picker bottom sheet
  Container pickImages() {
    return Container(
      height: 160,
      decoration: BoxDecoration(
          color: ThemeColor.white,
          borderRadius: const BorderRadius.only(topRight: Radius.circular(22), topLeft: Radius.circular(22))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 6,
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              height: 6,
              width: 70,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: ThemeColor.pink,
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Divider(
            height: 1,
            color: ThemeColor.grayinsta.withOpacity(0.16),
            thickness: 0.8,
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: InkWell(
              onTap: () => messageShowController.cameraImage(),
              child: Container(
                height: 50,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: ThemeColor.white,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 26,
                      width: 26,
                      child: ImageIcon(const AssetImage("Images/Message/camera.png"), color: ThemeColor.blackback),
                    ).paddingSymmetric(horizontal: 10),
                    Text(
                      "Take a photo",
                      style: TextStyle(fontFamily: 'amidum', fontSize: 15, color: ThemeColor.blackback),
                    )
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: InkWell(
              onTap: () => messageShowController.pickImage(),
              child: Container(
                height: 50,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: ThemeColor.white,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      height: 26,
                      width: 26,
                      child: ImageIcon(
                        const AssetImage("Images/Message/gallery2.png"),
                        color: ThemeColor.blackback,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Choose from your file",
                      style: TextStyle(fontFamily: 'amidum', fontSize: 15, color: ThemeColor.blackback),
                    )
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  ///Gift Sheet
  Container giftsheet() {
    return Container(
      decoration: BoxDecoration(
        color: ThemeColor.grayinsta.withOpacity(0.7),
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(20),
          topLeft: Radius.circular(20),
        ),
      ),
      height: Get.height / 1.3,
      child: Padding(
        padding: const EdgeInsets.only(
          top: 10,
        ),
        child: Column(
          children: [
            const SizedBox(
              height: 3,
            ),
            Container(
              height: 6,
              width: 50,
              decoration: BoxDecoration(color: ThemeColor.pink, borderRadius: const BorderRadius.all(Radius.circular(10))),
            ),
            const SizedBox(
              height: 6,
            ),
            GestureDetector(
              onTap: () {
                // myAppController.tabIndex = 4;
                // Get.off(MyAppView());
              },
              child: Container(
                height: 40,
                width: Get.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    50,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 30,
                        width: 30,
                        child: Image.asset(AppImages.coinImages),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        "${userCoins.value}",
                        style: TextStyle(
                          color: ThemeColor.white,
                          fontSize: 16.5,
                          fontFamily: 'amidum',
                        ),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          myAppController.tabIndex = 4;
                          Get.off(const MyApp());
                        },
                        child: Container(
                          height: 27,
                          width: 94,
                          decoration: BoxDecoration(
                              border: Border.all(color: ThemeColor.pink, width: 1), borderRadius: BorderRadius.circular(100)),
                          alignment: Alignment.center,
                          child: const Text(
                            "+ Get Coins",
                            style: TextStyle(fontFamily: 'amidum', color: Colors.white, fontSize: 12.5),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Expanded(
              child: NotificationListener<OverscrollIndicatorNotification>(
                onNotification: (notification) {
                  notification.disallowIndicator();
                  return false;
                },
                child: SingleChildScrollView(
                  child: SizedBox(
                    child: Obx(
                      () => (messageShowController.giftLoading.value)
                          ? Center(
                              child: CircularProgressIndicator(color: ThemeColor.pink),
                            )
                          : sticker(),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: SizedBox(
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      height: 33,
                      width: 130,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                border: Border.all(color: ThemeColor.pink, width: 1),
                                borderRadius:
                                    const BorderRadius.only(topLeft: Radius.circular(100), bottomLeft: Radius.circular(100)),
                              ),
                              alignment: Alignment.center,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 4),
                                child: Obx(
                                  () => DropdownButton(
                                    value: messageShowController.dropdownvalue.value,
                                    icon: const Icon(Icons.keyboard_arrow_down, color: Colors.white),
                                    elevation: 0,
                                    underline: Container(),
                                    dropdownColor: Colors.black,
                                    items: messageShowController.items.map((int items) {
                                      return DropdownMenuItem(
                                        value: items,
                                        child: Text(
                                          (items == 1 || items == 5) ? "  x$items" : " x$items",
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: ThemeColor.white,
                                            fontFamily: 'amidum',
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (int? newValue) {
                                      messageShowController.dropdownvalue.value = newValue!;
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                              child: InkWell(
                            onTap: () {
                              if (userCoins.value == 0) {
                                Fluttertoast.showToast(
                                    msg: "Not Sufficient Coins",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: ThemeColor.white,
                                    textColor: ThemeColor.pink,
                                    fontSize: 16.0);
                              } else if (userCoins.value >=
                                  (messageShowController.getGiftList[messageShowController.selectedGiftIndex.value].coin!
                                          .toInt() *
                                      messageShowController.dropdownvalue.value)) {
                                userCoins.value = userCoins.value -
                                    messageShowController.getGiftList[messageShowController.selectedGiftIndex.value].coin!
                                            .toInt() *
                                        messageShowController.dropdownvalue.value;
                                getstorage.write("UserCoins", userCoins.value);
                                log("########################${messageShowController.getGiftList[messageShowController.selectedGiftIndex.value].coin!.toInt() * messageShowController.dropdownvalue.value}");
                                socket.emit("chat", {
                                  "chatTopic": widget.chatRoomId,
                                  "senderUserId": widget.senderId,
                                  "receiverUserId": widget.userId2,
                                  "gift": messageShowController.getGiftList[messageShowController.selectedGiftIndex.value],
                                  "message":
                                      "${Constant.BASE_URL}${messageShowController.getGiftList[messageShowController.selectedGiftIndex.value].image.toString()}",
                                  "messageType": 1,
                                  "coin":
                                      "${messageShowController.getGiftList[messageShowController.selectedGiftIndex.value].coin!.toInt() * messageShowController.dropdownvalue.value}",
                                });
                              } else {
                                Fluttertoast.showToast(
                                    msg: "Not Sufficient Coins",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: ThemeColor.white,
                                    textColor: ThemeColor.pink,
                                    fontSize: 16.0);
                              }
                              // messageShowController.scrollController.animateTo(
                              //     messageShowController.scrollController
                              //         .position.maxScrollExtent,
                              //     duration: Duration(milliseconds: 300),
                              //     curve: Curves.easeOut);
                              Get.back();
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: ThemeColor.pink,
                                border: Border.all(color: ThemeColor.pink, width: 1),
                                borderRadius:
                                    const BorderRadius.only(topRight: Radius.circular(100), bottomRight: Radius.circular(100)),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                "Send",
                                style: TextStyle(
                                  color: ThemeColor.white,
                                  fontSize: 16.5,
                                  fontFamily: 'abold',
                                ),
                              ),
                            ),
                          )),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }

  ///Gift sheet GiftImage
  GridView sticker() {
    return GridView.builder(
      scrollDirection: Axis.vertical,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.only(left: 5, right: 5),
      shrinkWrap: true,
      itemCount: messageShowController.getGiftList.length,
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 100,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (BuildContext context, i) {
        return InkWell(
          onTap: () {
            messageShowController.selectedGiftIndex.value = i;
          },
          child: Obx(
            () => Container(
              height: 78,
              decoration: (messageShowController.selectedGiftIndex.value == i)
                  ? BoxDecoration(
                      color: ThemeColor.graymidum,
                      borderRadius: const BorderRadius.all(Radius.circular(12)),
                      border: Border.all(
                        color: ThemeColor.pink,
                      ),
                    )
                  : const BoxDecoration(color: Colors.transparent),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage("${Constant.BASE_URL}${messageShowController.getGiftList[i].image.toString()}"),
                        fit: BoxFit.cover,
                      ),
                    ),
                    alignment: Alignment.center,
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 11,
                        width: 11,
                        child: Image.asset(AppImages.coinImages),
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      Text(messageShowController.getGiftList[i].coin.toString(),
                          style: const TextStyle(fontFamily: 'amidum', fontSize: 11.5, color: Colors.white)),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
