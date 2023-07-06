import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../model/login_model.dart';

import '../model/trending_products_modal.dart';
import '../utils/ApiConstant.dart';
import '../utils/helper.dart';


Future<TendingModel> trendingProductsRepo() async {
  //OverlayEntry loader = Helpers.overlayLoader(context);
 // Overlay.of(context).insert(loader);
  var header = {
    HttpHeaders.contentTypeHeader: "application/json",
    HttpHeaders.acceptHeader: "application/json",
  };
  final response = await http.post(Uri.parse(ApiUrls.trendingProductsUrl),
       headers: header);
  if (response.statusCode == 200 || response.statusCode == 400) {
    log(response.body);
    //Helpers.hideLoader(loader);
    return TendingModel.fromJson(jsonDecode(response.body));
  } else {
    //Helpers.hideLoader(loader);
    throw Exception(response.body);
  }
}