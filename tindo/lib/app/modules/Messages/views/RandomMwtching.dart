import 'dart:async';
import 'dart:developer';

import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:rayzi/app/API_Services/app_url.dart';
import 'package:rayzi/app/data/APP_variables/AppVariable.dart';
import 'package:rayzi/app/data/Colors.dart';
import 'package:rayzi/app/modules/Messages/views/LiveVideoCall.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

class RandomMatching extends StatefulWidget {
  final String matchImage;
  final String matchName;
  final String channel;
  final String token;
  final String receiverId;
  final String callId;
  final String callerId;

  const RandomMatching(
      {Key? key,
      required this.matchImage,
      required this.matchName,
      required this.channel,
      required this.token,
      required this.receiverId,
      required this.callId,
      required this.callerId})
      : super(key: key);

  @override
  State<RandomMatching> createState() => _RandomMatchingState();
}

class _RandomMatchingState extends State<RandomMatching> {
  String text = "Calling...";
  int elapsedSeconds = 0;
  Timer? timer;

  void connect() {
    log("on");
    socket = io.io(
      Constant.BASE_URL,
      io.OptionBuilder().setTransports(['websocket']).setQuery(
          {"callRoom": widget.callId}).build(),
    );
    socket.connect();

    socket.onConnect((data) {
      log("Connected");
      socket.on("callConfirmed", (data) {
        log("==================>>>>>>>>> callConfirmed listen");
        log("callConfirmed $data");
        if (!mounted) {
          return;
        }
        setState(() {
          text = "Ringing....";
        });
      });
      socket.on("callAnswer", (data) {
        log(data);
        log("==================>>>>>>>>> call Answer listen");
        if (data["accept"] == true) {
          timer!.cancel();
          log("DATA=========================$data");
          socket.emit("callDisconnect", {
            "callId": widget.callId,
          });
          Get.off(() => LivevideoCall(
                clientRole: ClientRole.Broadcaster,
                token: data["token"],
                channelName: data["channel"],
                callId: data["callId"],
              ));
        } else {
          socket.emit("callDisconnect", {
            "callId": widget.callId,
          });
          log("==================>>>>>>>>> callDisconnect Socket Emit");
          Get.back();
        }
      });
    });
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      elapsedSeconds++;
      log("Second Is ##### :- $elapsedSeconds");
      if (elapsedSeconds >= 120) {
        socket.emit("callCancel", {
          "callerId": widget.callerId,
          "receiverId": widget.receiverId,
          "token": widget.token,
          "channel": widget.channel,
          "callId": widget.callId,
        });

        socket.emit("callDisconnect", {
          'callId': widget.callId,
        });
        Fluttertoast.showToast(
            msg: "${widget.matchName} is not answering your calls",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: ThemeColor.white,
            textColor: ThemeColor.blackback,
            fontSize: 16.0);
        Get.back();
        timer.cancel();
      }
    });
  }

  @override
  void initState() {
    connect();
    startTimer();
    super.initState();
  }

  @override
  void dispose() {
    timer!.cancel();
    super.dispose();
  }

  //RandomMetchingController metchingController = Get.put(RandomMetchingController());
  // HomeController homeController = Get.put(HomeController());
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
                  child: Lottie.asset(
                      width: 300,
                      height: 300,
                      repeat: true,
                      "lottie/callwave.json"),
                ),
                Container(
                  height: 120,
                  width: 120,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border:
                          Border.all(color: const Color(0xff4F1231), width: 3),
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                            widget.matchImage,
                          ))),
                )
              ],
            ),
            Text(
              widget.matchName,
              style: TextStyle(
                  fontFamily: 'abold',
                  color: ThemeColor.white,
                  fontSize: 26,
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              text,
              style: TextStyle(
                fontFamily: 'amidum',
                color: ThemeColor.white,
                fontSize: 18,
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 35),
              child: GestureDetector(
                onTap: () {
                  socket.emit("callCancel", {
                    "callerId": widget.callerId,
                    "receiverId": widget.receiverId,
                    "token": widget.token,
                    "channel": widget.channel,
                    "callId": widget.callId,
                  });

                  socket.emit("callDisconnect", {
                    'callId': widget.callId,
                  });
                  log("==================>>>>>>>>> callDisconnect Socket Emit");
                  Get.back();
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
            ),
          ],
        ),
      ),
    );
  }
}
