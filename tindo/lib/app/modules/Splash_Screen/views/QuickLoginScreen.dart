import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:rayzi/app/data/Colors.dart';
import 'package:rayzi/app/modules/Splash_Screen/controllers/QuickLogincontrooler.dart';
import 'package:rayzi/app/modules/Splash_Screen/views/LocationScreen.dart';

class QuickLoginScreen extends StatefulWidget {
  const QuickLoginScreen({Key? key}) : super(key: key);

  @override
  State<QuickLoginScreen> createState() => _QuickLoginScreenState();
}

class _QuickLoginScreenState extends State<QuickLoginScreen> {
  QuickLoginController quickLoginController = Get.put(QuickLoginController());
  @override
  void initState() {
    quickLoginController.chooseName();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: Get.height,
          width: Get.width,
          decoration: const BoxDecoration(
            image:
                DecorationImage(image: AssetImage("Images/QuickLoginScreenBG.png"), fit: BoxFit.cover),
          ),
          child: SizedBox(
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: Get.height / 10,
                  ),
                  Padding(
                      padding: const EdgeInsets.only(left: 5, right: 5),
                      child: Text(
                        "Complete your information ",
                        style: TextStyle(
                            fontSize: Get.height / 28,
                            color: ThemeColor.blackback,
                            fontFamily: 'amidum'),
                      )),
                  const SizedBox(
                    height: 35,
                  ),

                  ///Profile picture
                  Padding(
                    padding: const EdgeInsets.only(left: 5, right: 5),
                    child: Stack(
                      children: [
                        GetBuilder<QuickLoginController>(
                          builder: (controller) => CircleAvatar(
                            radius: Get.height / 20,
                            backgroundColor: ThemeColor.pink,
                            child: (quickLoginController.proImage == null)
                                ? Obx(
                                    () => CircleAvatar(
                                      radius: Get.height / 21,
                                      backgroundColor: ThemeColor.greAlpha20,
                                      backgroundImage: NetworkImage(controller.maleUser.value == true
                                          ? "https://tindo.codderlab.com/storage/male.png"
                                          : "https://tindo.codderlab.com/storage/female.png"),
                                    ),
                                  )
                                : CircleAvatar(
                                    radius: Get.height / 21,
                                    backgroundColor: ThemeColor.greAlpha20,
                                    backgroundImage: FileImage(quickLoginController.proImage!),
                                  ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: GestureDetector(
                            onTap: () {
                              Get.bottomSheet(picture());
                            },
                            child: Container(
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  color: Colors.white,
                                  border: Border.all(color: ThemeColor.pink, width: 1)),
                              child: Icon(Icons.edit, color: ThemeColor.pink, size: 15),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),

                  ///Gender selection
                  Padding(
                    padding: const EdgeInsets.only(left: 5, right: 5),
                    child: Text(
                      "Please choose your gender",
                      style: TextStyle(color: ThemeColor.blackback, fontFamily: "alight", fontSize: 18),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5, right: 5),
                    child: Row(
                      children: [
                        Column(
                          children: [
                            Obx(
                              () => InkWell(
                                onTap: () {
                                  if (quickLoginController.maleUser.value == false) {
                                    quickLoginController.maleUser.value = true;
                                    quickLoginController.femaleUser.value = false;
                                  }
                                },
                                child: Stack(
                                  children: [
                                    (quickLoginController.maleUser.value)
                                        ? CircleAvatar(
                                            radius: 34,
                                            backgroundColor: ThemeColor.greAlpha20,
                                            backgroundImage:
                                                const AssetImage("Images/Gender/Color/Boy.png"),
                                          )
                                        : CircleAvatar(
                                            radius: 34,
                                            backgroundColor: ThemeColor.greAlpha20,
                                            backgroundImage:
                                                const AssetImage("Images/Gender/B&W/Boy.png"),
                                          ),
                                    (quickLoginController.maleUser.value)
                                        ? Positioned(
                                            right: 3,
                                            bottom: 0,
                                            child: Container(
                                              height: 20,
                                              width: 20,
                                              decoration: BoxDecoration(
                                                color: ThemeColor.pink,
                                                borderRadius: BorderRadius.circular(100),
                                              ),
                                              child: Icon(
                                                Icons.done,
                                                color: ThemeColor.white,
                                                size: 15,
                                              ),
                                            ))
                                        : const SizedBox(),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 3,
                            ),
                            Text(
                              "Boy",
                              style: TextStyle(
                                  fontSize: 14, fontFamily: "alight", color: ThemeColor.blackback),
                            )
                          ],
                        ),
                        const SizedBox(
                          width: 25,
                        ),
                        Column(
                          children: [
                            Obx(
                              () => InkWell(
                                onTap: () {
                                  if (quickLoginController.femaleUser.value == false) {
                                    quickLoginController.femaleUser.value = true;
                                    quickLoginController.maleUser.value = false;
                                  }
                                },
                                child: Stack(
                                  children: [
                                    (quickLoginController.femaleUser.value)
                                        ? CircleAvatar(
                                            radius: 34,
                                            backgroundColor: ThemeColor.greAlpha20,
                                            backgroundImage:
                                                const AssetImage("Images/Gender/Color/Girl.png"),
                                          )
                                        : CircleAvatar(
                                            radius: 34,
                                            backgroundColor: ThemeColor.greAlpha20,
                                            backgroundImage:
                                                const AssetImage("Images/Gender/B&W/Girl.png"),
                                          ),
                                    (quickLoginController.femaleUser.value)
                                        ? Positioned(
                                            right: 3,
                                            bottom: 0,
                                            child: Container(
                                              height: 20,
                                              width: 20,
                                              decoration: BoxDecoration(
                                                color: ThemeColor.pink,
                                                borderRadius: BorderRadius.circular(100),
                                              ),
                                              child: Icon(
                                                Icons.done,
                                                color: ThemeColor.white,
                                                size: 15,
                                              ),
                                            ))
                                        : const SizedBox(),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 3,
                            ),
                            Text(
                              "Girl",
                              style: TextStyle(
                                  fontSize: 14, fontFamily: "alight", color: ThemeColor.blackback),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),

                  ///User name
                  Container(
                    height: 70,
                    decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.12), borderRadius: BorderRadius.circular(12)),
                    child: GetBuilder<QuickLoginController>(
                      builder: (controller) => Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(
                            width: 15,
                          ),
                          Image.asset(
                            "Images/user.png",
                            height: 26,
                            width: 26,
                            color: ThemeColor.pink,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            child: Container(
                              height: 60,
                              alignment: Alignment.center,
                              padding: const EdgeInsets.only(top: 5),
                              child: TextField(
                                controller: quickLoginController.nameController,
                                maxLines: 1,
                                cursorColor: ThemeColor.blackback,
                                style: TextStyle(
                                  fontFamily: 'amidum',
                                  fontSize: 16,
                                  color: ThemeColor.blackback,
                                ),
                                decoration: InputDecoration(
                                  isDense: true,
                                  filled: true,
                                  fillColor: Colors.transparent,
                                  hintText: "Enter your Name",
                                  hintStyle: const TextStyle(
                                    fontFamily: 'amidum',
                                    fontSize: 15,
                                  ),
                                  disabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide.none),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide.none),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide.none),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide.none),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  GetBuilder<QuickLoginController>(
                    builder: (controller) => Container(
                      height: 70,
                      decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.12), borderRadius: BorderRadius.circular(12)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(
                            width: 15,
                          ),
                          Image.asset(
                            "Images/map-location.png",
                            height: 26,
                            width: 26,
                            color: ThemeColor.pink,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            child: Container(
                              height: 60,
                              alignment: Alignment.center,
                              padding: const EdgeInsets.only(top: 5),
                              child: GetBuilder<QuickLoginController>(
                                builder: (controller) => TextField(
                                  controller: quickLoginController.locationController,
                                  maxLines: 1,
                                  cursorColor: ThemeColor.blackback,
                                  style: TextStyle(
                                    fontFamily: 'amidum',
                                    fontSize: 16,
                                    color: ThemeColor.blackback,
                                  ),
                                  decoration: InputDecoration(
                                    isDense: true,
                                    filled: true,
                                    fillColor: Colors.transparent,
                                    hintText: quickLoginController.currentAddress,
                                    hintStyle: const TextStyle(
                                      fontFamily: 'amidum',
                                      fontSize: 15,
                                    ),
                                    disabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: BorderSide.none),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: BorderSide.none),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: BorderSide.none),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: BorderSide.none),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          InkWell(
                            onTap: () {
                              Get.to(() => LocationScreen());
                            },
                            child: const Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const Spacer(),

                  ///Submit Button
                  GestureDetector(
                    onTap: () {
                      quickLoginController.submit();
                    },
                    child: Container(
                      height: 56,
                      width: Get.width,
                      decoration: BoxDecoration(
                          color: ThemeColor.pink, borderRadius: BorderRadius.circular(100)),
                      alignment: Alignment.center,
                      child: Text(
                        "Start the journey",
                        style: TextStyle(
                          fontFamily: 'amidum',
                          fontSize: 18,
                          color: ThemeColor.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Container picture() {
    return Container(
      height: 160,
      decoration: BoxDecoration(
          color: ThemeColor.white,
          borderRadius:
              const BorderRadius.only(topRight: Radius.circular(22), topLeft: Radius.circular(22))),
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
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: InkWell(
              onTap: () => quickLoginController.cameraImage(),
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
                      child: ImageIcon(const AssetImage("Images/Message/camera.png"),
                          color: ThemeColor.blackback),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Take a photo",
                      style: TextStyle(fontFamily: 'amidum', fontSize: 15, color: ThemeColor.blackback),
                    )
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: InkWell(
              onTap: () => quickLoginController.pickImage(),
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
                      style: TextStyle(fontFamily: 'amidum', fontSize: 15, color: ThemeColor.blackback),
                    )
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }
}
