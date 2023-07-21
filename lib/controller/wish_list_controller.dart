import 'dart:convert';

import 'package:dirise/repoistery/repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../model/model_whishlist.dart';
import '../utils/ApiConstant.dart';

class WishListController extends GetxController {
  final Repositories repositories = Repositories();
  Rx<WhishlistModel> model = WhishlistModel().obs;
  RxBool isDataLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    getYourWishList();
  }

  getYourWishList() async {
    await repositories.postApi(url: ApiUrls.wishListUrl).then((value){
      model.value = WhishlistModel.fromJson(jsonDecode(value));
      isDataLoading.value = true;
    });
  }
}
