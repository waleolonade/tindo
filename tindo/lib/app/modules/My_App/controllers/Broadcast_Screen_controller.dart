import 'dart:developer';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../data/APP_variables/AppVariable.dart';

class BroadcastScreenController extends GetxController {
  //TODO: Implement MyAppController
  CameraController? cameraController;
  bool isRearCameraSelected = true;
  File? proImage;

  @override
  void onInit() {
    super.onInit();
    cameraInitialization();
  }

  void cameraInitialization() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      try {
        cameras = await availableCameras();
        startCamera(
          cameras[1],
        );
      } on CameraException catch (e) {
        log('Error in fetching the cameras: $e');
      }
    });
  }

  void startCamera(CameraDescription cameraDescription) async {
    cameras = await availableCameras();
    cameraController = CameraController(
      cameraDescription,
      ResolutionPreset.max,
      enableAudio: false,
    );
    await cameraController?.initialize().then((value) {
      if (isClosed) {
        return;
      }
      update();
    }).catchError((e) {});
  }

  Future cameraImage() async {
    try {
      final imagePike = await ImagePicker().pickImage(source: ImageSource.camera);
      if (imagePike == null) return;

      final imageTeam = File(imagePike.path);
      proImage = imageTeam;
      Get.back();
      update();
    } on PlatformException catch (e) {
      log("$e");
    }
  }

  Future pickImage() async {
    try {
      final imagePike = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (imagePike == null) return;

      final imageTeam = File(imagePike.path);
      proImage = imageTeam;
      Get.back();
      update();
    } on PlatformException catch (e) {
      log("fail$e");
    }
  }

  void changeTabIndex(int index) {
    update();
  }

  void switchCamera() {
    startCamera(cameras[isRearCameraSelected ? 0 : 1]);
    isRearCameraSelected = !isRearCameraSelected;
    // update();
  }
}
