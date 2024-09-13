import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rayzi/app/data/Colors.dart';
import 'package:rayzi/app/modules/User_Profile/controllers/WithdrawalController.dart';

class WithdrawalDetails extends StatefulWidget {
  const WithdrawalDetails({
    Key? key,
  }) : super(key: key);

  @override
  State<WithdrawalDetails> createState() => _WithdrawalDetailsState();
}

class _WithdrawalDetailsState extends State<WithdrawalDetails> {
  FocusNode commonFocusnode = FocusNode();
  WithdrawalController withdrawalController = Get.put(WithdrawalController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: Get.height,
          width: Get.width,
          child: Obx(
            () => withdrawalController.isLoading.value
                ? Center(child: CircularProgressIndicator(color: ThemeColor.pink))
                : Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Enter your details",
                          style: TextStyle(
                            color: ThemeColor.blackback,
                            fontSize: 25,
                            fontFamily: "abold",
                          )).paddingOnly(bottom: 20),
                      Container(
                        width: Get.width,
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          border: Border.all(color: ThemeColor.pink, style: BorderStyle.solid, width: 0.80),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: Obx(
                            () => DropdownButton(
                              items: withdrawalController.dropdownValues
                                  .map((value) => DropdownMenuItem(
                                        value: value,
                                        child: Text(value, overflow: TextOverflow.ellipsis),
                                      ))
                                  .toList(),
                              onChanged: (value) {
                                withdrawalController.selectedValue.value = value.toString();
                              },
                              isExpanded: true,
                              value: withdrawalController.selectedValue.value,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 200,
                        alignment: Alignment.center,
                        child: TextField(
                          controller: withdrawalController.enterBankDetails,
                          maxLines: 8,
                          cursorColor: ThemeColor.blackback,
                          style: TextStyle(
                            fontFamily: 'amidum',
                            fontSize: 16,
                            color: ThemeColor.blackback,
                          ),
                          focusNode: commonFocusnode,
                          decoration: InputDecoration(
                            isDense: true,
                            filled: true,
                            fillColor: Colors.grey.withOpacity(0.1),
                            hintText: withdrawalController.getHintText(),
                            hintStyle: const TextStyle(
                              fontFamily: 'amidum',
                              fontSize: 16,
                            ),
                            disabledBorder:
                                OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: ThemeColor.pink)),
                            enabledBorder:
                                OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                          ),
                        ),
                      ).paddingOnly(top: 30, bottom: 10),
                      Text(
                        "* If all the information provided is accurate, then your withdrawal request has been approved.",
                        style: TextStyle(
                          color: ThemeColor.red,
                          fontWeight: FontWeight.w400,
                          fontSize: 15,
                        ),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          withdrawalController.withdrawal();
                        },
                        child: Container(
                          height: 60,
                          decoration: BoxDecoration(
                            color: ThemeColor.pink,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          alignment: Alignment.center,
                          child: Obx(
                            () => withdrawalController.withdrawalLoading.value
                                ? const Center(child: CircularProgressIndicator(color: Colors.white))
                                : Text(
                                    "Submit",
                                    style: TextStyle(color: ThemeColor.white, fontFamily: 'abold', fontSize: 20),
                                  ),
                          ),
                        ),
                      ),
                    ],
                  ).paddingSymmetric(horizontal: 15, vertical: 10),
          ),
        ),
      ),
    );
  }
}
