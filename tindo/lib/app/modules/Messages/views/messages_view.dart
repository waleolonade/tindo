import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rayzi/app/API_Services/app_url.dart';
import 'package:rayzi/app/data/APP_variables/AppVariable.dart';
import 'package:rayzi/app/data/AppImages.dart';
import 'package:rayzi/app/data/Colors.dart';
import 'package:rayzi/app/modules/Messages/controllers/messages_controller.dart';
import 'package:rayzi/app/modules/Messages/views/FakeMessage.dart';
import 'package:shimmer/shimmer.dart';
import 'Message_Show.dart';

class MessagesView extends StatefulWidget {
  const MessagesView({Key? key}) : super(key: key);

  @override
  State<MessagesView> createState() => _MessagesViewState();
}

class _MessagesViewState extends State<MessagesView> {
  MessagesController messagesController = Get.put(MessagesController());

  Future<void> onRefresh() async {
    messagesController.chatThumbList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Messages",
          style: TextStyle(fontFamily: 'alight', fontSize: 22, color: ThemeColor.pink, fontWeight: FontWeight.w800),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Obx(
        () => (messagesController.isLoading.value)
            ? buildShimmer
            : (messagesController.chatListModel!.chatList!.isEmpty)
                ? RefreshIndicator(
                    color: ThemeColor.pink,
                    onRefresh: () {
                      return Future(() => onRefresh());
                    },
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: SizedBox(
                        height: 600,
                        child: Center(
                          child: Image.asset(
                            AppImages.nodataImage,
                            height: 200,
                            width: 200,
                          ),
                        ),
                      ),
                    ),
                  )
                : NotificationListener<OverscrollIndicatorNotification>(
                    onNotification: (overscroll) {
                      overscroll.disallowIndicator();
                      return false;
                    },
                    child: ListView.separated(
                      shrinkWrap: true,
                      itemCount: messagesController.chatListModel!.chatList!.length,
                      separatorBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 7,
                              ),
                              Divider(
                                color: ThemeColor.graylight.withOpacity(0.3),
                                thickness: 0.8,
                              ),
                              const SizedBox(
                                height: 7,
                              ),
                            ],
                          ),
                        );
                      },
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.only(
                          left: 20,
                          right: 20,
                        ),
                        child: InkWell(
                          highlightColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          onTap: () {
                            if (messagesController.chatListModel!.chatList![index].isFake == true) {
                              Get.to(()=>FakeMessageShow(
                                images: "${messagesController.chatListModel!.chatList![index].profileImage}",
                                // "${Constant.BASE_URL}${controller.chatListModel!.chatList![index].profileImage}",
                                name: "${messagesController.chatListModel!.chatList![index].name}",
                                userId: '${messagesController.chatListModel!.chatList![index].userId}',
                                videoUrl: '${Constant.BASE_URL}${messagesController.chatListModel!.chatList![index].video}',
                              ));
                            } else {
                              Get.to(()=>MessageShow(
                                images: "${messagesController.chatListModel!.chatList![index].profileImage}",
                                name: "${messagesController.chatListModel!.chatList![index].name}",
                                userId2: '${messagesController.chatListModel!.chatList![index].userId}',
                                senderId: userID,
                                chatRoomId: "${messagesController.chatListModel!.chatList![index].topic}",
                              ));
                            }
                          },
                          child: SizedBox(
                            height: 62,
                            child: Stack(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    CircleAvatar(
                                      radius: 30,
                                      backgroundColor: ThemeColor.graylight,
                                      child: Container(
                                        height: 56,
                                        width: 56,
                                        clipBehavior: Clip.hardEdge,
                                        decoration: const BoxDecoration(shape: BoxShape.circle),
                                        child: CachedNetworkImage(
                                            placeholder: (context, url) =>
                                                Image.asset(AppImages.profileImagePlaceHolder, fit: BoxFit.cover),
                                            fit: BoxFit.cover,
                                            imageUrl: "${messagesController.chatListModel!.chatList![index].profileImage}"),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              "${messagesController.chatListModel!.chatList![index].name}",
                                              style: TextStyle(
                                                fontFamily: 'abold',
                                                fontSize: 16.5,
                                                //color: theme_Color.white,
                                                color: ThemeColor.blackback,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          (messagesController.chatListModel!.chatList![index].messageType == 1)
                                              ? "🎁  Gift"
                                              : "${messagesController.chatListModel!.chatList![index].message}",
                                          style: TextStyle(
                                              fontFamily: 'alight',
                                              fontSize: 12.5,
                                              //color: theme_Color.white,
                                              color: ThemeColor.blacklight),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Positioned(
                                    top: 5,
                                    right: 0,
                                    child: Text(
                                      "${messagesController.chatListModel!.chatList![index].time}",
                                      style: TextStyle(
                                          fontFamily: 'alight',
                                          fontSize: 10,
                                          color: ThemeColor.blacklight,
                                          fontWeight: FontWeight.w300),
                                    )),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
      ),
    );
  }

  Shimmer get buildShimmer {
    return Shimmer.fromColors(
      baseColor: ThemeColor.shimmerBaseColor,
      highlightColor: ThemeColor.shimmerHighlight,
      child: ListView.builder(
        shrinkWrap: true,
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: 10,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            decoration: BoxDecoration(color: Colors.red.withOpacity(0.20), borderRadius: BorderRadius.circular(10)),
            height: 80,
            child: Row(
              children: [
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1.5),
                    shape: BoxShape.circle,
                    color: Colors.red,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 17, left: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 15,
                        width: Get.width * 0.35,
                        decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(15)),
                      ).paddingOnly(bottom: 8, top: 4),
                      Container(
                        height: 8,
                        width: Get.width * 0.55,
                        decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(15)),
                      ).paddingOnly(bottom: 3),
                      Container(
                        height: 8,
                        width: Get.width * 0.25,
                        decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(15)),
                      )
                    ],
                  ),
                )
              ],
            ).paddingOnly(left: 15),
          ).paddingSymmetric(horizontal: 15, vertical: 7);
        },
      ),
    );
  }
}
