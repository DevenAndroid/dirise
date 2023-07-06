
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../model/trending_products_modal.dart';
import '../repoistery/trending_product_repo.dart';

class TrendingProductsController extends GetxController {
  Rx<TendingModel> trendingModel = TendingModel().obs;
  Future trendingData() async {
   await   trendingProductsRepo().then((value) {
      trendingModel.value=value;
      if(value.status==true){
        print(value.message.toString());
      }
    });
  }
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => trendingData());

  }
}