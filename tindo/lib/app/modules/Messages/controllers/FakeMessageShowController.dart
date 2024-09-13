import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:rayzi/app/API%20Models/getgift_model.dart';
import 'package:rayzi/app/API_Services/getgift_services.dart';

class FakeMessageShowController extends GetxController {
  var selectedGiftIndex;
  File? proImage;
  List<DummyChatModel> messages = [];
  final ScrollController scrollController = ScrollController();
  TextEditingController textEditingController = TextEditingController();
  final TextEditingController messageTaxController = TextEditingController();

  bool isButtonDisabled = true;

  ///Gift
  var getGiftList = <Gift>[].obs;
  var giftLoading = true.obs;

  var items = [1, 5, 10, 15, 20, 25, 30, 35, 40, 45, 50];
  var dropdownvalue = 1.obs;
  @override
  void onInit() {
    selectedGiftIndex = 0.obs;
    //
    messageTaxController.addListener(() {
      validateField(messageTaxController.text);
    });
    super.onInit();
  }

  /// Camera and Gallary Image Picker
  Future cameraImage() async {
    try {
      final imagepike =
          await ImagePicker().pickImage(source: ImageSource.camera);
      if (imagepike == null) return;
      final imageTeam = File(imagepike.path);
      proImage = imageTeam;
      onTabSend(messageType: 2, message: "", assetFile: proImage);
      Get.back();
      update();
    } on PlatformException catch (e) {
      log("$e");
    }
  }

  Future pickImage() async {
    try {
      final imagepike =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (imagepike == null) return;

      final imageTeam = File(imagepike.path);
      proImage = imageTeam;
      onTabSend(messageType: 2, message: "", assetFile: proImage);
      Get.back();
      update();
    } on PlatformException catch (e) {
      log("fail$e");
    }
  }

  void setMessage(int type, String message, {File? assetFile}) {
    DummyChatModel dummyChatModel;
    if (type == 1 || type == 3) {
      dummyChatModel = DummyChatModel(
        type: type,
        message: message,
        time: DateFormat.jm().format(DateTime.now()),
      );
      messages.add(dummyChatModel);
      scrollController.animateTo(scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
      update();
    } else if (type == 2 || type == 4) {
      dummyChatModel = DummyChatModel(
        type: type,
        message: message,
        time: DateFormat.jm().format(DateTime.now()),
        assetFile: assetFile,
      );
      messages.add(dummyChatModel);
      scrollController.animateTo(scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
      update();
    }
  }

  /// OnTab Message send
  void onTabSend(
      {required int messageType, required String message, File? assetFile}) {
    if (messageType == 1 || messageType == 3) {
      setMessage(
        messageType,
        message,
      );
      log("_____++++111");
      messageTaxController.clear();
      update();
    } else if (messageType == 2 || messageType == 4) {
      setMessage(
        messageType,
        message,
        assetFile: assetFile,
      );
    }
  }

  ///Text fiel validation
  void validateField(text) {
    if (messageTaxController.text.isEmpty ||
        messageTaxController.text.isBlank == true) {
      isButtonDisabled = true;
      update();
    } else {
      isButtonDisabled = false;
      update();
    }
  }

  ///

  /// ==== FetchGiftList ==== \\\
  Future fetchGiftlist() async {
    try {
      log("++++");
      giftLoading(true);
      var getGiftData = await GetGiftService.getGift();
      getGiftList.value = getGiftData.gift!;
      log("Get Gift Data Is :- ${jsonEncode(getGiftData)}");
    } finally {
      giftLoading(false);
      log("++++");
    }
  }
}

class DummyChatModel {
  int type;
  String message;
  String time;
  File? assetFile;
  DummyChatModel({
    required this.message,
    required this.type,
    required this.time,
    this.assetFile,
  });
}
