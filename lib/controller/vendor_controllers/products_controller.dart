import 'package:dirise/repoistery/repository.dart';
import 'package:dirise/utils/ApiConstant.dart';
import 'package:get/get.dart';

class ProductsController extends GetxController{
  final Repositories repositories = Repositories();
  RxInt refreshInt = 0.obs;
  bool apiLoaded = false;

  void get updateUI => refreshInt.value = DateTime.now().millisecondsSinceEpoch;
  
  getProductList(){
    repositories.getApi(url: ApiUrls.vendorProductsListUrl).then((value) {
      apiLoaded = true;
      updateUI;
    });
  }

}