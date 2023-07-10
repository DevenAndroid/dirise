
import 'package:get/get.dart';
import '../model/author_modal.dart';
import '../model/categories_modal.dart';
import '../model/home_modal.dart';
import '../model/popular_product_modal.dart';
import '../model/trending_products_modal.dart';
import '../repoistery/all_categories_repo.dart';
import '../repoistery/author_repo.dart';
import '../repoistery/home_repo.dart';
import '../repoistery/popular_product_repo.dart';
import '../repoistery/trending_product_repo.dart';

class TrendingProductsController extends GetxController {
  Rx<TendingModel> trendingModel = TendingModel().obs;
  Rx<HomeModal> homeModal = HomeModal().obs;
  Rx<CategoriesModal> categoryModal = CategoriesModal().obs;
  Rx<PopularProductsModal> popularProdModal = PopularProductsModal().obs;
  Rx<AuthorModal> authorModal = AuthorModal().obs;
  Future trendingData() async {
    await trendingProductsRepo().then((value) {
       trendingModel.value=value;
      if(value.status==true){
        print(value.message.toString());
      }
    });
  }
  Future homeData() async {
    await homeRepo().then((value) {
      homeModal.value=value;
      if(value.status==true){
        print("homeeeeeeeeee");
      }
    });
  }
  Future categoriesData() async {
    await categoryRepo().then((value) {
      categoryModal.value=value;
      if(value.status==true){
        print("Categorieeeeeee");
      }
    });
  }
  Future popularProductsData() async {
    await popularProductsRepo().then((value) {
      popularProdModal.value=value;
      if(value.status==true){
        print("popolarrrrrrrrrrrrrrrr");
      }
    });
  }
  Future authorData() async {
    await authorRepo().then((value) {
      authorModal.value=value;
      if(value.status==true){
        print("aaaaaaaauhhorrrrrrrrrrrrrrrrrrr");
      }
    });
  }
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
     trendingData();
    categoriesData();
    popularProductsData();
    homeData();
    authorData();

  }
}