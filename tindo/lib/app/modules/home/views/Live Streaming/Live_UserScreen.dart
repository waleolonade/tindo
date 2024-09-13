import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:agora_rtc_engine/rtc_local_view.dart' as rtclocalview;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as rtcremoteview;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rayzi/app/API_Services/app_url.dart';
import 'package:rayzi/app/Branch_IO/BranchIOController.dart';
import 'package:rayzi/app/data/AppImages.dart';
import 'package:rayzi/app/data/Colors.dart';
import 'package:rayzi/app/modules/My_App/controllers/Live_User_controller.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

import '../../../../data/APP_variables/AppVariable.dart';
import '../../../../data/Model/CenterTab_Model/HostComment_Model.dart';
import '../../../My_App/views/UserliveProfileDailog.dart';
import '../../../My_App/views/Userlive_EndScreen.dart';

class LiveUserScreen extends StatefulWidget {
  final String channelName;
  final String token;
  final String liveHostId;
  final String liveRoomId;
  final ClientRole clientRole;
  final String mongoID;

  const LiveUserScreen(
      {super.key,
      required this.token,
      required this.liveRoomId,
      required this.clientRole,
      required this.channelName,
      required this.liveHostId,
      required this.mongoID});

  @override
  State<LiveUserScreen> createState() => _LiveUserScreenState();
}

class _LiveUserScreenState extends State<LiveUserScreen> with SingleTickerProviderStateMixin {
  TabController? tabController1;
  LiveUsercontroller liveUserController = Get.put(LiveUsercontroller());
  BranchIOController branchIOController = Get.put(BranchIOController());
  final ScrollController scrollController = ScrollController();
  String gift = "";
  String senderUserName = "";
  String count = "";
  bool showGift = false;
  bool muted = false;
  late RtcEngine _engine;
  int view = 0;
  final _users = <int>[];
  List viewData = [];
  double thisLiveCoin = 0;

  void connect() {
    var obj = json.encode({
      "liveUserRoom": widget.liveHostId,
      "liveRoom": widget.liveRoomId,
    }.map((key, value) => MapEntry(key, value.toString())));

    liveSocket = io.io(Constant.BASE_URL, io.OptionBuilder().setTransports(['websocket']).setQuery({"obj": obj}).build());
    liveSocket.connect();
    liveSocket.onConnect((data1) {
      liveSocket.on("view", (data) {
        viewData = data;
        setState(() {
          log("Total view count host :: ${viewData.length}");
          view = viewData.length;
        });
      });
    });
    liveSocket.on("comment", (data) {
      setState(() {
        liveUserController.sendComment(
            image: data["image"], user: data["user"], message: data["message"], useRID: data["userID"]);
      });
    });
    liveSocket.on("gift", (data) {
      setState(() {
        int coin;
        coin = int.parse("${data[0]["coin"]}");
        thisLiveCoin = thisLiveCoin + coin;
        userCoins.value = data[2]["coin"];
        count = "${data[0]["count"]}";
        senderUserName = "${data[0]["senderUserName"]}";
        gift = "${Constant.BASE_URL}${data[0]["gift"]["image"]}";
        log("gift user coin:: ${data[2]["coin"]}");
        showGift = true;
      });
      Future.delayed(const Duration(seconds: 5)).then((value) {
        setState(() {
          gift = "";
          count = "";
          showGift = false;
        });
      });
    });
  }

  @override
  void initState() {
    dummyCommentList.clear();
    initialize();
    connect();
    tabController1 = TabController(length: 2, vsync: this, initialIndex: 0);

    Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      setState(() {});
    });
    // TODO: implement initState

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
    }, userJoined: (uid, elapsed) {
      setState(() {
        final info = "User Joined:$uid";
        infoString.add(info);
        _users.add(uid);
      });
    }, userOffline: (uid, elapsed) {
      setState(() {
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
      list.add(const rtclocalview.SurfaceView());
    }
    for (var uid in _users) {
      list.add(rtcremoteview.SurfaceView(uid: uid, channelId: widget.channelName));
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

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        showDialog(
          context: context,
          builder: (context) {
            return backDialog();
          },
        );
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: commentSection(),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: SizedBox(
                height: 50,
                child: GetBuilder<LiveUsercontroller>(
                  builder: (controller) => TextFormField(
                    controller: liveUserController.commentController,
                    style: TextStyle(
                      fontFamily: 'alight',
                      color: ThemeColor.white,
                      fontSize: 16,
                    ),
                    decoration: InputDecoration(
                      filled: true,
                      suffixIcon: Padding(
                        padding: const EdgeInsets.all(10),
                        child: InkWell(
                          onTap: () {
                            if (liveUserController.commentController.text.isEmpty ||
                                liveUserController.commentController.text.isBlank == true) {
                            } else {
                              liveSocket.emit("comment", {
                                "liveStreamingId": widget.liveRoomId,
                                "message": liveUserController.commentController.text,
                                "user": userName,
                                "image": userProfile.value,
                                'userID': userID,
                              });
                              liveUserController.commentController.clear();
                            }
                          },
                          child: const ImageIcon(
                            AssetImage("Images/Center_Tab/send.png"),
                            color: Colors.white,
                            size: 10,
                          ),
                        ),
                      ),
                      contentPadding: const EdgeInsets.only(
                        left: 30,
                      ),
                      fillColor: Colors.black26,
                      border: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(50)),
                      hintText: "Say something...",
                      hintStyle: TextStyle(
                        fontFamily: 'alight',
                        color: ThemeColor.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        body: SizedBox(
            height: Get.height,
            width: Get.width,
            child: Stack(
              children: [
                viewRows(),
                Padding(
                  padding: const EdgeInsets.only(top: 35),
                  child: Stack(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Get.bottomSheet(
                                          isScrollControlled: true,
                                          profileSheet(),
                                        );
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(50),
                                          color: ThemeColor.blackback.withOpacity(0.3),
                                        ),
                                        padding: const EdgeInsets.only(left: 5, right: 10, top: 5, bottom: 5),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Container(
                                              height: 48,
                                              width: 48,
                                              clipBehavior: Clip.hardEdge,
                                              decoration: const BoxDecoration(shape: BoxShape.circle),
                                              child: CachedNetworkImage(
                                                placeholder: (context, url) =>
                                                    Image.asset(AppImages.profileImagePlaceHolder, fit: BoxFit.cover),
                                                fit: BoxFit.cover,
                                                imageUrl: userProfile.value,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 6,
                                            ),
                                            Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  userName,
                                                  style: TextStyle(color: ThemeColor.white, fontSize: 16, fontFamily: 'amidum'),
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Row(
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets.only(left: 5),
                                                      child: Container(
                                                        height: 16,
                                                        width: 16,
                                                        decoration: BoxDecoration(
                                                          shape: BoxShape.circle,
                                                          image: DecorationImage(
                                                            fit: BoxFit.cover,
                                                            image: AssetImage(
                                                              AppImages.coinImages,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Obx(
                                                      () => Padding(
                                                        padding: const EdgeInsets.only(left: 5, right: 5),
                                                        child: Text(
                                                          "${userCoins.value}",
                                                          style: TextStyle(
                                                            color: ThemeColor.white,
                                                            fontSize: 13.5,
                                                            fontWeight: FontWeight.w400,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 12,
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          height: 26,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(20),
                                            color: ThemeColor.blackback.withOpacity(0.3),
                                          ),
                                          padding: const EdgeInsets.only(left: 5, right: 5),
                                          child: Row(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(left: 5),
                                                child: Container(
                                                  height: 16,
                                                  width: 16,
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    image: DecorationImage(
                                                      fit: BoxFit.cover,
                                                      image: AssetImage(
                                                        AppImages.coinImages,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(left: 5, right: 5),
                                                child: Text(
                                                  "${thisLiveCoin.toInt()}",
                                                  style: TextStyle(
                                                    color: ThemeColor.white,
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 3.5,
                                        ),
                                        Container(
                                          height: 26,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(20),
                                            color: ThemeColor.blackback.withOpacity(0.3),
                                          ),
                                          padding: const EdgeInsets.only(left: 10, right: 10),
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.remove_red_eye,
                                                size: 16,
                                                color: ThemeColor.white,
                                              ),
                                              const SizedBox(
                                                width: 3,
                                              ),
                                              Text(
                                                '$view',
                                                style: TextStyle(fontFamily: 'amidum', color: ThemeColor.white, fontSize: 12),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 3.5,
                                        ),
                                        Container(
                                          height: 26,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(20),
                                            color: ThemeColor.blackback.withOpacity(0.3),
                                          ),
                                          padding: const EdgeInsets.only(left: 10, right: 10),
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.access_time_filled,
                                                size: 16,
                                                color: ThemeColor.white,
                                              ),
                                              const SizedBox(
                                                width: 3,
                                              ),
                                              GetBuilder<LiveUsercontroller>(
                                                builder: (controller) => Text(
                                                  '${controller.hours.toString().padLeft(2, '0')}:${controller.minutes.toString().padLeft(2, '0')}:${controller.seconds.toString().padLeft(2, '0')}',
                                                  style: TextStyle(fontFamily: 'amidum', color: ThemeColor.white, fontSize: 12),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Row(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            branchIOController.imageURL.value = userProfile.value;
                                            branchIOController.initDeepLinkDataLiveStriming(
                                              shareType: 3,
                                              token: widget.token,
                                              liveuserid: userID,
                                              channelName: widget.channelName,
                                              liveStrimingid: widget.liveRoomId,
                                              liveusername: userName,
                                              liveuserimage: userProfile.value,
                                              mongoId: widget.mongoID,
                                              diamond: "$userCoins",
                                            );
                                            branchIOController.generateLink();
                                          },
                                          child: const ImageIcon(
                                            AssetImage("Images/Post_Screen/share_post.png"),
                                            color: Colors.white,
                                            size: 24,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 15,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            showDialog(
                                              context: context,
                                              builder: (context) {
                                                return backDialog();
                                              },
                                            );
                                          },
                                          child: Container(
                                            height: 34,
                                            width: 34,
                                            decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                              // color: Colors.black26,
                                            ),
                                            child: const Icon(
                                              Icons.close,
                                              color: Colors.white,
                                              size: 26,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 50,
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 0),
                                      child: InkWell(
                                          onTap: () {
                                            _engine.switchCamera();
                                          },
                                          child: Image.asset(
                                            AppImages.flipCamera,
                                            width: 40,
                                            height: 40,
                                            color: ThemeColor.white,
                                          )),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 5),
                                      child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            muted = !muted;
                                          });
                                          _engine.muteLocalAudioStream(muted);
                                        },
                                        child: (muted)
                                            ? Image.asset(
                                                AppImages.liveStrimingMutemic,
                                                width: 40,
                                                height: 40,
                                                color: ThemeColor.white,
                                              )
                                            : Image.asset(
                                                AppImages.liveStrimingmic,
                                                width: 40,
                                                height: 40,
                                                color: ThemeColor.white,
                                              ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                        ],
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
                                      count,
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
            )),
      ),
    );
  }

  Container profileSheet() {
    return Container(
      height: Get.height / 1.3,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(22), topRight: Radius.circular(22)),
        color: ThemeColor.blackback.withOpacity(0.8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 10,
          ),
          Container(
            height: 6,
            width: 50,
            decoration: BoxDecoration(color: ThemeColor.pink, borderRadius: const BorderRadius.all(Radius.circular(10))),
          ),
          const SizedBox(
            height: 15,
          ),
          TabBar(
              controller: tabController1,
              indicatorColor: ThemeColor.pink,
              labelStyle: TextStyle(color: ThemeColor.white, fontFamily: 'amidum', fontSize: 17),
              indicator: BoxDecoration(color: ThemeColor.transparent),
              tabs: const [
                Tab(
                  text: "VIEWERS",
                ),
                Tab(
                  text: "STATISICS",
                ),
              ]),
          Expanded(
            child: SizedBox(
              child: TabBarView(
                controller: tabController1,
                children: [
                  (viewData.isEmpty)
                      ? Center(
                          child: Text('No gifts received in this broadcast',
                              style: TextStyle(color: ThemeColor.white, fontSize: 16, fontFamily: 'alight')),
                        )
                      : Expanded(
                          child: SizedBox(
                          child: ListView.builder(
                            itemCount: viewData.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Container(
                                  height: 60,
                                  width: Get.width,
                                  padding: const EdgeInsets.only(left: 15, right: 15),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      CircleAvatar(
                                        backgroundColor: ThemeColor.grayIcon,
                                        foregroundImage: NetworkImage("${viewData[index]["profileImage"]}"),
                                      ),
                                      const SizedBox(
                                        width: 15,
                                      ),
                                      Text(
                                        '${viewData[index]["name"]}',
                                        style: TextStyle(color: ThemeColor.white, fontFamily: 'alight', fontSize: 18),
                                      ),
                                      const Spacer(),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        )),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Container(
                          height: 60,
                          width: Get.width,
                          decoration: BoxDecoration(
                            color: ThemeColor.grayinsta,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          padding: const EdgeInsets.only(left: 15, right: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.access_time_filled_outlined,
                                color: ThemeColor.white,
                                size: 16,
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              Text(
                                'Time',
                                style: TextStyle(color: ThemeColor.white, fontFamily: 'alight', fontSize: 20),
                              ),
                              const Spacer(),
                              Obx(
                                () => Text(
                                  '${liveUserController.hours.toString().padLeft(2, '0')}:${liveUserController.minutes.toString().padLeft(2, '0')}:${liveUserController.seconds.toString().padLeft(2, '0')}',
                                  style: TextStyle(fontSize: 22, fontFamily: 'amidum', color: ThemeColor.white),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15, right: 15, bottom: 17),
                        child: Container(
                          height: 60,
                          width: Get.width,
                          decoration: BoxDecoration(
                            color: ThemeColor.grayinsta,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          padding: const EdgeInsets.only(left: 15, right: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.remove_red_eye_outlined,
                                color: ThemeColor.white,
                                size: 20,
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Viewers',
                                    style: TextStyle(color: ThemeColor.white, fontFamily: 'alight', fontSize: 20),
                                  ),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                  Text(
                                    'in stream',
                                    style: TextStyle(color: ThemeColor.offwhite, fontFamily: 'amidum', fontSize: 15),
                                  ),
                                ],
                              ),
                              const Spacer(),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '$view',
                                    style: TextStyle(fontSize: 22, fontFamily: 'amidum', color: ThemeColor.white),
                                  ),
                                  // Text(
                                  //   '$view',
                                  //   style: TextStyle(
                                  //     fontSize: 15,
                                  //     fontFamily: 'alight',
                                  //     color: ThemeColor.offwhite,
                                  //   ),
                                  // ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15, right: 15, bottom: 17),
                        child: Container(
                          height: 60,
                          width: Get.width,
                          decoration: BoxDecoration(
                            color: ThemeColor.grayinsta,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          padding: const EdgeInsets.only(left: 15, right: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 20,
                                width: 20,
                                child: Image.asset(AppImages.coinImages),
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Diamonds',
                                    style: TextStyle(color: ThemeColor.white, fontFamily: 'alight', fontSize: 20),
                                  ),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                  Text(
                                    'to cash out',
                                    style: TextStyle(color: ThemeColor.offwhite, fontFamily: 'amidum', fontSize: 15),
                                  ),
                                ],
                              ),
                              const Spacer(),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    '+${thisLiveCoin.toInt()}',
                                    style: TextStyle(fontSize: 22, fontFamily: 'amidum', color: ThemeColor.white),
                                  ),
                                  Text(
                                    '$userDiamond',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontFamily: 'alight',
                                      color: ThemeColor.offwhite,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  GetBuilder<LiveUsercontroller> commentSection() {
    return GetBuilder(builder: (context) {
      return Container(
          margin: const EdgeInsets.only(
            right: 60,
          ),
          height: 250,
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
                controller: scrollController,
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
                                      ///\\\\\
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
    });
  }

  Dialog backDialog() {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      child: Container(
        height: 230,
        decoration: BoxDecoration(
          color: ThemeColor.white,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 20,
            ),
            Text(
              "Are you sure you want to end broadcast?",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontFamily: 'amidum',
                color: ThemeColor.blackback,
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: GestureDetector(
                onTap: () => Get.back(),
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: ThemeColor.pink,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    "Continue Broadcast",
                    style: TextStyle(
                      color: ThemeColor.white,
                      fontSize: 16,
                      fontFamily: 'abold',
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: GestureDetector(
                onTap: () {
                  _engine.destroy();
                  liveSocket.disconnect();
                  liveSocket.dispose();
                  String finalTime =
                      '${liveUserController.hours.toString().padLeft(2, '0')}:${liveUserController.minutes.toString().padLeft(2, '0')}:${liveUserController.seconds.toString().padLeft(2, '0')}';
                  Get.to(() => UerLiveEndScreen(
                        liveStreamingID: widget.liveRoomId,
                        totalDuration: finalTime,
                      ));
                },
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: ThemeColor.white,
                      border: Border.all(color: ThemeColor.greAlpha20.withOpacity(0.3))),
                  alignment: Alignment.center,
                  child: Text(
                    "End Broadcast",
                    style: TextStyle(
                      color: ThemeColor.blackback,
                      fontSize: 16,
                      fontFamily: 'abold',
                    ),
                  ),
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
}
