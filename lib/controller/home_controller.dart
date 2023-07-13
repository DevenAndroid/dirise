import 'dart:convert';
import 'package:dirise/repoistery/repository.dart';
import 'package:get/get.dart';
import '../model/author_modal.dart';
import '../model/categories_modal.dart';
import '../model/home_modal.dart';
import '../model/popular_product_modal.dart';
import '../model/trending_products_modal.dart';
import '../utils/ApiConstant.dart';

class TrendingProductsController extends GetxController {
  Rx<TendingModel> trendingModel = TendingModel().obs;
  Rx<HomeModal> homeModal = HomeModal().obs;
  Rx<CategoriesModal> categoryModal = CategoriesModal().obs;
  Rx<PopularProductsModal> popularProdModal = PopularProductsModal().obs;
  Rx<AuthorModal> authorModal = AuthorModal().obs;

  final Repositories repositories = Repositories();

  Future trendingData() async {
    repositories.postApi(url: ApiUrls.trendingProductsUrl, mapData: {}).then((value) {
      trendingModel.value = TendingModel.fromJson(jsonDecode(value));
    });
  }

  Future homeData() async {
    repositories.postApi(url: ApiUrls.homeUrl, mapData: {}).then((value) {
      homeModal.value = HomeModal.fromJson(jsonDecode(value));
    });
  }

  Future categoriesData() async {
    await repositories.postApi(url: ApiUrls.categoryUrl, mapData: {}).then((value) {
      categoryModal.value = CategoriesModal.fromJson(jsonDecode(value));
    });
  }

  Future popularProductsData() async {
    repositories.postApi(url: ApiUrls.popularProductUrl, mapData: {}).then((value) {
      popularProdModal.value = PopularProductsModal.fromJson(jsonDecode(value));
    });
  }

  Future authorData() async {
    repositories.getApi(url: ApiUrls.authorUrl).then((value) {
      authorModal.value = AuthorModal.fromJson(jsonDecode(value));
    });
  }

  @override
  void onInit() {
    super.onInit();
    trendingData();
    popularProductsData();
    homeData();
    authorData();
  }
}
