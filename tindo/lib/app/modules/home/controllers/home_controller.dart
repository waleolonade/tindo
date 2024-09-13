import 'package:get/get.dart';

import '../../../API Models/user_thumblist_model.dart';
import '../../../API_Services/banner_services.dart';
import '../../../API_Services/userthumblist_service.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController
  var initialIndex = 0.obs;
  var images = [].obs;
  List<String> bannerUri = [];
  UserThumbListModel? userThumbListModel;
  var isLoading = true.obs;
  var bannerList;
  @override
  void onInit() {
    super.onInit();
    banner();
    thumbList();
  }

  Future banner() async {
    var bannerData = await BannerServices().bannerServices();
    bannerList = bannerData!.banner;
    bannerList!.forEach((element) {
      images.add(element.image!);
      bannerUri.add(element.url!);
    });
  }

  Future thumbList() async {
    isLoading.value = true;
    var data = await UserThumbListService().userThumblistService();
    userThumbListModel = data;
    if (data!.status == true) {
      isLoading.value = false;
    }
  }
}
