import 'package:dirise/repository/repository.dart';
import 'package:get/get.dart';

import '../../utils/ApiConstant.dart';

class BankDetailsController extends GetxController{
  final Repositories repositories = Repositories();

  getBankDetails(){
    repositories.getApi(url: ApiUrls.accountDetailsUrl).then((value) {});
  }

}