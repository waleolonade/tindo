import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rayzi/app/API_Services/app_url.dart';
import 'package:rayzi/app/data/AppImages.dart';
import 'package:rayzi/app/data/Colors.dart';
import 'package:rayzi/app/modules/My_App/views/my_app_view.dart';
import 'package:rayzi/app/modules/home/controllers/NotificationController.dart';
import 'package:shimmer/shimmer.dart';

import '../../../data/APP_variables/AppVariable.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  NotificationScreenController controller =
      Get.put(NotificationScreenController());

  @override
  void initState() {
    NotificationScreenController().notificationData();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (notificationVisit.value == true) {
          Get.offAll(const MyApp());
        } else {
          Get.back();
        }
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 1,
          title: const Text(
            "Notifications",
            style: TextStyle(
                color: Colors.black, fontSize: 20, fontFamily: "abold"),
          ),
          backgroundColor: Colors.white,
          leading: IconButton(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onPressed: () {
              if (notificationVisit.value == true) {
                Get.offAll(const MyApp());
              } else {
                Get.back();
              }
            },
            icon: const Icon(Icons.arrow_back_outlined, color: Colors.black),
          ),
          actions: [
            SizedBox(
              height: 30,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      controller.deleteNotification();
                    },
                    child: Text("Clear all",
                        style: TextStyle(
                            color: ThemeColor.pink,
                            fontSize: 14,
                            fontFamily: "amidum")),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                ],
              ),
            ),
          ],
        ),
        body: Obx(
          () => (controller.isloding.value)
              ? shimmer()
              : (controller.isDataNull.value)
                  ? Center(
                      child: Image.asset(
                        AppImages.nodataImage,
                        height: 200,
                        width: 200,
                      ),
                    )
                  : NotificationListener<OverscrollIndicatorNotification>(
                      onNotification: (overscroll) {
                        overscroll.disallowIndicator();
                        return false;
                      },
                      child: ListView.separated(
                        shrinkWrap: true,
                        itemCount:
                            controller.notificationModel!.notification!.length,
                        padding: const EdgeInsets.only(top: 10, bottom: 20),
                        separatorBuilder: (context, index) {
                          return const SizedBox(
                            height: 25,
                          );
                        },
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(left: 15, right: 15),
                            child: GestureDetector(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  CircleAvatar(
                                    radius: 23,
                                    backgroundColor: ThemeColor.grayIcon,
                                    backgroundImage: NetworkImage(
                                      "${controller.notificationModel!.notification![index].profileImage}",
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  SizedBox(
                                    width: 160,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${controller.notificationModel!.notification![index].name}",
                                          style: TextStyle(
                                            fontFamily: 'amidum',
                                            fontSize: 16.5,
                                            color: ThemeColor.blackback,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 2,
                                        ),
                                        subTitle(index)
                                      ],
                                    ),
                                  ),
                                  const Spacer(),
                                  suffix(index),
                                ],
                              ),
                            ),
                          );
                        },
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

  Widget suffix(int index) {
    return GetBuilder<NotificationScreenController>(
      builder: (controller) => (controller
                      .notificationModel!.notification![index].type ==
                  0 &&
              controller.notificationModel!.notification![index].friends ==
                  true)
          ? GestureDetector(
              onTap: () {
                controller.followRequest(index);
              },
              child: Container(
                height: 32,
                width: 88,
                decoration: BoxDecoration(
                  color: ThemeColor.greAlpha20,
                  borderRadius: BorderRadius.circular(50),
                ),
                alignment: Alignment.center,
                child: Text("Friends",
                    style: TextStyle(
                      color: ThemeColor.graylight,
                      fontSize: 14,
                      fontFamily: 'abold',
                    )),
              ),
            )
          : (controller.notificationModel!.notification![index].type == 0 &&
                  controller.notificationModel!.notification![index].friends ==
                      false)
              ? GestureDetector(
                  onTap: () {
                    controller.followRequest(index);
                  },
                  child: Container(
                    height: 32,
                    width: 88,
                    decoration: BoxDecoration(
                      color: ThemeColor.pink,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    alignment: Alignment.center,
                    child: Text("Follow",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: ThemeColor.white,
                            fontFamily: 'abold',
                            fontSize: 14)),
                  ),
                )
              : (controller.notificationModel!.notification![index].type == 1 ||
                      controller.notificationModel!.notification![index].type ==
                          3)
                  ? Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        color: ThemeColor.pink.withOpacity(0.4),
                        image: DecorationImage(
                            image: NetworkImage(
                                "${controller.notificationModel!.notification![index].postImage}"),
                            fit: BoxFit.cover),
                      ),
                    )
                  : (controller.notificationModel!.notification![index].type ==
                          2)
                      ? Container(
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(
                                    "${Constant.BASE_URL}${controller.notificationModel!.notification![index].giftImage}"),
                                fit: BoxFit.cover),
                          ),
                        )
                      : (controller.notificationModel!.notification![index]
                                  .type ==
                              4)
                          ? Container(
                              height: 60,
                              width: 60,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(
                                        "${controller.notificationModel!.notification![index].image}"),
                                    fit: BoxFit.cover),
                              ),
                            )
                          : const Text(""),
    );
  }

  Text subTitle(int index) {
    return Text(
      (controller.notificationModel!.notification![index].type == 0 &&
              controller.notificationModel!.notification![index].friends ==
                  true)
          ? "${controller.notificationModel!.notification![index].name} follow you"
          : (controller.notificationModel!.notification![index].type == 0 &&
                  controller.notificationModel!.notification![index].friends ==
                      false)
              ? "You following ${controller.notificationModel!.notification![index].name}"
              : (controller.notificationModel!.notification![index].type == 1)
                  ? "${controller.notificationModel!.notification![index].name} like your Post"
                  : (controller.notificationModel!.notification![index].type ==
                          2)
                      ? "${controller.notificationModel!.notification![index].name} set gift"
                      : (controller.notificationModel!.notification![index]
                                  .type ==
                              3)
                          ? "${controller.notificationModel!.notification![index].name} Comment your Post"
                          : (controller.notificationModel!.notification![index]
                                      .type ==
                                  4)
                              ? "${controller.notificationModel!.notification![index].message}"
                              : "",
      style: TextStyle(
          color: ThemeColor.grayIcon, fontSize: 12, fontFamily: "alight"),
    );
  }
}
