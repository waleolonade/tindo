import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:rayzi/app/data/APP_variables/AppVariable.dart';
import 'package:rayzi/app/data/AppImages.dart';
import 'package:rayzi/app/data/Colors.dart';

import '../controllers/splash_screen_controller.dart';

class SplashScreenView extends StatefulWidget {
  const SplashScreenView({Key? key}) : super(key: key);

  static final StreamController purchaseStreamController = StreamController<PurchaseDetails>.broadcast();

  @override
  State<SplashScreenView> createState() => _SplashScreenViewState();
}

class _SplashScreenViewState extends State<SplashScreenView> with WidgetsBindingObserver {
  SplashScreenController screenController = Get.put(SplashScreenController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.paused) {
      log("==================================================== went to Background");
      bgCall.value = true;
    }
    if (state == AppLifecycleState.resumed) {
      log("====================================================== came back to");
      bgCall.value = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: Get.height,
        width: Get.width,
        decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage(AppImages.splashBG), fit: BoxFit.cover)),
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: Get.height / 2.5,
            ),
            Obx(
              () => (screenController.notActive.value)
                  ? Center(
                      child: Container(
                        height: 230,
                        width: 250,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: ThemeColor.greAlpha20,
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          "App is Not Working Currently",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: ThemeColor.pink, fontSize: 20),
                        ),
                      ),
                    )
                  : (screenController.userBlock.value)
                      ? Center(
                          child: Container(
                            height: 230,
                            width: 250,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: ThemeColor.greAlpha20,
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              "You are Block By Admin",
                              textAlign: TextAlign.center,
                              style: TextStyle(color: ThemeColor.pink, fontSize: 20),
                            ),
                          ),
                        )
                      : SizedBox(
                          height: Get.height / 5.6,
                          width: Get.width / 1.5,
                          child: Image(image: AssetImage(AppImages.splashIcon)),
                        ),
            ),
            const Spacer(),
            Image.asset(
              AppImages.splashText,
              height: 50,
            ),
            SizedBox(
              height: Get.height / 14,
            ),
          ],
        ),
      ),
    );
  }
}
