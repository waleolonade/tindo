import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:rayzi/app/API_Services/app_url.dart';
import 'package:rayzi/app/API_Services/fake_giftsend_services.dart';
import 'package:rayzi/app/data/APP_variables/AppVariable.dart';
import 'package:rayzi/app/data/AppImages.dart';
import 'package:rayzi/app/data/Colors.dart';
import 'package:rayzi/app/data/FakeData.dart';
import 'package:rayzi/app/modules/My_App/controllers/my_app_controller.dart';
import 'package:rayzi/app/modules/My_App/views/my_app_view.dart';
import 'package:rayzi/app/modules/User_Profile/views/second_user_profile.dart';
import 'package:rayzi/app/modules/home/controllers/LiveStreaming_controller.dart';
import 'package:video_player/video_player.dart';

class FakeLiveStreaming extends StatefulWidget {
  final String username;
  final String videourl;
  final String profileIamge;
  final String userCoin;
  final String userId;
  const FakeLiveStreaming(
      {Key? key,
      required this.username,
      required this.videourl,
      required this.profileIamge,
      required this.userCoin,
      required this.userId})
      : super(key: key);

  @override
  State<FakeLiveStreaming> createState() => _FakeLiveStreamingState();
}

class _FakeLiveStreamingState extends State<FakeLiveStreaming> {
  late VideoPlayerController _controller;
  final ScrollController scrollController1 = ScrollController();
  TextEditingController textEditingController = TextEditingController();
  LiveStreamingController liveStreamingController = Get.put(LiveStreamingController());
  MyAppController myAppController = Get.put(MyAppController());
  FocusNode focusNode = FocusNode();
  void addItems() {
    hostCommentList.shuffle();
    if(mounted) {
      setState(() {
      dummyCommentList1.add(hostCommentList.first);
      scrollController1.animateTo(scrollController1.position.maxScrollExtent,
          duration: const Duration(milliseconds: 50), curve: Curves.easeOut);
    });
    }
  }

  bool showgift = false;
  bool isfollow = false;

  @override
  void initState() {
    // TODO: implement initState
    _controller = VideoPlayerController.network(widget.videourl)
      // _controller = VideoPlayerController.network("${Constant.BASE_URL}${widget.videourl}")
      ..initialize().then((_) {
        setState(() {
          _controller.play();
          _controller.setLooping(true);
        });
      });
    Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      addItems();
    });
    textEditingController.addListener(() {
      validateField(textEditingController.text);
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.pause();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.offAll(const MyApp());
        return false;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.black,
        body: Column(
          children: [
            Stack(
              children: [
                SizedBox(height: Get.height, width: Get.width, child: VideoPlayer(_controller)),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 38,
                    left: 18,
                    right: 15,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () => Get.offAll(const MyApp()),
                        child: ImageIcon(
                          const AssetImage(
                            "Images/new_dis/back.png",
                          ),
                          size: 25,
                          color: ThemeColor.white,
                        ),
                      ),
                      const Spacer(),
                      Icon(
                        Icons.remove_red_eye,
                        color: ThemeColor.white,
                        size: 20,
                      ),
                      const SizedBox(
                        width: 3,
                      ),
                      Text(
                        "198",
                        style: TextStyle(color: ThemeColor.white, fontFamily: 'amidum', fontSize: 12),
                      ),
                      const SizedBox(
                        width: 18,
                      ),
                      GestureDetector(
                        //onTap: () => Get.back(),
                        onTap: () {
                          Fluttertoast.showToast(
                              msg: "Share successfully",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: ThemeColor.white,
                              textColor: ThemeColor.pink,
                              fontSize: 16.0);
                        },
                        child: ImageIcon(
                          const AssetImage(
                            "Images/Post_Screen/share_post.png",
                          ),
                          size: 25,
                          color: ThemeColor.white,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: Get.height / 2.1,
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 5,
                        ),
                        child: commentSection(),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 70,
                        width: Get.width,
                        child: Obx(
                          () => (liveStreamingController.giftLoading.value)
                              ? const SizedBox()
                              : ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: liveStreamingController.getGiftList.length,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
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
                                        } else if (userCoins.value >=
                                            (liveStreamingController.getGiftList[index].coin!.toInt() * 1)) {
                                          int cutCoin =
                                              liveStreamingController.getGiftList[index].coin!.toInt() * 1;
                                          userCoins.value = userCoins.value - cutCoin;
                                          getstorage.write("UserCoins", userCoins.value);
                                          emojiImage.add(
                                              "${Constant.BASE_URL}${liveStreamingController.getGiftList[index].image}");
                                          setState(() {
                                            showgift = true;
                                          });
                                          Timer(const Duration(seconds: 3), () {
                                            setState(() {
                                              showgift = false;
                                            });
                                          });
                                          FakeGiftSend().fakeGiftSend(
                                              giftId: liveStreamingController.getGiftList[index].id!,
                                              receiverId: widget.userId);

                                          ///======================&&=============================\\\\\\
                                        } else {
                                          Fluttertoast.showToast(
                                              msg: "Not Sufficient Coins",
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.CENTER,
                                              timeInSecForIosWeb: 1,
                                              backgroundColor: ThemeColor.white,
                                              textColor: ThemeColor.pink,
                                              fontSize: 16.0);
                                        }
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 4, right: 4),
                                        child: Container(
                                          decoration: const BoxDecoration(color: Colors.transparent),
                                          child: Column(
                                            children: [
                                              Container(
                                                width: 45,
                                                height: 45,
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                    // image: AssetImage(
                                                    //     scrollSticker[index]),
                                                    image: NetworkImage(
                                                        "${Constant.BASE_URL}${liveStreamingController.getGiftList[index].image}"),
                                                    fit: BoxFit.cover,
                                                  ),
                                                  shape: BoxShape.circle,
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
                                                    height: 10,
                                                    width: 10,
                                                    child: Image.asset(AppImages.coinImages),
                                                  ),
                                                  const SizedBox(
                                                    width: 4,
                                                  ),
                                                  Text("${liveStreamingController.getGiftList[index].coin}",
                                                      style: const TextStyle(
                                                          fontFamily: 'amidum',
                                                          fontSize: 11,
                                                          color: Colors.white)),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Get.bottomSheet(
                                    barrierColor: Colors.transparent,
                                    BottomSheet(
                                      backgroundColor: Colors.black12,
                                      onClosing: () {},
                                      builder: (BuildContext context) {
                                        return commentTextfield();
                                      },
                                    ),
                                    backgroundColor: Colors.transparent);
                              },
                              child: Container(
                                height: 55,
                                width: 55,
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Image.asset("Images/Post_Screen/comment.png",
                                      color: ThemeColor.white, fit: BoxFit.fill),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: GestureDetector(
                                /// ================================================================\\\\
                                onTap: () {
                                  Get.off(SecondUserProfileView(
                                    userID: widget.userId,
                                  ));
                                },
                                child: Container(
                                  height: Get.height / 14.5,
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  padding: const EdgeInsets.all(2.5),
                                  child: Row(
                                    children: [
                                      Container(
                                        height: Get.height / 14.5,
                                        width: Get.width / 7,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                              // image: NetworkImage("${Constant.BASE_URL}${widget.profileIamge}"),
                                              image: NetworkImage(widget.profileIamge),
                                              fit: BoxFit.cover),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 3,
                                      ),
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            widget.username.length >= 14
                                                ? '${widget.username.substring(0, 14)}...'
                                                : widget.username,
                                            style: TextStyle(
                                                color: ThemeColor.white, fontSize: 12, fontFamily: 'amidum'),
                                          ),
                                          const SizedBox(
                                            height: 6,
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Image.asset(
                                                AppImages.coinImages,
                                                height: 16.6,
                                                width: 16.6,
                                              ),
                                              Text(
                                                "  ${widget.userCoin}",
                                                style: TextStyle(
                                                    fontFamily: 'amidum', fontSize: 12, color: ThemeColor.white),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                      const Spacer(),
                                      Padding(
                                        padding: const EdgeInsets.only(right: 3),
                                        child: GestureDetector(
                                          onTap: () {
                                            if (isfollow) {
                                              setState(() {
                                                isfollow = false;
                                              });
                                            } else {
                                              setState(() {
                                                isfollow = true;
                                              });
                                            }
                                          },
                                          child: Container(
                                            height: Get.height / 18,
                                            width: Get.width / 8,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: ThemeColor.pink,
                                            ),
                                            alignment: Alignment.center,
                                            child: (isfollow)
                                                ? Icon(Icons.check, color: ThemeColor.white, size: 22)
                                                : Icon(Icons.add, color: ThemeColor.white, size: 22),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            GestureDetector(
                              onTap: () => Get.bottomSheet(isScrollControlled: true, giftsheet()),
                              child: Container(
                                height: 55,
                                width: 55,
                                decoration: BoxDecoration(
                                  color: ThemeColor.white,
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Image.asset("Images/Post_Screen/gift.png",
                                      color: Colors.black, fit: BoxFit.fill),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                (showgift)
                    ? Positioned(
                        top: Get.height / 3.4,
                        right: Get.width / 3.2,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 150,
                              height: 150,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(emojiImage.last),
                                ),
                              ),
                            ),
                            Text(
                              "${emojicount.last}",
                              style: TextStyle(fontFamily: "amidum", fontSize: 20, color: ThemeColor.white),
                            ),
                          ],
                        ),
                      )
                    : Container(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Container giftsheet() {
    return Container(
      decoration: BoxDecoration(
        color: ThemeColor.grayinsta.withOpacity(0.7),
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
              decoration:
                  BoxDecoration(color: ThemeColor.pink, borderRadius: const BorderRadius.all(Radius.circular(10))),
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
                      height: 30,
                      width: 30,
                      child: Image.asset(AppImages.coinImages),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      "${userCoins.value}",
                      style: TextStyle(
                        color: ThemeColor.white,
                        fontSize: 16.5,
                        fontFamily: 'amidum',
                      ),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        myAppController.tabIndex = 4;
                        Get.off(const MyApp());
                      },
                      child: Container(
                        height: 27,
                        width: 94,
                        decoration: BoxDecoration(
                            border: Border.all(color: ThemeColor.pink, width: 1),
                            borderRadius: BorderRadius.circular(100)),
                        alignment: Alignment.center,
                        child: const Text(
                          "+ Get Couins",
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
                    child: (liveStreamingController.giftLoading.value)
                        ? Center(
                            child: CircularProgressIndicator(
                            color: ThemeColor.pink,
                          ))
                        : sticker(),
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
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(100), bottomLeft: Radius.circular(100)),
                              ),
                              alignment: Alignment.center,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 4),
                                child: Obx(
                                  () => DropdownButton(
                                    value: liveStreamingController.dropdownvalue.value,
                                    icon: const Icon(Icons.keyboard_arrow_down, color: Colors.white),
                                    elevation: 0,
                                    underline: Container(),
                                    dropdownColor: Colors.black,
                                    items: liveStreamingController.items.map((int items) {
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
                                      liveStreamingController.dropdownvalue.value = newValue!;
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
                                    (liveStreamingController
                                            .getGiftList[liveStreamingController.selectedGiftIndex.value].coin!
                                            .toInt() *
                                        liveStreamingController.dropdownvalue.value)) {
                                  int cutCoins = liveStreamingController
                                          .getGiftList[liveStreamingController.selectedGiftIndex.value].coin!
                                          .toInt() *
                                      liveStreamingController.dropdownvalue.value;
                                  userCoins.value = userCoins.value - cutCoins;

                                  /// ===================================
                                  getstorage.write("UserCoins", userCoins.value);
                                  emojiImage.add(
                                      "${Constant.BASE_URL}${liveStreamingController.getGiftList[liveStreamingController.selectedGiftIndex.value].image!.toString()}");

                                  setState(() {
                                    showgift = true;
                                  });
                                  Get.back();
                                  Timer(const Duration(seconds: 3), () {
                                    setState(() {
                                      showgift = false;
                                    });
                                  });
                                  FakeGiftSend().fakeGiftSend(
                                      giftId: liveStreamingController
                                          .getGiftList[liveStreamingController.selectedGiftIndex.value].id!,
                                      receiverId: widget.userId);
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
              height: 20,
            ),
          ],
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
      itemCount: liveStreamingController.getGiftList.length,
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 100,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (BuildContext context, i) {
        return InkWell(
          onTap: () {
            liveStreamingController.selectedGiftIndex.value = i;
          },
          child: Obx(
            () => Container(
              height: 78,
              decoration: (liveStreamingController.selectedGiftIndex.value == i)
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
                        //image: AssetImage(stickerList[i].image),
                        image: NetworkImage("${Constant.BASE_URL}${liveStreamingController.getGiftList[i].image}"),
                        fit: BoxFit.cover,
                      ),
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
                      Text("${liveStreamingController.getGiftList[i].coin}",
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

  Container commentSection() {
    return Container(
        margin: const EdgeInsets.only(
          right: 60,
        ),
        height: Get.height / 3.2,
        child: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (notification) {
            notification.disallowIndicator();
            return false;
          },
          child: ShaderMask(
            shaderCallback: (bounds) {
              return const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.purple, Colors.transparent, Colors.transparent, Colors.purple],
                stops: [0.0, 0.1, 0.9, 1.0],
              ).createShader(bounds);
            },
            blendMode: BlendMode.dstOut,
            child: ListView.builder(
              controller: scrollController1,
              shrinkWrap: true,
              reverse: false,
              itemCount: dummyCommentList1.length,
              itemBuilder: (BuildContext context, int index) {
                if (dummyCommentList1.isEmpty) {
                  return const SizedBox();
                }
                return Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: InkWell(
                    onTap: () {
                      // Get.bottomSheet(
                      //     shape: const OutlineInputBorder(
                      //         borderSide: BorderSide.none,
                      //         borderRadius: BorderRadius.only(
                      //             topRight: Radius.circular(20),
                      //             topLeft: Radius.circular(20))),
                      //     backgroundColor: ThemeColor.white,
                      //     FakeUserDailod(
                      //       profileImage: '${dummyCommentList1[index].image}',
                      //       name: '${dummyCommentList1[index].user}',
                      //       followStatus: true,
                      //       contry: "UK",
                      //     ));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ConstrainedBox(
                          constraints: const BoxConstraints(minHeight: 45),
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                            ),
                            padding: const EdgeInsets.all(3),
                            child: Row(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 5,
                                  ),
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: 30,
                                    width: 30,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                          image: NetworkImage(dummyCommentList1[index].image), fit: BoxFit.cover),
                                    ),
                                  ),
                                ),
                                (dummyCommentList1[index].message == 'Joined')
                                    ? Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              left: 10,
                                              right: 15,
                                              bottom: 3,
                                            ),
                                            child: RichText(
                                                text: TextSpan(
                                              text: dummyCommentList1[index].user,
                                              style: TextStyle(
                                                fontFamily: 'amidum',
                                                color: Colors.white.withOpacity(0.8),
                                                fontSize: 12.5,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              children: <TextSpan>[
                                                TextSpan(
                                                    text: "   ${dummyCommentList1[index].message}",
                                                    style: TextStyle(
                                                        fontFamily: 'amidum',
                                                        color: ThemeColor.pink,
                                                        fontSize: 13.5,
                                                        overflow: TextOverflow.ellipsis)),
                                              ],
                                            )),
                                          ),
                                          const SizedBox(),
                                        ],
                                      )
                                    : Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              left: 10,
                                              right: 15,
                                              bottom: 3,
                                            ),
                                            child: Text(dummyCommentList1[index].user,
                                                style: TextStyle(
                                                  fontFamily: 'amidum',
                                                  color: Colors.white.withOpacity(0.6),
                                                  fontSize: 12.5,
                                                  overflow: TextOverflow.ellipsis,
                                                )),
                                          ),
                                          ConstrainedBox(
                                            constraints: const BoxConstraints(
                                              maxWidth: 240,
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                left: 10,
                                                right: 15,
                                                bottom: 3,
                                              ),
                                              child: Text(
                                                  softWrap: false,
                                                  maxLines: 100,
                                                  overflow: TextOverflow.ellipsis,
                                                  dummyCommentList1[index].message,
                                                  style: const TextStyle(
                                                    fontFamily: 'amidum',
                                                    color: Colors.white,
                                                    fontSize: 12.5,
                                                    overflow: TextOverflow.ellipsis,
                                                  )),
                                            ),
                                          ),
                                        ],
                                      ),
                              ],
                            ),
                          ),
                        ),
                        const Spacer(),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ));
  }

  ConstrainedBox commentTextfield() {
    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: 60),
      child: Container(
        color: Colors.black,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: ConstrainedBox(
                constraints: const BoxConstraints(minHeight: 50),
                child: SizedBox(
                  child: Card(
                    color: Colors.black38,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                    child: TextFormField(
                      keyboardAppearance: Brightness.dark,
                      focusNode: focusNode,
                      minLines: 1,
                      maxLines: 5,
                      keyboardType: TextInputType.multiline,
                      controller: textEditingController,
                      autofocus: true,
                      autocorrect: false,
                      cursorColor: const Color(0xff767676),
                      style: TextStyle(
                        fontFamily: 'amidum',
                        fontSize: 14,
                        color: ThemeColor.white,
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.only(top: 15, bottom: 15, left: 15, right: 15),
                        hintText: "Say something.....",
                        hintStyle: TextStyle(
                          fontFamily: 'amidum',
                          fontSize: 14,
                          color: ThemeColor.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 15),
              child: GestureDetector(
                onTap: () {
                  if (textEditingController.text.isNotEmpty) {
                    setState(() {
                      dummyCommentList1.add(HostComment1(
                        message: textEditingController.text.toString(),
                        user: "You",
                        image: "$userProfile",
                      ));
                    });
                    textEditingController.clear();
                    Get.back();
                  }
                },
                child: Container(
                  height: 38,
                  width: 38,
                  decoration: const BoxDecoration(
                    color: Colors.black38,
                    shape: BoxShape.circle,
                  ),
                  padding: const EdgeInsets.all(10),
                  child: Image.asset(
                    "Images/Home/send_live.png",
                    color: ThemeColor.white,
                    width: 25,
                    height: 25,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
