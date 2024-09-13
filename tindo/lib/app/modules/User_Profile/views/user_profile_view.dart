import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rayzi/app/Branch_IO/BranchIOController.dart';
import 'package:rayzi/app/data/APP_variables/AppVariable.dart';
import 'package:rayzi/app/data/AppImages.dart';
import 'package:rayzi/app/data/Colors.dart';
import 'package:rayzi/app/modules/My_App/views/my_app_view.dart';
import 'package:rayzi/app/modules/User_Profile/controllers/user_profile_controller.dart';
import 'package:rayzi/app/modules/User_Profile/views/Get_Money.dart';
import 'package:shimmer/shimmer.dart';

import '../../../API_Services/create_post_services.dart';
import 'FollowersScreen.dart';
import 'Following_Screen.dart';
import 'My_Account.dart';
import 'UserProfilePosts.dart';

class UserProfileView extends StatefulWidget {
  const UserProfileView({
    Key? key,
  }) : super(key: key);

  @override
  State<UserProfileView> createState() => _UserProfileViewState();
}

class _UserProfileViewState extends State<UserProfileView> with SingleTickerProviderStateMixin {
  TextEditingController discription = TextEditingController();
  BranchIOController branchIOController = Get.put(BranchIOController());
  UserProfileController userProfileController = Get.put(UserProfileController());
  File? proImage;

  @override
  void initState()  {
     userProfileController.profileget();
    super.initState();
  }

  Future cameraImage() async {
    try {
      final imagepike = await ImagePicker().pickImage(source: ImageSource.camera);
      if (imagepike == null) return;

      final imageTeam = File(imagepike.path);
      setState(() {
        proImage = imageTeam;
        Get.back();
        Get.bottomSheet(
          isDismissible: false,
          Container(
            height: 500,
            decoration: BoxDecoration(
              color: ThemeColor.white,
              borderRadius: const BorderRadius.only(topRight: Radius.circular(22), topLeft: Radius.circular(22)),
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Spacer(),
                        GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: ThemeColor.blackback.withOpacity(0.08),
                            ),
                            child: Icon(Icons.close, color: ThemeColor.blackback.withOpacity(0.8)),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 18,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: Container(
                          height: 200,
                          width: Get.width,
                          decoration: BoxDecoration(
                            color: ThemeColor.greAlpha20.withOpacity(0.13),
                            borderRadius: BorderRadius.circular(13),
                            image: DecorationImage(
                              image: FileImage(proImage!),
                              fit: BoxFit.fitHeight,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: TextFormField(
                          controller: discription,
                          minLines: 2,
                          maxLines: 4,
                          cursorColor: ThemeColor.blackback,
                          decoration: InputDecoration(
                            hintStyle: TextStyle(
                              color: ThemeColor.grayIcon,
                              fontFamily: "amidum",
                              fontSize: 18,
                            ),
                            hintText: "What's new?",
                            focusedErrorBorder:
                                OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
                            disabledBorder:
                                OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
                            focusedBorder:
                                OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
                            enabledBorder:
                                OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
                            fillColor: ThemeColor.greAlpha20.withOpacity(0.1),
                            filled: true,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      GestureDetector(
                        onTap: () async {
                          userProfileController.postLoding.value = true;
                          await CreatePostServices().createPostServices(discription.text, proImage!);
                          await userProfileController.profileget();
                          userProfileController.postLoding.value = false;
                          Get.back();
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: Container(
                            height: 50,
                            width: Get.width,
                            decoration: BoxDecoration(
                              color: ThemeColor.pink,
                              borderRadius: BorderRadius.circular(100),
                            ),
                            alignment: Alignment.center,
                            child: Obx(
                              () => (userProfileController.postLoding.value)
                                  ? Center(
                                      child: CircularProgressIndicator(color: ThemeColor.white),
                                    )
                                  : Text("Post", style: TextStyle(color: ThemeColor.white, fontSize: 18, fontFamily: 'abold')),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      });
    } on PlatformException catch (e) {
      log("$e");
    }
  }

  Future pickImage() async {
    try {
      final imagepike = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (imagepike == null) return;

      final imageTeam = File(imagepike.path);
      setState(() {
        proImage = imageTeam;
        Get.back();
        Get.bottomSheet(
          isDismissible: false,
          Container(
            height: 500,
            decoration: BoxDecoration(
              color: ThemeColor.white,
              borderRadius: const BorderRadius.only(topRight: Radius.circular(22), topLeft: Radius.circular(22)),
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Spacer(),
                        // Container(
                        //   height: 6,
                        //   width: 70,
                        //   decoration: BoxDecoration(
                        //     borderRadius: BorderRadius.circular(50),
                        //     color: theme_Color.pink,
                        //   ),
                        // ),
                        // Spacer(),
                        GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: ThemeColor.blackback.withOpacity(0.08),
                            ),
                            child: Icon(Icons.close, color: ThemeColor.blackback.withOpacity(0.8)),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 18,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: Container(
                          height: 200,
                          width: Get.width,
                          decoration: BoxDecoration(
                            color: ThemeColor.greAlpha20.withOpacity(0.13),
                            borderRadius: BorderRadius.circular(13),
                            image: DecorationImage(
                              image: FileImage(proImage!),
                              fit: BoxFit.fitHeight,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: TextFormField(
                          minLines: 2,
                          maxLines: 4,
                          controller: discription,
                          cursorColor: ThemeColor.blackback,
                          decoration: InputDecoration(
                            hintStyle: TextStyle(
                              color: ThemeColor.grayIcon,
                              fontFamily: "amidum",
                              fontSize: 18,
                            ),
                            hintText: "What's new?",
                            focusedErrorBorder:
                                OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
                            disabledBorder:
                                OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
                            focusedBorder:
                                OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
                            enabledBorder:
                                OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
                            fillColor: ThemeColor.greAlpha20.withOpacity(0.1),
                            filled: true,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      GestureDetector(
                        onTap: () async {
                          userProfileController.postLoding.value = true;
                          await CreatePostServices().createPostServices(discription.text, proImage!);
                          await userProfileController.profileget();
                          userProfileController.postLoding.value = false;
                          Get.back();
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: Container(
                            height: 50,
                            width: Get.width,
                            decoration: BoxDecoration(
                              color: ThemeColor.pink,
                              borderRadius: BorderRadius.circular(100),
                            ),
                            alignment: Alignment.center,
                            child: Obx(
                              () => (userProfileController.postLoding.value)
                                  ? Center(
                                      child: CircularProgressIndicator(color: ThemeColor.white),
                                    )
                                  : Text("Post", style: TextStyle(color: ThemeColor.white, fontSize: 18, fontFamily: 'abold')),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      });
    } on PlatformException catch (e) {
      log("fail$e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (branchIOVisit.value = true) {
          Get.offAll(const MyApp());
        } else {
          Get.back();
        }
        return false;
      },
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(46),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 20,
                color: Colors.transparent,
              ),
              Container(
                height: 50,
                color: Colors.transparent,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(
                      width: 15,
                    ),
                    GestureDetector(
                      onTap: () {
                        if (branchIOVisit.value = true) {
                          Get.offAll(const MyApp());
                        } else {
                          Get.back();
                        }
                      },
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
                      "Profile",
                      style: TextStyle(fontFamily: 'abold', fontSize: 18.5, color: ThemeColor.blackback),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        branchIOController.imageURL.value = "$userProfile";
                        branchIOController.initDeepLinkDataProfile(
                          shareType: 1,
                          profileUserID: userID,
                        );
                        branchIOController.generateLink();
                      },
                      child: ImageIcon(
                        const AssetImage(
                          "Images/Post_Screen/share_post.png",
                        ),
                        size: 25,
                        color: ThemeColor.blackback,
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    InkWell(
                      onTap: () => Get.off(const MyAccount()),
                      child: ImageIcon(
                        const AssetImage(
                          "Images/new_dis/menu.png",
                        ),
                        size: 16,
                        color: ThemeColor.blackback,
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        body: Obx(
          () => (userProfileController.isLoding.value)
              ? shimmer()
              : NestedScrollView(
                  headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
                    return [
                      SliverToBoxAdapter(
                        child: Container(
                          color: ThemeColor.white,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 5,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 15, right: 15),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 72,
                                      width: 72,
                                      clipBehavior: Clip.hardEdge,
                                      decoration: const BoxDecoration(shape: BoxShape.circle),
                                      child: Obx(
                                        () => CachedNetworkImage(
                                          placeholder: (context, url) =>
                                              Image.asset(AppImages.profileImagePlaceHolder, fit: BoxFit.cover),
                                          fit: BoxFit.cover,
                                          imageUrl: userProfile.value,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          //"${userProfileController.profileData["userProfile"]["name"].toString()}",
                                          userName,
                                          style: TextStyle(
                                            color: ThemeColor.blackback,
                                            fontSize: 20,
                                            fontFamily: 'abold',
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 4,
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Text(
                                              "ID:${userProfileController.profileData["userProfile"]["uniqueId"].toString()} ",
                                              style: TextStyle(
                                                  color: ThemeColor.grayIcon.withOpacity(0.7),
                                                  fontFamily: "amidum",
                                                  fontSize: 14),
                                            ),
                                            Container(
                                              padding: const EdgeInsets.only(
                                                left: 6,
                                                right: 6,
                                                top: 1.5,
                                                bottom: 1.5,
                                              ),
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(6),
                                                color: ThemeColor.grayIcon.withOpacity(0.1),
                                              ),
                                              child: Text(
                                                userProfileController.profileData["userProfile"]["country"].toString(),
                                                style: TextStyle(
                                                    // color: theme_Color.gray_icon
                                                    //     .withOpacity(0.7),
                                                    color: ThemeColor.blackback.withOpacity(0.7),
                                                    fontFamily: "amidum",
                                                    fontSize: 15),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 4,
                                        ),
                                        ConstrainedBox(
                                          constraints: const BoxConstraints(maxHeight: 100, maxWidth: 200),
                                          child: Text(
                                            //"${userProfileController.profileData["userProfile"]["bio"].toString()}",
                                            userBio,
                                            style: TextStyle(
                                                color: ThemeColor.blackback.withOpacity(0.92),
                                                fontFamily: "amidum",
                                                fontSize: 15),
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 15, right: 15),
                                child: Container(
                                  height: 90,
                                  width: Get.width,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(color: ThemeColor.textGray.withOpacity(0.8), width: 0.6),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      GestureDetector(
                                        onTap: () => Get.to(() => GetMoney()),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              userProfileController.profileData["userProfile"]["coin"].toString(),
                                              style: const TextStyle(
                                                fontFamily: 'abold',
                                                fontSize: 18,
                                                color: Colors.black,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Row(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Image.asset(
                                                  AppImages.coinImages,
                                                  height: 12,
                                                  width: 12,
                                                ).paddingOnly(top: 2, right: 4),
                                                Text(
                                                  "Earned",
                                                  style: TextStyle(
                                                    fontFamily: 'amidum',
                                                    fontSize: 14,
                                                    color: ThemeColor.blackback.withOpacity(0.6),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        height: 45,
                                        width: 1,
                                        color: ThemeColor.textGray.withOpacity(0.8),
                                      ),
                                      GestureDetector(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              userProfileController.profileData["userProfile"]["totalLike"].toString(),
                                              style: const TextStyle(
                                                fontFamily: 'abold',
                                                fontSize: 18,
                                                color: Colors.black,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              "   Like   ",
                                              style: TextStyle(
                                                fontFamily: 'amidum',
                                                fontSize: 14,
                                                color: ThemeColor.blackback.withOpacity(0.6),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Container(
                                        height: 45,
                                        width: 1,
                                        color: ThemeColor.textGray.withOpacity(0.8),
                                      ),
                                      GestureDetector(
                                        onTap: () => Get.to(() => const FollowingScreen()),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              userProfileController.profileData["userProfile"]["following"].toString(),
                                              style: const TextStyle(
                                                fontFamily: 'abold',
                                                fontSize: 18,
                                                color: Colors.black,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              "Following",
                                              style: TextStyle(
                                                fontFamily: 'amidum',
                                                fontSize: 14,
                                                color: ThemeColor.blackback.withOpacity(0.6),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Container(
                                        height: 45,
                                        width: 1,
                                        color: ThemeColor.textGray.withOpacity(0.8),
                                      ),
                                      GestureDetector(
                                        onTap: () => Get.to(const FollowersScreen()),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              userProfileController.profileData["userProfile"]["followers"].toString(),
                                              style: const TextStyle(
                                                fontFamily: 'abold',
                                                fontSize: 18,
                                                color: Colors.black,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              "Followers",
                                              style: TextStyle(
                                                fontFamily: 'amidum',
                                                fontSize: 14,
                                                color: ThemeColor.blackback.withOpacity(0.6),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 20, right: 20),
                                child: GestureDetector(
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
                                              onTap: () => cameraImage(),
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
                                                      style: TextStyle(
                                                          fontFamily: 'amidum', fontSize: 15, color: ThemeColor.blackback),
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
                                              onTap: () => pickImage(),
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
                                                          fontFamily: 'amidum', fontSize: 15, color: ThemeColor.blackback),
                                                    ),
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
                                    ));
                                  },
                                  child: Container(
                                    height: 55,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        gradient: LinearGradient(colors: [
                                          ThemeColor.pink,
                                          ThemeColor.pink,
                                        ])),
                                    alignment: Alignment.center,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.add_circle_outline,
                                          size: 24,
                                          color: ThemeColor.white,
                                        ).paddingOnly(bottom: 2, right: 6),
                                        Text(
                                          "Add post",
                                          style: TextStyle(
                                            color: ThemeColor.white,
                                            fontSize: 20,
                                            fontFamily: 'amidum',
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ];
                  },
                  body: (userProfileController.isPostNull.value)
                      ? Center(
                          child: Image.asset(
                            AppImages.nodataImage,
                            height: 200,
                            width: 200,
                          ),
                        )
                      : CustomScrollView(
                          slivers: [
                            GetBuilder<UserProfileController>(
                              builder: (controller) => SliverPadding(
                                padding: const EdgeInsets.only(left: 5, right: 5, top: 20),
                                sliver: SliverGrid(
                                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    mainAxisSpacing: 2,
                                    crossAxisSpacing: 2,
                                    childAspectRatio: 0.75,
                                  ),
                                  delegate: SliverChildBuilderDelegate(
                                    (context, index) {
                                      return GestureDetector(
                                        onTap: () => Get.off(const UserProfilePostScreen()),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(7),
                                            border: Border.all(color: ThemeColor.grayIcon.withOpacity(0.3), width: 1),
                                            color: ThemeColor.grayIcon.withOpacity(0.1),
                                          ),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(7),
                                            child: CachedNetworkImage(
                                              fit: BoxFit.cover,
                                              imageUrl: userProfileController.profileData["userProfile"]["userPost"][index]
                                                      ["postImage"]
                                                  .toString(),
                                              placeholder: (context, url) => Center(
                                                  child: Image.asset(AppImages.postImagePlaceHolder,
                                                      color: Colors.grey[300], height: 60)),
                                              errorWidget: (context, string, dynamic) => Image(
                                                height: 400,
                                                color: Colors.grey.withOpacity(0.4),
                                                image: AssetImage(
                                                  AppImages.bottomCenterIcon,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                    childCount: userProfileController.profileData["userProfile"]["userPost"].length,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                ),
        ),
      ),
    );
  }

  Shimmer shimmer() {
    return Shimmer.fromColors(
      highlightColor: ThemeColor.shimmerHighlight,
      baseColor: ThemeColor.shimmerBaseColor,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CircleAvatar(
                    radius: 36,
                    backgroundColor: Colors.red,
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 20,
                        color: Colors.red,
                        width: 100,
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            height: 10,
                            width: 50,
                            color: Colors.red,
                          ),
                          Container(
                              padding: const EdgeInsets.only(
                                left: 6,
                                right: 6,
                                top: 1.5,
                                bottom: 1.5,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                color: ThemeColor.grayIcon.withOpacity(0.1),
                              ),
                              child: Container(
                                height: 10,
                                width: 20,
                                color: Colors.red,
                              )),
                        ],
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      ConstrainedBox(
                          constraints: const BoxConstraints(maxHeight: 100, maxWidth: 200),
                          child: Container(
                            height: 15,
                            width: 200,
                            color: Colors.red,
                          ))
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Container(
                height: 90,
                width: Get.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: ThemeColor.textGray.withOpacity(0.8), width: 0.6),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                        child: Container(
                      color: Colors.transparent,
                    )),
                    Container(
                      height: 45,
                      width: 1,
                      color: ThemeColor.textGray.withOpacity(0.8),
                    ),
                    Expanded(
                        child: Container(
                      color: Colors.transparent,
                    )),
                    Container(
                      height: 45,
                      width: 1,
                      color: ThemeColor.textGray.withOpacity(0.8),
                    ),
                    Expanded(
                        child: Container(
                      color: Colors.transparent,
                    )),
                    Container(
                      height: 45,
                      width: 1,
                      color: ThemeColor.textGray.withOpacity(0.8),
                    ),
                    Expanded(
                        child: Container(
                      color: Colors.transparent,
                    )),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Container(
                height: 55,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    gradient: LinearGradient(colors: [
                      ThemeColor.pink,
                      ThemeColor.pink,
                    ])),
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.add_circle_outline,
                      size: 26,
                      color: ThemeColor.white,
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    Text(
                      "Add post",
                      style: TextStyle(
                        color: ThemeColor.white,
                        fontSize: 22,
                        fontFamily: 'amidum',
                      ),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      child: Container(
                    height: 200,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  )),
                  const SizedBox(
                    width: 5,
                  ),
                  Expanded(
                      child: Container(
                    height: 200,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  )),
                  const SizedBox(
                    width: 5,
                  ),
                  Expanded(
                      child: Container(
                    height: 200,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  )),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      child: Container(
                    height: 200,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  )),
                  const SizedBox(
                    width: 5,
                  ),
                  Expanded(
                      child: Container(
                    height: 200,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  )),
                  const SizedBox(
                    width: 5,
                  ),
                  Expanded(
                      child: Container(
                    height: 200,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  )),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
