import 'package:dirise/repoistery/repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../model/model_whishlist.dart';
import '../repoistery/get_whishlist_repo.dart';
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
    bool result = await InternetConnectionChecker().hasConnection;
    if (result == true) {
      await repositories.postApi(url: ApiUrls.wishListUrl).then((value){
        isDataLoading.value = true;
        model.value = value;
      });
    } else {
      // model.value = value;
    }
  }
}
