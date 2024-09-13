import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rayzi/app/API_Services/app_url.dart';
import 'package:rayzi/app/data/AppImages.dart';
import 'package:rayzi/app/data/Colors.dart';
import 'package:shimmer/shimmer.dart';

import '../controllers/BlockedUserController.dart';

class BlockedUsers extends StatefulWidget {
  const BlockedUsers({Key? key}) : super(key: key);

  @override
  State<BlockedUsers> createState() => _BlockedUsersState();
}

BlockedUserController blockedController = Get.put(BlockedUserController());

class _BlockedUsersState extends State<BlockedUsers> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  onTap: () => Get.back(),
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
                  "Blocked Users",
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
            () => (blockedController.isLoading.value)
                ? shimmer()
                : (blockedController.blockUserListModel!.block!.isEmpty)
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
                            separatorBuilder: (context, index) {
                              return const SizedBox(
                                height: 10,
                              );
                            },
                            itemCount: blockedController
                                .blockUserListModel!.block!.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return Container(
                                height: 70,
                                padding:
                                    const EdgeInsets.only(left: 15, right: 15),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    CircleAvatar(
                                      radius: 26,
                                      backgroundColor: ThemeColor.pink,
                                      child: CircleAvatar(
                                        radius: 24.6,
                                        backgroundColor: Colors.grey,
                                        backgroundImage: (blockedController
                                                    .blockUserListModel!
                                                    .block![index]
                                                    .isFake ==
                                                true)
                                            ? NetworkImage(
                                                "${blockedController.blockUserListModel!.block![index].profileImage}")
                                            : NetworkImage(blockedController
                                                .blockUserListModel!
                                                .block![index]
                                                .profileImage
                                                .toString()),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 7,
                                    ),
                                    Text(
                                      blockedController.blockUserListModel!
                                          .block![index].name
                                          .toString(),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontFamily: 'amidum',
                                          fontSize: 18,
                                          color: ThemeColor.blackback),
                                    ),
                                    const Spacer(),
                                    GestureDetector(
                                      onTap: () {
                                        Get.bottomSheet(unblocsheet(index));
                                      },
                                      child: Container(
                                        height: 35,
                                        width: 100,
                                        decoration: BoxDecoration(
                                          color: ThemeColor.pink,
                                          borderRadius:
                                              BorderRadius.circular(50),
                                        ),
                                        alignment: Alignment.center,
                                        child: Text(
                                          "Unblock",
                                          style: TextStyle(
                                              fontFamily: 'abold',
                                              color: ThemeColor.white,
                                              fontSize: 15.5),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ),
          )
        ],
      )),
    );
  }

  Container unblocsheet(int index) {
    return Container(
      height: 260,
      decoration: BoxDecoration(
        color: ThemeColor.white,
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(16),
          topLeft: Radius.circular(16),
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
            width: 45,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: Colors.grey,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Text(
            "Unblock this person?",
            style: TextStyle(
              fontFamily: 'abold',
              fontSize: 22,
              color: ThemeColor.blackback,
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(left: 6, right: 6),
            child: GestureDetector(
              onTap: () {
                blockedController.blockRequest(
                    blockUser: blockedController
                        .blockUserListModel!.block![index].to
                        .toString());
              },
              child: Container(
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: ThemeColor.pink,
                ),
                alignment: Alignment.center,
                child: Text(
                  "Unblock",
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
            height: 20,
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
                    border: Border.all(
                        color: ThemeColor.greAlpha20.withOpacity(0.3))),
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
          const SizedBox(
            height: 20,
          ),
        ],
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
