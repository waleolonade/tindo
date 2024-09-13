import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rayzi/app/data/Colors.dart';
import 'package:rayzi/app/modules/Messages/controllers/FakeMessageShowController.dart';
import 'package:rayzi/app/modules/Messages/controllers/messageShow_controller.dart';
import 'package:rayzi/app/modules/Messages/views/flow_shader.dart';
import 'package:rayzi/app/modules/Messages/views/lottie_animation.dart';
import 'package:record/record.dart';

class RecordButton extends StatefulWidget {
  const RecordButton({
    Key? key,
    required this.controller,
    required this.isFake,
  }) : super(key: key);

  final AnimationController controller;
  final bool isFake;

  @override
  State<RecordButton> createState() => _RecordButtonState();
}

class _RecordButtonState extends State<RecordButton> {
  static const double size = 50;

  final double lockerHeight = 200;
  double timerWidth = 0;

  late Animation<double> buttonScaleAnimation;
  late Animation<double> timerAnimation;
  late Animation<double> lockerAnimation;

  DateTime? startTime;
  Timer? timer;
  String recordDuration = "00:00";
  late AudioRecorder record;

  bool isLocked = false;
  bool showLottie = false;

  MessageShowController messageShowController = Get.put(MessageShowController());
  FakeMessageShowController fakeMessageShowController = Get.put(FakeMessageShowController());

  GlobalKey<AnimatedListState> audioListKey = GlobalKey<AnimatedListState>();
  @override
  void initState() {
    super.initState();
    record = AudioRecorder();
    buttonScaleAnimation = Tween<double>(begin: 1, end: 2).animate(
      CurvedAnimation(
        parent: widget.controller,
        curve: const Interval(0.0, 0.6, curve: Curves.elasticInOut),
      ),
    );
    if(mounted) {
      widget.controller.addListener(() {
      setState(() {});
    });
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    timerWidth = MediaQuery.of(context).size.width - 2 * 8 - 6;
    timerAnimation = Tween<double>(begin: timerWidth + 30, end: 0).animate(
      CurvedAnimation(
        parent: widget.controller,
        curve: const Interval(0.2, 1, curve: Curves.easeIn),
      ),
    );
    lockerAnimation = Tween<double>(begin: lockerHeight + 20, end: 0).animate(
      CurvedAnimation(
        parent: widget.controller,
        curve: const Interval(0.2, 1, curve: Curves.easeIn),
      ),
    );
  }

  @override
  void dispose() {
    record.dispose();
    timer?.cancel();
    timer = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        lockSlider(),
        cancelSlider(),
        audioButton(),
        if (isLocked) timerLocked(),
      ],
    );
  }

  Widget lockSlider() {
    return Positioned(
      bottom: -lockerAnimation.value,
      child: Container(
        height: lockerHeight,
        width: size,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(27),
          color: Colors.white,
        ),
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const FaIcon(
              FontAwesomeIcons.lock,
              size: 20,
              color: Colors.green,
            ),
            const SizedBox(height: 8),
            FlowShader(
              direction: Axis.vertical,
              child: Column(
                children: const [
                  Icon(
                    Icons.keyboard_arrow_up,
                    color: Colors.black,
                  ),
                  Icon(
                    Icons.keyboard_arrow_up,
                    color: Colors.black,
                  ),
                  Icon(
                    Icons.keyboard_arrow_up,
                    color: Colors.black,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget cancelSlider() {
    return Positioned(
      right: -timerAnimation.value,
      child: Container(
        height: size,
        width: timerWidth,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(27),
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              const SizedBox(
                width: 10,
              ),
              showLottie
                  ? const LottieAnimation()
                  : Text(
                      recordDuration,
                      style: const TextStyle(color: Colors.black),
                    ),
              const SizedBox(width: size),
              FlowShader(
                duration: const Duration(seconds: 3),
                flowColors: const [
                  Colors.black,
                  Colors.black,
                ],
                child: Row(
                  children: const [
                    Icon(
                      Icons.keyboard_arrow_left,
                      color: Colors.black,
                    ),
                    Text(
                      "Slide to cancel",
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(width: size),
            ],
          ),
        ),
      ),
    );
  }

  Widget timerLocked() {
    return Positioned(
      right: 0,
      child: Container(
        height: size,
        width: timerWidth,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(27),
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 15, right: 25),
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () async {
              Vibrate.feedback(FeedbackType.success);
              timer?.cancel();
              timer = null;
              startTime = null;
              recordDuration = "00:00";

              var filePath = await record.stop();
              File audioFile = File(filePath!);
              if (widget.isFake) {
                /// =============================================
                fakeMessageShowController.onTabSend(messageType: 4, message: "", assetFile: audioFile);
                log("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
              } else {
                messageShowController.sendChatFile("4", audioFile);
              }
              debugPrint(filePath);
              setState(() {
                isLocked = false;
              });
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                const SizedBox(),
                Text(
                  recordDuration,
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                ),
                FlowShader(
                  duration: const Duration(seconds: 3),
                  flowColors: const [Colors.white, Colors.grey],
                  child: const Text(
                    "Tap lock to stop",
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
                const Center(
                  child: FaIcon(
                    FontAwesomeIcons.lock,
                    size: 18,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget audioButton() {
    return GestureDetector(
      child: Transform.scale(
        scale: buttonScaleAnimation.value,
        child: Container(
          height: size,
          width: size,
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: ThemeColor.white,
          ),
          child: Icon(
            Icons.mic,
            size: 30,
            color: ThemeColor.pink,
          ),
        ),
      ),
      onLongPressDown: (_) {
        debugPrint("onLongPressDown");
        widget.controller.forward();
      },
      onLongPressEnd: (details) async {
        if (isCancelled(details.localPosition, context)) {
          Vibrate.feedback(FeedbackType.heavy);
          timer?.cancel();
          timer = null;
          startTime = null;
          recordDuration = "00:00";

          setState(() {
            showLottie = true;
          });

          Timer(const Duration(milliseconds: 1440), () async {
            widget.controller.reverse();
            debugPrint("Cancelled recording");
            var filePath = await record.stop();
            debugPrint(filePath);
            File(filePath!).delete();
            debugPrint("Deleted $filePath");
            showLottie = false;
          });
        } else if (checkIsLocked(details.localPosition)) {
          widget.controller.reverse();

          Vibrate.feedback(FeedbackType.heavy);
          debugPrint("Locked recording");
          debugPrint(details.localPosition.dy.toString());
          setState(() {
            isLocked = true;
          });
        } else {
          widget.controller.reverse();

          Vibrate.feedback(FeedbackType.success);

          timer?.cancel();
          timer = null;
          startTime = null;
          recordDuration = "00:00";

          var filePath = await record.stop();
          File audioFile = File(filePath!);
          if (widget.isFake) {
            fakeMessageShowController.onTabSend(messageType: 4, message: "", assetFile: audioFile);
            log("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
          } else {
            messageShowController.sendChatFile("4", audioFile);
          }
          setState(() {
            isLocked = false;
          });
          //audioListKey.currentState!.insertItem(AudioState.files.length - 1);
          debugPrint(filePath);
        }
      },
      onLongPressCancel: () {
        debugPrint("onLongPressCancel");
        widget.controller.reverse();
      },
      onLongPress: () async {
        debugPrint("onLongPress");
        Vibrate.feedback(FeedbackType.success);
        if (await AudioRecorder().hasPermission()) {
          record = AudioRecorder();

          await record.start(
            const RecordConfig(),
            path:
                "${(await getApplicationDocumentsDirectory()).path}/audio_${DateTime.now().millisecondsSinceEpoch}.m4a",
          );

          startTime = DateTime.now();

          timer = Timer.periodic(const Duration(seconds: 1), (_) {
            final minDur = DateTime.now().difference(startTime!).inMinutes;
            final secDur = DateTime.now().difference(startTime!).inSeconds % 60;
            String min = minDur < 10 ? "0$minDur" : minDur.toString();
            String sec = secDur < 10 ? "0$secDur" : secDur.toString();
            setState(() {
              recordDuration = "$min:$sec";
            });
          });
        }
        setState(() {});
      },
    );
  }

  bool checkIsLocked(Offset offset) {
    return (offset.dy < -35);
  }

  bool isCancelled(Offset offset, BuildContext context) {
    return (offset.dx < -(MediaQuery.of(context).size.width * 0.2));
  }
}
