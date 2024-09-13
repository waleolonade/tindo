import 'package:get/get.dart';

class PopularScreenController extends GetxController {
  var items = [
    '  x1',
    '  x5',
    ' x10',
    ' x15',
    ' x20',
    ' x25',
    ' x30',
    ' x35',
    ' x40',
    ' x45',
    ' x50',
  ];
  var dropdownvalue = '  x1'.obs;
  var selectedGiftIndex;

  @override
  void onInit() {
    selectedGiftIndex = 0.obs;
    // TODO: implement onInit
    super.onInit();
  }

  // sentdGift() async {
  //   emojiImage.add(stickerList[selectedGiftIndex.value].image);
  //   emojicount.add("${dropdownvalue.value}");
  //
  //   ///
  //   emojiImage.removeRange(0, emojiImage.length - 1);
  //   emojicount.removeRange(0, emojicount.length - 1);
  //   Get.back();
  //   update();
  //   await Future.delayed(const Duration(seconds: 1)).then((value) {
  //     emojiImage.add("Images/Center_Tab/flairImage.png");
  //     emojicount.add("");
  //   });
  //   update();
  // }
}
