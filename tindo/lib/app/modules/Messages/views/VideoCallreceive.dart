import 'dart:async';
import 'dart:developer';

import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:lottie/lottie.dart';
import 'package:rayzi/app/API_Services/app_url.dart';
import 'package:rayzi/app/data/APP_variables/AppVariable.dart';
import 'package:rayzi/app/data/Colors.dart';
import 'package:rayzi/app/modules/Messages/views/LiveVideoCall.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

class VideoCallreceive extends StatefulWidget {
  final String callerImage;
  final String callerName;
  final String callID;
  final dynamic receiveCallData;
  const VideoCallreceive({
    Key? key,
    required this.callerName,
    required this.callerImage,
    required this.callID,
    required this.receiveCallData,
  }) : super(key: key);

  @override
  State<VideoCallreceive> createState() => _VideoCallreceiveState();
}

class _VideoCallreceiveState extends State<VideoCallreceive> {
  int elapsedSeconds = 0;
  Timer? timer;
  final player = AudioPlayer();
  connect() {
    log("on");
    log("callid +++++++++++++++ ${widget.callID}");
    socket = io.io(
      Constant.BASE_URL,
      io.OptionBuilder().setTransports(['websocket']).setQuery({"callRoom": widget.callID}).build(),
    );

    socket.connect();
    socket.onConnect((data) {
      log("Connected");

      socket.emit("callConfirmed", widget.receiveCallData);
      log("+++++++++++++ ${widget.receiveCallData}");
      log("==============>>>>> CallConfirmed Soket Emit");

      socket.on("callConfirmed", (data) {
        log("===========>>>>>>> callConfirmed Socket listen");
        log("callConfirmed :-  $data");
      });

      socket.on("callCancel", (data) {
        log("===========>>>>>>> callCancel Socket listen");
        log("============callCancel :-  $data");
        Get.back();
      });
    });
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      elapsedSeconds++;
      log("Second Is ##### :- $elapsedSeconds");
      if (elapsedSeconds >= 45) {
        Map<String, dynamic> isAccept = {"accept": false};
        Map<String, dynamic> result = {};
        result.addAll(isAccept);
        for (final entry in widget.receiveCallData.entries) {
          result.putIfAbsent(entry.key, () => entry.value);
        }
        socket.emit("callAnswer", result);

        Get.back();
        timer.cancel();
      }
    });
  }

  @override
  void initState() {
    connect();
    startTimer();
    player.setAsset("audio/call.mp3").then(
      (value) {
        player.play();
      },
    );
    player.setLoopMode(LoopMode.all);
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    player.dispose();
    timer!.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.back();
        return false;
      },
      child: Scaffold(
        backgroundColor: const Color(0xff111217),
        body: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  alignment: Alignment.center,
                  child: Lottie.asset(width: 300, height: 300, repeat: true, "lottie/callwave.json"),
                ),
                Container(
                  height: 120,
                  width: 120,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: const Color(0xff4F1231), width: 3),
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                            widget.callerImage,
                          ))),
                )
              ],
            ),
            Text(
              widget.callerName,
              style: TextStyle(fontFamily: 'abold', color: ThemeColor.white, fontSize: 26, fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              "receiving Call",
              style: TextStyle(
                fontFamily: 'amidum',
                color: ThemeColor.white,
                fontSize: 18,
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(left: 50, right: 50),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 35),
                    child: GestureDetector(
                      onTap: () {
                        Map<String, dynamic> isaccept = {"accept": false};

                        Map<String, dynamic> result = {};
                        result.addAll(isaccept);
                        log(widget.receiveCallData);
                        for (final entry in widget.receiveCallData.entries) {
                          result.putIfAbsent(entry.key, () => entry.value);
                        }

                        socket.emit("callAnswer", result);
                        log("=============>>>>>>> callAnswer socket Emit");
                        socket.emit("callDisconnect", {
                          'callId': widget.receiveCallData["callId"],
                        });
                        player.dispose();
                        log("=============>>>>>>> callDisconnect socket Emit");
                        Get.back();
                      },
                      child: Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: ThemeColor.red,
                        ),
                        child: const Icon(
                          Icons.call_end,
                          color: Colors.white,
                          size: 35,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 35),
                    child: GestureDetector(
                      onTap: () async {
                        Map<String, dynamic> isaccept = {
                          "accept": true,
                          "callRoom": widget.receiveCallData["callId"],
                          "videoCallRoom": widget.receiveCallData["callId"],
                        };

                        Map<String, dynamic> result = {};
                        result.addAll(isaccept);
                        log(widget.receiveCallData);
                        for (final entry in widget.receiveCallData.entries) {
                          result.putIfAbsent(entry.key, () => entry.value);
                        }

                        socket.emit("callAnswer", result);
                        log("=============>>>>>>> callAnswer socket Emit");

                        socket = io.io(Constant.BASE_URL,
                          io.OptionBuilder()
                              .setTransports(['websocket']).setQuery({
                            "videoCallRoom": widget.receiveCallData["callId"]
                          }).build(),
                        );
                        socket.connect();
                        log("=============>>>>>>> connect socket connect${socket.connected}");
                        socket.onConnect((data) {
                          socket.emit("callReceive", {
                            'callId': widget.receiveCallData["callId"],
                            "videoCallRoom": widget.receiveCallData["callId"],
                            'coin': videoCallCharge,
                          });
                          log("=============>>>>>>> callReceive socket Emit");
                          socket.on("callReceive", (data) {
                            log("^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^$data");
                            log("===================>>> callReceive listen");
                          });
                          log("============Video Call Connected");
                        });
                        player.dispose();
                        await Get.off(() => LivevideoCall(
                              clientRole: ClientRole.Broadcaster,
                              token: widget.receiveCallData["token"],
                              channelName: widget.receiveCallData["channel"],
                              callId: widget.receiveCallData["callId"],
                            ));
                      },
                      child: Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: ThemeColor.green,
                        ),
                        child: const Icon(
                          Icons.call,
                          color: Colors.white,
                          size: 35,
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
    );
  }
}
