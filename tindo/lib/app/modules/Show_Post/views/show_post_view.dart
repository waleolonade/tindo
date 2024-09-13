import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:like_button/like_button.dart';
import 'package:lottie/lottie.dart';
import 'package:rayzi/app/Branch_IO/BranchIOController.dart';
import 'package:rayzi/app/data/AppImages.dart';
import 'package:rayzi/app/data/Colors.dart';
import 'package:rayzi/app/modules/Show_Post/controllers/show_post_controller.dart';
import 'package:rayzi/app/modules/User_Profile/views/user_profile_view.dart';

import '../../../API_Services/app_url.dart';
import '../../../data/APP_variables/AppVariable.dart';
import '../../My_App/controllers/my_app_controller.dart';
import '../../User_Profile/views/second_user_profile.dart';
import 'CommentScreen.dart';

class ShowPostView extends StatefulWidget {
  const ShowPostView({Key? key}) : super(key: key);

  @override
  State<ShowPostView> createState() => _ShowPostViewState();
}

class _ShowPostViewState extends State<ShowPostView> with TickerProviderStateMixin {
  TextEditingController searchController = TextEditingController();
  ShowPostController showPostController = Get.put(ShowPostController());
  MyAppController myAppController = Get.put(MyAppController());
  BranchIOController branchIOController = Get.put(BranchIOController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    showPostController.getAllPostModel == null ? showPostController.getPost() : null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Feed",
            style: TextStyle(
              // color: theme_Color.white,
              color: Colors.black,
              fontSize: 23,
              fontFamily: 'abold',
            )),
        actions: [
          GestureDetector(
            onTap: () {
              Get.bottomSheet(Container(
                height: 160,
                decoration: BoxDecoration(
                    color: ThemeColor.white,
                    borderRadius: const BorderRadius.only(topRight: Radius.circular(22), topLeft: Radius.circular(22))),
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
                                child: ImageIcon(const AssetImage("Images/Message/camera.png"), color: ThemeColor.blackback),
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
                                style: TextStyle(fontFamily: 'amidum', fontSize: 15, color: ThemeColor.blackback),
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
            child: ImageIcon(const AssetImage("Images/Post_Screen/add.png"),
                // color: theme_Color.offwhite,
                color: ThemeColor.blackback,
                size: 28),
          ),
          const SizedBox(
            width: 15,
          ),
        ],
        elevation: 0,
      ),
      body: RefreshIndicator(
        color: ThemeColor.pink,
        onRefresh: () async {
          showPostController.getPost();
        },
        child: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (overscroll) {
            overscroll.disallowIndicator();
            return false;
          },
          child: GetBuilder<ShowPostController>(
            builder: (ShowPostController showPostController) => (showPostController.isLoding.value)
                ? Center(
                    child: CircularProgressIndicator(
                    color: ThemeColor.pink,
                  ))
                : (showPostController.getAllPostModel == null)
                    ? SingleChildScrollView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        child: SizedBox(
                          height: 600,
                          width: Get.width,
                          child: Center(
                            child: Image.asset(
                              AppImages.nodataImage,
                              height: 200,
                              width: 200,
                            ),
                          ),
                        ),
                      )
                    : Stack(
                        children: [
                          SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            child: ListView.separated(
                              cacheExtent: 5000,
                              physics: const NeverScrollableScrollPhysics(),
                              separatorBuilder: (context, index) {
                                return Divider(
                                  color: ThemeColor.graylight.withOpacity(0.3),
                                  thickness: 0.8,
                                );
                              },
                              shrinkWrap: true,
                              itemCount: showPostController.postData.length,
                              padding: const EdgeInsets.only(bottom: 10),
                              itemBuilder: (context, index) {
                                return postView(index);
                              },
                            ),
                          ),
                          Positioned(
                            top: Get.height / 3,
                            right: Get.width / 3.2,
                            child: Center(
                              child: GetBuilder<ShowPostController>(
                                builder: (controller) => Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    (showPostController.giftshow.value)
                                        ? Image.network(
                                            "${Constant.BASE_URL}${showPostController.getGiftList[showPostController.selectedGiftIndex.value].image}",
                                            fit: BoxFit.cover,
                                            height: 150,
                                            width: 150,
                                          )
                                        : const SizedBox(),
                                    (showPostController.giftshow.value)
                                        ? Text(
                                            "x${showPostController.dropdownvalue.value}",
                                            style: TextStyle(fontFamily: "amidum", fontSize: 20, color: ThemeColor.white),
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
      ),
    );
  }

  ConstrainedBox postView(int index) {
    String date = showPostController.postData[index]["date"].toString();
    List<String> dateParts = date.split(", ");
    List datePartsList = dateParts[0].split("/");
    return ConstrainedBox(
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
                if (showPostController.postData[index]["userId"].toString() == userID) {
                  Get.to(()=>const UserProfileView());
                } else {
                  Get.to(()=>SecondUserProfileView(
                    userID: showPostController.postData[index]["userId"].toString(),
                  ));
                }
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 4, bottom: 10, right: 10, left: 10),
                child: Row(
                  children: [
                    Container(
                      height: 40,
                      width: 40,
                      clipBehavior: Clip.hardEdge,
                      decoration: const BoxDecoration(shape: BoxShape.circle),
                      child: CachedNetworkImage(
                        placeholder: (context, url) => Image.asset(AppImages.profileImagePlaceHolder, fit: BoxFit.cover),
                        fit: BoxFit.cover,
                        imageUrl: showPostController.postData[index]["profileImage"].toString(),
                      ),
                    ).paddingOnly(right: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          showPostController.postData[index]["name"].toString(),
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
                          "${datePartsList[1]}/${datePartsList[0]}/${datePartsList[2]}",
                          style: TextStyle(
                              fontFamily: 'amidum',
                              fontSize: 15,
                              // color: theme_Color.PostScreen_text,
                              color: ThemeColor.blackback.withOpacity(0.8)),
                        ),
                      ],
                    ),
                    showPostController.postData[index]["isLive"] == true
                        ? Container(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            height: 26,
                            width: 62,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.pink,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Lottie.asset(
                                  waveLottie,
                                  fit: BoxFit.cover,
                                  reverse: true,
                                  repeat: true,
                                  animate: true,
                                  height: 14,
                                  width: 08,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                const Text(
                                  "Live",
                                  style: TextStyle(
                                    fontFamily: "abold",
                                    color: Colors.white,
                                    fontSize: 11,
                                  ),
                                )
                              ],
                            ),
                          ).paddingOnly(left: 15)
                        : const SizedBox.shrink(),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        if (showPostController.postData[index]["userId"].toString() != userID) {
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
                                    showPostController.blockRequest(
                                        blockUser: showPostController.postData[index]["userId"].toString());
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
                                            showPostController.postData[index]["name"].toString(),
                                            style: TextStyle(color: ThemeColor.blackback, fontSize: 20, fontFamily: 'abold'),
                                          ),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          GetBuilder<ShowPostController>(
                                            builder: (controller) => Column(
                                              children: [
                                                SizedBox(
                                                  height: 40,
                                                  child: ListTile(
                                                    title: const Text('sexual Content'),
                                                    leading: Radio<SingingCharacter>(
                                                      value: SingingCharacter.sexualContent,
                                                      groupValue: showPostController.character,
                                                      activeColor: ThemeColor.pink,
                                                      onChanged: (SingingCharacter? value) {
                                                        showPostController.reportRedio(value, 0);
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
                                                      groupValue: showPostController.character,
                                                      activeColor: ThemeColor.pink,
                                                      onChanged: (SingingCharacter? value) {
                                                        // setState(() {
                                                        //   showPostController
                                                        //       .character = value;
                                                        // });
                                                        showPostController.reportRedio(value, 1);
                                                      },
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 40,
                                                  child: ListTile(
                                                    title: const Text('child abuse'),
                                                    leading: Radio<SingingCharacter>(
                                                      value: SingingCharacter.childAbuse,
                                                      groupValue: showPostController.character,
                                                      activeColor: ThemeColor.pink,
                                                      onChanged: (SingingCharacter? value) {
                                                        // setState(() {
                                                        //   showPostController
                                                        //       .character = value;
                                                        // });
                                                        showPostController.reportRedio(value, 2);
                                                      },
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 40,
                                                  child: ListTile(
                                                    title: const Text('Spam'),
                                                    leading: Radio<SingingCharacter>(
                                                      value: SingingCharacter.Spam,
                                                      groupValue: showPostController.character,
                                                      activeColor: ThemeColor.pink,
                                                      onChanged: (SingingCharacter? value) {
                                                        // setState(() {
                                                        //   showPostController
                                                        //       .character = value;
                                                        // });
                                                        showPostController.reportRedio(value, 3);
                                                      },
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 40,
                                                  child: ListTile(
                                                    title: const Text('Other'),
                                                    leading: Radio<SingingCharacter>(
                                                      value: SingingCharacter.Other,
                                                      groupValue: showPostController.character,
                                                      activeColor: ThemeColor.pink,
                                                      onChanged: (SingingCharacter? value) {
                                                        // setState(() {
                                                        //   showPostController
                                                        //       .character = value;
                                                        // });
                                                        showPostController.reportRedio(value, 4);
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
                                                showPostController.sendReport(
                                                    postID: showPostController.postData[index]["_id"].toString(),
                                                    postimage: showPostController.postData[index]["postImage"].toString());
                                              },
                                              child: Container(
                                                height: 60,
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
                        }
                      },
                      child: (showPostController.postData[index]["userId"].toString() == userID)
                          ? const SizedBox()
                          : Icon(
                              Icons.more_vert_outlined,
                              size: 28,
                              color: ThemeColor.grayIcon,
                            ),
                    ),
                  ],
                ),
              ),
            ),
            ConstrainedBox(
              constraints: BoxConstraints(minHeight: 350, maxHeight: 500, maxWidth: Get.width, minWidth: Get.width),
              child: CachedNetworkImage(
                fit: BoxFit.cover,
                filterQuality: FilterQuality.low,
                imageUrl: showPostController.postData[index]["postImage"].toString(),
                placeholder: (context, url) =>
                    Center(child: Image.asset(AppImages.postImagePlaceHolder, color: Colors.grey[300], height: 170)),
                errorWidget: (context, string, dynamic) => Image(
                  height: 50,
                  width: 50,
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
                    isLiked: showPostController.postData[index]['isLike'],
                    size: 25,
                    circleColor: CircleColor(start: ThemeColor.pink, end: ThemeColor.pinklight),
                    bubblesColor: BubblesColor(
                      dotPrimaryColor: ThemeColor.pink,
                      dotSecondaryColor: ThemeColor.pinklight,
                    ),
                    onTap: (isLiked) async {
                      showPostController.sendLike(index, showPostController.postData[index]['_id']);
                      return !isLiked;
                    },
                    likeBuilder: (isLike) {
                      return (showPostController.postData[index]['isLike'])
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
                      postID: showPostController.postData[index]["_id"].toString(),
                      index: index,
                      postScreenType: 0,
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
                      branchIOController.imageURL.value = showPostController.postData[index]["postImage"].toString();
                      branchIOController.initDeepLinkDataPost(
                          shareType: 2,
                          userId: showPostController.postData[index]["userId"].toString(),
                          postId: showPostController.postData[index]["_id"].toString());
                      branchIOController.generateLink();
                    },
                    child: const ImageIcon(AssetImage("Images/Post_Screen/share_post.png"),
                        //color: Color(0xffA7A7B3),
                        color: Colors.black,
                        size: 25.5),
                  ),
                  const Spacer(),
                  (showPostController.postData[index]["userId"].toString() == userID)
                      ? const SizedBox()
                      : GestureDetector(
                          onTap: () {
                            showPostController.fetchGiftlist();
                            Get.bottomSheet(isScrollControlled: true, giftsheet(index));
                          },
                          child: const ImageIcon(AssetImage("Images/new_dis/gift.png"),
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
            (showPostController.postData[index]["description"].toString() == "")
                ? const SizedBox()
                : Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxHeight: 100),
                      child: Text(
                        showPostController.postData[index]["description"].toString(),
                        style: TextStyle(
                            fontFamily: 'amidum',
                            fontSize: 15,
                            // color: theme_Color.PostScreen_text,
                            color: ThemeColor.blackback.withOpacity(0.8)),
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ),
            SizedBox(
              height: (showPostController.postData[index]["description"].toString() == "") ? 0 : 5,
            ),
            GetBuilder<ShowPostController>(
              builder: (controller) => Padding(
                padding: EdgeInsets.only(
                    right: 10, left: (showPostController.getAllPostModel!.userPost![index].userLike!.length == 1) ? 10.0 : 5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    (showPostController.getAllPostModel!.userPost![index].userGift!.isNotEmpty)
                        ? (showPostController.getAllPostModel!.userPost![index].userGift!.length == 1)
                            ? Row(
                                children: [
                                  const SizedBox(
                                    width: 5,
                                  ),
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
                                            "${showPostController.getAllPostModel!.userPost![index].userGift![0].profileImage}",
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
                                    "${showPostController.getAllPostModel!.userPost![index].userGift!.length} gifted",
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
                                                  "${showPostController.getAllPostModel!.userPost![index].userGift![0].profileImage}",
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
                                                      "${showPostController.getAllPostModel!.userPost![index].userGift![1].profileImage}"),
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
                                    "${showPostController.getAllPostModel!.userPost![index].userGift!.length} gifted",
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
                    (showPostController.getAllPostModel!.userPost![index].userLike!.isNotEmpty)
                        ? (showPostController.getAllPostModel!.userPost![index].userLike!.length == 1)
                            ? Row(
                                children: [
                                  const SizedBox(
                                    width: 5,
                                  ),
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
                                            "${showPostController.getAllPostModel!.userPost![index].userLike![0].profileImage}",
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
                                    "${showPostController.getAllPostModel!.userPost![index].userLike!.length} likes",
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
                                                  "${showPostController.getAllPostModel!.userPost![index].userLike![0].profileImage}",
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
                                                      "${showPostController.getAllPostModel!.userPost![index].userLike![1].profileImage}"),
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
                                    "${showPostController.getAllPostModel!.userPost![index].userLike!.length} likes",
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
              padding: const EdgeInsets.only(left: 10, right: 10, bottom: 3),
              child: Obx(
                () => GestureDetector(
                  onTap: () => Get.to(()=>CommentScreen(
                    postID: showPostController.postData[index]["_id"].toString(),
                    index: index,
                    postScreenType: 0,
                  )),
                  child: showPostController.commentCount[index] == 0
                      ? Text(
                          textAlign: TextAlign.start,
                          "Add your first comment on this post",
                          style: TextStyle(
                              fontFamily: 'abold',
                              fontSize: 14,
                              // color: Color(0xffA6A6AD),
                              color: ThemeColor.blackback),
                        )
                      : Text(
                          textAlign: TextAlign.start,
                          "Show All Comments (${showPostController.commentCount[index]})",
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
                decoration: BoxDecoration(color: ThemeColor.pink, borderRadius: const BorderRadius.all(Radius.circular(10))),
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
                              border: Border.all(color: ThemeColor.pink, width: 1), borderRadius: BorderRadius.circular(100)),
                          alignment: Alignment.center,
                          child: const Text(
                            "+ Get Coins",
                            style: TextStyle(fontFamily: 'amidum', color: Colors.white, fontSize: 12.5),
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
                      child: Obx(() => (showPostController.giftLoading.value)
                          ? Center(
                              child: CircularProgressIndicator(color: ThemeColor.pink),
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
                                  border: Border.all(color: ThemeColor.pink, width: 1),
                                  borderRadius:
                                      const BorderRadius.only(topLeft: Radius.circular(100), bottomLeft: Radius.circular(100)),
                                ),
                                alignment: Alignment.center,
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 4),
                                  child: Obx(
                                    () => DropdownButton(
                                      value: showPostController.dropdownvalue.value,
                                      icon: const Icon(Icons.keyboard_arrow_down, color: Colors.white),
                                      elevation: 0,
                                      underline: Container(),
                                      dropdownColor: Colors.black,
                                      items: showPostController.items.map((int items) {
                                        return DropdownMenuItem(
                                          value: items,
                                          child: Text(
                                            (items == 1 || items == 5) ? "  x$items" : " x$items",
                                            style: TextStyle(
                                              fontSize: 18,
                                              color: ThemeColor.white,
                                              fontFamily: 'amidum',
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                      onChanged: (int? newValue) {
                                        showPostController.dropdownvalue.value = newValue!;
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
                                      (showPostController.getGiftList[showPostController.selectedGiftIndex.value].coin!.toInt() *
                                          showPostController.dropdownvalue.value)) {
                                    userCoins.value = userCoins.value -
                                        showPostController.getGiftList[showPostController.selectedGiftIndex.value].coin!.toInt() *
                                            showPostController.dropdownvalue.value;
                                    getstorage.write("UserCoins", userCoins.value);
                                    showPostController.sendGift(
                                        giftId: showPostController.getGiftList[showPostController.selectedGiftIndex.value].id
                                            .toString(),
                                        postId: showPostController.postData[index]["_id"].toString(),
                                        index: index,
                                        coin: showPostController.getGiftList[showPostController.selectedGiftIndex.value].coin!
                                                .toInt() *
                                            showPostController.dropdownvalue.value);
                                    showPostController.setGift();
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
                                    border: Border.all(color: ThemeColor.pink, width: 1),
                                    borderRadius: const BorderRadius.only(
                                        topRight: Radius.circular(100), bottomRight: Radius.circular(100)),
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
      itemCount: showPostController.getGiftList.length,
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 100,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (BuildContext context, i) {
        return InkWell(
          onTap: () {
            showPostController.selectedGiftIndex.value = i;
          },
          child: Obx(
            () => Container(
              height: 78,
              decoration: (showPostController.selectedGiftIndex.value == i)
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
                        image: NetworkImage("${Constant.BASE_URL}${showPostController.getGiftList[i].image.toString()}"),
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
                      Text(showPostController.getGiftList[i].coin.toString(),
                          style: const TextStyle(fontFamily: 'amidum', fontSize: 11.5, color: Colors.white)),
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

  Future cameraImage() async {
    try {
      final imagepike = await ImagePicker().pickImage(source: ImageSource.camera);
      if (imagepike == null) return;

      final imageTeam = File(imagepike.path);
      showPostController.proImage = imageTeam;
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
                            image: FileImage(showPostController.proImage!),
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
                        controller: showPostController.discription,
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
                          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
                          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
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
                        showPostController.send();
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
                            () => (showPostController.postLoding.value)
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
    } on PlatformException catch (e) {
      log("$e");
    }
  }

  Future pickImage() async {
    try {
      final imagepike = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (imagepike == null) return;

      final imageTeam = File(imagepike.path);
      showPostController.proImage = imageTeam;
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
                            image: FileImage(showPostController.proImage!),
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
                        controller: showPostController.discription,
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
                          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
                          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
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
                        showPostController.send();
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
                            () => (showPostController.postLoding.value)
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
    } on PlatformException catch (e) {
      log("fail$e");
    }
  }
}
