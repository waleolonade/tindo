import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rayzi/app/API%20Models/createchat_topic_model.dart';
import 'package:rayzi/app/API_Services/create_chattopic_services.dart';
import 'package:rayzi/app/data/APP_variables/AppVariable.dart';
import 'package:rayzi/app/data/AppImages.dart';
import 'package:rayzi/app/data/Colors.dart';
import 'package:rayzi/app/modules/Messages/views/Message_Show.dart';

import '../../User_Profile/controllers/SecondUserProfileController.dart';
import '../../home/controllers/LiveStreaming_controller.dart';
import '../controllers/my_app_controller.dart';

class ProfileDailog extends StatefulWidget {
  final String userId;
  const ProfileDailog({
    Key? key,
    required this.userId,
  }) : super(key: key);

  @override
  State<ProfileDailog> createState() => _ProfileDailogState();
}

class _ProfileDailogState extends State<ProfileDailog> {
  MyAppController myAppController = Get.put(MyAppController());
  SecondUserProfileController userProfileController =
      Get.put(SecondUserProfileController());
  LiveStreamingController liveStreamingController =
      Get.put(LiveStreamingController());
  var items = [
    ' x1',
    ' x5',
    'x10',
    'x15',
    'x20',
    'x25',
    'x30',
    'x35',
    'x40',
    'x45',
    'x50'
  ];
  String dropdownvalue = ' x1';
  String discription = "luv❤my❤friends👈 🌹🌹 this is discription ♥♥ 🎁🎁🎁 ";

  ///Chat Topic
  CreateChatTopicModel? chatTopicModel;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    chatTopic(userID2: widget.userId);
    setState(() {
      userProfileController.profileget(widget.userId);
    });
  }

  /// Create Chat Topic
  Future chatTopic({required String userID2}) async {
    log("++++++++++++$userID2#############$userID");
    var data =
        await CreateChatTopicServices().createChatTopic(userId2: userID2);
    chatTopicModel = data;
    if (data!.status == true) {
      // isLoading.value = false;
      log("==========================******========${chatTopicModel!.chatTopic!.id.toString()}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => (userProfileController.isLoding.value)
          ? Center(
              child: CircularProgressIndicator(color: ThemeColor.pink),
            )
          : Container(
              height: 310,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 8,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 6,
                          width: 70,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: ThemeColor.pink,
                          ),
                        ),
                        // Spacer(),
                        // Icon(
                        //   Icons.more_vert_outlined,
                        //   size: 28,
                        //   color: theme_Color.gray_icon,
                        // ),
                        // SizedBox(
                        //   width: 15,
                        // ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 36,
                          backgroundColor: Colors.transparent,
                          backgroundImage: NetworkImage(
                            userProfileController.postData["userProfile"]
                                    ["profileImage"]
                                .toString(),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              userProfileController.postData["userProfile"]
                                      ["name"]
                                  .toString(),
                              style: TextStyle(
                                color: ThemeColor.blackback,
                                fontSize: 18,
                                fontFamily: 'abold',
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              userProfileController.postData["userProfile"]
                                      ["country"]
                                  .toString(),
                              style: TextStyle(
                                  color: ThemeColor.grayIcon.withOpacity(0.7),
                                  fontFamily: "amidum",
                                  fontSize: 15),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            ConstrainedBox(
                              constraints: const BoxConstraints(
                                  maxHeight: 100, maxWidth: 200),
                              child: Text(
                                userProfileController.postData["userProfile"]
                                        ["bio"]
                                    .toString(),
                                style: TextStyle(
                                    color:
                                        ThemeColor.blackback.withOpacity(0.92),
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
                        border: Border.all(
                            color: ThemeColor.textGray.withOpacity(0.8),
                            width: 0.6),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  userProfileController.postData["userProfile"]
                                          ["diamond"]
                                      .toString(),
                                  style: const TextStyle(
                                    fontFamily: 'abold',
                                    fontSize: 17,
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
                                      color:
                                          ThemeColor.blackback.withOpacity(0.6),
                                      height: 10,
                                      width: 10,
                                    ),
                                    Text(
                                      "Earned",
                                      style: TextStyle(
                                        fontFamily: 'amidum',
                                        fontSize: 13,
                                        color: ThemeColor.blackback
                                            .withOpacity(0.6),
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
                                  userProfileController.postData["userProfile"]
                                          ["totalLike"]
                                      .toString(),
                                  style: const TextStyle(
                                    fontFamily: 'abold',
                                    fontSize: 17,
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
                                    fontSize: 13,
                                    color:
                                        ThemeColor.blackback.withOpacity(0.6),
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
                                  userProfileController.postData["userProfile"]
                                          ["followers"]
                                      .toString(),
                                  style: const TextStyle(
                                    fontFamily: 'abold',
                                    fontSize: 17,
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
                                    fontSize: 13,
                                    color:
                                        ThemeColor.blackback.withOpacity(0.6),
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
                                  userProfileController.postData["userProfile"]
                                          ["following"]
                                      .toString(),
                                  style: const TextStyle(
                                    fontFamily: 'abold',
                                    fontSize: 17,
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
                                    fontSize: 13,
                                    color:
                                        ThemeColor.blackback.withOpacity(0.6),
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
                          () => GestureDetector(
                              onTap: () {
                                //userProfileController.changevalue();
                                userProfileController.followRequest();
                              },
                              child: (userProfileController.isfollow.value)
                                  ? Container(
                                      alignment: Alignment.center,
                                      height: 55,
                                      width: Get.width / 1.7,
                                      decoration: BoxDecoration(
                                        color: ThemeColor.graylight,
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                      child: (userProfileController.indicater ==
                                              false)
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
                                      width: Get.width / 1.7,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        color: ThemeColor.pink,
                                      ),
                                      child: (userProfileController.indicater ==
                                              false)
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
                                    )),
                        ),
                        GestureDetector(
                          onTap: () {
                            log("***********************************${chatTopicModel!.chatTopic.toString()}");
                            Get.to(()=>MessageShow(
                              images: userProfileController
                                  .postData["userProfile"]["profileImage"]
                                  .toString(),
                              name: userProfileController
                                  .postData["userProfile"]["name"]
                                  .toString(),
                              userId2: widget.userId,
                              chatRoomId:
                                  chatTopicModel!.chatTopic!.id.toString(),
                              senderId: userID,
                            ));
                          },
                          child: Container(
                            height: Get.height / 14.5,
                            width: Get.width / 7,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              border: Border.all(color: ThemeColor.greAlpha20),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(14.5),
                              child: Image.asset(
                                  "Images/Post_Screen/comment.png",
                                  color: ThemeColor.blackback,
                                  fit: BoxFit.fill),
                            ),
                          ),
                        ),
                        GestureDetector(
                          // onTap: () => Get.bottomSheet(
                          //     isScrollControlled: true, giftsheet()),
                          child: Container(
                            height: Get.height / 14.5,
                            width: Get.width / 7,
                            decoration: BoxDecoration(
                              color: ThemeColor.white,
                              borderRadius: BorderRadius.circular(100),
                              border: Border.all(color: ThemeColor.greAlpha20),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Image.asset(
                                  "Images/Post_Screen/share_post.png",
                                  color: Colors.black,
                                  fit: BoxFit.fill),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
