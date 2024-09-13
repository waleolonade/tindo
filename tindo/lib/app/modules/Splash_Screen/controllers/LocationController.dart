import 'package:get/get.dart';
import 'package:rayzi/app/API_Services/country_name_services.dart';

class LocationController extends GetxController {
  var isLoading = true.obs;
  var flag = [].obs;
  var countryName = [].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    listCountry();
  }

  Future listCountry() async {
    try {
      var country = await CountryNameService().countrynameService();
      country!.flag!.forEach((element) {
        flag.add(element.flag);
        countryName.add(element.name);
      });
    } finally {
      isLoading(false);
    }
  }
}
