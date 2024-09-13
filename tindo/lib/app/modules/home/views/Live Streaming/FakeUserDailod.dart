import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rayzi/app/data/AppImages.dart';
import 'package:rayzi/app/data/Colors.dart';
import 'package:rayzi/app/modules/home/controllers/FakeuserprofileController.dart';

class FakeUserDailod extends StatefulWidget {
  final String profileImage;
  final String name;
  final String contry;
  final bool followStatus;
  const FakeUserDailod(
      {Key? key,
      required this.profileImage,
      required this.name,
      required this.contry,
      required this.followStatus})
      : super(key: key);

  @override
  State<FakeUserDailod> createState() => _FakeUserDailodState();
}

class _FakeUserDailodState extends State<FakeUserDailod> {
  FakeUserProfileController userProfileController =
      Get.put(FakeUserProfileController());
  String discription = "luv❤my❤friends👈 🌹🌹 this is discription ♥♥ 🎁🎁🎁 ";
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 340,
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
                    widget.profileImage,
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.name,
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
                      widget.contry,
                      style: TextStyle(
                          color: ThemeColor.grayIcon.withOpacity(0.7),
                          fontFamily: "amidum",
                          fontSize: 15),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    ConstrainedBox(
                      constraints:
                          const BoxConstraints(maxHeight: 100, maxWidth: 200),
                      child: Text(
                        discription,
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
                border: Border.all(
                    color: ThemeColor.textGray.withOpacity(0.8), width: 0.6),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "102",
                          style: TextStyle(
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
                              color: ThemeColor.blackback.withOpacity(0.6),
                              height: 10,
                              width: 10,
                            ),
                            Text(
                              "Earned",
                              style: TextStyle(
                                fontFamily: 'amidum',
                                fontSize: 13,
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
                        const Text(
                          "102",
                          style: TextStyle(
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
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "478",
                          style: TextStyle(
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
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "54",
                          style: TextStyle(
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
                GetBuilder<FakeUserProfileController>(
                  builder: (controller) => GestureDetector(
                    onTap: () {
                      userProfileController.changevalue();
                    },
                    child: (userProfileController.followUnfollow == true &&
                            userProfileController.followStatus == false)
                        ? Container(
                            alignment: Alignment.center,
                            height: 55,
                            width: Get.width / 1.7,
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
                          )
                        : Container(
                            alignment: Alignment.center,
                            height: 55,
                            width: Get.width / 1.7,
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
                          ),
                  ),
                ),
                GestureDetector(
                  // onTap: () => Get.to(MessageShow(
                  //     images: "${widget.profileImage}",
                  //     name: widget.name,
                  //     country: widget.contry)),
                  child: Container(
                    height: Get.height / 14.5,
                    width: Get.width / 7,
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
                Container(
                  height: Get.height / 14.5,
                  width: Get.width / 7,
                  decoration: BoxDecoration(
                    color: ThemeColor.white,
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(color: ThemeColor.greAlpha20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Image.asset("Images/Post_Screen/share_post.png",
                        color: Colors.black, fit: BoxFit.fill),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
