import 'package:get/get.dart';
import 'package:rayzi/app/API%20Models/coinsplan_model.dart';

import '../../../API_Services/coinsplan_services.dart';

class CoinsController extends GetxController {
  //TODO: Implement CoinsController
  var coins = [].obs;
  var offer = [].obs;
  var price = [].obs;
  String productKey = "";
  final count = 0.obs;
  var coinPlan = "".obs;
  CoinsPlanModel? coinsPlanModel;
  RxBool paymentChoice1 = RxBool(true);
  RxBool paymentChoice2 = RxBool(false);
  RxBool paymentChoice3 = RxBool(false);
  @override
  void onInit() {
    coinsplan();
    super.onInit();
  }

  Future coinsplan() async {
    var coinsData = await CoinsPlanServices().coinsPlanSrevices();
    coinsPlanModel = coinsData;
    var planList = coinsData!.coinPlan;
    productKey = planList![0].productKey.toString();
    for (var element in planList) {
      coins.add(element.coin);
      offer.add(element.extraCoin);
      price.add(element.dollar);
    }
  }

  void increment() => count.value++;
}
