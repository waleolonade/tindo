import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:like_button/like_button.dart';
import 'package:rayzi/app/API_Services/app_url.dart';
import 'package:rayzi/app/Branch_IO/BranchIOController.dart';
import 'package:rayzi/app/data/APP_variables/AppVariable.dart';
import 'package:rayzi/app/data/AppImages.dart';
import 'package:rayzi/app/data/Colors.dart';
import 'package:rayzi/app/modules/My_App/controllers/my_app_controller.dart';
import 'package:rayzi/app/modules/My_App/views/my_app_view.dart';
import 'package:rayzi/app/modules/Show_Post/controllers/GetSingleController.dart';
import 'package:rayzi/app/modules/User_Profile/views/second_user_profile.dart';
import 'package:rayzi/app/modules/User_Profile/views/user_profile_view.dart';

import 'CommentScreen.dart';

class GetSinglePostScreen extends StatefulWidget {
  final String secounduserID;
  final String postID;
  const GetSinglePostScreen(
      {Key? key, required this.secounduserID, required this.postID})
      : super(key: key);

  @override
  State<GetSinglePostScreen> createState() => _GetSinglePostScreenState();
}

class _GetSinglePostScreenState extends State<GetSinglePostScreen> {
  MyAppController myAppController = Get.put(MyAppController());
  GetSinglePostController singlePostController =
      Get.put(GetSinglePostController());
  BranchIOController branchIOController = Get.put(BranchIOController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    singlePostController.getPost(
        secounduserID: widget.secounduserID, postID: widget.postID);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.offAll(const MyApp());
        return false;
      },
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              Column(
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
                          onTap: () => Get.offAll(const MyApp()),
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
                          "My Posts",
                          style: TextStyle(
                              fontFamily: 'abold',
                              fontSize: 20,
                              color: ThemeColor.blackback),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Divider(
                      color: ThemeColor.graylight.withOpacity(0.3),
                      height: 0.8,
                      thickness: 0.6),
                  Obx(
                    () => (singlePostController.isLoding.value)
                        ? Expanded(
                            child: Center(
                              child: CircularProgressIndicator(
                                color: ThemeColor.pink,
                              ),
                            ),
                          )
                        : Expanded(
                            child: ListView.separated(
                              shrinkWrap: true,
                              itemCount: singlePostController
                                  .getSinglePostModel!.userPost!.length,
                              padding: const EdgeInsets.only(bottom: 10),
                              separatorBuilder: (context, index) {
                                return Divider(
                                  color: ThemeColor.graylight.withOpacity(0.3),
                                  thickness: 0.8,
                                );
                              },
                              itemBuilder: (context, index) {
                                return postView(index);
                              },
                            ),
                          ),
                  ),
                ],
              ),
              Positioned(
                top: Get.height / 3,
                right: Get.width / 3.2,
                child: Center(
                  child: GetBuilder<GetSinglePostController>(
                    builder: (controller) => Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        (singlePostController.giftshow.value)
                            ? Image.network(
                                "${Constant.BASE_URL}${singlePostController.getGiftList[singlePostController.selectedGiftIndex.value].image}",
                                fit: BoxFit.cover,
                                height: 150,
                                width: 150,
                              )
                            : const SizedBox(),
                        (singlePostController.giftshow.value)
                            ? Text(
                                "${singlePostController.getGiftList[singlePostController.selectedGiftIndex.value].coin}",
                                style: TextStyle(
                                    fontFamily: "amidum",
                                    fontSize: 20,
                                    color: ThemeColor.white),
                              )
                            : const SizedBox(),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Padding postView(int index) {
    String date = singlePostController.getSinglePostModel!.userPost![index].date
        .toString();
    List<String> dateParts = date.split(", ");
    List datePartslist = dateParts[0].split("/");
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          minHeight: 415,
        ),
        child: SizedBox(
          width: Get.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  if (singlePostController
                          .getSinglePostModel!.userPost![index].userId
                          .toString() ==
                      userID) {
                    Get.to(()=>const UserProfileView());
                  } else {
                    Get.to(()=>SecondUserProfileView(
                      userID: singlePostController
                          .getSinglePostModel!.userPost![index].userId
                          .toString(),
                    ));
                  }
                },
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.grey.withOpacity(0.2),
                        foregroundImage: NetworkImage(singlePostController
                            .getSinglePostModel!.userPost![index].profileImage
                            .toString()),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            singlePostController
                                .getSinglePostModel!.userPost![index].name
                                .toString(),
                            style: TextStyle(
                                fontFamily: 'abold',
                                fontSize: 14.5,
                                color: ThemeColor.blackback),
                          ),
                          const SizedBox(
                            height: 3,
                          ),
                          Text(
                            "${datePartslist[1]}/${datePartslist[0]}/${datePartslist[2]}",
                            style: TextStyle(
                                fontFamily: 'amidum',
                                fontSize: 15,
                                color: ThemeColor.blackback.withOpacity(0.8)),
                          ),
                        ],
                      ),
                      const Spacer(),
                      const Spacer(),
                      (singlePostController.getSinglePostModel!.userPost![index]
                                  .userId ==
                              userID)
                          ? const SizedBox()
                          : GestureDetector(
                              onTap: () {
                                Get.bottomSheet(Container(
                                  height: 150,
                                  decoration: BoxDecoration(
                                    color: ThemeColor.white,
                                    borderRadius: const BorderRadius.only(
                                      topRight: Radius.circular(14),
                                      topLeft: Radius.circular(14),
                                    ),
                                  ),
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.only(
                                      left: 15, right: 15),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Container(
                                        height: 6.5,
                                        width: 55,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          color: Colors.grey,
                                        ),
                                      ),
                                      const Spacer(),
                                      GestureDetector(
                                        onTap: () {
                                          singlePostController.blockRequest(
                                              blockUser: singlePostController
                                                  .getSinglePostModel!
                                                  .userPost![index]
                                                  .userId
                                                  .toString(),
                                              secounduserID:
                                                  widget.secounduserID,
                                              postID: widget.postID);
                                        },
                                        child: SizedBox(
                                          height: 55,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
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
                                              borderRadius:
                                                  const BorderRadius.only(
                                                topRight: Radius.circular(16),
                                                topLeft: Radius.circular(16),
                                              ),
                                            ),
                                            alignment: Alignment.center,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                const SizedBox(
                                                  height: 8,
                                                ),
                                                Container(
                                                  height: 6.5,
                                                  width: 55,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50),
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 20,
                                                ),
                                                Text(
                                                  "Report on",
                                                  style: TextStyle(
                                                      color:
                                                          ThemeColor.blackback,
                                                      fontSize: 22,
                                                      fontFamily: 'abold'),
                                                ),
                                                const SizedBox(
                                                  height: 6,
                                                ),
                                                Text(
                                                  singlePostController
                                                      .getSinglePostModel!
                                                      .userPost![index]
                                                      .name
                                                      .toString(),
                                                  style: TextStyle(
                                                      color:
                                                          ThemeColor.blackback,
                                                      fontSize: 20,
                                                      fontFamily: 'abold'),
                                                ),
                                                const SizedBox(
                                                  height: 8,
                                                ),
                                                GetBuilder<
                                                    GetSinglePostController>(
                                                  builder: (controller) =>
                                                      Column(
                                                    children: [
                                                      SizedBox(
                                                        height: 40,
                                                        child: ListTile(
                                                          title: const Text(
                                                              'sexual Content'),
                                                          leading: Radio<
                                                              SingingCharacter>(
                                                            value: SingingCharacter
                                                                .sexualContent,
                                                            groupValue:
                                                                singlePostController
                                                                    .character,
                                                            activeColor:
                                                                ThemeColor.pink,
                                                            onChanged:
                                                                (SingingCharacter?
                                                                    value) {
                                                              singlePostController
                                                                  .reportRedio(
                                                                      value, 0);
                                                            },
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 40,
                                                        child: ListTile(
                                                          title: const Text(
                                                              'Violent Content'),
                                                          leading: Radio<
                                                              SingingCharacter>(
                                                            value: SingingCharacter
                                                                .ViolentContent,
                                                            groupValue:
                                                                singlePostController
                                                                    .character,
                                                            activeColor:
                                                                ThemeColor.pink,
                                                            onChanged:
                                                                (SingingCharacter?
                                                                    value) {
                                                              // setState(() {
                                                              //   showPostController
                                                              //       .character = value;
                                                              // });
                                                              singlePostController
                                                                  .reportRedio(
                                                                      value, 1);
                                                            },
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 40,
                                                        child: ListTile(
                                                          title: const Text(
                                                              'child abuse'),
                                                          leading: Radio<
                                                              SingingCharacter>(
                                                            value:
                                                                SingingCharacter
                                                                    .childAbuse,
                                                            groupValue:
                                                                singlePostController
                                                                    .character,
                                                            activeColor:
                                                                ThemeColor.pink,
                                                            onChanged:
                                                                (SingingCharacter?
                                                                    value) {
                                                              // setState(() {
                                                              //   showPostController
                                                              //       .character = value;
                                                              // });
                                                              singlePostController
                                                                  .reportRedio(
                                                                      value, 2);
                                                            },
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 40,
                                                        child: ListTile(
                                                          title: const Text(
                                                              'Spam'),
                                                          leading: Radio<
                                                              SingingCharacter>(
                                                            value:
                                                                SingingCharacter
                                                                    .Spam,
                                                            groupValue:
                                                                singlePostController
                                                                    .character,
                                                            activeColor:
                                                                ThemeColor.pink,
                                                            onChanged:
                                                                (SingingCharacter?
                                                                    value) {
                                                              singlePostController
                                                                  .reportRedio(
                                                                      value, 3);
                                                            },
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 40,
                                                        child: ListTile(
                                                          title: const Text(
                                                              'Other'),
                                                          leading: Radio<
                                                              SingingCharacter>(
                                                            value:
                                                                SingingCharacter
                                                                    .Other,
                                                            groupValue:
                                                                singlePostController
                                                                    .character,
                                                            activeColor:
                                                                ThemeColor.pink,
                                                            onChanged:
                                                                (SingingCharacter?
                                                                    value) {
                                                              singlePostController
                                                                  .reportRedio(
                                                                      value, 4);
                                                            },
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                const Spacer(),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 15, right: 15),
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      singlePostController.sendReport(
                                                          postID: singlePostController
                                                              .getSinglePostModel!
                                                              .userPost![index]
                                                              .id
                                                              .toString(),
                                                          postimage:
                                                              singlePostController
                                                                  .getSinglePostModel!
                                                                  .userPost![
                                                                      index]
                                                                  .postImage
                                                                  .toString());
                                                    },
                                                    child: Container(
                                                      height: 60,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(50),
                                                        color: ThemeColor.pink,
                                                      ),
                                                      alignment:
                                                          Alignment.center,
                                                      child: Text(
                                                        "Submit report",
                                                        style: TextStyle(
                                                          color:
                                                              ThemeColor.white,
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
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 6, right: 6),
                                                  child: GestureDetector(
                                                    onTap: () => Get.back(),
                                                    child: Container(
                                                      height: 60,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(50),
                                                        color: ThemeColor.white,
                                                      ),
                                                      alignment:
                                                          Alignment.center,
                                                      child: Text(
                                                        "Cancel",
                                                        style: TextStyle(
                                                          color: ThemeColor
                                                              .blackback,
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
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Image.asset(
                                                "Images/Post_Screen/megaphone.png",
                                                height: 25,
                                                width: 25,
                                                color: ThemeColor.blackback,
                                              ),
                                              const SizedBox(
                                                width: 20,
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
                                        height: 15,
                                      ),
                                    ],
                                  ),
                                ));
                              },
                              child: Icon(
                                Icons.more_vert_outlined,
                                size: 28,
                                color: ThemeColor.grayIcon,
                              ),
                            )
                    ],
                  ),
                ),
              ),
              ConstrainedBox(
                constraints: BoxConstraints(
                    minHeight: 350,
                    maxHeight: 350,
                    maxWidth: Get.width,
                    minWidth: Get.width),
                child: CachedNetworkImage(
                  fit: BoxFit.fitHeight,
                  imageUrl: singlePostController
                      .getSinglePostModel!.userPost![index].postImage
                      .toString(),
                  placeholder: (context, url) => Image(
                    height: 400,
                    color: Colors.grey.withOpacity(0.4),
                    image: AssetImage(
                      AppImages.placeHoder,
                    ),
                  ),
                  errorWidget: (context, string, dynamic) => Image(
                    height: 400,
                    color: Colors.grey.withOpacity(0.4),
                    image: AssetImage(
                      AppImages.bottomCenterIcon,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 10,
                  right: 10,
                  left: 10,
                  bottom: 15,
                ),
                child: Row(
                  children: [
                    const SizedBox(
                      width: 5,
                    ),
                    LikeButton(
                      isLiked: singlePostController.isLike.value,
                      size: 25,
                      circleColor: CircleColor(
                          start: ThemeColor.pink, end: ThemeColor.pinklight),
                      bubblesColor: BubblesColor(
                        dotPrimaryColor: ThemeColor.pink,
                        dotSecondaryColor: ThemeColor.pinklight,
                      ),
                      onTap: (isLiked) async {
                        singlePostController.sendLike(index,
                            "${singlePostController.getSinglePostModel!.userPost![index].id}");
                        return !isLiked;
                      },
                      likeBuilder: (isLike) {
                        return (singlePostController.isLike.value)
                            ? SizedBox(
                                height: 35,
                                width: 35,
                                child: ImageIcon(
                                  const AssetImage(
                                    "Images/Post_Screen/love_fill.png",
                                  ),
                                  color: ThemeColor.pink,
                                  //: Color(0xffA7A7B3),
                                  size: 35,
                                ),
                              )
                            : SizedBox(
                                height: 35,
                                width: 35,
                                child: ImageIcon(
                                  const AssetImage(
                                    "Images/Post_Screen/love.png",
                                  ),
                                  color: ThemeColor.blackback,
                                  // : Color(0xffA7A7B3),
                                  size: 35,
                                ),
                              );
                      },
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    GestureDetector(
                      onTap: () => Get.to(()=>CommentScreen(
                        postID:
                            '${singlePostController.getSinglePostModel!.userPost![index].id}',
                        index: index,
                        postScreenType: 3,
                      )),
                      child: const SizedBox(
                        height: 28,
                        width: 28,
                        child: ImageIcon(
                          AssetImage(
                            "Images/Post_Screen/comment.png",
                          ),
                          //color: Color(0xffA7A7B3),
                          color: Colors.black,
                          size: 23,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        log("++++++");
                        branchIOController.imageURL.value = singlePostController
                            .getSinglePostModel!.userPost![index].profileImage
                            .toString();
                        branchIOController.initDeepLinkDataPost(
                            shareType: 2,
                            userId: singlePostController
                                .getSinglePostModel!.userPost![index].userId
                                .toString(),
                            postId: singlePostController
                                .getSinglePostModel!.userPost![index].id
                                .toString());
                        branchIOController.generateLink();
                      },
                      child: const ImageIcon(
                          AssetImage("Images/Post_Screen/share_post.png"),
                          //color: Color(0xffA7A7B3),
                          color: Colors.black,
                          size: 25.5),
                    ),
                    const Spacer(),
                    (singlePostController
                                .getSinglePostModel!.userPost![index].userId
                                .toString() ==
                            userID)
                        ? const SizedBox()
                        : GestureDetector(
                            onTap: () {
                              singlePostController.fetchGiftlist();
                              Get.bottomSheet(
                                  isScrollControlled: true, giftsheet(index));
                            },
                            child: const ImageIcon(
                                AssetImage("Images/new_dis/gift.png"),
                                //color: Color(0xffA7A7B3),
                                color: Colors.black,
                                size: 25),
                          ),
                    const SizedBox(
                      width: 5,
                    ),
                  ],
                ),
              ),
              (singlePostController
                          .getSinglePostModel!.userPost![index].description
                          .toString() ==
                      "")
                  ? const SizedBox()
                  : Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxHeight: 100),
                        child: Text(
                          singlePostController
                              .getSinglePostModel!.userPost![index].description
                              .toString(),
                          style: TextStyle(
                              fontFamily: 'amidum',
                              fontSize: 15,
                              // color: theme_Color.PostScreen_text,
                              color: ThemeColor.blackback.withOpacity(0.8)),
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ),
              const SizedBox(
                height: 5,
              ),
              GetBuilder<GetSinglePostController>(
                builder: (controller) => Padding(
                  padding: EdgeInsets.only(
                      right: 10,
                      left: (singlePostController.getSinglePostModel!
                                  .userPost![index].userLike!.length ==
                              1)
                          ? 10.0
                          : 5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      //// ==== ==== Like List ==== ==== \\\\
                      (singlePostController.getSinglePostModel!.userPost![index]
                              .userGift!.isNotEmpty)
                          ? (singlePostController.getSinglePostModel!
                                      .userPost![index].userGift!.length ==
                                  1)
                              ? Row(
                                  children: [
                                    Stack(
                                      children: [
                                        Container(
                                          height: 30,
                                          width: 25,
                                          alignment: Alignment.center,
                                          child: CircleAvatar(
                                            backgroundColor:
                                                ThemeColor.textGray,
                                            radius: 13,
                                            backgroundImage: NetworkImage(
                                              "${singlePostController.getSinglePostModel!.userPost![index].userGift![0].profileImage}",
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          bottom: 0,
                                          right: 0,
                                          child: Image.asset(
                                              AppImages.coinImages,
                                              width: 10),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      "${singlePostController.getSinglePostModel!.userPost![index].userGift!.length} gifted",
                                      style: TextStyle(
                                        fontFamily: 'amidum',
                                        fontSize: 14,
                                        //color: theme_Color.PostScreen_text,
                                        color: ThemeColor.blackback,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                )
                              : Row(
                                  children: [
                                    Stack(
                                      children: [
                                        SizedBox(
                                          height: 35,
                                          width: 50,
                                          child: Stack(
                                            children: [
                                              Container(
                                                width: 50,
                                                alignment:
                                                    Alignment.centerRight,
                                                child: CircleAvatar(
                                                  backgroundColor:
                                                      ThemeColor.textGray,
                                                  radius: 13,
                                                  backgroundImage: NetworkImage(
                                                    "${singlePostController.getSinglePostModel!.userPost![index].userGift![0].profileImage}",
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                right: 18,
                                                top: 3.8,
                                                // right: 30,
                                                child: CircleAvatar(
                                                  radius: 14,
                                                  backgroundColor: Colors.white,
                                                  child: CircleAvatar(
                                                    radius: 13,
                                                    backgroundColor:
                                                        ThemeColor.textGray,
                                                    backgroundImage: NetworkImage(
                                                        "${singlePostController.getSinglePostModel!.userPost![index].userGift![1].profileImage}"),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Positioned(
                                          bottom: 0,
                                          right: 0,
                                          child: Image.asset(
                                              AppImages.coinImages,
                                              width: 10),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      "${singlePostController.getSinglePostModel!.userPost![index].userGift!.length} gifted",
                                      style: TextStyle(
                                        fontFamily: 'amidum',
                                        fontSize: 14,
                                        //color: theme_Color.PostScreen_text,
                                        color: ThemeColor.blackback,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                )
                          : const SizedBox(),
                      const SizedBox(
                        width: 5,
                      ),
                      //// ==== ==== Like List ==== ==== \\\\
                      (singlePostController.getSinglePostModel!.userPost![index]
                              .userLike!.isNotEmpty)
                          ? (singlePostController.getSinglePostModel!
                                      .userPost![index].userLike!.length ==
                                  1)
                              ? Row(
                                  children: [
                                    Stack(
                                      children: [
                                        Container(
                                          height: 30,
                                          width: 25,
                                          alignment: Alignment.center,
                                          child: CircleAvatar(
                                            backgroundColor:
                                                ThemeColor.textGray,
                                            radius: 13,
                                            backgroundImage: NetworkImage(
                                              "${singlePostController.getSinglePostModel!.userPost![index].userLike![0].profileImage}",
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          bottom: 0,
                                          right: 0,
                                          child: Icon(
                                            Icons.favorite,
                                            color: ThemeColor.pink,
                                            size: 10,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      "${singlePostController.getSinglePostModel!.userPost![index].userLike!.length} likes",
                                      style: TextStyle(
                                        fontFamily: 'amidum',
                                        fontSize: 14,
                                        //color: theme_Color.PostScreen_text,
                                        color: ThemeColor.blackback,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                )
                              : Row(
                                  children: [
                                    Stack(
                                      children: [
                                        SizedBox(
                                          height: 35,
                                          width: 50,
                                          child: Stack(
                                            children: [
                                              Container(
                                                width: 50,
                                                alignment:
                                                    Alignment.centerRight,
                                                child: CircleAvatar(
                                                  backgroundColor:
                                                      ThemeColor.textGray,
                                                  radius: 13,
                                                  backgroundImage: NetworkImage(
                                                    "${singlePostController.getSinglePostModel!.userPost![index].userLike![0].profileImage}",
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                right: 18,
                                                top: 3.8,
                                                // right: 30,
                                                child: CircleAvatar(
                                                  radius: 14,
                                                  backgroundColor: Colors.white,
                                                  child: CircleAvatar(
                                                    radius: 13,
                                                    backgroundColor:
                                                        ThemeColor.textGray,
                                                    backgroundImage: NetworkImage(
                                                        "${singlePostController.getSinglePostModel!.userPost![index].userLike![1].profileImage}"),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Positioned(
                                          bottom: 0,
                                          right: 0,
                                          child: Icon(
                                            Icons.favorite,
                                            color: ThemeColor.pink,
                                            size: 10,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      "${singlePostController.getSinglePostModel!.userPost![index].userLike!.length} likes",
                                      style: TextStyle(
                                        fontFamily: 'amidum',
                                        fontSize: 14,
                                        //color: theme_Color.PostScreen_text,
                                        color: ThemeColor.blackback,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                )
                          : const SizedBox(),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Obx(
                  () => GestureDetector(
                    onTap: () => Get.to(CommentScreen(
                      postID: singlePostController
                          .getSinglePostModel!.userPost![index].id
                          .toString(),
                      index: index,
                      postScreenType: 2,
                    )),
                    child: Text(
                      textAlign: TextAlign.start,
                      "Show All Comments (${singlePostController.commentCount[index]})",
                      style: TextStyle(
                          fontFamily: 'abold',
                          fontSize: 14,
                          // color: Color(0xffA6A6AD),
                          color: ThemeColor.blackback),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  StatefulBuilder giftsheet(int index) {
    return StatefulBuilder(
      builder: (context, setState1) => Container(
        decoration: BoxDecoration(
          color: ThemeColor.grayinsta.withOpacity(0.8),
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(20),
            topLeft: Radius.circular(20),
          ),
        ),
        height: Get.height / 1.3,
        child: Padding(
          padding: const EdgeInsets.only(
            top: 10,
          ),
          child: Column(
            children: [
              const SizedBox(
                height: 3,
              ),
              Container(
                height: 6,
                width: 50,
                decoration: BoxDecoration(
                    color: ThemeColor.pink,
                    borderRadius: const BorderRadius.all(Radius.circular(10))),
              ),
              const SizedBox(
                height: 6,
              ),
              Container(
                height: 40,
                width: Get.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    50,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Row(
                    children: [
                      SizedBox(
                        height: 18,
                        width: 18,
                        child: Image.asset(AppImages.coinImages),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Obx(
                        () => Text(
                          "${userCoins.value}",
                          style: TextStyle(
                            color: ThemeColor.white,
                            fontSize: 16.5,
                            fontFamily: 'amidum',
                          ),
                        ),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          myAppController.changeTabIndex(4);
                          Get.back();
                        },
                        child: Container(
                          height: 27,
                          width: 94,
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: ThemeColor.pink, width: 1),
                              borderRadius: BorderRadius.circular(100)),
                          alignment: Alignment.center,
                          child: const Text(
                            "+ Get Coins",
                            style: TextStyle(
                                fontFamily: 'amidum',
                                color: Colors.white,
                                fontSize: 12.5),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Expanded(
                child: NotificationListener<OverscrollIndicatorNotification>(
                  onNotification: (notification) {
                    notification.disallowIndicator();
                    return false;
                  },
                  child: SingleChildScrollView(
                    child: SizedBox(
                      child: Obx(() => (singlePostController.giftLoading.value)
                          ? Center(
                              child: CircularProgressIndicator(
                                  color: ThemeColor.pink),
                            )
                          : sticker()),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: SizedBox(
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        height: 33,
                        width: 130,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  border: Border.all(
                                      color: ThemeColor.pink, width: 1),
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(100),
                                      bottomLeft: Radius.circular(100)),
                                ),
                                alignment: Alignment.center,
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 4),
                                  child: Obx(
                                    () => DropdownButton(
                                      value: singlePostController
                                          .dropdownvalue.value,
                                      icon: const Icon(
                                          Icons.keyboard_arrow_down,
                                          color: Colors.white),
                                      elevation: 0,
                                      underline: Container(),
                                      dropdownColor: Colors.black,
                                      items: singlePostController.items
                                          .map((int items) {
                                        return DropdownMenuItem(
                                          value: items,
                                          child: Text(
                                            (items == 1 || items == 5)
                                                ? "  x$items"
                                                : " x$items",
                                            style: TextStyle(
                                              fontSize: 18,
                                              color: ThemeColor.white,
                                              fontFamily: 'amidum',
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                      onChanged: (int? newValue) {
                                        singlePostController
                                            .dropdownvalue.value = newValue!;
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: InkWell(
                                onTap: () async {
                                  if (userCoins.value == 0) {
                                    Fluttertoast.showToast(
                                        msg: "Not Sufficient Coins",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.CENTER,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: ThemeColor.white,
                                        textColor: ThemeColor.pink,
                                        fontSize: 16.0);
                                    Get.back();
                                  } else if (userCoins.value >=
                                      (singlePostController
                                              .getGiftList[singlePostController
                                                  .selectedGiftIndex.value]
                                              .coin!
                                              .toInt() *
                                          singlePostController
                                              .dropdownvalue.value)) {
                                    userCoins.value = userCoins.value -
                                        singlePostController
                                                .getGiftList[
                                                    singlePostController
                                                        .selectedGiftIndex
                                                        .value]
                                                .coin!
                                                .toInt() *
                                            singlePostController
                                                .dropdownvalue.value;
                                    getstorage.write(
                                        "UserCoins", userCoins.value);
                                    singlePostController.sendGift(
                                        giftId: singlePostController
                                            .getGiftList[singlePostController
                                                .selectedGiftIndex.value]
                                            .id
                                            .toString(),
                                        postId: singlePostController
                                            .getSinglePostModel!
                                            .userPost![index]
                                            .id
                                            .toString(),
                                        index: index,
                                        coin: singlePostController
                                                .getGiftList[
                                                    singlePostController
                                                        .selectedGiftIndex
                                                        .value]
                                                .coin!
                                                .toInt() *
                                            singlePostController
                                                .dropdownvalue.value);
                                    singlePostController.setGift();
                                  } else {
                                    Fluttertoast.showToast(
                                        msg: "Not Sufficient Coins",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.CENTER,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: ThemeColor.white,
                                        textColor: ThemeColor.pink,
                                        fontSize: 16.0);
                                    Get.back();
                                  }
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: ThemeColor.pink,
                                    border: Border.all(
                                        color: ThemeColor.pink, width: 1),
                                    borderRadius: const BorderRadius.only(
                                        topRight: Radius.circular(100),
                                        bottomRight: Radius.circular(100)),
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    "Send",
                                    style: TextStyle(
                                      color: ThemeColor.white,
                                      fontSize: 16.5,
                                      fontFamily: 'abold',
                                    ),
                                  ),
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
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }

  GridView sticker() {
    return GridView.builder(
      scrollDirection: Axis.vertical,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.only(left: 5, right: 5),
      shrinkWrap: true,
      itemCount: singlePostController.getGiftList.length,
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 100,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (BuildContext context, i) {
        return InkWell(
          onTap: () {
            singlePostController.selectedGiftIndex.value = i;
          },
          child: Obx(
            () => Container(
              height: 78,
              decoration: (singlePostController.selectedGiftIndex.value == i)
                  ? BoxDecoration(
                      color: ThemeColor.graymidum,
                      borderRadius: const BorderRadius.all(Radius.circular(12)),
                      border: Border.all(
                        color: ThemeColor.pink,
                      ),
                    )
                  : const BoxDecoration(color: Colors.transparent),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                            "${Constant.BASE_URL}${singlePostController.getGiftList[i].image.toString()}"),
                        fit: BoxFit.cover,
                      ),
                      //shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 11,
                        width: 11,
                        child: Image.asset(AppImages.coinImages),
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      Text(singlePostController.getGiftList[i].coin.toString(),
                          style: const TextStyle(
                              fontFamily: 'amidum',
                              fontSize: 11.5,
                              color: Colors.white)),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
