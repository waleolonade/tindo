import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rayzi/app/API_Services/app_url.dart';
import 'package:rayzi/app/data/AppImages.dart';
import 'package:rayzi/app/data/Colors.dart';
import 'package:rayzi/app/modules/User_Profile/controllers/FollowersController.dart';
import 'package:rayzi/app/modules/User_Profile/views/second_user_profile.dart';
import 'package:shimmer/shimmer.dart';

class FollowersScreen extends StatefulWidget {
  const FollowersScreen({Key? key}) : super(key: key);

  @override
  State<FollowersScreen> createState() => _FollowersScreenState();
}

class _FollowersScreenState extends State<FollowersScreen> {
  FollowersController followersController = Get.put(FollowersController());
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
          "Followers",
          style: TextStyle(
              fontFamily: 'abold', fontSize: 22, color: ThemeColor.blackback),
        ),
        elevation: 0.8,
      ),
      body: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (overscroll) {
          overscroll.disallowIndicator();
          return false;
        },
        child: GetBuilder<FollowersController>(
            builder: (controller) => (followersController.data.isNotEmpty)
                ? ListView.separated(
                    padding: const EdgeInsets.only(top: 10),
                    shrinkWrap: true,
                    itemCount: followersController.data.length,
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
                            userID: followersController.data[index]["from"]
                                ["_id"],
                          )),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                radius: 23,
                                backgroundColor: ThemeColor.grayIcon,
                                backgroundImage: (followersController
                                            .data[index]["from"]["isFake"] ==
                                        true)
                                    ? NetworkImage(
                                        "${Constant.BASE_URL}${followersController.data[index]["from"]["profileImage"]}",
                                      )
                                    : NetworkImage(
                                        followersController.data[index]["from"]
                                                ["profileImage"]
                                            .toString(),
                                      ),
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              Text(
                                followersController.data[index]["from"]["name"]
                                            .length >
                                        15
                                    ? "${followersController.data[index]["from"]["name"].substring(0, 15)}..."
                                    : "${followersController.data[index]["from"]["name"]}",
                                style: TextStyle(
                                  fontFamily: 'amidum',
                                  fontSize: 18.5,
                                  color: ThemeColor.blackback,
                                ),
                              ),
                              const Spacer(),
                              // (fans[index].Status == 'NotFriends' &&
                              //         fans[index].following == true)
                              //     ? InkWell(
                              //         onTap: () {
                              //           setState(() {
                              //             fans[index].following = false;
                              //           });
                              //         },
                              //         child: Container(
                              //           height: 36,
                              //           width: 95,
                              //           decoration: BoxDecoration(
                              //             color: ThemeColor.gre_alpha_20,
                              //             borderRadius: BorderRadius.circular(50),
                              //           ),
                              //           alignment: Alignment.center,
                              //           child: Text("Following",
                              //               style: TextStyle(
                              //                 color: ThemeColor.graylight,
                              //                 fontSize: 16.5,
                              //                 fontFamily: 'abold',
                              //               )),
                              //         ),
                              //       )
                              //     : (fans[index].Status == 'NotFriends' &&
                              //             fans[index].following == false)
                              //         ? InkWell(
                              //             onTap: () {
                              //               setState(() {
                              //                 print("88888");
                              //                 fans[index].following = true;
                              //               });
                              //             },
                              //             child: Container(
                              //               height: 36,
                              //               width: 95,
                              //               decoration: BoxDecoration(
                              //                 color: ThemeColor.pink,
                              //                 borderRadius:
                              //                     BorderRadius.circular(50),
                              //               ),
                              //               alignment: Alignment.center,
                              //               child: Text("Follow",
                              //                   textAlign: TextAlign.center,
                              //                   style: TextStyle(
                              //                       color: ThemeColor.white,
                              //                       fontFamily: 'abold',
                              //                       fontSize: 17.5)),
                              //             ),
                              //           )
                              //         : Container(
                              //             height: 36,
                              //             width: 95,
                              //             decoration: BoxDecoration(
                              //               color: ThemeColor.gre_alpha_20,
                              //               borderRadius:
                              //                   BorderRadius.circular(50),
                              //             ),
                              //             alignment: Alignment.center,
                              //             child: Text("Friends",
                              //                 style: TextStyle(
                              //                   color: ThemeColor.graylight,
                              //                   fontSize: 17.5,
                              //                   fontFamily: 'abold',
                              //                 )),
                              //           ),
                              ///
                              InkWell(
                                onTap: () {
                                  followersController.followRequest(index);
                                  followersController.isFollowss(index);
                                  // setState(() {
                                  //  followersController.data[index] = followersController.data[index]
                                  //               ["friends"] ==
                                  //           false
                                  //       ? true
                                  //       : false;
                                  // });
                                },
                                child: (followersController.data[index]
                                            ["friends"] ==
                                        true)
                                    ? Container(
                                        height: 36,
                                        width: 95,
                                        decoration: BoxDecoration(
                                          color: ThemeColor.greAlpha20,
                                          borderRadius:
                                              BorderRadius.circular(50),
                                        ),
                                        alignment: Alignment.center,
                                        child: Text("Friends",
                                            style: TextStyle(
                                              color: ThemeColor.graylight,
                                              fontSize: 17.5,
                                              fontFamily: 'abold',
                                            )),
                                      )
                                    : Container(
                                        height: 36,
                                        width: 95,
                                        decoration: BoxDecoration(
                                          color: ThemeColor.pink,
                                          borderRadius:
                                              BorderRadius.circular(50),
                                        ),
                                        alignment: Alignment.center,
                                        child: Text("Follow",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: ThemeColor.white,
                                                fontFamily: 'abold',
                                                fontSize: 17.5)),
                                      ),
                              ),

                              ///
                              // (followersController.followersList[index].friends ==
                              //         true)
                              //     ? InkWell(
                              //         onTap: () {
                              //           FollowRequestServices().followRequestServices(
                              //               "${followersController.followersList[index].from!.id}");
                              //           print(
                              //               "${followersController.followersList[index].friends}");
                              //           setState(() {
                              //             print("++++++++++");
                              //           });
                              //         },
                              //         child: Container(
                              //           height: 36,
                              //           width: 95,
                              //           decoration: BoxDecoration(
                              //             color: ThemeColor.gre_alpha_20,
                              //             borderRadius: BorderRadius.circular(50),
                              //           ),
                              //           alignment: Alignment.center,
                              //           child: Text("Friends",
                              //               style: TextStyle(
                              //                 color: ThemeColor.graylight,
                              //                 fontSize: 17.5,
                              //                 fontFamily: 'abold',
                              //               )),
                              //         ),
                              //       )
                              //     : InkWell(
                              //         onTap: () {
                              //           setState(() {
                              //             print("88888");
                              //             FollowRequestServices()
                              //                 .followRequestServices(
                              //                     "${followersController.followersList[index].from?.id}");
                              //             print(
                              //                 "${followersController.followersList[index].friends}");
                              //             setState(() {
                              //               print("++++++++++");
                              //             });
                              //           });
                              //         },
                              //         child: Container(
                              //           height: 36,
                              //           width: 95,
                              //           decoration: BoxDecoration(
                              //             color: ThemeColor.pink,
                              //             borderRadius: BorderRadius.circular(50),
                              //           ),
                              //           alignment: Alignment.center,
                              //           child: Text("Follow",
                              //               textAlign: TextAlign.center,
                              //               style: TextStyle(
                              //                   color: ThemeColor.white,
                              //                   fontFamily: 'abold',
                              //                   fontSize: 17.5)),
                              //         ),
                              //       ),
                            ],
                          ),
                        ),
                      );
                    },
                  )
                : (followersController.isNoData.value)
                    ? Center(
                        child: Image.asset(
                          AppImages.nodataImage,
                          height: 200,
                          width: 200,
                        ),
                      )
                    : shimmer()),
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
