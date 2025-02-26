import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:rayzi/app/API_Services/success_purchas_service.dart';
import 'package:rayzi/app/PaymentMethod/stripe_pay.dart';
import 'package:rayzi/app/data/AppImages.dart';
import 'package:rayzi/app/data/Colors.dart';
import 'package:rayzi/app/modules/Coins/controllers/coins_controller.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shimmer/shimmer.dart';

import '../../../API Models/success_purchase_model.dart';
import '../../../data/APP_variables/AppVariable.dart';
import '../../../data/APP_variables/payment_releted.dart';
import '../../../data/in_app_purchase/iap_callback.dart';
import '../../../data/in_app_purchase/in_app_purchase_helper.dart';

class CoinsView extends StatefulWidget {
  const CoinsView({Key? key}) : super(key: key);

  @override
  State<CoinsView> createState() => _CoinsViewState();
}

class _CoinsViewState extends State<CoinsView> with SingleTickerProviderStateMixin implements IAPCallback {
  CoinsController coinsController = Get.put(CoinsController());

  //// ==== RazorPay ==== \\\\
  String? payment;
  Map<String, dynamic>? paymentIntent;
  late Razorpay razorpay;
  //// ==== StripePay ==== \\\\
  var stripePayController = StripeService();
  @override
  void initState() {
    // TODO: implement initState
    razorpay = Razorpay();
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    InAppPurchaseHelper().getAlreadyPurchaseItems(this);
    purchases = InAppPurchaseHelper().getPurchases();
    InAppPurchaseHelper().clearTransactions();
    super.initState();
  }

  /// Razor Pay Success function ///
  Future<void> _handlePaymentSuccess(PaymentSuccessResponse response) async {
    SuccessPurchaseModel data =
        await SuccessPurchasService().successPurchas(coinPlanId: coinsController.coinPlan.value, paymentGateway: "RAZORPAY");
    if (data.status == true) {
      userCoins.value += data.history!.coin!.toInt();
      Fluttertoast.showToast(msg: "SUCCESS: ${response.paymentId!}", timeInSecForIosWeb: 4);
    }
  }

  /// Razor Pay error function ///
  void _handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(msg: "ERROR: ${response.code} - ${response.message}", timeInSecForIosWeb: 4);
  }

  /// Razor Pay Wallet  function ///
  void _handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(
      msg: "EXTERNAL_WALLET: ${response.walletName}",
      timeInSecForIosWeb: 4,
    );
  }

  /// Razor Pay ///
  void openCheckout(
    String amount,
  ) {
    var options = {
      "key": razorPayKey,
      "amount": num.parse(amount) * 100,
      'currency': 'USD',
      "name": "tindo",
      "description": "Payment For any product",
      "prefill": {
        "contact": "",
        "email": "",
      },
      "external": {
        "wallets": ["gpay"]
      }
    };

    try {
      razorpay.open(options);
    } catch (e) {
      log(e.toString());
    }
  }

  Map<String, PurchaseDetails>? purchases;

  int selectedCoins = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  AppImages.myCoinBG2,
                ),
                fit: BoxFit.cover),
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 240,
                  decoration: const BoxDecoration(color: Colors.transparent),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15, right: 15),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(Radius.circular(12)),
                                    color: Colors.white.withOpacity(0.15),
                                    border: Border.all(
                                      color: Colors.white.withOpacity(0.3),
                                      width: 1,
                                    )),
                                padding: const EdgeInsets.only(
                                  top: 5,
                                  bottom: 5,
                                  left: 16,
                                  right: 16,
                                ),
                                child: Column(
                                  children: [
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text("My Coin",
                                        style: TextStyle(
                                            fontFamily: 'amidum',
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600,
                                            color: ThemeColor.white)),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Obx(
                                      () => Text((userCoins.value == 0) ? "0" : "${userCoins.value}",
                                          style: TextStyle(fontFamily: 'abold', fontSize: 30, color: ThemeColor.white)),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Image.asset(
                              AppImages.myCoin,
                              fit: BoxFit.cover,
                              height: 107,
                              width: 190,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: ThemeColor.white,
                    borderRadius: const BorderRadius.only(topLeft: Radius.circular(36), topRight: Radius.circular(36)),
                  ),
                  child: NotificationListener<OverscrollIndicatorNotification>(
                    onNotification: (overscroll) {
                      overscroll.disallowIndicator();
                      return false;
                    },
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        const Text("Select Your Plan",
                            style:
                                TextStyle(color: Colors.black, fontFamily: 'abold', fontWeight: FontWeight.w500, fontSize: 20)),
                        const SizedBox(
                          height: 17,
                        ),
                        SizedBox(
                          child: Obx(
                            () => (coinsController.coins.isNotEmpty)
                                ? ListView.separated(
                                    separatorBuilder: (context, index) => const SizedBox(
                                      height: 16,
                                    ),
                                    padding: const EdgeInsets.only(top: 10, bottom: 34),
                                    physics: const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: coinsController.coins.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.only(
                                          left: 13,
                                          right: 13,
                                        ),
                                        child: GestureDetector(
                                          onTap: () {
                                            selectedCoins = coinsController.coinsPlanModel!.coinPlan![index].coin!.toInt();
                                            Get.bottomSheet(
                                              purchaseSheet(
                                                "${coinsController.coinsPlanModel!.coinPlan![index].id}",
                                                "${coinsController.coinsPlanModel!.coinPlan![index].dollar}",
                                                coinsController.coinsPlanModel!.coinPlan![index].coin!.toInt(),
                                              ),
                                            );
                                          },
                                          child: Container(
                                            height: 77,
                                            width: Get.width,
                                            decoration: BoxDecoration(
                                              gradient: LinearGradient(colors: [
                                                const Color(0xffE63792).withOpacity(0.5),
                                                const Color(0xff9A1CD7).withOpacity(0.5),
                                              ]),
                                              borderRadius: BorderRadius.circular(18),
                                            ),
                                            padding: const EdgeInsets.all(0.8),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: const Color(0xffFBF8FF),
                                                borderRadius: BorderRadius.circular(18),
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.only(left: 15, right: 15),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      height: 48,
                                                      width: 48,
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(100),
                                                        gradient: LinearGradient(colors: [
                                                          const Color(0xffD91679).withOpacity(0.06),
                                                          const Color(0xff9819CF).withOpacity(0.06),
                                                        ]),
                                                      ),
                                                      alignment: Alignment.center,
                                                      child: Image.asset(
                                                        AppImages.myCoin2,
                                                        height: 30,
                                                        width: 30,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 13,
                                                    ),
                                                    Text(
                                                      "${coinsController.coins[index]}",
                                                      style:
                                                          const TextStyle(color: Colors.black, fontFamily: 'abold', fontSize: 25),
                                                    ),
                                                    const SizedBox(
                                                      width: 8,
                                                    ),
                                                    Container(
                                                      decoration: BoxDecoration(
                                                          color: const Color(0xffF7E2FF).withOpacity(0.4),
                                                          borderRadius: BorderRadius.circular(100)),
                                                      padding: const EdgeInsets.all(8),
                                                      child: Text("+${coinsController.offer[index]} coins",
                                                          style: TextStyle(
                                                              color: ThemeColor.blackback,
                                                              fontWeight: FontWeight.w500,
                                                              fontSize: 12)),
                                                    ),
                                                    const Spacer(),
                                                    Padding(
                                                      padding: const EdgeInsets.only(top: 17, bottom: 17),
                                                      child: ConstrainedBox(
                                                        constraints: const BoxConstraints(minWidth: 67, minHeight: 40),
                                                        child: Container(
                                                          decoration: BoxDecoration(
                                                            color: const Color(0xffFFADEC).withOpacity(0.25),
                                                            borderRadius: BorderRadius.circular(100),
                                                          ),
                                                          alignment: Alignment.center,
                                                          padding: const EdgeInsets.only(left: 5, right: 5, top: 3, bottom: 2),
                                                          child: Text(
                                                            "\$ ${coinsController.price[index]}",
                                                            style: const TextStyle(
                                                              fontSize: 20,
                                                              fontWeight: FontWeight.bold,
                                                              color: Color(0xff9D19C8),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  )
                                : (coinsController.coins.isEmpty)
                                    ? Center(
                                        child: Image.asset(
                                          AppImages.nodataImage,
                                          height: 200,
                                          width: 200,
                                        ),
                                      )
                                    : shimmer(),
                          ),
                        ),
                      ],
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

  Shimmer shimmer() {
    return Shimmer.fromColors(
      highlightColor: ThemeColor.textGray,
      baseColor: ThemeColor.grayIcon,
      child: ListView.separated(
        separatorBuilder: (context, index) => const SizedBox(
          height: 10,
        ),
        padding: const EdgeInsets.only(top: 10, bottom: 34),
        shrinkWrap: true,
        itemCount: 4,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(
              left: 13,
              right: 13,
            ),
            child: Container(
              height: 125,
              width: Get.width,
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.2),
                border: Border.all(width: 1.2, color: Colors.grey.withOpacity(0.3)),
                borderRadius: BorderRadius.circular(24),
              ),
              alignment: Alignment.center,
            ),
          );
        },
      ),
    );
  }

  Container purchaseSheet(String planId, String amount, int coin) {
    return Container(
      height: 450,
      decoration: BoxDecoration(
        color: ThemeColor.white,
        borderRadius: const BorderRadius.only(topRight: Radius.circular(16), topLeft: Radius.circular(16)),
      ),
      padding: const EdgeInsets.only(top: 10, right: 10, left: 10),
      child: Column(
        children: [
          const SizedBox(
            height: 15,
          ),
          (googlepayActive && Platform.isAndroid)
              ? Obx(
                  () => GestureDetector(
                    onTap: () {
                      if (coinsController.paymentChoice2.value) {
                        coinsController.paymentChoice2.value = false;
                        coinsController.paymentChoice1.value = true;
                      } else if (coinsController.paymentChoice3.value) {
                        coinsController.paymentChoice3.value = false;
                        coinsController.paymentChoice1.value = true;
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        border: (coinsController.paymentChoice1.value)
                            ? Border.all(width: 1, color: ThemeColor.pink)
                            : Border.all(width: 1, color: const Color(0xFFE3E7EC)),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          SizedBox(
                            height: 50,
                            width: 60,
                            child: Image.asset("Images/google play.png", fit: BoxFit.cover).paddingAll(7),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Text(
                            "Google play",
                            style: TextStyle(
                              fontSize: 18,
                              color: ThemeColor.blackback,
                            ),
                          ),
                          const Spacer(),
                          Container(
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                  color: (coinsController.paymentChoice1.value) ? ThemeColor.pink : Colors.transparent,
                                  border: Border.all(
                                    width: 1,
                                    color: const Color(0xFFE3E7EC),
                                  ),
                                  shape: BoxShape.circle),
                              child: Center(
                                child: (coinsController.paymentChoice1.value)
                                    ? const Icon(
                                        Icons.check,
                                        color: Colors.white,
                                        size: 18,
                                      )
                                    : Container(
                                        height: 30,
                                        width: 30,
                                        decoration: BoxDecoration(
                                            border: Border.all(width: 1, color: const Color(0xFFE3E9ED)), shape: BoxShape.circle),
                                      ),
                              )),
                        ],
                      ),
                    ),
                  ),
                )
              : const SizedBox(),
          const SizedBox(
            height: 15,
          ),
          (razorPayActive)
              ? Obx(
                  () => GestureDetector(
                    onTap: () {
                      if (coinsController.paymentChoice1.value) {
                        coinsController.paymentChoice1.value = false;
                        coinsController.paymentChoice2.value = true;
                      } else if (coinsController.paymentChoice3.value) {
                        coinsController.paymentChoice3.value = false;
                        coinsController.paymentChoice2.value = true;
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        border: (coinsController.paymentChoice2.value)
                            ? Border.all(width: 1, color: ThemeColor.pink)
                            : Border.all(width: 1, color: const Color(0xFFE3E7EC)),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          SizedBox(
                            height: 50,
                            width: 50,
                            child: Image.asset("Images/RazorPay.png", fit: BoxFit.cover).paddingAll(0),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Text(
                            "Razor pay",
                            style: TextStyle(
                              fontSize: 18,
                              color: ThemeColor.blackback,
                            ),
                          ),
                          const Spacer(),
                          Container(
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                  color: (coinsController.paymentChoice2.value) ? ThemeColor.pink : Colors.transparent,
                                  border: Border.all(
                                    width: 1,
                                    color: const Color(0xFFE3E7EC),
                                  ),
                                  shape: BoxShape.circle),
                              child: Center(
                                child: (coinsController.paymentChoice2.value)
                                    ? const Icon(
                                        Icons.check,
                                        color: Colors.white,
                                        size: 18,
                                      )
                                    : Container(
                                        height: 30,
                                        width: 30,
                                        decoration: BoxDecoration(
                                            border: Border.all(width: 1, color: const Color(0xFFE3E9ED)), shape: BoxShape.circle),
                                      ),
                              )),
                        ],
                      ),
                    ),
                  ),
                )
              : const SizedBox(),
          const SizedBox(
            height: 15,
          ),
          (stripActive)
              ? Obx(
                  () => GestureDetector(
                    onTap: () {
                      if (coinsController.paymentChoice1.value) {
                        coinsController.paymentChoice1.value = false;
                        coinsController.paymentChoice3.value = true;
                      } else if (coinsController.paymentChoice2.value) {
                        coinsController.paymentChoice2.value = false;
                        coinsController.paymentChoice3.value = true;
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        border: (coinsController.paymentChoice3.value)
                            ? Border.all(width: 1, color: ThemeColor.pink)
                            : Border.all(width: 1, color: const Color(0xFFE3E7EC)),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          SizedBox(
                            height: 50,
                            // width: 35,
                            child: Image.asset("Images/atm-card.png", fit: BoxFit.cover).paddingAll(3),
                          ),
                          const SizedBox(
                            width: 25,
                          ),
                          Text(
                            "Pay using card",
                            style: TextStyle(
                              fontSize: 18,
                              color: ThemeColor.blackback,
                            ),
                          ),
                          const Spacer(),
                          Container(
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                  color: (coinsController.paymentChoice3.value) ? ThemeColor.pink : Colors.transparent,
                                  border: Border.all(
                                    width: 1,
                                    color: const Color(0xFFE3E7EC),
                                  ),
                                  shape: BoxShape.circle),
                              child: Center(
                                child: (coinsController.paymentChoice3.value)
                                    ? const Icon(
                                        Icons.check,
                                        color: Colors.white,
                                        size: 18,
                                      )
                                    : Container(
                                        height: 30,
                                        width: 30,
                                        decoration: BoxDecoration(
                                            border: Border.all(width: 1, color: const Color(0xFFE3E9ED)), shape: BoxShape.circle),
                                      ),
                              )),
                        ],
                      ),
                    ),
                  ),
                )
              : const SizedBox(),
          const Spacer(),
          GestureDetector(
            onTap: () async {
              Fluttertoast.showToast(
                msg: "Redirecting...",
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.SNACKBAR,
                timeInSecForIosWeb: 1,
                backgroundColor: ThemeColor.white,
                textColor: ThemeColor.pink,
                fontSize: 16.0,
              );
              if (coinsController.paymentChoice1.value) {
                List<String> kProductIds = <String>["android.test.purchased"];
                await InAppPurchaseHelper().init(
                  coinPlanId: planId,
                  productId: kProductIds,
                  coin: coin.toString(),
                );

                InAppPurchaseHelper().initStoreInfo();

                await Future.delayed(const Duration(seconds: 1));

                log("Payment product key :: ${coinsController.productKey}");
                ProductDetails? product = InAppPurchaseHelper().getProductDetail("android.test.purchased");

                if (product != null) {
                  InAppPurchaseHelper().buySubscription(product, purchases!);
                }
              } else if (coinsController.paymentChoice2.value) {
                coinsController.coinPlan.value = planId;
                openCheckout(amount);
              } else if (coinsController.paymentChoice3.value) {
                Stripe.publishableKey = stripPublishableKey;

                await StripeService().init();
                1.seconds.delay;
                StripeService()
                    .stripePay(
                      isCoinPlan: true,
                      coin: coin.toString(),
                      amount: amount,
                      currency: "USD",
                      coinPlanId: planId,
                      isTest: false,
                    )
                    .then((value) {})
                    .catchError((e) {
                  Fluttertoast.showToast(
                    msg: e.toString(),
                    toastLength: Toast.LENGTH_LONG,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.black.withOpacity(0.35),
                    textColor: Colors.white,
                    fontSize: 16.0,
                  );
                });
              }
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Container(
                height: 50,
                width: Get.width,
                decoration: BoxDecoration(
                  color: ThemeColor.pink,
                  borderRadius: BorderRadius.circular(100),
                ),
                alignment: Alignment.center,
                child: Text(
                  "Pay",
                  style: TextStyle(color: ThemeColor.white, fontSize: 18, fontFamily: 'abold'),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }

  @override
  void onBillingError(error) {
    // TODO: implement onBillingError
  }

  @override
  void onLoaded(bool initialized) {
    // TODO: implement onLoaded
  }

  @override
  void onPending(PurchaseDetails product) {
    // TODO: implement onPending
  }

  @override
  void onSuccessPurchase(PurchaseDetails product) {
    // TODO: implement onSuccessPurchase
  }
}
