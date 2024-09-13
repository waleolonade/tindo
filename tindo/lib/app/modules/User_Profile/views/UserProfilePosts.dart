import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:like_button/like_button.dart';
import 'package:rayzi/app/Branch_IO/BranchIOController.dart';
import 'package:rayzi/app/data/AppImages.dart';
import 'package:rayzi/app/data/Colors.dart';
import 'package:rayzi/app/modules/User_Profile/controllers/UserPostController.dart';
import 'package:rayzi/app/modules/User_Profile/views/user_profile_view.dart';

import '../../My_App/controllers/my_app_controller.dart';
import '../../Show_Post/views/CommentScreen.dart';

class UserProfilePostScreen extends StatefulWidget {
  const UserProfilePostScreen({Key? key}) : super(key: key);

  @override
  State<UserProfilePostScreen> createState() => _UserProfilePostScreenState();
}

class _UserProfilePostScreenState extends State<UserProfilePostScreen> {
  MyAppController myAppController = Get.put(MyAppController());
  UserPostController userPostControllre = Get.put(UserPostController());
  BranchIOController branchIOController = Get.put(BranchIOController());
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
                      "My Posts",
                      style: TextStyle(fontFamily: 'abold', fontSize: 20, color: ThemeColor.blackback),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Divider(color: ThemeColor.graylight.withOpacity(0.3), height: 0.8, thickness: 0.6),
              Obx(
                () => (userPostControllre.isLoding.value)
                    ? Expanded(
                        child: Center(
                          child: CircularProgressIndicator(
                            color: ThemeColor.pink,
                          ),
                        ),
                      )
                    : (userPostControllre.getAllPostModel!.userPost!.isEmpty)
                        ? Expanded(
                            child: Center(
                              child: Image.asset(
                                AppImages.nodataImage,
                                height: 200,
                                width: 200,
                              ),
                            ),
                          )
                        : Expanded(
                            child: SizedBox(
                              child: ListView.separated(
                                shrinkWrap: true,
                                padding: const EdgeInsets.only(bottom: 10),
                                separatorBuilder: (context, index) {
                                  return Divider(
                                    color: ThemeColor.graylight.withOpacity(0.3),
                                    thickness: 0.8,
                                  );
                                },
                                itemCount: userPostControllre.postData.length,
                                itemBuilder: (context, index) {
                                  return postView(index);
                                },
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
    String date = userPostControllre.postData[index]["date"].toString();
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: Row(
                  children: [
                    Container(
                      height: 40,
                      width: 40,
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.grey.withOpacity(0.2)),
                      child: CachedNetworkImage(
                        placeholder: (context, url) => Image.asset(AppImages.profileImagePlaceHolder, fit: BoxFit.cover),
                        fit: BoxFit.cover,
                        imageUrl: userPostControllre.postData[index]["profileImage"].toString(),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          userPostControllre.postData[index]["name"].toString(),
                          style: TextStyle(
                              fontFamily: 'abold',
                              fontSize: 14.5,
                              //color: theme_Color.PostScreen_text,
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
                              // color: theme_Color.PostScreen_text,
                              color: ThemeColor.blackback.withOpacity(0.8)),
                        ),
                      ],
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        Get.bottomSheet(Container(
                          height: 100,
                          decoration: BoxDecoration(
                            color: ThemeColor.white,
                            borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(14),
                              topLeft: Radius.circular(14),
                            ),
                          ),
                          alignment: Alignment.center,
                          padding: const EdgeInsets.only(left: 20, right: 20),
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
                                height: 15,
                              ),
                              SizedBox(
                                height: 55,
                                child: GestureDetector(
                                  onTap: () {
                                    userPostControllre.deletePostIs("${userPostControllre.postData[index]["_id"]}");
                                    Get.back();
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        "Images/Post_Screen/trash.png",
                                        color: ThemeColor.blackback,
                                        height: 23,
                                        width: 23,
                                      ),
                                      const SizedBox(
                                        width: 25,
                                      ),
                                      Text(
                                        "Delete Post",
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

              ///Post Image
              ConstrainedBox(
                constraints: BoxConstraints(minHeight: 350, maxHeight: 350, maxWidth: Get.width, minWidth: Get.width),
                child: CachedNetworkImage(
                  fit: BoxFit.fitHeight,
                  imageUrl: userPostControllre.postData[index]["postImage"].toString(),
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
              // ConstrainedBox(
              //   constraints: BoxConstraints(minHeight: 200, maxHeight: 350),
              //   child: Container(
              //     width: Get.width,
              //     decoration: BoxDecoration(
              //       image: DecorationImage(
              //         fit: BoxFit.cover,
              //         image: NetworkImage(
              //           "${userPostControllre.postData[index]["postImage"].toString()}",
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 10,
                  right: 10,
                  left: 10,
                  bottom: 15,
                ),
                child: Row(
                  children: [
                    LikeButton(
                      isLiked: userPostControllre.postData[index]['isLike'],
                      size: 25,
                      circleColor: CircleColor(start: ThemeColor.pink, end: ThemeColor.pinklight),
                      bubblesColor: BubblesColor(
                        dotPrimaryColor: ThemeColor.pink,
                        dotSecondaryColor: ThemeColor.pinklight,
                      ),
                      onTap: (isLiked) async {
                        userPostControllre.sendLike(index, userPostControllre.postData[index]['_id']);
                        return !isLiked;
                      },
                      likeBuilder: (isLike) {
                        return (userPostControllre.postData[index]['isLike'])
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
                      onTap: () => Get.to(CommentScreen(
                        postID: userPostControllre.postData[index]["_id"].toString(),
                        index: index,
                        postScreenType: 1,
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
                        branchIOController.imageURL.value =
                            userPostControllre.getAllPostModel!.userPost![index].profileImage.toString();
                        branchIOController.initDeepLinkDataPost(
                            shareType: 2,
                            userId: userPostControllre.getAllPostModel!.userPost![index].userId.toString(),
                            postId: userPostControllre.getAllPostModel!.userPost![index].id.toString());
                        branchIOController.generateLink();
                      },
                      child: const ImageIcon(AssetImage("Images/Post_Screen/share_post.png"),
                          //color: Color(0xffA7A7B3),
                          color: Colors.black,
                          size: 25.5),
                    ),
                    const Spacer(),
                  ],
                ),
              ),
              ////====
              (userPostControllre.postData[index]["description"].toString() == "")
                  ? const SizedBox()
                  : Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxHeight: 100),
                        child: Text(
                          userPostControllre.postData[index]["description"].toString(),
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

              GetBuilder<UserPostController>(
                builder: (controller) => Padding(
                  padding: EdgeInsets.only(
                      right: 10, left: (userPostControllre.getAllPostModel!.userPost![index].userLike!.length == 1) ? 10.0 : 5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      //// ==== ==== Like List ==== ==== \\\\
                      (userPostControllre.getAllPostModel!.userPost![index].userGift!.isNotEmpty)
                          ? (userPostControllre.getAllPostModel!.userPost![index].userGift!.length == 1)
                              ? Row(
                                  children: [
                                    Stack(
                                      children: [
                                        Container(
                                          height: 30,
                                          width: 25,
                                          alignment: Alignment.center,
                                          child: CircleAvatar(
                                            backgroundColor: ThemeColor.textGray,
                                            radius: 13,
                                            backgroundImage: NetworkImage(
                                              "${userPostControllre.getAllPostModel!.userPost![index].userGift![0].profileImage}",
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          bottom: 0,
                                          right: 0,
                                          child: Image.asset(AppImages.coinImages, width: 10),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      "${userPostControllre.getAllPostModel!.userPost![index].userGift!.length} gifted",
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
                                                alignment: Alignment.centerRight,
                                                child: CircleAvatar(
                                                  backgroundColor: ThemeColor.textGray,
                                                  radius: 13,
                                                  backgroundImage: NetworkImage(
                                                    "${userPostControllre.getAllPostModel!.userPost![index].userGift![0].profileImage}",
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
                                                    backgroundColor: ThemeColor.textGray,
                                                    backgroundImage: NetworkImage(
                                                        "${userPostControllre.getAllPostModel!.userPost![index].userGift![1].profileImage}"),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Positioned(
                                          bottom: 0,
                                          right: 0,
                                          child: Image.asset(AppImages.coinImages, width: 10),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      "${userPostControllre.getAllPostModel!.userPost![index].userGift!.length} gifted",
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
                      (userPostControllre.getAllPostModel!.userPost![index].userLike!.isNotEmpty)
                          ? (userPostControllre.getAllPostModel!.userPost![index].userLike!.length == 1)
                              ? Row(
                                  children: [
                                    Stack(
                                      children: [
                                        Container(
                                          height: 30,
                                          width: 25,
                                          alignment: Alignment.center,
                                          child: CircleAvatar(
                                            backgroundColor: ThemeColor.textGray,
                                            radius: 13,
                                            backgroundImage: NetworkImage(
                                              "${userPostControllre.getAllPostModel!.userPost![index].userLike![0].profileImage}",
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
                                      "${userPostControllre.getAllPostModel!.userPost![index].userLike!.length} likes",
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
                                                alignment: Alignment.centerRight,
                                                child: CircleAvatar(
                                                  backgroundColor: ThemeColor.textGray,
                                                  radius: 13,
                                                  backgroundImage: NetworkImage(
                                                    "${userPostControllre.getAllPostModel!.userPost![index].userLike![0].profileImage}",
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
                                                    backgroundColor: ThemeColor.textGray,
                                                    backgroundImage: NetworkImage(
                                                        "${userPostControllre.getAllPostModel!.userPost![index].userLike![1].profileImage}"),
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
                                      "${userPostControllre.getAllPostModel!.userPost![index].userLike!.length} likes",
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
                      postID: userPostControllre.postData[index]["_id"].toString(),
                      index: index,
                      postScreenType: 1,
                    )),
                    child: Text(
                      textAlign: TextAlign.start,
                      "Show All Comments (${userPostControllre.commentCount[index]})",
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
}
