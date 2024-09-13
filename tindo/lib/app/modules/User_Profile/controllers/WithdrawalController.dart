import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:rayzi/app/API_Services/getwithdraw_service.dart';
import 'package:rayzi/app/API_Services/withdrawal_services.dart';
import 'package:rayzi/app/data/Colors.dart';

import '../../../API Models/get_withdraw_model.dart';
import '../../../API Models/get_withdraw_request_list.dart';
import '../../../API_Services/app_url.dart';
import '../../../data/APP_variables/AppVariable.dart';
import 'package:http/http.dart' as http;

class WithdrawalController extends GetxController {
  GetWithdrawModel? getWithdrawModel;
  GetWithdrawRequestList? withdrawList;
  RxBool isLoading = false.obs;
  RxBool withdrawalLoading = false.obs;
  RxBool getWithdrawListLoading = false.obs;
  @override

  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getWithdrawal();
    getWithdrawList();
  }

  final List dropdownValues = [];
  RxString selectedValue = "".obs;

  TextEditingController enterBankDetails = TextEditingController();

  Future getWithdrawal() async {
    try {
      isLoading.value = true;
      var data = await GetWithdrawService().getWithdrawService();
      getWithdrawModel = data;
      for (int i = 0; i < getWithdrawModel!.withdraw!.length; i++) {
        dropdownValues.add(getWithdrawModel!.withdraw![i].name.toString());
      }
      selectedValue.value = dropdownValues.isNotEmpty ? dropdownValues[0] : ""; // Set the selected value if the list is not empty

      // selectedValue.value = dropdownValues[0];
    } catch (e) {
      log("Get Withdrawal Error $e");
    } finally {
      isLoading.value = false;
    }
  }

  String getHintText() {
    // Find the selected withdrawal based on the selected value
    final selectedWithdraw = getWithdrawModel?.withdraw?.firstWhere(
      (withdraw) => withdraw.name == selectedValue.value,
    );

    // Return the details if found, otherwise return a default hint text
    return selectedWithdraw?.details ?? "Select an option from the dropdown";
  }

  Future withdrawal() async {
    try {
      withdrawalLoading(true);
      log("userID :: $userID");
      log("User diamond :: $userDiamond");
      log("enterBankDetails.text :: ${enterBankDetails.text}");
      log("v ${selectedValue.value}");
      if (enterBankDetails.text.isBlank != true) {
        var data = await WithdrawalServices()
            .withdrawalServices(paymentGateway: selectedValue.value, diamond: userDiamond, details: enterBankDetails.text);
        if (data!.status == true) {
          Fluttertoast.showToast(
              msg: "Request sent successfully!",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: ThemeColor.pink,
              textColor: ThemeColor.white,
              fontSize: 16.0);
          Get.back();
        } else {
          Get.back();
          Fluttertoast.showToast(
              msg: "${data.message}",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: ThemeColor.pink,
              textColor: ThemeColor.white,
              fontSize: 16.0);
        }
      } else {
        Fluttertoast.showToast(
            msg: "Enter your $selectedValue details!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: ThemeColor.pink,
            textColor: ThemeColor.white,
            fontSize: 16.0);
      }
    } catch (e) {
      Fluttertoast.showToast(
          msg: "$e",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: ThemeColor.pink,
          textColor: ThemeColor.white,
          fontSize: 16.0);
    } finally {
      withdrawalLoading(false);
    }
  }

  Future getWithdrawList() async {
    try {
      getWithdrawListLoading(true);
      String uri = Constant.getDomainFromURL(Constant.BASE_URL);
      final params = {"userId": userID};
      var url = Uri.https(uri, Constant.getWithdrawList, params);
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          "key": Constant.SECRET_KEY,
        },
      );
      log("Response body getWithdrawList ::  ${response.body}");
      if (response.statusCode == 200) {
        var data = await jsonDecode(response.body);
        withdrawList = GetWithdrawRequestList.fromJson(data);
      } else {
        log("Withdrawal States Code :- ${response.statusCode}");
      }
      return null;
    } catch (e) {
      log("$e");
    } finally {
      getWithdrawListLoading(false);
    }
  }
}
