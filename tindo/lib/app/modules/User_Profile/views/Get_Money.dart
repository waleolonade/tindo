// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:rayzi/app/WebPages/contactSupportWeb.dart';
import 'package:rayzi/app/WebPages/howToWithdrawWeb.dart';
import 'package:rayzi/app/data/APP_variables/AppVariable.dart';
import 'package:rayzi/app/data/AppImages.dart';
import 'package:rayzi/app/data/Colors.dart';
import 'package:rayzi/app/modules/My_App/views/Broadcast_Screen.dart';
import 'package:rayzi/app/modules/User_Profile/controllers/WithdrawalController.dart';
import 'package:rayzi/app/modules/User_Profile/views/WithdrawalDetails.dart';

class GetMoney extends StatelessWidget {
  GetMoney({super.key});
  WithdrawalController withdrawalController = Get.put(WithdrawalController());
  double minimumDollar = (withdrawLimit * 1) / plusdiamond;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Container(
            height: 60,
            width: Get.width,
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
                    size: 20,
                    color: ThemeColor.blackback,
                  ),
                ),
                const SizedBox(
                  width: 18,
                ),
                Text(
                  "Withdraw money",
                  style: TextStyle(fontFamily: 'AvenirNextLTPro-Demi', fontSize: 19, color: ThemeColor.blackback),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    Get.bottomSheet(menuSheet());
                  },
                  child: Icon(
                    Icons.more_vert_outlined,
                    size: 25,
                    color: ThemeColor.grayIcon,
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: userDiamond <= withdrawLimit
          ? GestureDetector(
              onTap: () => Get.to(() => const BroadCastScreen()),
              child: Container(
                height: 60,
                decoration: BoxDecoration(
                  color: ThemeColor.pink,
                  borderRadius: BorderRadius.circular(50),
                ),
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      "Images/Center_Tab/video-camera.png",
                      color: ThemeColor.white,
                      height: 25,
                      width: 25,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Go Live",
                      style: TextStyle(color: ThemeColor.white, fontFamily: 'abold', fontSize: 20),
                    )
                  ],
                ),
              ),
            ).paddingSymmetric(horizontal: 15, vertical: 5)
          : GestureDetector(
              onTap: () {
                if (userDiamond >= withdrawLimit) {
                  Get.to(() => const WithdrawalDetails())!.then((value) => withdrawalController.getWithdrawList());
                } else {
                  Fluttertoast.showToast(
                      msg: "You need more coins to withdraw!",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: ThemeColor.white,
                      textColor: ThemeColor.pink,
                      fontSize: 16.0);
                }
              },
              child: Container(
                height: 60,
                decoration: BoxDecoration(
                  color: ThemeColor.pink,
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(color: ThemeColor.greAlpha20.withOpacity(0.15), width: 1.5),
                ),
                child: Center(
                  child: Text("Withdraw now", style: TextStyle(fontFamily: 'abold', color: ThemeColor.white, fontSize: 18)),
                ),
              ),
            ).paddingSymmetric(horizontal: 15, vertical: 5),
      body: SafeArea(
          child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Container(
              height: 156,
              width: Get.width,
              decoration: BoxDecoration(
                image: const DecorationImage(image: AssetImage("Images/withdraw_backgroud.png"), fit: BoxFit.cover),
                color: Colors.purple,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "Available Diamond",
                        style: TextStyle(fontSize: 17, fontFamily: 'abold', color: ThemeColor.white),
                      ),
                      Text(
                        "$userDiamond",
                        style: TextStyle(fontSize: 36, fontFamily: 'abold', color: ThemeColor.white),
                      ),
                      Container(
                        height: 30,
                        width: 120,
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.30),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              AppImages.coinImages,
                              height: 17,
                            ).paddingOnly(bottom: 3, left: 3),
                            Text(
                              "$plusdiamond = \$1.00 ",
                              style: TextStyle(fontSize: 14.4, fontFamily: 'abold', color: ThemeColor.white),
                            ),
                          ],
                        ),
                      )
                    ],
                  ).paddingOnly(left: 22, top: 18, bottom: 15),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Image.asset(
                      AppImages.coinImages,
                      height: 100,
                    ).paddingOnly(right: 30),
                  )
                ],
              ),
            ).paddingSymmetric(vertical: 15),
            Container(
              height: 98,
              width: Get.width,
              decoration: BoxDecoration(
                color: const Color(0xffF7F6FF),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      Text(
                        "Only ",
                        style: TextStyle(color: ThemeColor.blackback, fontSize: 13, fontWeight: FontWeight.w500),
                      ),
                      Image.asset(
                        AppImages.coinImages,
                        height: 16,
                        width: 16,
                      ).paddingOnly(right: 6),
                      Text(
                        (userDiamond < withdrawLimit) ? " ${withdrawLimit - userDiamond} left to get" : "0 left to get",
                        style: TextStyle(color: ThemeColor.blackback, fontSize: 13, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  Text(
                    "\$$minimumDollar",
                    style: TextStyle(fontFamily: 'AvenirNextLTPro-Demi', color: ThemeColor.pink, fontSize: 25),
                  ),
                  Container(
                    height: 10,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: ThemeColor.white,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: LinearProgressIndicator(
                        backgroundColor: ThemeColor.white,
                        valueColor: const AlwaysStoppedAnimation<Color>(Colors.pink),
                        value: userDiamond / withdrawLimit,
                      ),
                    ),
                  ),
                ],
              ).paddingSymmetric(vertical: 8, horizontal: 15),
            ),
            Obx(
              () => withdrawalController.getWithdrawListLoading.value
                  ? Center(child: CircularProgressIndicator(color: ThemeColor.pink)).paddingOnly(top: 20)
                  : withdrawalController.withdrawList!.withdrawRequest!.isNotEmpty
                      ? Column(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Transaction History",
                                style: TextStyle(fontSize: 19, fontFamily: 'AvenirNextLTPro-Demi', color: ThemeColor.blackback),
                              ).paddingOnly(top: 20, bottom: 10),
                            ),
                            ListView.builder(
                              shrinkWrap: true,
                              itemCount: withdrawalController.withdrawList!.withdrawRequest!.length,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                var withdrawList = withdrawalController.withdrawList!.withdrawRequest![index];
                                double dollarAmount = withdrawList.diamond! / plusdiamond;
                                DateTime date = DateFormat("M/d/yyyy").parse(withdrawList.date.toString());
                                String convertedDate = DateFormat('MM/dd/yyyy hh:mm a').format(date);
                                return Container(
                                  height: 70,
                                  width: Get.width,
                                  decoration: BoxDecoration(
                                    color: ThemeColor.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.10),
                                        blurRadius: 10,
                                      ),
                                    ],
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        height: 42,
                                        width: 42,
                                        child: Image.asset(AppImages.coinImages),
                                      ).paddingSymmetric(horizontal: 12),
                                      Text(withdrawList.paymentGateway.toString(),
                                          style: TextStyle(
                                            fontFamily: 'AvenirNextLTPro-Demi',
                                            fontSize: 20,
                                            color: ThemeColor.blackback,
                                          )).paddingOnly(left: 6),
                                      const Spacer(),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Row(
                                            children: [
                                              Container(
                                                height: 23,
                                                decoration: BoxDecoration(
                                                  color: withdrawList.status == 0
                                                      ? const Color(0xffEFEFEF)
                                                      : withdrawList.status == 1
                                                          ? const Color(0xffDBFFC4)
                                                          : withdrawList.status == 2
                                                              ? const Color(0xffFFE9E9)
                                                              : null,
                                                  borderRadius: BorderRadius.circular(4),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    withdrawList.status == 0
                                                        ? "Pending"
                                                        : withdrawList.status == 1
                                                            ? "Approve"
                                                            : withdrawList.status == 2
                                                                ? "Decline"
                                                                : "",
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      fontFamily: 'abold',
                                                      color: withdrawList.status == 0
                                                          ? const Color(0xffAAAAAA)
                                                          : withdrawList.status == 1
                                                              ? const Color(0xff218F17)
                                                              : withdrawList.status == 2
                                                                  ? const Color(0xffFF2B2B)
                                                                  : null,
                                                      // color: Color(0xff218F17), green
                                                      // color: Color(0xffFF2B2B),red
                                                    ),
                                                  ).paddingSymmetric(horizontal: 14),
                                                ),
                                              ).paddingOnly(right: 10),
                                              Text(
                                                "\$ ${dollarAmount.toStringAsFixed(2)}",
                                                style: TextStyle(
                                                  fontSize: 17,
                                                  fontFamily: 'AvenirNextLTPro-Demi',
                                                  color: withdrawList.status == 0
                                                      ? const Color(0xffAAAAAA)
                                                      : withdrawList.status == 1
                                                          ? const Color(0xff218F17)
                                                          : withdrawList.status == 2
                                                              ? const Color(0xffFF2B2B)
                                                              : null,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Text(
                                            convertedDate,
                                            style: const TextStyle(
                                                fontSize: 11, fontFamily: 'AvenirNextLTPro-Demi', color: Colors.black),
                                          ),
                                        ],
                                      ).paddingOnly(right: 10),
                                    ],
                                  ).paddingSymmetric(vertical: 3),
                                ).paddingOnly(bottom: 10);
                              },
                            ),
                          ],
                        )
                      : const SizedBox.shrink(),
            ),
          ],
        ).paddingSymmetric(horizontal: 15),
      )),
    );
  }

  // Dialog withdrawalDialog() {
  //   return Dialog(
  //     shape: OutlineInputBorder(borderRadius: BorderRadius.circular(18), borderSide: BorderSide.none),
  //     child: StatefulBuilder(
  //       builder: (context, setState1) => Container(
  //         height: 300,
  //         decoration: BoxDecoration(
  //           color: ThemeColor.white,
  //           borderRadius: BorderRadius.circular(18),
  //         ),
  //         child: Column(
  //           mainAxisAlignment: MainAxisAlignment.start,
  //           crossAxisAlignment: CrossAxisAlignment.center,
  //           children: [
  //             const SizedBox(
  //               height: 15,
  //             ),
  //             Align(
  //               alignment: Alignment.center,
  //               child: Row(
  //                 mainAxisAlignment: MainAxisAlignment.center,
  //                 children: [
  //                   const Spacer(),
  //                   GestureDetector(
  //                     onTap: () {
  //                       Get.back();
  //                     },
  //                     child: Container(
  //                       height: 30,
  //                       width: 30,
  //                       decoration: BoxDecoration(
  //                         borderRadius: BorderRadius.circular(100),
  //                         color: ThemeColor.blackback.withOpacity(0.08),
  //                       ),
  //                       child: Icon(Icons.close, color: ThemeColor.blackback.withOpacity(0.8)),
  //                     ),
  //                   ),
  //                   const SizedBox(
  //                     width: 20,
  //                   ),
  //                 ],
  //               ),
  //             ),
  //             const SizedBox(
  //               height: 15,
  //             ),
  //             RichText(
  //               text: TextSpan(
  //                 children: [
  //                   TextSpan(
  //                     text: "Note :- ",
  //                     style: TextStyle(
  //                       fontSize: 18,
  //                       color: ThemeColor.pink,
  //                       fontWeight: FontWeight.w400,
  //                     ),
  //                   ),
  //                   TextSpan(
  //                     text: "Minimum $miniDoller\$ Withdraw",
  //                     style: TextStyle(
  //                       fontSize: 15,
  //                       color: ThemeColor.blackback,
  //                       fontWeight: FontWeight.w400,
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //             const SizedBox(
  //               height: 15,
  //             ),
  //             Container(
  //               padding: const EdgeInsets.only(left: 40, right: 40),
  //               height: 55,
  //               width: 280,
  //               decoration: BoxDecoration(
  //                 borderRadius: BorderRadius.circular(40),
  //                 color: Colors.grey.withOpacity(0.1),
  //               ),
  //               child: Row(
  //                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //                 children: [
  //                   SizedBox(
  //                     width: 70,
  //                     child: TextField(
  //                       maxLength: 6,
  //                       onChanged: (value) {
  //                         setState1(() {
  //                           calculateText(int.parse(value));
  //                         });
  //                       },
  //                       controller: coinController,
  //                       cursorColor: Colors.black,
  //                       style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
  //                       keyboardType: const TextInputType.numberWithOptions(decimal: true, signed: false),
  //                       decoration: const InputDecoration(border: InputBorder.none, counterText: ""),
  //                     ),
  //                   ),
  //                   Text(
  //                     "=",
  //                     style: TextStyle(
  //                       color: ThemeColor.pink,
  //                       fontWeight: FontWeight.w700,
  //                       fontSize: 20,
  //                     ),
  //                   ),
  //                   Text(
  //                     "\$ $autoCalculatedText",
  //                     style: TextStyle(color: ThemeColor.pinklight, fontWeight: FontWeight.bold, fontSize: 20),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //             const SizedBox(
  //               height: 10,
  //             ),
  //             // Text(
  //             //   "Coin to Withdraw",
  //             //   style: TextStyle(
  //             //     color: ThemeColor.pink,
  //             //     fontWeight: FontWeight.w500,
  //             //     fontSize: 20,
  //             //   ),
  //             // ),
  //             const SizedBox(
  //               height: 50,
  //             ),
  //             GestureDetector(
  //               onTap: () async {
  //                 if (coinController.text.isEmpty) {
  //                   Fluttertoast.showToast(
  //                     msg: "Please Enter your withdraw diamond...",
  //                     backgroundColor: Colors.white,
  //                     fontSize: 15,
  //                     textColor: ThemeColor.pink,
  //                     timeInSecForIosWeb: 4,
  //                   );
  //                 } else if (userDiamond < withdrawLimit) {
  //                   Fluttertoast.showToast(
  //                     msg: "No Enough diamond to withdraw",
  //                     backgroundColor: Colors.white,
  //                     fontSize: 15,
  //                     textColor: ThemeColor.pink,
  //                     timeInSecForIosWeb: 4,
  //                   );
  //                 } else if (int.parse(coinController.text) > userDiamond) {
  //                   Fluttertoast.showToast(
  //                     msg: "Withdraw diamond are more then\ntotal diamond!",
  //                     backgroundColor: ThemeColor.white,
  //                     fontSize: 15,
  //                     textColor: ThemeColor.pink,
  //                     timeInSecForIosWeb: 4,
  //                   );
  //                 } else {
  //                   Get.back();
  //                   // Get.to(WithdrawalDetails(
  //                   //   details: withdrawalController.getWithdrawModel!.withdraw![index].details,
  //                   //   paymentGateway: "${withdrawalController.getWithdrawModel!.withdraw![index].name}",
  //                   //   diamond: widget.diamond,
  //                   // ));
  //                   // Get.to(WithdrawalMethod(
  //                   //   diamond: int.parse(coinController.text),
  //                   // ));
  //                   Get.to(() => const WithdrawalDetails());
  //                 }
  //               },
  //               child: Padding(
  //                 padding: const EdgeInsets.only(left: 20, right: 20),
  //                 child: Container(
  //                   height: 50,
  //                   width: Get.width,
  //                   decoration: BoxDecoration(
  //                     color: ThemeColor.pink,
  //                     borderRadius: BorderRadius.circular(100),
  //                   ),
  //                   alignment: Alignment.center,
  //                   child: Text(
  //                     "Next",
  //                     style: TextStyle(color: ThemeColor.white, fontSize: 18, fontFamily: 'abold'),
  //                   ),
  //                 ),
  //               ),
  //             ),
  //             const SizedBox(
  //               height: 20,
  //             )
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }

  Container menuSheet() {
    return Container(
      height: 155,
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
              color: ThemeColor.pink,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          SizedBox(
            height: 55,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  "Images/User_Profile/information.png",
                  height: 25,
                  width: 25,
                  color: ThemeColor.blackback,
                ),
                const SizedBox(
                  width: 25,
                ),
                GestureDetector(
                  onTap: () => Get.to(() => const HowToWithdrawWeb()),
                  child: Text(
                    "how to withdraw earnings",
                    style: TextStyle(
                      color: ThemeColor.blackback,
                      fontSize: 20,
                      fontFamily: 'amidum',
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 55,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  "Images/User_Profile/rubber-ring.png",
                  height: 25,
                  width: 25,
                  color: ThemeColor.blackback,
                ),
                const SizedBox(
                  width: 20,
                ),
                GestureDetector(
                  onTap: () => Get.to(() => const ContactSupportWeb()),
                  child: Text(
                    "Contact Support",
                    style: TextStyle(
                      color: ThemeColor.blackback,
                      fontSize: 20,
                      fontFamily: 'amidum',
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }
}
