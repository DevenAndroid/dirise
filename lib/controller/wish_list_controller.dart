import 'dart:convert';

import 'package:dirise/repository/repository.dart';
import 'package:get/get.dart';

import '../model/model_whishlist.dart';
import '../utils/ApiConstant.dart';

class WishListController extends GetxController {
  final Repositories repositories = Repositories();
  Rx<WhishlistModel> model = WhishlistModel().obs;
  bool apiLoaded = false;
  RxInt refreshInt = 0.obs;

  get updateUI => refreshInt.value = DateTime.now().millisecondsSinceEpoch;

  @override
  void onInit() {
    super.onInit();
    getYourWishList();
  }

  getYourWishList() async {
    await repositories.postApi(url: ApiUrls.wishListUrl).then((value){
      model.value = WhishlistModel.fromJson(jsonDecode(value));
      apiLoaded = true;
      updateUI;
    });
  }
}
