import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rayzi/app/WebPages/privacyPolicyWeb.dart';
import 'package:rayzi/app/data/APP_variables/AppVariable.dart';
import 'package:rayzi/app/data/AppImages.dart';
import 'package:rayzi/app/data/Colors.dart';
import 'package:rayzi/app/modules/Coins/views/coins_view.dart';
import 'package:rayzi/app/modules/Messages/controllers/messages_controller.dart';
import 'package:rayzi/app/modules/Messages/views/messages_view.dart';
import 'package:rayzi/app/modules/My_App/controllers/my_app_controller.dart';
import 'package:rayzi/app/modules/My_App/views/Broadcast_Screen.dart';
import 'package:rayzi/app/modules/Show_Post/views/show_post_view.dart';
import 'package:rayzi/app/modules/Splash_Screen/controllers/QuickLogincontrooler.dart';
import 'package:rayzi/app/modules/home/views/home_view.dart';

class MyApp extends StatefulWidget {
  final int? index;
  const MyApp({super.key, this.index});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  MyAppController controller = Get.put(MyAppController());
  MessagesController messagesController = Get.put(MessagesController());
  QuickLoginController quickLoginController = Get.put(QuickLoginController());

  @override
  void initState() {
    super.initState();
    [
      Permission.microphone,
      Permission.location,
      Permission.locationWhenInUse,
      Permission.storage,
    ].request();

    // Deferring state changes to the end of the frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.index != null) {
        controller.tabIndex = widget.index!;
      }
      if (getstorage.read('login') == true) {
        userID = getstorage.read("UserID");
        userName = getstorage.read("UserName");
        userProfile.value = getstorage.read("UserProfile");
        userCoins.value = getstorage.read("UserCoins");
        userGender = getstorage.read("Gender");
        userBio = getstorage.read("UserBio");
        userDOB = getstorage.read("UserDOB");
        userProfile.value = getstorage.read("UserProfile");
        userCoins.value = getstorage.read("UserCoins");
      }

      if (getstorage.read('login') == false) {
        show(context);
      }
    });
  }

  /// ===========LOGIN BOTTOMSHEET ========= \\\
  void show(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      isDismissible: false,
      isScrollControlled: true,
      useRootNavigator: false,
      enableDrag: false,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return PopScope(
          canPop: false,
          child: Container(
            height: 310,
            decoration: BoxDecoration(
                color: ThemeColor.white,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(18), topRight: Radius.circular(16))),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(
                    height: 8,
                  ),
                  Container(
                    height: 6.5,
                    width: 55,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Image.asset(
                    AppImages.appIcon,
                    height: 65,
                    width: 65,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () {
                      controller.googleLogin();
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 25, right: 25),
                      child: Container(
                        height: 56,
                        width: Get.width,
                        decoration: BoxDecoration(
                          color: ThemeColor.white,
                          border: Border.all(color: Colors.grey.withOpacity(0.3)),
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(
                              width: 30,
                            ),
                            SizedBox(
                              height: 30,
                              width: 30,
                              child: Image.asset(
                                "Images/google.png",
                              ),
                            ),
                            const Spacer(
                              flex: 1,
                            ),
                            const Text(
                              "Login in with Google",
                              style: TextStyle(
                                fontFamily: 'amidum',
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ),
                            const Spacer(
                              flex: 2,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 25, right: 25),
                    child: InkWell(
                      onTap: () async {
                        quickLoginController.checkQuickLogin();
                      },
                      child: Container(
                        height: 56,
                        width: Get.width,
                        decoration: BoxDecoration(
                          color: ThemeColor.white,
                          border: Border.all(color: Colors.grey.withOpacity(0.3)),
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(
                              width: 30,
                            ),
                            ImageIcon(
                              const AssetImage(
                                "Images/rocket.png",
                              ),
                              color: ThemeColor.pink,
                              size: 22,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            const Spacer(
                              flex: 1,
                            ),
                            Obx(
                                  () => quickLoginController.isLoading.value
                                  ? Center(
                                  child: CircularProgressIndicator(
                                    color: ThemeColor.pink,
                                  ))
                                  : Text(
                                "Quick Login",
                                style: TextStyle(
                                  fontFamily: 'amidum',
                                  fontSize: 18,
                                  color: ThemeColor.blackback,
                                ),
                              ),
                            ),
                            const Spacer(
                              flex: 2,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 25, right: 25),
                    child: GestureDetector(
                      onTap: () {
                        Get.to(() => const PrivacyPolicyWeb());
                      },
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text: 'By login in you agree to our ',
                          style:
                          TextStyle(color: ThemeColor.grayIcon, fontSize: 15, fontFamily: 'amidum'),
                          children: [
                            TextSpan(
                              text: 'Terms of Use and Privacy Policy',
                              style: TextStyle(
                                color: ThemeColor.grayIcon,
                                fontSize: 15,
                                fontFamily: 'amidum',
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyAppController>(
      builder: (controller2) => Scaffold(
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(top: 65),
          child: FloatingActionButton(
            backgroundColor: Colors.transparent,
            elevation: 0,
            onPressed: () {
              Get.to(() => BroadCastScreen());
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    ThemeColor.pink,
                    ThemeColor.purple,
                  ],
                ),
              ),
              child: Center(
                child: Image.asset(
                  AppImages.bottomCenterIcon,
                  height: 30,
                  width: 30,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        body: IndexedStack(
          index: controller.tabIndex,
          children: const [
            HomeView(),
            ShowPostView(),
            HomeView(),
            MessagesView(),
            CoinsView(),
            // ProfileScreenView(),
          ],
        ),
        bottomNavigationBar: SizedBox(
          height: (Platform.isIOS)
              ? 100
              : (Platform.isAndroid)
              ? 80
              : 0,
          child: Theme(
            data: ThemeData(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
            ),
            child: BottomNavigationBar(
              elevation: 5,
              currentIndex: controller.tabIndex,
              unselectedItemColor: Colors.transparent,
              type: BottomNavigationBarType.fixed,
              items: [
                BottomNavigationBarItem(
                  activeIcon: Image.asset(
                    AppImages.homefill,
                    height: 25,
                  ),
                  icon: Image.asset(
                    AppImages.homeunfill,
                    height: 25,
                  ),
                  label: "",
                ),
                BottomNavigationBarItem(
                  icon: Image.asset(
                    AppImages.postunfill,
                    height: 25,
                  ),
                  activeIcon: Image.asset(
                    AppImages.postfill,
                    height: 25,
                  ),
                  label: "",
                ),
                BottomNavigationBarItem(
                  icon: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100), color: Colors.transparent),
                    child: Center(
                        child: Container(
                          height: 28,
                          width: 28,
                          decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(100),
                              border: Border.all(color: Colors.white, width: 3)),
                        )),
                  ),
                  label: "",
                ),
                BottomNavigationBarItem(
                  icon: Stack(
                    children: [
                      Image.asset(
                        AppImages.massageunfill,
                        fit: BoxFit.cover,
                        height: 25,
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: Container(
                          height: 8,
                          width: 8,
                          decoration: BoxDecoration(
                            color: ThemeColor.pink,
                            borderRadius: BorderRadius.circular(100),
                          ),
                        ),
                      )
                    ],
                  ),
                  activeIcon: Stack(
                    children: [
                      Image.asset(
                        AppImages.massagefill,
                        fit: BoxFit.cover,
                        height: 25,
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: Container(
                          height: 8,
                          width: 8,
                          decoration: BoxDecoration(
                            color: ThemeColor.pink,
                            borderRadius: BorderRadius.circular(100),
                          ),
                        ),
                      )
                    ],
                  ),
                  label: "",
                ),
                BottomNavigationBarItem(
                  icon: Image.asset(
                    AppImages.coinunfill,
                    height: 25,
                  ),
                  activeIcon: Image.asset(
                    AppImages.coinfill,
                    height: 25,
                  ),
                  label: "",
                ),
              ],
              onTap: (value) {
                controller.changeTabIndex(value);
                if (value == 3) {
                  messagesController.chatThumbList();
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
