import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;
import '../API Models/stripe_pay_model.dart';
import '../API Models/success_purchase_model.dart';
import '../API_Services/success_purchas_service.dart';
import '../data/APP_variables/AppVariable.dart';
import '../data/APP_variables/payment_releted.dart';
import '../data/Colors.dart';

// class StripeService {
//   Map<String, dynamic>? paymentIntentData;
//
//   Future<void> makePayment({
//     required String amount,
//     required String currency,
//     required String coinPlanId,
//     required int coins,
//   }) async {
//     try {
//       debugPrint("Start Payment");
//       paymentIntentData = await createPaymentIntent(amount, currency);
//
//       debugPrint("After payment intent");
//       print(paymentIntentData);
//       if (paymentIntentData != null) {
//         debugPrint(" payment intent is not null .........");
//         await Stripe.instance.initPaymentSheet(
//             paymentSheetParameters: SetupPaymentSheetParameters(
//           customFlow: true,
//           merchantDisplayName: 'Prospects',
//           customerId: paymentIntentData!['customer'],
//           paymentIntentClientSecret: paymentIntentData!['client_secret'],
//           // applePay: const PaymentSheetApplePay(merchantCountryCode: '+92'),
//           googlePay: const PaymentSheetGooglePay(merchantCountryCode: '+91', testEnv: true),
//           style: ThemeMode.dark,
//         ));
//         displayPaymentSheet(coinPlanId, coins);
//       }
//     } catch (e, s) {
//       debugPrint("After payment intent Error: ${e.toString()}");
//       debugPrint("After payment intent s Error: ${s.toString()}");
//     }
//   }
//
//   displayPaymentSheet(String coinPlanId, int coins) async {
//     try {
//       await Stripe.instance.presentPaymentSheet();
//       // ToastMessage.success('Payment Successful');
//       updateUserPlan(coinPlanId, coins);
//     } on Exception catch (e) {
//       if (e is StripeException) {
//         debugPrint("Error from Stripe: ${e.error.localizedMessage}");
//       } else {
//         debugPrint("Unforcen Error: $e");
//       }
//     } catch (e) {
//       debugPrint("Exception $e");
//     }
//   }
//
//   createPaymentIntent(String amount, String currency) async {
//     try {
//       Map<String, dynamic> body = {
//         'amount': calculate(amount),
//         'currency': currency,
//         'payment_method_types[]': 'card',
//       };
//
//       debugPrint("Start Payment Intent http rwq post method");
//
//       var response = await http.post(Uri.parse("https://api.stripe.com/v1/payment_intents"), body: body, headers: {
//         "Authorization": "Bearer $stripSecrateKey",
//         "Content-Type": 'application/x-www-form-urlencoded'
//       });
//       debugPrint("End Payment Intent http rwq post method");
//       debugPrint(response.body.toString());
//
//       return jsonDecode(response.body);
//     } catch (e) {
//       debugPrint('err charging user: ${e.toString()}');
//     }
//   }
//
//   calculate(String amount) {
//     final a = (int.parse(amount)) * 100;
//     return a.toString();
//   }
//
//   updateUserPlan(
//     String coinPlanId,
//     int coins,
//   ) async {
//     Fluttertoast.showToast(
//       msg: "Payment Successfully",
//       backgroundColor: ThemeColor.pink,
//       fontSize: 15,
//       textColor: Colors.white,
//       timeInSecForIosWeb: 4,
//     );
//     userCoins.value = userCoins.value + coins;
//     SuccessPurchasService().successPurchas(coinPlanId: coinPlanId, paymentGateway: "Stripe Pay");
//     // await coinHistoryController.coinPlanHistory(
//     //     loginUserId, coinPlanId, "Stripe Pay");
//     // selectedIndex = 0;
//     // Get.offAll(() => const MyApp());
//     Get.back();
//   }
// }

class StripeService {
  init() async {
    Stripe.merchantIdentifier = 'merchant.flutter.stripe.test';

    await Stripe.instance.applySettings().catchError((e) {
      Fluttertoast.showToast(
        msg: e.toString(),
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black.withOpacity(0.35),
        textColor: Colors.white,
        fontSize: 16.0,
      );
      throw e.toString();
    });
  }

  //StripPayment
  Future<dynamic> stripePay(
      {required bool isCoinPlan,
      String? coin,
      required String amount,
      required String currency,
      required String coinPlanId,
      required bool isTest}) async {
    try {
      Map<String, dynamic> body = {
        'amount': (int.parse(amount) * 100).toString(),
        'currency': "USD",
        'description': 'Name: $userName',
      };

      debugPrint("Start Payment Intent http rwq post method");

      var response = await http.post(Uri.parse("https://api.stripe.com/v1/payment_intents"),
          body: body,
          headers: {"Authorization": "Bearer $stripSecrateKey", "Content-Type": 'application/x-www-form-urlencoded'});
      debugPrint("End Payment Intent http rwq post method");
      debugPrint(response.body.toString());

      if (response.statusCode == 200) {
        StripePayModel res = StripePayModel.fromJson(jsonDecode(response.body));

        SetupPaymentSheetParameters setupPaymentSheetParameters = SetupPaymentSheetParameters(
          paymentIntentClientSecret: res.clientSecret,
          appearance: const PaymentSheetAppearance(colors: PaymentSheetAppearanceColors(primary: Colors.pinkAccent)),
          merchantDisplayName: 'Tindo',
          googlePay: const PaymentSheetGooglePay(
            merchantCountryCode: 'US',
            testEnv: true,
          ),
          applePay: const PaymentSheetApplePay(
            buttonType: PlatformButtonType.buy,
            merchantCountryCode: 'US',
          ),
          customerId: userID.toString(),
          billingDetails: BillingDetails(name: userName),
          allowsDelayedPaymentMethods: true,
        );

        await Stripe.instance.initPaymentSheet(paymentSheetParameters: setupPaymentSheetParameters).then((value) async {
          await Stripe.instance.presentPaymentSheet().then((value) async {
            SuccessPurchaseModel? data =
                await SuccessPurchasService().successPurchas(coinPlanId: coinPlanId, paymentGateway: "Stripe Pay");
            if (data!.status == true) {
              userCoins.value += data.history!.coin!.toInt();
              Fluttertoast.showToast(
                msg: "Payment Successfully",
                backgroundColor: ThemeColor.pink,
                fontSize: 15,
                textColor: Colors.white,
                timeInSecForIosWeb: 4,
              );
              Get.back();
            }
          }).catchError((e) {
            log("Payment :: $e");
          });
        }).catchError((e) {
          throw 'Something Went Wrong $e';
        });
      }
      return jsonDecode(response.body);
    } catch (e) {
      debugPrint('err charging user: ${e.toString()}');
    }
  }
}
