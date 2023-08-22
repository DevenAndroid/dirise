import 'dart:convert';
import 'package:get/get.dart';
import '../../model/vendor_models/model_store_availability.dart';
import '../../repository/repository.dart';
import '../../utils/ApiConstant.dart';

class VendorStoreTimingController extends GetxController{
  final Repositories repositories = Repositories();
  ModelStoreAvailability modelStoreAvailability = ModelStoreAvailability();
  RxInt refreshInt = 0.obs;

  getTime() {
    repositories.getApi(url: ApiUrls.storeTimingUrl).then((value) {
      modelStoreAvailability = ModelStoreAvailability.fromJson(jsonDecode(value));
      refreshInt.value = DateTime.now().millisecondsSinceEpoch;
    });
  }

  @override
  void onInit() {
    super.onInit();
    getTime();
  }

}