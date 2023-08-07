import 'dart:convert';
import 'package:dirise/repository/repository.dart';
import 'package:get/get.dart';
import '../model/Vendor_categories-model.dart';
import '../model/aboutus_model.dart';
import '../model/author_modal.dart';
import '../model/categories_modal.dart';
import '../model/category_author_model.dart';
import '../model/category_furniture_model.dart';
import '../model/category_libraries_model.dart';
import '../model/category_teacher_model.dart';
import '../model/home_modal.dart';
import '../model/popular_product_modal.dart';
import '../model/trending_products_modal.dart';
import '../utils/ApiConstant.dart';

class TrendingProductsController extends GetxController {
  Rx<TendingModel> trendingModel = TendingModel().obs;
  Rx<HomeModal> homeModal = HomeModal().obs;
  Rx<CategoriesModal> categoryModal = CategoriesModal().obs;
  Rx<VendorCategoryModel> vendorcategoryModel = VendorCategoryModel().obs;
  Rx<CategoryLibraryModel> categoryLibraryModel = CategoryLibraryModel().obs;
  Rx<CategoryAuthorsModel> categoryAuthorsModel = CategoryAuthorsModel().obs;
  Rx<CategoryTeacherModel> categoryTeacherModel = CategoryTeacherModel().obs;
  Rx<CategoryFurnitureModel> categoryFurnitureModel = CategoryFurnitureModel().obs;
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

  Future categoriesData() async {
    await repositories.postApi(url: ApiUrls.categoryUrl, mapData: {}).then((value) {
      categoryModal.value = CategoriesModal.fromJson(jsonDecode(value));
    });
  }
  Future vendorCategoriesData() async {
    await repositories.getApi(url: ApiUrls.vendorCategoryListUrl, mapData: {}).then((value) {
      vendorcategoryModel.value = VendorCategoryModel.fromJson(jsonDecode(value));
    });
  }
  Future librariesData() async {
    await repositories.getApi(url: ApiUrls.categoryLibraryUrl, mapData: {}).then((value) {
      categoryLibraryModel.value = CategoryLibraryModel.fromJson(jsonDecode(value));
    });
  }
  Future categoryAuthorData() async {
    await repositories.getApi(url: ApiUrls.categoryAuthorsUrl, mapData: {}).then((value) {
      categoryAuthorsModel.value = CategoryAuthorsModel.fromJson(jsonDecode(value));
    });
  }
  Future categoryTeacherData() async {
    await repositories.getApi(url: ApiUrls.categoryTeacherUrl, mapData: {}).then((value) {
      categoryTeacherModel.value = CategoryTeacherModel.fromJson(jsonDecode(value));
    });
  }
  Future categoryFurnitureData() async {
    await repositories.getApi(url: ApiUrls.categoryFurnitureUrl, mapData: {}).then((value) {
      categoryFurnitureModel.value = CategoryFurnitureModel.fromJson(jsonDecode(value));
    });
  }
  getAll(){
    trendingData();
    popularProductsData();
    homeData();
    authorData();
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
