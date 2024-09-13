
import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rayzi/app/data/APP_variables/AppVariable.dart';
import 'package:rayzi/app/data/Colors.dart';
import 'package:rayzi/app/modules/My_App/controllers/Broadcast_Screen_controller.dart';
import 'package:rayzi/app/modules/My_App/controllers/Golive_controller.dart';

class BroadCastScreen extends StatefulWidget {
  const BroadCastScreen({super.key});

  @override
  State<BroadCastScreen> createState() => _BroadCastScreenState();
}

class _BroadCastScreenState extends State<BroadCastScreen> {
  GoLiveController goLiveController = Get.put(GoLiveController());
  BroadcastScreenController broadcastScreenController = Get.put(BroadcastScreenController());
  @override
  Widget build(BuildContext context) {
    final deviceRatio = Get.width / Get.height;
    return WillPopScope(
      onWillPop: () async {
        broadcastScreenController.cameraController?.pausePreview();
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        body: GetBuilder<BroadcastScreenController>(
          builder: (controller) {
            return Center(
              child: (broadcastScreenController.cameraController != null)
                  ? Stack(
                      children: [
                        Transform.scale(
                          scale: 1 / broadcastScreenController.cameraController!.value.aspectRatio / deviceRatio,
                          child: Center(
                            child: CameraPreview(
                              broadcastScreenController.cameraController!,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15),
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 30,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      broadcastScreenController.cameraController?.pausePreview();
                                      Get.back();
                                    },
                                    child: Container(
                                      height: 33,
                                      width: 33,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.black.withOpacity(0.2),
                                      ),
                                      child: Icon(Icons.close, color: ThemeColor.white),
                                    ),
                                  )
                                ],
                              ),
                              const Spacer(),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  // const Spacer(
                                  //   flex: 3,
                                  // ),
                                  GestureDetector(
                                    onTap: () {
                                      Get.bottomSheet(Container(
                                        height: 160,
                                        decoration: BoxDecoration(
                                            color: ThemeColor.white,
                                            borderRadius: const BorderRadius.only(
                                                topRight: Radius.circular(22), topLeft: Radius.circular(22))),
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
                                              height: 5,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(left: 15, right: 15),
                                              child: InkWell(
                                                onTap: () => broadcastScreenController.cameraImage(),
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
                                                            const AssetImage("Images/Message/camera.png"),
                                                            color: ThemeColor.blackback),
                                                      ),
                                                      const SizedBox(
                                                        width: 10,
                                                      ),
                                                      Text(
                                                        "Take a photo",
                                                        style: TextStyle(
                                                            fontFamily: 'amidum',
                                                            fontSize: 15,
                                                            color: ThemeColor.blackback),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(left: 15, right: 15),
                                              child: InkWell(
                                                onTap: () => broadcastScreenController.pickImage(),
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
                                                        style: TextStyle(
                                                            fontFamily: 'amidum',
                                                            fontSize: 15,
                                                            color: ThemeColor.blackback),
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
                                      ));
                                    },
                                    child: Stack(
                                      children: [
                                        Obx(
                                          () => Container(
                                            height: Get.height / 4.6,
                                            width: Get.width / 3,
                                            decoration: (broadcastScreenController.proImage == null)
                                                ? BoxDecoration(
                                                    image: DecorationImage(
                                                        image: NetworkImage(userProfile.value), fit: BoxFit.cover),
                                                    color: ThemeColor.blackback,
                                                    borderRadius: BorderRadius.circular(10),
                                                  )
                                                : BoxDecoration(
                                                    image: DecorationImage(
                                                        image: FileImage(broadcastScreenController.proImage!),
                                                        fit: BoxFit.cover),
                                                    color: ThemeColor.blackback,
                                                    borderRadius: BorderRadius.circular(10),
                                                  ),
                                            foregroundDecoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10),
                                              gradient: const LinearGradient(
                                                  begin: Alignment.topCenter,
                                                  end: Alignment.bottomCenter,
                                                  colors: [
                                                    Colors.transparent,
                                                    Colors.transparent,
                                                    Colors.black26,
                                                    Colors.black45
                                                  ]),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          bottom: 10,
                                          child: SizedBox(
                                            height: 20,
                                            width: 120,
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "Edit",
                                                  style: TextStyle(
                                                      color: ThemeColor.white, fontFamily: 'amidum', fontSize: 15),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Spacer(),
                                  GestureDetector(
                                    onTap: () {
                                      if (broadcastScreenController.proImage == null) {
                                        goLiveController.userGoLive(userId: userID);
                                      } else {
                                        goLiveController.userGoLive(
                                            userId: userID, coverImage: broadcastScreenController.proImage);
                                      }
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      height: Get.height / 17,
                                      width: Get.width / 2.3,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(25),
                                        color: ThemeColor.pink,
                                      ),
                                      child: Obx(
                                        () => goLiveController.isLoading.value
                                            ? const Center(child: CupertinoActivityIndicator(color: Colors.white))
                                            : Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Image.asset(
                                                    "Images/Center_Tab/video-camera.png",
                                                    color: ThemeColor.white,
                                                    height: 25,
                                                    width: 25,
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    "Go live",
                                                    style: TextStyle(
                                                      fontFamily: 'abold',
                                                      color: ThemeColor.white,
                                                      fontSize: 20,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                      ),
                                    ),
                                  ),
                                  const Spacer(),
                                  GestureDetector(
                                    onTap: () {
                                      broadcastScreenController.switchCamera();
                                    },
                                    child: Container(
                                      height: Get.height / 17,
                                      width: Get.width / 9,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.black.withOpacity(0.2),
                                      ),
                                      padding: const EdgeInsets.all(10),
                                      child: Image.asset(
                                        "Images/Center_Tab/flipcamera.png",
                                        color: ThemeColor.white,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  : Container(
                      height: Get.height,
                      width: Get.width,
                      color: Colors.black,
                    ),
            );
          },
        ),
      ),
    );
  }
}
