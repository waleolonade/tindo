import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:rayzi/app/data/Colors.dart';
import 'package:rayzi/app/modules/Splash_Screen/controllers/LocationController.dart';
import 'package:shimmer/shimmer.dart';

import '../controllers/QuickLogincontrooler.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({Key? key}) : super(key: key);

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  QuickLoginController quickLoginController = Get.put(QuickLoginController());

  LocationController locationController = Get.put(LocationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: Text("Countries and regions",
            style: TextStyle(
              fontFamily: 'abold',
              fontSize: 18,
              color: ThemeColor.blackback,
            )),
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
                  color: ThemeColor.blackback,
                  size: 26,
                ))
          ],
        ),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          // Padding(
          //   padding: const EdgeInsets.only(left: 15, right: 15),
          //   child: SizedBox(
          //     height: 50,
          //     child: TextFormField(
          //       decoration: InputDecoration(
          //         border: OutlineInputBorder(
          //             borderRadius: BorderRadius.circular(100),
          //             borderSide: BorderSide.none),
          //         focusedBorder: OutlineInputBorder(
          //             borderRadius: BorderRadius.circular(100),
          //             borderSide: BorderSide.none),
          //         disabledBorder: OutlineInputBorder(
          //             borderRadius: BorderRadius.circular(100),
          //             borderSide: BorderSide.none),
          //         focusedErrorBorder: OutlineInputBorder(
          //             borderRadius: BorderRadius.circular(100),
          //             borderSide: BorderSide.none),
          //         filled: true,
          //         fillColor: ThemeColor.gre_alpha_20.withOpacity(0.1),
          //         prefixIcon: Icon(
          //           Icons.search_outlined,
          //           color: ThemeColor.gray_icon,
          //         ),
          //         hintText: "Search country",
          //         hintStyle: TextStyle(
          //           color: ThemeColor.gray_icon,
          //           fontFamily: 'amidum',
          //           fontSize: 16,
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
          // SizedBox(
          //   height: 15,
          // ),
          Obx(
            () => Expanded(
              child: (locationController.isLoading.value)
                  ? shimmer()
                  : SizedBox(
                      child: ListView.separated(
                        itemCount: locationController.countryName.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.only(
                                bottom: 5, left: 20, top: 10),
                            child: GestureDetector(
                              onTap: () {
                                quickLoginController.locationController.text =
                                    locationController.countryName[index]
                                        .toString();
                                Get.back();
                              },
                              child: Row(
                                children: [
                                  Container(
                                    height: 25,
                                    width: 35,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(3),
                                    ),
                                    child: SvgPicture.network(
                                        locationController.flag[index]
                                            .toString(),
                                        fit: BoxFit.cover),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                    locationController.countryName[index]
                                                .toString()
                                                .length >
                                            35
                                        ? '${locationController.countryName[index].toString().substring(0, 35)}...'
                                        : locationController.countryName[index]
                                            .toString(),
                                    style: TextStyle(
                                        color: ThemeColor.blackback,
                                        fontSize: 16),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.only(
                              left: 18,
                              right: 25,
                            ),
                            child: Divider(
                              color: ThemeColor.greAlpha20.withOpacity(0.2),
                              thickness: 1,
                            ),
                          );
                        },
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Shimmer shimmer() {
    return Shimmer.fromColors(
      highlightColor: ThemeColor.textGray,
      baseColor: ThemeColor.grayIcon,
      child: ListView.separated(
        itemCount: 10,
        padding: const EdgeInsets.only(top: 15),
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 5, left: 20, top: 10),
            child: Row(
              children: [
                Container(
                  height: 25,
                  width: 35,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                const SizedBox(
                  height: 10,
                  width: 300,
                )
              ],
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.only(
              left: 18,
              right: 25,
            ),
            child: Divider(
              color: ThemeColor.greAlpha20.withOpacity(0.2),
              thickness: 1,
            ),
          );
        },
      ),
    );
  }
}
