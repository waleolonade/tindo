import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rayzi/app/Branch_IO/delete_account_controller.dart';
import 'package:rayzi/app/data/AppImages.dart';
import 'package:rayzi/app/data/Colors.dart';
import 'package:rayzi/app/modules/My_App/controllers/my_app_controller.dart';
import 'package:rayzi/app/modules/My_App/views/my_app_view.dart';
import 'package:rayzi/app/modules/User_Profile/views/user_profile_view.dart';

import '../../../data/APP_variables/AppVariable.dart';
import 'Blocked_Users.dart';
import 'Edit_Profile.dart';
import 'Get_Money.dart';
import 'Refill_coin.dart';

class MyAccount extends StatefulWidget {
  const MyAccount({Key? key}) : super(key: key);

  @override
  State<MyAccount> createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  List<String> title = ["Edit profile", "Withdraw money", "Blocked Users", "Log Out", "Delete Account"];
  List<String> iconimage = [
    "Images/User_Profile/edit.png",
    "Images/User_Profile/coin.png",
    "Images/User_Profile/danger.png",
    "Images/User_Profile/log-out.png",
    "Images/Post_Screen/trash.png",
  ];
  DeleteAccountController deleteAccountController = Get.put(DeleteAccountController());
  MyAppController myAppController = Get.put(MyAppController());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.off(const UserProfileView());
        return false;
      },
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Container(
                height: 50,
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(
                      width: 15,
                    ),
                    GestureDetector(
                      onTap: () => Get.off(const UserProfileView()),
                      child: ImageIcon(
                        const AssetImage(
                          "Images/new_dis/back.png",
                        ),
                        size: 25,
                        color: ThemeColor.blackback,
                      ),
                    ),
                    const SizedBox(
                      width: 26,
                    ),
                    Text(
                      "My Account",
                      style: TextStyle(fontFamily: 'abold', fontSize: 20, color: ThemeColor.blackback),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Expanded(
                child: SizedBox(
                  child: ListView.separated(
                    itemCount: title.length,
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        height: 5,
                      );
                    },
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () async {
                          (index == 0)
                              ? Get.to(() => const EditeProfile())
                              : (index == 1)
                                  ? Get.to(() => GetMoney())
                                  : (index == 2)
                                      ? Get.to(() => const BlockedUsers())
                                      : (index == 3)
                                          ? Get.bottomSheet(logOutsheet())
                                          : Get.bottomSheet(accountSheet());
                        },
                        splashFactory: NoSplash.splashFactory,
                        splashColor: Colors.transparent,
                        child: Container(
                          height: 60,
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                iconimage[index],
                                width: 24,
                                height: 60,
                                color: ThemeColor.blackback,
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Text(
                                title[index],
                                style: TextStyle(
                                  color: ThemeColor.blackback,
                                  fontFamily: 'amidum',
                                  fontSize: 19,
                                ),
                              ),
                              const Spacer(),
                              (index == 1)
                                  ? Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        SizedBox(height: 16, width: 16, child: Image.asset(AppImages.coinImages)),
                                        const SizedBox(
                                          width: 2.5,
                                        ),
                                        Obx(
                                          () => Text(
                                            "${userCoins.value}",
                                            style: TextStyle(
                                                fontSize: 18,
                                                // color: theme_Color.white,
                                                color: ThemeColor.blackback,
                                                fontFamily: 'abold'),
                                          ),
                                        )
                                      ],
                                    )
                                  : const SizedBox(),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container logOutsheet() {
    return Container(
      height: 295,
      decoration: BoxDecoration(
        color: ThemeColor.white,
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(16),
          topLeft: Radius.circular(16),
        ),
      ),
      alignment: Alignment.center,
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 6.5,
            width: 45,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: Colors.grey,
            ),
          ).paddingOnly(top: 8, bottom: 20),
          Text(
            "Log Out",
            style: TextStyle(
              fontFamily: 'abold',
              fontSize: 22,
              color: ThemeColor.blackback,
            ),
          ),
          Text(
            "Are you sure you want to log out of ${getstorage.read('UserName')} ?",
            maxLines: 2,
            textAlign: TextAlign.center,
            style: TextStyle(color: ThemeColor.blackback, fontSize: 15, fontFamily: 'amidum'),
          ).paddingSymmetric(vertical: 13),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(left: 6, right: 6),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  MyAppController().logOut();
                  getstorage.write("UserID", "");
                  getstorage.write("UserProfile", "");
                  getstorage.write('UserName', "");
                  getstorage.write('Gender', "");
                  getstorage.write("Country", "");
                  getstorage.write("UserCoins", "");
                  getstorage.write("UserBio", "");
                  getstorage.write("UserDOB", "");
                  getstorage.write("userDiamond", "");
                  getstorage.write('login', false);
                  Get.offAll(const MyApp());
                });
              },
              child: Container(
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: ThemeColor.pink,
                ),
                alignment: Alignment.center,
                child: Text(
                  "Log Out",
                  style: TextStyle(
                    color: ThemeColor.white,
                    fontSize: 18,
                    fontFamily: 'abold',
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 6, right: 6),
            child: GestureDetector(
              onTap: () => Get.back(),
              child: Container(
                height: 60,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: ThemeColor.white,
                    border: Border.all(color: ThemeColor.greAlpha20.withOpacity(0.3))),
                alignment: Alignment.center,
                child: Text(
                  "Cancel",
                  style: TextStyle(
                    color: ThemeColor.blackback,
                    fontSize: 18,
                    fontFamily: 'abold',
                  ),
                ),
              ),
            ),
          ).paddingSymmetric(vertical: 15),
        ],
      ),
    );
  }

  Container accountSheet() {
    return Container(
      height: 295,
      decoration: BoxDecoration(
        color: ThemeColor.white,
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(16),
          topLeft: Radius.circular(16),
        ),
      ),
      alignment: Alignment.center,
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 6.5,
            width: 45,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: Colors.grey,
            ),
          ).paddingOnly(top: 8, bottom: 20),
          Text(
            "Delete Account",
            style: TextStyle(
              fontFamily: 'abold',
              fontSize: 22,
              color: ThemeColor.blackback,
            ),
          ),
          Text(
            "Are you sure you want to permanently delete your account?",
            maxLines: 2,
            textAlign: TextAlign.center,
            style: TextStyle(color: ThemeColor.blackback, fontSize: 15, fontFamily: 'amidum'),
          ).paddingSymmetric(vertical: 13),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(left: 6, right: 6),
            child: GestureDetector(
              onTap: () {
                setState(() async {
                  await deleteAccountController.deleteAccount(userID);

                  myAppController.googleSignIn.signOut();

                  getstorage.write("UserID", "");
                  getstorage.write("UserProfile", "");
                  getstorage.write('UserName', "");
                  getstorage.write('Gender', "");
                  getstorage.write("Country", "");
                  getstorage.write("UserCoins", "");
                  getstorage.write("UserBio", "");
                  getstorage.write("UserDOB", "");
                  getstorage.write("userDiamond", "");
                  getstorage.write('login', false);
                  Get.offAll(const MyApp());
                });
              },
              child: Container(
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: ThemeColor.pink,
                ),
                alignment: Alignment.center,
                child: Text(
                  "Delete Account",
                  style: TextStyle(
                    color: ThemeColor.white,
                    fontSize: 18,
                    fontFamily: 'abold',
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 6, right: 6),
            child: GestureDetector(
              onTap: () => Get.back(),
              child: Container(
                height: 60,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: ThemeColor.white,
                    border: Border.all(color: ThemeColor.greAlpha20.withOpacity(0.3))),
                alignment: Alignment.center,
                child: Text(
                  "Cancel",
                  style: TextStyle(
                    color: ThemeColor.blackback,
                    fontSize: 18,
                    fontFamily: 'abold',
                  ),
                ),
              ),
            ),
          ).paddingSymmetric(vertical: 15),
        ],
      ),
    );
  }
}
