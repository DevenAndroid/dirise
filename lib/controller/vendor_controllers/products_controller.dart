import 'package:dirise/repository/repository.dart';
import 'package:dirise/utils/ApiConstant.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ProductsController extends GetxController{
  final Repositories repositories = Repositories();
  RxInt refreshInt = 0.obs;
  bool apiLoaded = false;
  final GlobalKey slotKey = GlobalKey();
  final GlobalKey productAvailabilityKey = GlobalKey();


  final TextEditingController startTime = TextEditingController();
  final TextEditingController endTime = TextEditingController();
  final TextEditingController serviceDuration = TextEditingController();
  final TextEditingController startDate = TextEditingController();
  final TextEditingController endDate = TextEditingController();

  void get updateUI => refreshInt.value = DateTime.now().millisecondsSinceEpoch;
  
  getProductList(){
    repositories.getApi(url: ApiUrls.vendorProductsListUrl).then((value) {
      apiLoaded = true;
      updateUI;
    });
  }

}