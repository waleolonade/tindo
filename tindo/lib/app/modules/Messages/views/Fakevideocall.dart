import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rayzi/app/modules/Messages/controllers/FakevideocallControlle.dart';
import 'package:video_player/video_player.dart';

class FakeLivevideoCall extends StatefulWidget {
  final String videoUrl;
  const FakeLivevideoCall({Key? key, required this.videoUrl}) : super(key: key);

  @override
  State<FakeLivevideoCall> createState() => _FakeLivevideoCallState();
}

class _FakeLivevideoCallState extends State<FakeLivevideoCall> {
  FakeLiveVideoController liveVideoController =
      Get.put(FakeLiveVideoController());
  bool ismic = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    liveVideoController.videoInitialization(videoUrl: widget.videoUrl);
    liveVideoController.cameraInitialization();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        liveVideoController.cameraController?.pausePreview();
        Get.back();
        return false;
      },
      child: Scaffold(
        body: Column(
          children: [
            Stack(
              children: [
                FittedBox(
                  fit: BoxFit.fill,
                  child: GetBuilder<FakeLiveVideoController>(
                    builder: (controller) => SizedBox(
                      height: Get.height,
                      width: Get.width,
                      child: liveVideoController.controller.value.isInitialized
                          ? AspectRatio(
                              aspectRatio: liveVideoController
                                  .controller.value.aspectRatio,
                              child:
                                  VideoPlayer(liveVideoController.controller),
                            )
                          : Container(),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 50, right: 25),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: ClipRRect(
                      clipBehavior: Clip.hardEdge,
                      borderRadius: BorderRadius.circular(10),
                      child: GetBuilder<FakeLiveVideoController>(
                        builder: (controller) => SizedBox(
                          height: 170,
                          width: 125,
                          child: (liveVideoController.cameraController != null)
                              ? CameraPreview(
                                  liveVideoController.cameraController!)
                              : Container(
                                  height: 155,
                                  width: 115,
                                  color: Colors.black,
                                ),
                        ),
                      ),
                    ),
                  ),
                ),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      liveVideoController.switchCamera();
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
                                      liveVideoController.cameraController!
                                          .pausePreview();
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
                                  GestureDetector(
                                    onTap: () {
                                      if (ismic == true) {
                                        setState(() {
                                          ismic = false;
                                        });
                                      } else {
                                        setState(() {
                                          ismic = true;
                                        });
                                      }
                                    },
                                    child: (ismic == true)
                                        ? Container(
                                            height: 55,
                                            width: 55,
                                            decoration: const BoxDecoration(
                                              image: DecorationImage(
                                                image: AssetImage(
                                                  "Images/Home/mic.png",
                                                ),
                                              ),
                                              shape: BoxShape.circle,
                                            ),
                                          )
                                        : Container(
                                            height: 55,
                                            width: 55,
                                            decoration: const BoxDecoration(
                                              image: DecorationImage(
                                                image: AssetImage(
                                                  "Images/Home/btn_mute_pressed.png",
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
              ],
            ),
          ],
        ),
      ),
    );
  }
}
