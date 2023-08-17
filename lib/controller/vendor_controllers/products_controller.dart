import 'dart:convert';
import 'package:dirise/model/common_modal.dart';
import 'package:dirise/repository/repository.dart';
import 'package:dirise/utils/ApiConstant.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../model/vendor_models/model_vendor_product_list.dart';

class ProductsController extends GetxController {
  final Repositories repositories = Repositories();
  RxInt refreshInt = 0.obs;
  bool apiLoaded = false;

  ModelProductsList model = ModelProductsList(product: []);

  void get updateUI => refreshInt.value = DateTime.now().millisecondsSinceEpoch;

  Future getProductList() async {
    await repositories.getApi(url: ApiUrls.myProductsListUrl).then((value) {
      apiLoaded = true;
      model = ModelProductsList.fromJson(jsonDecode(value));
      updateUI;
    });
  }

  Future updateProductStatus({
    required BuildContext context,
    required String productID,
    required Function(bool gg) changed,
  }) async {
    await repositories
        .postApi(url: ApiUrls.updateProductStatusUrl, mapData: {"product_id": productID}, context: context)
        .then((value) {
      ModelCommonResponse response = ModelCommonResponse.fromJson(jsonDecode(value));
      if (response.status == true) {
        changed(true);
      }
      showToast(response.message.toString());
      updateUI;
    });
    changed(false);
  }
}
