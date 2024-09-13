import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rayzi/app/data/AppImages.dart';
import 'package:rayzi/app/data/Colors.dart';
import 'package:rayzi/app/modules/User_Profile/controllers/FollowingController.dart';
import 'package:rayzi/app/modules/User_Profile/views/second_user_profile.dart';
import 'package:shimmer/shimmer.dart';

class FollowingScreen extends StatefulWidget {
  const FollowingScreen({Key? key}) : super(key: key);

  @override
  State<FollowingScreen> createState() => _FollowingScreenState();
}

class _FollowingScreenState extends State<FollowingScreen> {
  FollowingScreenController followingController = Get.put(FollowingScreenController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Row(
          children: [
            const SizedBox(
              width: 15,
            ),
            GestureDetector(
              onTap: () => Get.back(),
              child: ImageIcon(
                const AssetImage(
                  "Images/new_dis/back.png",
                ),
                size: 25,
                color: ThemeColor.blackback,
              ),
            ),
          ],
        ),
        title: Text(
          "Following",
          style: TextStyle(fontFamily: 'abold', fontSize: 22, color: ThemeColor.blackback),
        ),
        elevation: 0.8,
      ),
      body: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (notification) {
          notification.disallowIndicator();
          return false;
        },
        child: Obx(
          () => (followingController.isLoding.value)
              ? shimmer()
              : (followingController.listNull.value)
                  ? Center(
                      child: Image.asset(
                        AppImages.nodataImage,
                        height: 200,
                        width: 200,
                      ),
                    )
                  : ListView.separated(
                      padding: const EdgeInsets.only(top: 10),
                      shrinkWrap: true,
                      itemCount: followingController.followingList.length,
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          height: 25,
                        );
                      },
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(left: 15, right: 15),
                          child: GestureDetector(
                            onTap: () => Get.off(SecondUserProfileView(
                              userID: "${followingController.followingList[index].to!.id}",
                            )),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                CircleAvatar(
                                  radius: 23,
                                  backgroundColor: ThemeColor.grayIcon,
                                  backgroundImage: (followingController.followingList[index].to!.isFake == true)
                                      ? NetworkImage(
                                          "${followingController.followingList[index].to!.profileImage}",
                                        )
                                      : NetworkImage(
                                          "${followingController.followingList[index].to!.profileImage}",
                                        ),
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                Text(
                                  followingController.followingList[index].to!.name!.length > 15
                                      ? '${followingController.followingList[index].to!.name!.substring(0, 15)}...'
                                      : '${followingController.followingList[index].to!.name}',
                                  style: TextStyle(
                                    fontFamily: 'amidum',
                                    fontSize: 18.5,
                                    color: ThemeColor.blackback,
                                  ),
                                ),
                                const Spacer(),
                                GestureDetector(
                                  onTap: () => showDialog(
                                    context: context,
                                    builder: (context) {
                                      return Dialog(
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                                        child: Container(
                                          height: 250,
                                          decoration: BoxDecoration(
                                            color: ThemeColor.white,
                                            borderRadius: BorderRadius.circular(18),
                                          ),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              RichText(
                                                text: TextSpan(
                                                  text: 'Unfollow ',
                                                  style: TextStyle(
                                                      color: ThemeColor.blackback, fontFamily: 'amidum', fontSize: 18.5),
                                                  children: <TextSpan>[
                                                    TextSpan(
                                                      text: '${followingController.followingList[index].to!.name} ?',
                                                      style: TextStyle(
                                                        fontSize: 18.5,
                                                        fontFamily: 'abold',
                                                        color: ThemeColor.blackback,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(left: 15, right: 15),
                                                child: GestureDetector(
                                                  onTap: () {
                                                    followingController.status.value = true;
                                                    followingController.followRequest(index);
                                                  },
                                                  child: Container(
                                                    height: 55,
                                                    decoration: BoxDecoration(
                                                      color: ThemeColor.pink,
                                                      borderRadius: BorderRadius.circular(50),
                                                    ),
                                                    alignment: Alignment.center,
                                                    child: Obx(
                                                      () => (followingController.status.value)
                                                          ? const CircularProgressIndicator(
                                                              color: Colors.white,
                                                            )
                                                          : Text("Unfollow",
                                                              style: TextStyle(
                                                                  color: ThemeColor.white, fontFamily: 'abold', fontSize: 20)),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 15,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(left: 15, right: 15),
                                                child: GestureDetector(
                                                  onTap: () => Get.back(),
                                                  child: Container(
                                                    height: 55,
                                                    decoration: BoxDecoration(
                                                      color: ThemeColor.white,
                                                      border: Border.all(color: ThemeColor.grayIcon.withOpacity(0.8), width: 0.4),
                                                      borderRadius: BorderRadius.circular(50),
                                                    ),
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                      "Cancel",
                                                      style: TextStyle(
                                                          color: ThemeColor.blackback, fontFamily: 'abold', fontSize: 20),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                  child: Container(
                                    height: 34,
                                    width: 94,
                                    decoration: BoxDecoration(
                                      color: ThemeColor.greAlpha20.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    alignment: Alignment.center,
                                    child:
                                        Text((followingController.followingList[index].friends == true) ? "Friends" : "Following",
                                            style: TextStyle(
                                              color: ThemeColor.graylight,
                                              fontSize: 16.5,
                                              fontFamily: 'abold',
                                            )),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
        ),
      ),
    );
  }

  Shimmer shimmer() {
    return Shimmer.fromColors(
      highlightColor: ThemeColor.shimmerHighlight,
      baseColor: ThemeColor.shimmerBaseColor,
      child: ListView.separated(
        padding: const EdgeInsets.only(top: 10),
        shrinkWrap: true,
        //itemCount: following.length,
        itemCount: 8,
        separatorBuilder: (context, index) {
          return const SizedBox(
            height: 25,
          );
        },
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const CircleAvatar(
                  radius: 26,
                ),
                const SizedBox(
                  width: 15,
                ),
                Container(
                  color: Colors.red,
                  height: 25,
                  width: 150,
                ),
                const Spacer(),
                Container(
                  height: 34,
                  width: 94,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    // color: ThemeColor.gre_alpha_20
                    //     .withOpacity(0.1),
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
