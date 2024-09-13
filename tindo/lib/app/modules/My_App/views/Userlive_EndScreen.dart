import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rayzi/app/data/APP_variables/AppVariable.dart';
import 'package:rayzi/app/data/Colors.dart';
import 'package:rayzi/app/modules/My_App/controllers/Userlive_EndController.dart';
import 'package:rayzi/app/modules/My_App/views/my_app_view.dart';

class UerLiveEndScreen extends StatefulWidget {
  final String liveStreamingID;
  final String totalDuration;
  const UerLiveEndScreen(
      {Key? key, required this.liveStreamingID, required this.totalDuration})
      : super(key: key);

  @override
  State<UerLiveEndScreen> createState() => _UerLiveEndScreenState();
}

class _UerLiveEndScreenState extends State<UerLiveEndScreen> {
  UserLiveEndController userliveEndController =
      Get.put(UserLiveEndController());
  @override
  void initState() {
    // TODO: implement initState
    userliveEndController.userliveEnd(liveStreamingID: widget.liveStreamingID);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.offAll(const MyApp());
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Obx(
          () => (userliveEndController.isLoding.value)
              ? Center(
                  child: CircularProgressIndicator(color: ThemeColor.pink),
                )
              : Container(
                  height: Get.height,
                  width: Get.width,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(
                            "${userliveEndController.historyModel!.liveStreaming!.coverImage}"),
                        opacity: 0.4,
                        fit: BoxFit.cover),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Live show ended",
                        style: TextStyle(
                            fontSize: 18,
                            color: ThemeColor.white,
                            fontFamily: 'abold'),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Container(
                        height: 93,
                        width: 93,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: ThemeColor.white,
                            image: DecorationImage(
                                image: NetworkImage(
                                    '${userliveEndController.historyModel!.liveStreaming!.profileImage}'),
                                fit: BoxFit.cover),
                            border:
                                Border.all(color: ThemeColor.white, width: 2)),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        userName,
                        style: TextStyle(
                            fontSize: 15,
                            color: ThemeColor.white,
                            fontFamily: 'abold'),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      SizedBox(
                        height: 80,
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  Text(
                                    '${userliveEndController.historyModel!.liveStreaming!.userView}',
                                    style: TextStyle(
                                      fontFamily: 'abold',
                                      color: ThemeColor.white,
                                      fontSize: 17,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 3,
                                  ),
                                  Text(
                                    'Joined Users',
                                    style: TextStyle(
                                      fontFamily: 'alight',
                                      color: ThemeColor.colorGrey2,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  Text(
                                    widget.totalDuration,
                                    style: TextStyle(
                                      fontFamily: 'abold',
                                      color: ThemeColor.white,
                                      fontSize: 17,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 3,
                                  ),
                                  Text(
                                    'Live Duration',
                                    style: TextStyle(
                                      fontFamily: 'alight',
                                      color: ThemeColor.offwhite,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  Text(
                                    '${userliveEndController.historyModel!.liveStreaming!.gift}',
                                    style: TextStyle(
                                      fontFamily: 'abold',
                                      color: ThemeColor.white,
                                      fontSize: 17,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 3,
                                  ),
                                  Text(
                                    'Received Gifts',
                                    style: TextStyle(
                                      fontFamily: 'alight',
                                      color: ThemeColor.offwhite,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(),
                      SizedBox(
                        height: 80,
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  Text(
                                    '${userliveEndController.historyModel!.liveStreaming!.comment}',
                                    style: TextStyle(
                                      fontFamily: 'abold',
                                      color: ThemeColor.white,
                                      fontSize: 17,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 3,
                                  ),
                                  Text(
                                    'Comments',
                                    style: TextStyle(
                                      fontFamily: 'alight',
                                      color: ThemeColor.offwhite,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // Expanded(
                            //   child: Container(
                            //     child: Column(
                            //       children: [
                            //         Text(
                            //           '+12',
                            //           style: TextStyle(
                            //             fontFamily: 'abold',
                            //             color: ThemeColor.white,
                            //             fontSize: 17,
                            //           ),
                            //         ),
                            //         SizedBox(
                            //           height: 3,
                            //         ),
                            //         Text(
                            //           'Increased',
                            //           style: TextStyle(
                            //             fontFamily: 'alight',
                            //             color: ThemeColor.offwhite,
                            //             fontSize: 14,
                            //           ),
                            //         ),
                            //         Text(
                            //           'Fans',
                            //           style: TextStyle(
                            //             fontFamily: 'alight',
                            //             color: ThemeColor.offwhite,
                            //             fontSize: 14,
                            //           ),
                            //         ),
                            //       ],
                            //     ),
                            //   ),
                            // ),
                            Expanded(
                              child: Column(
                                children: [
                                  Text(
                                    '+${userliveEndController.historyModel!.liveStreaming!.diamond}',
                                    style: TextStyle(
                                      fontFamily: 'abold',
                                      color: ThemeColor.white,
                                      fontSize: 17,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 3,
                                  ),
                                  Text(
                                    'diamond',
                                    style: TextStyle(
                                      fontFamily: 'alight',
                                      color: ThemeColor.offwhite,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 60, right: 60),
                        child: GestureDetector(
                          onTap: () => Get.offAll(const MyApp()),
                          child: Container(
                            height: 50,
                            width: Get.width,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: ThemeColor.offwhite, width: 1.3),
                              borderRadius: BorderRadius.circular(100),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              "Back to the homepage",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: "amidum",
                                  color: ThemeColor.white),
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
}
