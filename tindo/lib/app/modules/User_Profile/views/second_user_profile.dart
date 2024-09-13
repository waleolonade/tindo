import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rayzi/app/API_Services/app_url.dart';
import 'package:rayzi/app/Branch_IO/BranchIOController.dart';
import 'package:rayzi/app/data/APP_variables/AppVariable.dart';
import 'package:rayzi/app/data/AppImages.dart';
import 'package:rayzi/app/data/Colors.dart';
import 'package:rayzi/app/modules/Messages/views/FakeMessage.dart';
import 'package:rayzi/app/modules/Messages/views/Message_Show.dart';
import 'package:rayzi/app/modules/My_App/controllers/my_app_controller.dart';
import 'package:rayzi/app/modules/My_App/views/my_app_view.dart';
import 'package:rayzi/app/modules/User_Profile/controllers/SecondUserProfileController.dart';
import 'package:rayzi/app/modules/User_Profile/views/second_user_profile_post.dart';
import 'package:shimmer/shimmer.dart';

class SecondUserProfileView extends StatefulWidget {
  final String userID;
  const SecondUserProfileView({
    Key? key,
    required this.userID,
  }) : super(key: key);

  @override
  State<SecondUserProfileView> createState() => _SecondUserProfileViewState();
}

class _SecondUserProfileViewState extends State<SecondUserProfileView> with SingleTickerProviderStateMixin {
  SecondUserProfileController userProfileController = Get.put(SecondUserProfileController());
  MyAppController myAppController = Get.put(MyAppController());
  BranchIOController branchIOController = Get.put(BranchIOController());
  @override
  void initState() {
    super.initState();
    userProfileController.profileget(widget.userID);
    log("==========================${userProfileController.followStatus}");
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (branchIOVisit.value == true) {
          Get.offAll(const MyApp());
        } else {
          Get.back();
        }
        return false;
      },
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(45),
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
                        if (branchIOVisit.value == true) {
                          log("================================");
                          Get.offAll(const MyApp());
                        } else {
                          log("=KKKKKKKKKKKKKKKKKKKKKKKKKKKKK");
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
                      width: 20,
                    ),
                    Text(
                      "Profile",
                      style: TextStyle(fontFamily: 'abold', fontSize: 18.5, color: ThemeColor.blackback),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        Get.bottomSheet(menusheet());
                      },
                      child: Icon(
                        Icons.more_vert_outlined,
                        size: 28,
                        color: ThemeColor.blackback,
                      ),
                    ),
                    const SizedBox(
                      width: 5,
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
                                      child: CachedNetworkImage(
                                        imageUrl: userProfileController.postData["userProfile"]["profileImage"].toString(),
                                        placeholder: (context, url) =>
                                            Image.asset(AppImages.profileImagePlaceHolder, fit: BoxFit.cover),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          userProfileController.postData["userProfile"]["name"].toString(),
                                          style: TextStyle(
                                            color: ThemeColor.blackback,
                                            fontSize: 18,
                                            fontFamily: 'abold',
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Text(
                                              "ID : ${userProfileController.postData["userProfile"]["uniqueId"].toString()}",
                                              style: TextStyle(
                                                  color: ThemeColor.grayIcon.withOpacity(0.7),
                                                  fontFamily: "amidum",
                                                  fontSize: 14),
                                            ),
                                            const SizedBox(
                                              width: 5,
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
                                                userProfileController.postData["userProfile"]["country"].toString(),
                                                style: TextStyle(
                                                    color: ThemeColor.blackback.withOpacity(0.7),
                                                    fontFamily: "amidum",
                                                    fontSize: 15),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        ConstrainedBox(
                                          constraints: const BoxConstraints(maxHeight: 100, maxWidth: 200),
                                          child: Text(
                                            userProfileController.postData["userProfile"]["bio"].toString(),
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
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              userProfileController.postData["userProfile"]["coin"].toString(),
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
                                              userProfileController.postData["userProfile"]["totalLike"].toString(),
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
                                        //onTap: () => Get.to(FanScreen()),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              userProfileController.postData["userProfile"]["followers"].toString(),
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
                                      Container(
                                        height: 45,
                                        width: 1,
                                        color: ThemeColor.graylight,
                                      ),
                                      GestureDetector(
                                        // onTap: () => Get.to(FollowingScreen()),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              userProfileController.postData["userProfile"]["following"].toString(),
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
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),

                              ///last Follow ,and Message
                              Padding(
                                padding: const EdgeInsets.only(left: 15, right: 15),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Obx(
                                      () => Expanded(
                                        child: GestureDetector(
                                          onTap: () {
                                            userProfileController.followRequest();
                                          },
                                          child: (userProfileController.isfollow.value)
                                              ? Container(
                                                  alignment: Alignment.center,
                                                  height: 55,
                                                  //width: Get.width / 1.7,
                                                  decoration: BoxDecoration(
                                                    color: ThemeColor.graylight,
                                                    borderRadius: BorderRadius.circular(50),
                                                  ),
                                                  child: (userProfileController.indicater == false)
                                                      ? Text(
                                                          "Unfollow",
                                                          style: TextStyle(
                                                            fontFamily: 'abold',
                                                            fontSize: 16,
                                                            color: ThemeColor.white,
                                                            fontWeight: FontWeight.w600,
                                                          ),
                                                        )
                                                      : SizedBox(
                                                          height: 20,
                                                          width: 20,
                                                          child: CircularProgressIndicator(
                                                            color: ThemeColor.white,
                                                            strokeWidth: 2,
                                                          ),
                                                        ),
                                                )
                                              : Container(
                                                  alignment: Alignment.center,
                                                  height: 55,
                                                  //  width: Get.width / 1.7,
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(50),
                                                    color: ThemeColor.pink,
                                                  ),
                                                  child: (userProfileController.indicater == false)
                                                      ? Text(
                                                          "Follow",
                                                          style: TextStyle(
                                                            fontFamily: 'abold',
                                                            fontSize: 16,
                                                            color: ThemeColor.white,
                                                            fontWeight: FontWeight.w600,
                                                          ),
                                                        )
                                                      : SizedBox(
                                                          height: 20,
                                                          width: 20,
                                                          child: CircularProgressIndicator(
                                                            color: ThemeColor.white,
                                                            strokeWidth: 2,
                                                          ),
                                                        ),
                                                ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        branchIOController.imageURL.value =
                                            userProfileController.postData["userProfile"]["profileImage"].toString();
                                        branchIOController.initDeepLinkDataProfile(
                                          shareType: 1,
                                          profileUserID: userProfileController.postData["userProfile"]["_id"].toString(),
                                        );
                                        branchIOController.generateLink();
                                      },
                                      child: Container(
                                        height: 55,
                                        width: 55,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(100),
                                          border: Border.all(color: ThemeColor.greAlpha20),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(14.5),
                                          child: Image.asset("Images/Post_Screen/share_post.png",
                                              color: ThemeColor.blackback, fit: BoxFit.fill),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        if (userProfileController.postData["userProfile"]["isFake"] == true) {
                                          Get.to(() => FakeMessageShow(
                                                images:
                                                    // '${Constant.BASE_URL}${userProfileController.postData["userProfile"]["profileImage"].toString()}',
                                                    '${userProfileController.postData["userProfile"]["profileImage"]}',
                                                name: userProfileController.postData["userProfile"]["name"].toString(),
                                                userId: userProfileController.postData["userProfile"]["_id"].toString(),
                                                videoUrl:
                                                    '${Constant.BASE_URL}${userProfileController.postData["userProfile"]["video"].toString()}',
                                              ));
                                        } else {
                                          Get.to(()=>MessageShow(
                                            images: userProfileController.postData["userProfile"]["profileImage"].toString(),
                                            name: userProfileController.postData["userProfile"]["name"].toString(),
                                            userId2: userProfileController.postData["userProfile"]["_id"].toString(),
                                            chatRoomId: userProfileController.chatTopicModel!.chatTopic!.id.toString(),
                                            senderId: userID,
                                            // oldChatList: userProfileController
                                            //         .oldChatModel!.chat ??
                                            //     [],
                                          ));
                                        }
                                      },
                                      child: Container(
                                        height: 55,
                                        width: 55,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(100),
                                          border: Border.all(color: ThemeColor.greAlpha20),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(14.5),
                                          child: Image.asset("Images/Post_Screen/comment.png",
                                              color: ThemeColor.blackback, fit: BoxFit.fill),
                                        ),
                                      ),
                                    ),
                                  ],
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
                            SliverPadding(
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
                                      onTap: () => Get.to(()=>SecondUserPost(
                                        secounduserID: "${userProfileController.postData["userProfile"]["_id"]}",
                                      )),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(7),
                                          border: Border.all(color: ThemeColor.grayIcon.withOpacity(0.3), width: 2),
                                          color: ThemeColor.grayIcon.withOpacity(0.3),
                                        ),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(7),
                                          child: CachedNetworkImage(
                                            fit: BoxFit.cover,
                                            imageUrl:
                                                "${userProfileController.postData["userProfile"]["userPost"][index]["postImage"]}",
                                            placeholder: (context, url) => Center(
                                                child: Image.asset(AppImages.postImagePlaceHolder,
                                                    color: Colors.grey[300], height: 60)),
                                            errorWidget: (context, string, dynamic) => Image(
                                              height: 400,
                                              color: Colors.grey.withOpacity(0.4),
                                              fit: BoxFit.cover,
                                              image: AssetImage(
                                                AppImages.bottomCenterIcon,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                  childCount: userProfileController.postData["userProfile"]["userPost"].length,
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
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Row(
                children: [
                  Expanded(
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
                  const SizedBox(
                    width: 10,
                  ),
                  Container(
                      height: 55,
                      width: 55,
                      decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(100))),
                  const SizedBox(
                    width: 10,
                  ),
                  Container(
                      height: 55,
                      width: 55,
                      decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(100))),
                ],
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

  Container menusheet() {
    return Container(
      height: 225,
      decoration: BoxDecoration(
        color: ThemeColor.white,
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(14),
          topLeft: Radius.circular(14),
        ),
      ),
      alignment: Alignment.center,
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
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
          const Spacer(),
          GestureDetector(
            onTap: () {
              branchIOController.imageURL.value = userProfileController.postData["userProfile"]["profileImage"].toString();
              branchIOController.initDeepLinkDataProfile(
                shareType: 1,
                profileUserID: userProfileController.postData["userProfile"]["_id"].toString(),
              );
              branchIOController.generateLink();
            },
            child: SizedBox(
              height: 55,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ImageIcon(
                    const AssetImage(
                      "Images/Post_Screen/share_post.png",
                    ),
                    size: 25,
                    color: ThemeColor.blackback,
                  ),
                  const SizedBox(
                    width: 25,
                  ),
                  Text(
                    "Share profile",
                    style: TextStyle(
                      color: ThemeColor.blackback,
                      fontSize: 20,
                      fontFamily: 'amidum',
                    ),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              userProfileController.blockRequest(blockUser: userProfileController.postData["userProfile"]["_id"].toString());
            },
            child: SizedBox(
              height: 55,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    "Images/Post_Screen/blocked.png",
                    height: 25,
                    width: 25,
                    color: ThemeColor.blackback,
                  ),
                  const SizedBox(
                    width: 25,
                  ),
                  Text(
                    "Block User",
                    style: TextStyle(
                      color: ThemeColor.blackback,
                      fontSize: 20,
                      fontFamily: 'amidum',
                    ),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Get.back();
              Get.bottomSheet(Container(
                height: 518,
                decoration: BoxDecoration(
                  color: ThemeColor.white,
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(16),
                    topLeft: Radius.circular(16),
                  ),
                ),
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
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
                      height: 20,
                    ),
                    Text(
                      "Report on",
                      style: TextStyle(color: ThemeColor.blackback, fontSize: 22, fontFamily: 'abold'),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    Text(
                      userProfileController.postData["userProfile"]["name"].toString(),
                      style: TextStyle(color: ThemeColor.blackback, fontSize: 20, fontFamily: 'abold'),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    GetBuilder<SecondUserProfileController>(
                      builder: (controller) => Column(
                        children: [
                          SizedBox(
                            height: 40,
                            child: ListTile(
                              title: const Text('sexual Content'),
                              leading: Radio<SingingCharacter>(
                                value: SingingCharacter.sexualContent,
                                groupValue: userProfileController.character,
                                activeColor: ThemeColor.pink,
                                onChanged: (SingingCharacter? value) {
                                  userProfileController.reportRedio(value, 0);
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 40,
                            child: ListTile(
                              title: const Text('Violent Content'),
                              leading: Radio<SingingCharacter>(
                                value: SingingCharacter.ViolentContent,
                                groupValue: userProfileController.character,
                                activeColor: ThemeColor.pink,
                                onChanged: (SingingCharacter? value) {
                                  // setState(() {
                                  //   showPostController
                                  //       .character = value;
                                  // });
                                  userProfileController.reportRedio(value, 1);
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 35,
                            child: ListTile(
                              title: const Text('child abuse'),
                              leading: Radio<SingingCharacter>(
                                value: SingingCharacter.childAbuse,
                                groupValue: userProfileController.character,
                                activeColor: ThemeColor.pink,
                                onChanged: (SingingCharacter? value) {
                                  // setState(() {
                                  //   showPostController
                                  //       .character = value;
                                  // });
                                  userProfileController.reportRedio(value, 2);
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 35,
                            child: ListTile(
                              title: const Text('Spam'),
                              leading: Radio<SingingCharacter>(
                                value: SingingCharacter.Spam,
                                groupValue: userProfileController.character,
                                activeColor: ThemeColor.pink,
                                onChanged: (SingingCharacter? value) {
                                  // setState(() {
                                  //   showPostController
                                  //       .character = value;
                                  // });
                                  userProfileController.reportRedio(value, 3);
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 35,
                            child: ListTile(
                              title: const Text('Other'),
                              leading: Radio<SingingCharacter>(
                                value: SingingCharacter.Other,
                                groupValue: userProfileController.character,
                                activeColor: ThemeColor.pink,
                                onChanged: (SingingCharacter? value) {
                                  // setState(() {
                                  //   showPostController
                                  //       .character = value;
                                  // });
                                  userProfileController.reportRedio(value, 4);
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      child: GestureDetector(
                        onTap: () {
                          userProfileController.sendReport(
                              postID: userProfileController.postData["userProfile"]["_id"].toString(),
                              postimage: userProfileController.postData["userProfile"]["profileImage"].toString());
                        },
                        child: Container(
                          height: 55,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: ThemeColor.pink,
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            "Submit report",
                            style: TextStyle(
                              color: ThemeColor.white,
                              fontSize: 18,
                              fontFamily: 'abold',
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
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
                            // border: Border.all(
                            //     color: ThemeColor
                            //         .gre_alpha_20
                            //         .withOpacity(0.3)),
                          ),
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
                    ),
                  ],
                ),
              ));
            },
            child: SizedBox(
              height: 55,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    "Images/Post_Screen/megaphone.png",
                    height: 25,
                    width: 25,
                    color: ThemeColor.blackback,
                  ),
                  const SizedBox(
                    width: 25,
                  ),
                  Text(
                    "Report",
                    style: TextStyle(
                      color: ThemeColor.blackback,
                      fontSize: 20,
                      fontFamily: 'amidum',
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }
}
