import 'dart:convert';
import 'package:dirise/repoistery/repository.dart';
import 'package:get/get.dart';
import '../model/single_category_model.dart';
import '../utils/ApiConstant.dart';

class SingleCategoryController extends GetxController {
  final Repositories repositories = Repositories();
  Rx<SingleCategoryModel> model = SingleCategoryModel().obs;
  RxBool isDataLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    getYourSingleOrder();
  }

  getYourSingleOrder() async {

    await repositories.postApi(url: ApiUrls.storesUrl).then((value){
      model.value = SingleCategoryModel.fromJson(jsonDecode(value));
      isDataLoading.value = true;
    });
  }
}