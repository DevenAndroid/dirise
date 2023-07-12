import 'dart:convert';

import 'package:dirise/model/common_modal.dart';
import 'package:dirise/repoistery/repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../model/model_cart_response.dart';
import '../utils/ApiConstant.dart';

class CartController extends GetxController{

  RxInt refreshInt = 0.obs;
  final Repositories repositories = Repositories();
  ModelCartResponse cartModel = ModelCartResponse(cart: []);
  bool apiLoaded = false;

  removeItemFromCart({
    required String productId,
    BuildContext? context,
  }){
    Map<String, dynamic> map = {};
    map["product_id"] = productId;
    repositories.postApi(url: ApiUrls.deleteCartUrl,context: context,mapData: map).then((value) {
      ModelCommonResponse response = ModelCommonResponse.fromJson(jsonDecode(value));
      showToast(response.message.toString());
      getCart();
    });
  }
  
  getCart(){
    repositories.postApi(url: ApiUrls.cartListUrl).then((value) {
      cartModel = ModelCartResponse.fromJson(jsonDecode(value));
      apiLoaded = true;
      updateUI();
    });
  }

  updateUI(){
    refreshInt.value = DateTime.now().microsecondsSinceEpoch;
  }

  @override
  void onInit() {
    super.onInit();
    getCart();
  }


}