import 'dart:convert';

import 'package:dirise/repository/repository.dart';
import 'package:get/get.dart';

import '../../model/vendor_models/model_vendor_dashboard.dart';
import '../../utils/api_constant.dart';

class VendorDashboardController extends GetxController {
  ModelVendorDashboard modelVendorDashboard = ModelVendorDashboard();
  final Repositories repositories = Repositories();
  RxInt refreshInt = 0.obs;

  void get updateUI => refreshInt.value = DateTime.now().millisecondsSinceEpoch;

  Future getVendorDashBoard() async {
    await repositories
        .postApi(
            url: ApiUrls.vendorDashBoardUrl,
            withStatus: (int status, String body) {
              modelVendorDashboard = ModelVendorDashboard.fromJson(jsonDecode(body));
              if (status == 200) {
                modelVendorDashboard.status = true;
                modelVendorDashboard.dashboard ??= Dashboard();
                modelVendorDashboard.order ??= [];
              }
              updateUI;
            })
        .then((value) {});
  }
}
