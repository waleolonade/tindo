import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:agora_rtc_engine/rtc_local_view.dart' as RtcLocalView;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemoteView;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:rayzi/app/API_Services/app_url.dart';
import 'package:rayzi/app/Branch_IO/BranchIOController.dart';
import 'package:rayzi/app/data/APP_variables/AppVariable.dart';
import 'package:rayzi/app/data/AppImages.dart';
import 'package:rayzi/app/data/Colors.dart';
import 'package:rayzi/app/modules/My_App/views/my_app_view.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

import '../../../../data/Model/CenterTab_Model/HostComment_Model.dart';
import '../../../My_App/controllers/my_app_controller.dart';
import '../../../My_App/views/UserliveProfileDailog.dart';
import '../../../User_Profile/views/second_user_profile.dart';
import '../../controllers/LiveStreaming_controller.dart';

class LiveStreamingScreen extends StatefulWidget {
  final String token;
  final String liveUserId;
  final String channelName;
  final ClientRole clientRole;
  final String liveStreamingId;
  final String liveUserName;
  final String liveUserImage;
  final String mongoId;
  final String userCoin;
  final String followStatus;

  const LiveStreamingScreen(
      {super.key,
      required this.token,
      required this.channelName,
      required this.liveUserId,
      required this.clientRole,
      required this.liveStreamingId,
      required this.liveUserName,
      required this.liveUserImage,
      required this.mongoId,
      required this.userCoin,
      required this.followStatus});

  @override
  State<LiveStreamingScreen> createState() => _LiveStreamingScreenState();
}

class _LiveStreamingScreenState extends State<LiveStreamingScreen> with SingleTickerProviderStateMixin {
  ///----------- For Gift --------------
  String gift = "";
  String senderUserName = "";
  String giftCount = "";
  bool showGift = false;
  RxString liveUserCoin = "".obs;

  ///---------------------------------------------
  late PersistentBottomSheetController bottomSheetController; // <------ Instance variable
  final _users = <int>[];
  int view = 0;
  final infoString = <String>[];
  late RtcEngine _engine;
  bool isUserJoin = false;
  final ScrollController scrollController1 = ScrollController();
  MyAppController myAppController = Get.put(MyAppController());
  LiveStreamingController liveStreamingController = Get.put(LiveStreamingController());
  BranchIOController branchIOController = Get.put(BranchIOController());
  TextEditingController textEditingController = TextEditingController();

  void connect() {
    var obj = json.encode({
      "liveRoom": widget.liveStreamingId,
      "showUserRoom": userID,
    }.map((key, value) => MapEntry(key, value.toString())));
    liveStreamingSocket =
        io.io(Constant.BASE_URL, io.OptionBuilder().setTransports(['websocket']).setQuery({"obj": obj}).build());
    liveStreamingSocket.connect();
    liveStreamingSocket.onConnect((data1) {
      liveStreamingSocket.emit("addView", {
        "userId": userID,
        "name": userName,
        "profileImage": userProfile.value,
        "liveStreamingId": widget.liveStreamingId,
        "mongoId": widget.mongoId,
      });
      //
      liveStreamingSocket.emit("comment", {
        "liveStreamingId": widget.liveStreamingId,
        "message": "$userName joined",
        "user": userName,
        "image": userProfile.value,
      });

      liveStreamingSocket.on("view", (data) {
        List viewdata = data;
        setState(() {
          log("Total view count user :: ${viewdata.length}");
          view = viewdata.length;
        });
      });

      ///Listion
      liveStreamingSocket.on("comment", (data) {
        log("comment ========== $data");
        if (mounted) {
          setState(() {
            dummyCommentList.add(HostComment(
              message: data["message"],
              user: data["user"],
              image: data["image"],
              userID: data["userID"],
            ));
          });
        }
      });
      liveStreamingSocket.on("gift", (data) async {
        log("Gifttt host :: $data");
        log("Gifttt host coin:: ${data[2]["coin"]}");

        setState(() {
          liveUserCoin.value = data[2]["coin"];
          gift = "${Constant.BASE_URL}${data[0]["gift"]["image"]}";
          senderUserName = "${data[0]["senderUserName"]}";
          showGift = data[0]["showgift"];
          giftCount = data[0]["count"];
        });

        await Future.delayed(const Duration(seconds: 5)).then((value) {
          setState(() {
            gift = "";
            showGift = false;
          });
        });
      });
    });
  }

  void userOut() {
    liveStreamingSocket.emit("lessView", {
      "userId": userID,
      "name": userName,
      "profileImage": userProfile.value,
      "liveStreamingId": widget.liveStreamingId,
      "mongoId": widget.mongoId,
    });
    log("Total view less by user");
    liveStreamingSocket.dispose();
    liveStreamingSocket.disconnect();
  }

  @override
  void initState() {
    liveUserCoin.value = widget.userCoin;
    initialize();
    connect();
    Timer(const Duration(seconds: 10), () {
      if (isUserJoin == false) {
        Get.offAll(const MyApp());
      }
    });
    super.initState();
  }

  Future<void> initialize() async {
    if (appId.isEmpty) {
      setState(() {
        infoString.add("appId is missing, Please provide your appId in app_variables.dart");
        infoString.add("Agora engine is not starting");
      });
      return;
    }
    _engine = await RtcEngine.create(appId);
    await _engine.enableVideo();
    await _engine.setChannelProfile(ChannelProfile.LiveBroadcasting);
    await _engine.setClientRole(widget.clientRole);
    addAgoraEventHandlers();
    VideoEncoderConfiguration configuration = VideoEncoderConfiguration();
    configuration.dimensions = const VideoDimensions(width: 1920, height: 1080);
    await _engine.setVideoEncoderConfiguration(configuration);
    await _engine.joinChannel(widget.token, widget.channelName, null, 0);
  }

  void addAgoraEventHandlers() {
    _engine.setEventHandler(RtcEngineEventHandler(error: (code) {
      setState(() {
        final info = "Error :$code";
        infoString.add(info);
      });
    }, joinChannelSuccess: (channel, uid, elapsed) {
      setState(() {
        final info = "Join Channel:$channel,uid:$uid";
        infoString.add(info);
      });
    }, leaveChannel: (stats) {
      setState(() {
        infoString.add("Leave Channel");
        _users.clear();
      });
    }, remoteVideoStats: (stats) {
      log("++++++++++++++++++++++++++++++++");
      setState(() {
        isUserJoin = true;
      });
    }, userJoined: (uid, elapsed) {
      setState(() {
        final info = "User Joined:$uid";
        infoString.add(info);
        _users.add(uid);
      });
    }, userOffline: (uid, elapsed) {
      setState(() {
        _users.clear();
        _engine.destroy();
        Get.offAll(() => const MyApp());

        final info = "User Offline:$uid";
        infoString.add(info);
        _users.remove(uid);
      });
    }, firstRemoteVideoFrame: (uid, width, height, elapsed) {
      setState(() {
        final info = "First Remote Video:$uid ${width}x$height";
        infoString.add(info);
      });
    }));
  }

  Widget viewRows() {
    final List<StatefulWidget> list = [];
    if (widget.clientRole == ClientRole.Broadcaster) {
      list.add(const RtcLocalView.SurfaceView());
    }
    for (var uid in _users) {
      list.add(RtcRemoteView.SurfaceView(uid: uid, channelId: widget.channelName));
    }
    final views = list;
    return Column(
      children: List.generate(views.length, (index) => Expanded(child: views[index])),
    );
  }

  @override
  void dispose() {
    _users.clear();
    _engine.leaveChannel();
    _engine.destroy();
    dummyCommentList.clear();
    super.dispose();
  }

  FocusNode focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        userOut();
        //myAppController.tabIndex = 0;
        //Get.offAll(MyApp());
        Get.back();
        return false;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            SizedBox(
              height: Get.height,
              width: Get.width,
              child: viewRows(),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 38,
                left: 18,
                right: 15,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      userOut();
                      Get.back();
                      //Get.offAll(MyApp());
                    },
                    child: ImageIcon(
                      const AssetImage(
                        "Images/new_dis/back.png",
                      ),
                      size: 25,
                      color: ThemeColor.white,
                    ),
                  ),
                  const Spacer(),
                  Container(
                    height: 28,
                    decoration:
                        BoxDecoration(color: ThemeColor.blackback.withOpacity(0.3), borderRadius: BorderRadius.circular(8)),
                    padding: const EdgeInsets.only(left: 5, right: 5, top: 3, bottom: 3),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.remove_red_eye,
                          color: ThemeColor.white,
                          size: 22,
                        ),
                        const SizedBox(
                          width: 3,
                        ),
                        Text(
                          "$view",
                          style: TextStyle(color: ThemeColor.white, fontFamily: 'amidum', fontSize: 16),
                        ),
                        const SizedBox(
                          width: 18,
                        ),
                        GestureDetector(
                          onTap: () {
                            branchIOController.imageURL.value = userProfile.value;
                            branchIOController.initDeepLinkDataLiveStriming(
                              shareType: 3,
                              token: widget.token,
                              liveuserid: widget.liveUserId,
                              channelName: widget.channelName,
                              liveStrimingid: widget.liveStreamingId,
                              liveusername: userName,
                              liveuserimage: userProfile.value,
                              mongoId: widget.mongoId,
                              diamond: widget.userCoin ?? '',
                            );
                            branchIOController.generateLink();
                          },
                          child: ImageIcon(
                            const AssetImage(
                              "Images/Post_Screen/share_post.png",
                            ),
                            size: 25,
                            color: ThemeColor.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: Get.height / 2.1,
                //  bottom: Get.height / 2.1,
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 5,
                    ),
                    child: commentSection(),
                  ),
                  const SizedBox(
                    height: 10,
                  ),

                  ///=====\\\
                  SizedBox(
                    height: 70,
                    width: Get.width,
                    child: Obx(
                      () => (liveStreamingController.giftLoading.value)
                          ? const SizedBox()
                          : ListView.builder(
                              shrinkWrap: true,
                              itemCount: liveStreamingController.getGiftList.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () async {
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
                                        (liveStreamingController.getGiftList[index].coin!.toInt() * 1)) {
                                      int cutCoin = liveStreamingController.getGiftList[index].coin!.toInt() * 1;
                                      userCoins.value = userCoins.value - cutCoin;
                                      getstorage.write("UserCoins", userCoins.value);
                                      liveStreamingSocket.emit("UserGift", {
                                        "coin": "$cutCoin",
                                        "liveStreaming": widget.liveStreamingId,
                                        "senderUserId": userID,
                                        "senderUserName": userName,
                                        "receiverUserId": widget.liveUserId,
                                        "showgift": true,
                                        "gift": liveStreamingController.getGiftList[index],
                                        "count": "x1",
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
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 4, right: 4),
                                    child: Container(
                                      decoration: const BoxDecoration(color: Colors.transparent),
                                      child: Column(
                                        children: [
                                          Container(
                                            width: 45,
                                            height: 45,
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                // image: AssetImage(
                                                //     scrollSticker[index]),
                                                image: NetworkImage(
                                                    "${Constant.BASE_URL}${liveStreamingController.getGiftList[index].image}"),
                                                fit: BoxFit.cover,
                                              ),
                                              shape: BoxShape.circle,
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
                                                height: 10,
                                                width: 10,
                                                child: Image.asset(AppImages.coinImages),
                                              ),
                                              const SizedBox(
                                                width: 4,
                                              ),
                                              Text("${liveStreamingController.getGiftList[index].coin}",
                                                  style:
                                                      const TextStyle(fontFamily: 'amidum', fontSize: 11, color: Colors.white)),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.bottomSheet(
                                barrierColor: Colors.transparent,
                                BottomSheet(
                                  backgroundColor: Colors.black12,
                                  onClosing: () {},
                                  builder: (BuildContext context) {
                                    return commentTextfield();
                                  },
                                ),
                                backgroundColor: Colors.transparent);
                          },
                          child: Container(
                            // height: Get.height / 14.5,
                            // width: Get.width / 7,
                            height: 55,
                            width: 55,
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Image.asset("Images/Post_Screen/comment.png", color: ThemeColor.white, fit: BoxFit.fill),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              Get.to(() => SecondUserProfileView(
                                    userID: widget.liveUserId,
                                  ));
                            },
                            child: Container(
                              height: Get.height / 14.5,
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(100),
                              ),
                              padding: const EdgeInsets.all(2.5),
                              child: Row(
                                children: [
                                  Container(
                                    height: Get.height / 14.5,
                                    width: Get.width / 7,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(image: NetworkImage(widget.liveUserImage), fit: BoxFit.cover),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 3,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        widget.liveUserName.toString().length >= 14
                                            ? '${widget.liveUserName.toString().substring(0, 14)}...'
                                            : widget.liveUserName.toString(),
                                        style: TextStyle(color: ThemeColor.white, fontSize: 12, fontFamily: 'amidum'),
                                      ),
                                      const SizedBox(
                                        height: 6,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Image.asset(
                                            AppImages.coinImages,
                                            height: 16.6,
                                            width: 16.6,
                                          ),
                                          Obx(
                                            () => Text(
                                              "  ${liveUserCoin.value}",
                                              style: TextStyle(fontFamily: 'amidum', fontSize: 12, color: ThemeColor.white),
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                  const Spacer(),
                                  widget.followStatus == "null"
                                      ? Padding(
                                          padding: const EdgeInsets.only(right: 3),
                                          child: Container(
                                            height: Get.height / 18,
                                            width: Get.width / 8,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: ThemeColor.pink,
                                            ),
                                            alignment: Alignment.center,
                                            child: (widget.followStatus == "Follow")
                                                ? Icon(Icons.add, color: ThemeColor.white, size: 22)
                                                : (widget.followStatus == "Friends")
                                                    ? Icon(Icons.check, color: ThemeColor.white, size: 22)
                                                    : null,
                                          ),
                                        )
                                      : const SizedBox.shrink(),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        GestureDetector(
                          onTap: () => Get.bottomSheet(isScrollControlled: true, giftsheet()),
                          child: Container(
                            // height: Get.height / 14.5,
                            // width: Get.width / 7,
                            height: 55,
                            width: 55,
                            decoration: BoxDecoration(
                              color: ThemeColor.white,
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Image.asset("Images/Post_Screen/gift.png", color: Colors.black, fit: BoxFit.fill),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            (showGift)
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 250,
                          width: Get.width * 0.60,
                          child: Stack(
                            children: [
                              Container(
                                width: 200,
                                height: 200,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    // image: AssetImage(emojiImage.last),
                                    image: NetworkImage(gift),
                                  ),
                                ),
                              ).paddingOnly(bottom: 35),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: Text(
                                  giftCount,
                                  style: const TextStyle(
                                    fontFamily: "amidum",
                                    fontSize: 80,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                              ).paddingAll(25),
                            ],
                          ),
                        ),
                        Text(
                          senderUserName,
                          style: TextStyle(
                              fontFamily: "amidum",
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: ThemeColor.white,
                              fontStyle: FontStyle.italic),
                        ),
                      ],
                    ),
                  )
                : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }

  ConstrainedBox commentTextfield() {
    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: 60),
      child: Container(
        color: Colors.black,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: ConstrainedBox(
                constraints: const BoxConstraints(minHeight: 50),
                child: SizedBox(
                  child: Card(
                    color: Colors.black38,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                    child: TextFormField(
                      keyboardAppearance: Brightness.dark,
                      focusNode: focusNode,
                      minLines: 1,
                      maxLines: 5,
                      keyboardType: TextInputType.multiline,
                      controller: textEditingController,
                      autofocus: true,
                      autocorrect: false,
                      cursorColor: const Color(0xff767676),
                      style: TextStyle(
                        fontFamily: 'amidum',
                        fontSize: 14,
                        color: ThemeColor.white,
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.only(top: 15, bottom: 15, left: 15, right: 15),
                        hintText: "Say something.....",
                        hintStyle: TextStyle(
                          fontFamily: 'amidum',
                          fontSize: 14,
                          color: ThemeColor.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 15),
              child: GestureDetector(
                onTap: () {
                  if (textEditingController.text.isNotEmpty) {
                    setState(() {
                      liveStreamingSocket.emit("comment", {
                        "liveStreamingId": widget.liveStreamingId,
                        "message": textEditingController.text,
                        "user": userName,
                        "image": userProfile.value,
                        "userID": userID,
                      });
                    });
                    textEditingController.clear();
                    Get.back();
                  }
                },
                child: Container(
                  height: 38,
                  width: 38,
                  decoration: const BoxDecoration(
                    color: Colors.black38,
                    shape: BoxShape.circle,
                  ),
                  padding: const EdgeInsets.all(10),
                  child: Image.asset(
                    "Images/Home/send_live.png",
                    color: ThemeColor.white,
                    width: 25,
                    height: 25,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

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
            Container(
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
                    child: (liveStreamingController.giftLoading.value)
                        ? Center(
                            child: CircularProgressIndicator(
                            color: ThemeColor.pink,
                          ))
                        : sticker(),
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
                                    value: liveStreamingController.dropdownvalue.value,
                                    icon: const Icon(Icons.keyboard_arrow_down, color: Colors.white),
                                    elevation: 0,
                                    underline: Container(),
                                    dropdownColor: Colors.black,
                                    items: liveStreamingController.items.map((int items) {
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
                                      liveStreamingController.dropdownvalue.value = newValue!;
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () async {
                                if (userCoins.value == 0) {
                                  Fluttertoast.showToast(
                                      msg: "Not Sufficient Coins",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.CENTER,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: ThemeColor.white,
                                      textColor: ThemeColor.pink,
                                      fontSize: 16.0);
                                  Get.back();
                                } else if (userCoins.value >=
                                    (liveStreamingController.getGiftList[liveStreamingController.selectedGiftIndex.value].coin!
                                            .toInt() *
                                        liveStreamingController.dropdownvalue.value)) {
                                  int cutCoins = liveStreamingController
                                          .getGiftList[liveStreamingController.selectedGiftIndex.value].coin!
                                          .toInt() *
                                      liveStreamingController.dropdownvalue.value;
                                  userCoins.value = userCoins.value - cutCoins;
                                  getstorage.write("UserCoins", userCoins.value);
                                  liveStreamingSocket.emit("UserGift", {
                                    "coin": "$cutCoins",
                                    "liveStreaming": widget.liveStreamingId,
                                    "senderUserId": userID,
                                    "receiverUserId": widget.liveUserId,
                                    "senderUserName": userName,
                                    "showgift": true,
                                    "gift": liveStreamingController.getGiftList[liveStreamingController.selectedGiftIndex.value],
                                    "count": "x${liveStreamingController.dropdownvalue.value}",
                                  });
                                  Get.back();
                                } else {
                                  Fluttertoast.showToast(
                                      msg: "Not Sufficient Coins",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.CENTER,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: ThemeColor.white,
                                      textColor: ThemeColor.pink,
                                      fontSize: 16.0);
                                  Get.back();
                                }
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
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  GridView sticker() {
    return GridView.builder(
      scrollDirection: Axis.vertical,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.only(left: 5, right: 5),
      shrinkWrap: true,
      itemCount: liveStreamingController.getGiftList.length,
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 100,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (BuildContext context, i) {
        return InkWell(
          onTap: () {
            liveStreamingController.selectedGiftIndex.value = i;
          },
          child: Obx(
            () => Container(
              height: 78,
              decoration: (liveStreamingController.selectedGiftIndex.value == i)
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
                        //image: AssetImage(stickerList[i].image),
                        image: NetworkImage("${Constant.BASE_URL}${liveStreamingController.getGiftList[i].image}"),
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
                      Text("${liveStreamingController.getGiftList[i].coin}",
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

  Container commentSection() {
    return Container(
        margin: const EdgeInsets.only(
          right: 60,
        ),
        height: Get.height / 3.2,
        child: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (notification) {
            notification.disallowIndicator();
            return false;
          },
          child: ShaderMask(
            shaderCallback: (bounds) {
              return const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.purple, Colors.transparent, Colors.transparent, Colors.purple],
                stops: [0.0, 0.1, 0.9, 1.0], // 10% purple, 80% transparent, 10% purple
              ).createShader(bounds);
            },
            blendMode: BlendMode.dstOut,
            child: ListView.builder(
              controller: scrollController1,
              shrinkWrap: true,
              reverse: true,
              itemCount: dummyCommentList.length,
              itemBuilder: (BuildContext context, int index) {
                final reversedIndex = dummyCommentList.length - 1 - index;
                if (dummyCommentList.isEmpty) {
                  return const SizedBox();
                }
                return Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          (dummyCommentList[reversedIndex].userID == userID)
                              ? const SizedBox()
                              : Get.bottomSheet(
                                  shape: const OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius:
                                          BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20))),
                                  backgroundColor: ThemeColor.white,
                                  ProfileDailog(
                                    userId: dummyCommentList[reversedIndex].userID,
                                  ));
                        },
                        child: Row(
                          //   mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ConstrainedBox(
                              constraints: const BoxConstraints(minHeight: 45),
                              child: Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  // color: Colors.black.withOpacity(0.35),
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                padding: const EdgeInsets.all(3),
                                child: Row(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        left: 5,
                                      ),
                                      child: Container(
                                        alignment: Alignment.center,
                                        height: 30,
                                        width: 30,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                              image: NetworkImage(dummyCommentList[reversedIndex].image), fit: BoxFit.cover),
                                        ),
                                      ),
                                    ),
                                    (dummyCommentList[reversedIndex].message == 'Joined')
                                        ? Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                  left: 10,
                                                  right: 15,
                                                  bottom: 3,
                                                ),
                                                child: RichText(
                                                    text: TextSpan(
                                                  text: dummyCommentList[reversedIndex].user,
                                                  style: TextStyle(
                                                    fontFamily: 'amidum',
                                                    color: Colors.white.withOpacity(0.8),
                                                    fontSize: 12.5,
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                  children: <TextSpan>[
                                                    TextSpan(
                                                        text: "   ${dummyCommentList[reversedIndex].message}",
                                                        style: TextStyle(
                                                            fontFamily: 'amidum',
                                                            color: ThemeColor.pink,
                                                            fontSize: 13.5,
                                                            overflow: TextOverflow.ellipsis)),
                                                  ],
                                                )),
                                              ),
                                              const SizedBox(),
                                            ],
                                          )
                                        : Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                  left: 10,
                                                  right: 15,
                                                  bottom: 3,
                                                ),
                                                child: Text(dummyCommentList[reversedIndex].user,
                                                    style: TextStyle(
                                                      fontFamily: 'amidum',
                                                      color: Colors.white.withOpacity(0.6),
                                                      fontSize: 12.5,
                                                      overflow: TextOverflow.ellipsis,
                                                    )),
                                              ),
                                              ConstrainedBox(
                                                constraints: const BoxConstraints(
                                                  maxWidth: 240,
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.only(
                                                    left: 10,
                                                    right: 15,
                                                    bottom: 3,
                                                  ),
                                                  child: Text(
                                                      softWrap: false,
                                                      maxLines: 100,
                                                      overflow: TextOverflow.ellipsis,
                                                      dummyCommentList[reversedIndex].message,
                                                      style: const TextStyle(
                                                        fontFamily: 'amidum',
                                                        color: Colors.white,
                                                        fontSize: 12.5,
                                                        overflow: TextOverflow.ellipsis,
                                                      )),
                                                ),
                                              ),
                                            ],
                                          ),
                                  ],
                                ),
                              ),
                            ),
                            const Spacer(),
                          ],
                        ),
                      ),
                      (index == 0)
                          ? const SizedBox(
                              height: 4,
                            )
                          : const SizedBox(),
                    ],
                  ),
                );
              },
            ),
          ),
        ));
  }
}
