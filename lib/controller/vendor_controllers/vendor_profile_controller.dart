import 'dart:convert';

import 'package:dirise/repoistery/repository.dart';
import 'package:dirise/utils/ApiConstant.dart';
import 'package:get/get.dart';

import '../../model/vendor_models/model_vendor_details.dart';

class VendorProfileController extends GetxController{
  final Repositories repositories = Repositories();
  ModelVendorDetails model = ModelVendorDetails();
  bool apiLoaded = false;
  RxInt refreshInt = 0.obs;

  get updateUI => refreshInt.value = DateTime.now().millisecondsSinceEpoch;

  Future getVendorDetails() async {
    await repositories.getApi(url: ApiUrls.getVendorDetailUrl).then((value) {
      model = ModelVendorDetails.fromJson(jsonDecode(value));
      apiLoaded = true;
      updateUI;
    });
  }

  @override
  void onInit() {
    super.onInit();
    getVendorDetails();
  }

}