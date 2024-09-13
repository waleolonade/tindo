import 'dart:async';
import 'dart:developer';

import 'package:agora_rtc_engine/rtc_engine.dart';
// ignore:library_prefixes
import 'package:agora_rtc_engine/rtc_local_view.dart' as RtcLocalView;
// ignore:library_prefixes
import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemoteView;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rayzi/app/data/APP_variables/AppVariable.dart';
import 'package:rayzi/app/data/Colors.dart';
import 'package:rayzi/app/modules/Messages/controllers/LiveVideoController.dart';

class LivevideoCall extends StatefulWidget {
  final ClientRole clientRole;
  final String token;
  final String channelName;
  final String callId;
  const LivevideoCall({
    Key? key,
    required this.clientRole,
    required this.token,
    required this.channelName,
    required this.callId,
  }) : super(key: key);

  @override
  State<LivevideoCall> createState() => _LivevideoCallState();
}

class _LivevideoCallState extends State<LivevideoCall> {
  LiveVideoController liveVideoController = Get.put(LiveVideoController());
  late RtcEngine _engine;
  final _users = <int>[];
  final infoString = <String>[];
  int user1 = 0;
  int user2 = 1;
  bool muted = false;
  bool viewPanel = false;
  bool isVolume = true;

  Future<void> initialize() async {
    [
      Permission.microphone,
      Permission.camera,
    ].request();
    if (appId.isEmpty) {
      setState(() {
        infoString.add(
            "appId is missing, Please provide your appId in app_variables.dart");
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
      setState(() {});
    }, joinChannelSuccess: (channel, uid, elapsed) {
      setState(() {
        final info = "Join Channel:$channel,uid:$uid";
        infoString.add(info);
      });
    }, leaveChannel: (stats) {
      setState(() {
        infoString.add("Leave Channel");
        socket.emit("callDisconnect", {
          'callId': widget.callId,
        });

        _engine.destroy();
        log("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!${widget.callId}!!!!!!!!!!");
        Get.back();
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
        infoString.add("Leave Channel");
        socket.emit("callDisconnect", {
          'callId': widget.callId,
        });
        _engine.destroy();
        log("!!!!!!!!!!!!!!!!!!!!@@@@@@@@@@@@@!!!${widget.callId}!!!!!!!!!!!!!");
        Get.back();
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
      list.add(
          RtcRemoteView.SurfaceView(uid: uid, channelId: widget.channelName));
    }
    final views = list;
    log("VIEWSS LENGTH === ${views.length}");
    return Stack(
      children: [
        (views.length == 2)
            ? SizedBox(
                height: Get.height, width: Get.width, child: views[user2])
            : Container(),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            (views.length == 2)
                ? GestureDetector(
                    onTap: () {
                      setState(() {
                        user2 = user2 == 0 ? 1 : 0;
                        user1 = user1 == 1 ? 0 : 1;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10, top: 38),
                      child: Container(
                        height: 220,
                        width: 160,
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: views[user1],
                      ),
                    ),
                  )
                : GestureDetector(
                    onTap: () {
                      setState(() {
                        user2 = user2 == 0 ? 1 : 0;
                        user1 = user1 == 1 ? 0 : 1;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10, top: 38),
                      child: Container(
                        height: 220,
                        width: 160,
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
          ],
        ),
      ],
    );
  }

  @override
  void initState() {
    connect();
    if (widget.callId == userID) {
      userCoins.value = userCoins.value - videoCallCharge;
      log("++++++++++++++++++++&&&+${userCoins.value}");
    }
    Timer.periodic(const Duration(minutes: 1), (timer) {
      if(mounted) {
        setState(() {
        if (widget.callId == userID) {
          log("____*************${userCoins.value}^^$videoCallCharge");
          if (userCoins.value >= videoCallCharge) {
            log("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@${userCoins.value}");
            socket.emit("callReceive", {
              'callId': widget.callId,
              'coin': videoCallCharge,
              'videoCallRoom': widget.callId,
            });
            userCoins.value = userCoins.value - videoCallCharge;
            log("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@${userCoins.value}");
          } else {
            setState(() {
              _engine.destroy();
              log("Call Disconnected Id Is :- ${widget.callId}");
              socket.emit("callDisconnect", {
                "callId": widget.callId,
              });
              log("++++++++++++++++++++++++${widget.callId}");
              Get.back();
            });
          }
        }
      });
      }
    });
    initialize();
    super.initState();
  }

  void connect() {
    socket.emit("callReceive", {
      'callId': widget.callId,
      'coin': videoCallCharge,
      'videoCallRoom': widget.callId,
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        //liveVideoController.cameraController?.pausePreview();
        Get.back();
        return false;
      },
      child: Scaffold(
        body: Stack(
          children: [
            const SizedBox(
              height: 10,
            ),
            viewRows(),
            Positioned(
              bottom: 20,
              left: Get.width / 5.6,
              right: Get.width / 5.6,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 15),
                        child: Container(
                          height: Get.height / 10,
                          width: 250,
                          decoration: BoxDecoration(
                            color: const Color(0xff1C1C1C).withOpacity(0.7),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  // liveVideoController.switchCamera();
                                  // isCameraFlip = false;
                                  _engine.switchCamera();
                                },
                                child: Container(
                                  height: 55,
                                  width: 55,
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(
                                          "Images/Home/switchCamera.png"),
                                    ),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _engine.destroy();
                                    log("Call Disconnected Id Is :- ${widget.callId}");
                                    socket.emit("callDisconnect", {
                                      "callId": widget.callId,
                                    });
                                    log("++++++++++++++++++++++++${widget.callId}");
                                    Get.back();
                                  });
                                  // liveVideoController.cameraController!.pausePreview();
                                },
                                child: Container(
                                  height: 60,
                                  width: 60,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color(0xffE32827),
                                  ),
                                  child: const Icon(
                                    Icons.call_end,
                                    color: Colors.white,
                                    size: 35,
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    muted = !muted;
                                  });
                                  _engine.muteLocalAudioStream(muted);
                                },
                                child: Container(
                                  height: 55,
                                  width: 55,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: (muted)
                                          ? const AssetImage(
                                              "Images/Home/btn_mute_pressed.png",
                                            )
                                          : const AssetImage(
                                              "Images/Home/mic.png",
                                            ),
                                    ),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Positioned(
              left: 15,
              top: 35,
              child: Container(
                height: 35,
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
                      size: 18,
                      color: ThemeColor.white,
                    ),
                    const SizedBox(
                      width: 3,
                    ),
                    Obx(
                      () => Text(
                        '${liveVideoController.hours.toString().padLeft(2, '0')}:${liveVideoController.minutes.toString().padLeft(2, '0')}:${liveVideoController.seconds.toString().padLeft(2, '0')}',
                        style: TextStyle(
                            fontFamily: 'amidum',
                            color: ThemeColor.white,
                            fontSize: 14),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
