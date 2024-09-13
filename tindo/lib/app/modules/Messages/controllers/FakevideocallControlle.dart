import 'dart:developer';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

import '../../../data/APP_variables/AppVariable.dart';

class FakeLiveVideoController extends GetxController {
  late VideoPlayerController controller;
  bool isRearCameraSelected = true;
  CameraController? cameraController;

  void videoInitialization({required String videoUrl}) {
    controller = VideoPlayerController.network(
      videoUrl,
    )..initialize().then((_) {
        controller.play();
        controller.setLooping(true);
        update();
      });
  }

  void cameraInitialization() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      try {
        cameras = await availableCameras();
        startCamera(cameras[1]);
      } on CameraException catch (e) {
        log('Error in fetching the cameras: $e');
      }
    });
  }

  void startCamera(CameraDescription cameraDescription) async {
    cameras = await availableCameras();
    cameraController = CameraController(
      cameraDescription,
      ResolutionPreset.ultraHigh,
      enableAudio: false,
    );
    await cameraController?.initialize().then((value) {
      if (isClosed) {
        return;
      }
      update();
    }).catchError((e) {});
  }

  void switchCamera() {
    startCamera(cameras[isRearCameraSelected ? 0 : 1]);
    isRearCameraSelected = !isRearCameraSelected;
    update();
  }

  @override
  void onClose() {
    super.onClose();
    controller.dispose();
  }
}
