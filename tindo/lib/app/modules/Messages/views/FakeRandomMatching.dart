import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:rayzi/app/data/Colors.dart';
import 'package:rayzi/app/modules/Messages/controllers/FakeRandomMatchingController.dart';

import '../../home/controllers/home_controller.dart';

class FakeRandomMatching extends StatefulWidget {
  final String proImage;
  final String videoUrl;
  final String name;
  const FakeRandomMatching(
      {Key? key,
      required this.proImage,
      required this.videoUrl,
      required this.name})
      : super(key: key);

  @override
  State<FakeRandomMatching> createState() => _FakeRandomMatchingState();
}

class _FakeRandomMatchingState extends State<FakeRandomMatching> {
  HomeController homeController = Get.put(HomeController());
  FakeRandomMetchingController metchingController =
      Get.put(FakeRandomMetchingController());
  @override
  void initState() {
    // TODO: implement initState
    metchingController.next(videoUrl: widget.videoUrl);
    super.initState();
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
                            widget.proImage,
                          ))),
                )
              ],
            ),
            Text(
              widget.name,
              style: TextStyle(
                  fontFamily: 'abold',
                  color: ThemeColor.white,
                  fontSize: 26,
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 5,
            ),
            Obx(
              () => Text(
                metchingController.text.value,
                style: TextStyle(
                  fontFamily: 'amidum',
                  color: ThemeColor.white,
                  fontSize: 18,
                ),
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 35),
              child: GestureDetector(
                onTap: () {
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
