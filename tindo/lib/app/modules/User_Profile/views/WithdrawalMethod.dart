// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:rayzi/app/API_Services/app_url.dart';
// import 'package:rayzi/app/WebPages/contactSupportWeb.dart';
// import 'package:rayzi/app/WebPages/howToWithdrawWeb.dart';
// import 'package:rayzi/app/data/Colors.dart';
//
// import '../controllers/WithdrawalController.dart';
// import 'WithdrawalDetails.dart';
//
// class WithdrawalMethod extends StatefulWidget {
//   final int diamond;
//   const WithdrawalMethod({Key? key, required this.diamond}) : super(key: key);
//
//   @override
//   State<WithdrawalMethod> createState() => _WithdrawalMethodState();
// }
//
// class _WithdrawalMethodState extends State<WithdrawalMethod> {
//   WithdrawalController withdrawalController = Get.put(WithdrawalController());
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Obx(
//           () => (withdrawalController.isLoading.value)
//               ? Center(
//                   child: CircularProgressIndicator(
//                     color: ThemeColor.pink,
//                   ),
//                 )
//               : Column(
//                   children: [
//                     Container(
//                       height: 50,
//                       color: Colors.white,
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: [
//                           const SizedBox(
//                             width: 15,
//                           ),
//                           GestureDetector(
//                             onTap: () => Get.back(),
//                             child: ImageIcon(
//                               const AssetImage(
//                                 "Images/new_dis/back.png",
//                               ),
//                               size: 25,
//                               color: ThemeColor.blackback,
//                             ),
//                           ),
//                           const SizedBox(
//                             width: 26,
//                           ),
//                           Text(
//                             "Add withdrawal method",
//                             style: TextStyle(fontFamily: 'abold', fontSize: 22, color: ThemeColor.blackback),
//                           ),
//                           const Spacer(),
//                           GestureDetector(
//                             onTap: () {
//                               Get.bottomSheet(menusheet());
//                             },
//                             child: Icon(
//                               Icons.more_vert_outlined,
//                               size: 30,
//                               color: ThemeColor.grayIcon,
//                             ),
//                           ),
//                           const SizedBox(
//                             width: 15,
//                           ),
//                         ],
//                       ),
//                     ),
//                     Expanded(
//                       child: ListView.builder(
//                         padding: const EdgeInsets.only(top: 15),
//                         shrinkWrap: true,
//                         itemCount: withdrawalController.getWithdrawModel!.withdraw!.length,
//                         scrollDirection: Axis.vertical,
//                         itemBuilder: (context, index) {
//                           return GestureDetector(
//                             onTap: () {
//                               Get.to(WithdrawalDetails(
//                                 details: withdrawalController.getWithdrawModel!.withdraw![index].details,
//                                 paymentGateway: "${withdrawalController.getWithdrawModel!.withdraw![index].name}",
//                                 diamond: widget.diamond,
//                               ));
//                             },
//                             child: Container(
//                               width: Get.width,
//                               decoration: BoxDecoration(
//                                 color: ThemeColor.greAlpha20.withOpacity(0.1),
//                                 borderRadius: BorderRadius.circular(12),
//                               ),
//                               padding: const EdgeInsets.all(10),
//                               child: Column(
//                                 mainAxisAlignment: MainAxisAlignment.start,
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Container(
//                                     height: 65,
//                                     color: Colors.transparent,
//                                     child: Row(
//                                       mainAxisAlignment: MainAxisAlignment.start,
//                                       crossAxisAlignment: CrossAxisAlignment.center,
//                                       children: [
//                                         SizedBox(
//                                           height: 60,
//                                           child: Image.network(
//                                             "${Constant.BASE_URL}${withdrawalController.getWithdrawModel!.withdraw![index].image}",
//                                             fit: BoxFit.fill,
//                                           ),
//                                         ),
//                                         const Spacer(),
//                                         Container(
//                                           height: 30,
//                                           width: 55,
//                                           decoration: BoxDecoration(
//                                               borderRadius: BorderRadius.circular(100),
//                                               color: ThemeColor.white,
//                                               border: Border.all(color: ThemeColor.greAlpha20.withOpacity(0.25), width: 1)),
//                                           alignment: Alignment.center,
//                                           child: Text("Add",
//                                               style: TextStyle(color: ThemeColor.blackback, fontSize: 15, fontFamily: 'abold')),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                   ListView.builder(
//                                     shrinkWrap: true,
//                                     physics: const NeverScrollableScrollPhysics(),
//                                     itemCount: withdrawalController.getWithdrawModel!.withdraw![index].details!.length,
//                                     itemBuilder: (context, index) {
//                                       return Text(
//                                         "•  ${withdrawalController.getWithdrawModel!.withdraw![0].details![index]}",
//                                         style: const TextStyle(
//                                           fontFamily: 'alight',
//                                           fontSize: 14.5,
//                                           color: Colors.black,
//                                         ),
//                                       );
//                                     },
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           );
//                         },
//                       ).paddingSymmetric(horizontal: 12),
//                     )
//                   ],
//                 ),
//         ),
//       ),
//     );
//   }
//
//   Container menusheet() {
//     return Container(
//       height: 155,
//       decoration: BoxDecoration(
//         color: ThemeColor.white,
//         borderRadius: const BorderRadius.only(
//           topRight: Radius.circular(14),
//           topLeft: Radius.circular(14),
//         ),
//       ),
//       alignment: Alignment.center,
//       padding: const EdgeInsets.only(left: 15, right: 15),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           const SizedBox(
//             height: 8,
//           ),
//           Container(
//             height: 6.5,
//             width: 55,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(50),
//               color: ThemeColor.pink,
//             ),
//           ),
//           const SizedBox(
//             height: 15,
//           ),
//           SizedBox(
//             height: 55,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.start,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Image.asset(
//                   "Images/User_Profile/information.png",
//                   height: 25,
//                   width: 25,
//                   color: ThemeColor.blackback,
//                 ),
//                 const SizedBox(
//                   width: 25,
//                 ),
//                 GestureDetector(
//                   onTap: () => Get.to(() => const HowToWithdrawWeb()),
//                   child: Text(
//                     "how to withdraw earnings",
//                     style: TextStyle(
//                       color: ThemeColor.blackback,
//                       fontSize: 20,
//                       fontFamily: 'amidum',
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           SizedBox(
//             height: 55,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.start,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Image.asset(
//                   "Images/User_Profile/rubber-ring.png",
//                   height: 25,
//                   width: 25,
//                   color: ThemeColor.blackback,
//                 ),
//                 const SizedBox(
//                   width: 20,
//                 ),
//                 GestureDetector(
//                   onTap: () => Get.to(() => const ContactSupportWeb()),
//                   child: Text(
//                     "Contact Support",
//                     style: TextStyle(
//                       color: ThemeColor.blackback,
//                       fontSize: 20,
//                       fontFamily: 'amidum',
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           const SizedBox(
//             height: 15,
//           ),
//         ],
//       ),
//     );
//   }
// }
