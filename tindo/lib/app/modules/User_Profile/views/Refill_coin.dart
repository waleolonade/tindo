import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:rayzi/app/API_Services/success_purchas_service.dart';
import 'package:rayzi/app/PaymentMethod/stripe_pay.dart';
import 'package:rayzi/app/data/APP_variables/AppVariable.dart';
import 'package:rayzi/app/data/AppImages.dart';
import 'package:rayzi/app/data/Colors.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shimmer/shimmer.dart';

import '../../../API Models/success_purchase_model.dart';
import '../../../data/APP_variables/payment_releted.dart';
import '../../Coins/controllers/coins_controller.dart';

class RefillCoin extends StatefulWidget {
  const RefillCoin({Key? key}) : super(key: key);

  @override
  State<RefillCoin> createState() => _RefillCoinState();
}

class _RefillCoinState extends State<RefillCoin> {
  CoinsController coinsController = Get.put(CoinsController());
  //// ==== RazorPay ==== \\\\
  String? payment;
  Map<String, dynamic>? paymentIntent;
  late Razorpay razorpay;
  //// ==== StripePay ==== \\\\
  var stripePayController = StripeService();
  int selectedCoins = 0;
  @override
  void initState() {
    // TODO: implement initState
    razorpay = Razorpay();
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    super.initState();
  }

  /// Razor Pay Success function ///
  Future<void> _handlePaymentSuccess(PaymentSuccessResponse response) async {
    SuccessPurchaseModel data = await SuccessPurchasService()
        .successPurchas(coinPlanId: coinsController.coinPlan.value, paymentGateway: "RAZORPAY");
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 50,
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
                      size: 25,
                      color: ThemeColor.blackback,
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                      onTap: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(height: 14, width: 14, child: Image.asset(AppImages.coinImages)),
                          const SizedBox(
                            width: 2.5,
                          ),
                          Obx(
                            () => Text(
                              "${userCoins.value}",
                              style: TextStyle(
                                  fontSize: 16,
                                  // color: theme_Color.white,
                                  color: ThemeColor.blackback,
                                  fontFamily: 'abold'),
                            ),
                          )
                        ],
                      )),
                  const SizedBox(
                    width: 15,
                  ),
                ],
              ),
            ),
            Divider(color: ThemeColor.graylight.withOpacity(0.3), height: 0.8, thickness: 0.6),
            const SizedBox(
              height: 10,
            ),

            ///
            Expanded(
              child: SizedBox(
                child: (coinsController.coins.isNotEmpty)
                    ? Obx(
                        () => ListView.separated(
                          separatorBuilder: (context, index) => const SizedBox(
                            height: 10,
                          ),
                          padding: const EdgeInsets.only(top: 10, bottom: 34),
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
                                  height: 125,
                                  width: Get.width,
                                  decoration: BoxDecoration(
                                    // color: Colors.black,
                                    border: Border.all(width: 1.2, color: Colors.grey.withOpacity(0.3)),
                                    borderRadius: BorderRadius.circular(24),
                                  ),
                                  alignment: Alignment.center,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 20, right: 20),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              // AppImages.coinImages,
                                              AppImages.coinImages,
                                              height: 25,
                                              width: 25,
                                              fit: BoxFit.cover,
                                            ),
                                            const SizedBox(
                                              height: 8,
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          width: 6,
                                        ),
                                        Text(
                                          "${coinsController.coins[index]}",
                                          style: const TextStyle(
                                              color: Colors.black, fontFamily: 'abold', fontSize: 31),
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Text("+${coinsController.offer[index]} coins",
                                            style: TextStyle(color: ThemeColor.blackback, fontSize: 13)),
                                        const Spacer(),
                                        Container(
                                          height: 38,
                                          width: 68,
                                          decoration: BoxDecoration(
                                            // color: Colors.black,
                                            border: Border.all(width: 1.2, color: Colors.grey.withOpacity(0.3)),
                                            borderRadius: BorderRadius.circular(14),
                                          ),
                                          alignment: Alignment.center,
                                          padding: const EdgeInsets.only(left: 5, right: 5, top: 3, bottom: 2),
                                          child: Text("${coinsController.price[index]} \$",
                                              style: TextStyle(
                                                  fontFamily: "amidum",
                                                  fontSize: 23,
                                                  fontWeight: FontWeight.w700,
                                                  color: ThemeColor.blackback)),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      )
                    : shimmer(),
              ),
            ),
          ],
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

  Container purchaseSheet(String planid, String amount, int coins) {
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
          (googlepayActive)
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
                            height: 60,
                            width: 60,
                            child: Image.asset("Images/Inapp.png", fit: BoxFit.cover),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Text(
                            "Google Pay",
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
                                  color: (coinsController.paymentChoice1.value)
                                      ? ThemeColor.pink
                                      : Colors.transparent,
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
                                            border: Border.all(width: 1, color: const Color(0xFFE3E9ED)),
                                            shape: BoxShape.circle),
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
                            height: 60,
                            width: 60,
                            child: Image.asset("Images/RazorPay.png", fit: BoxFit.cover),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Text(
                            "Razor Pay",
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
                                  color: (coinsController.paymentChoice2.value)
                                      ? ThemeColor.pink
                                      : Colors.transparent,
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
                                            border: Border.all(width: 1, color: const Color(0xFFE3E9ED)),
                                            shape: BoxShape.circle),
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
                            width: 50,
                            child: Image.asset("Images/StripePay.png", fit: BoxFit.cover),
                          ),
                          const SizedBox(
                            width: 25,
                          ),
                          Text(
                            "Stripe Pay",
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
                                  color: (coinsController.paymentChoice3.value)
                                      ? ThemeColor.pink
                                      : Colors.transparent,
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
                                            border: Border.all(width: 1, color: const Color(0xFFE3E9ED)),
                                            shape: BoxShape.circle),
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
              } else if (coinsController.paymentChoice2.value) {
                coinsController.coinPlan.value = planid;
                openCheckout(amount);
              } else if (coinsController.paymentChoice3.value) {
                Stripe.publishableKey = stripPublishableKey;
                log("Publish key is :: $stripPublishableKey");
                log("Secret Key key is :: $stripSecrateKey");

                await StripeService().init();
                1.seconds.delay;
                StripeService()
                    .stripePay(
                      isCoinPlan: true,
                      coin: coins.toString(),
                      amount: amount,
                      currency: "USD",
                      coinPlanId: planid,
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
                // stripePayController.makePayment(amount: amount, currency: "USD", coinPlanId: planid, coins: coins);
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
}
