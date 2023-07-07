import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../model/trending_products_modal.dart';
import '../utils/ApiConstant.dart';


Future<TendingModel> trendingProductsRepo() async {
  var header = {
    HttpHeaders.contentTypeHeader: "application/json",
    HttpHeaders.acceptHeader: "application/json",
  };
  final response = await http.post(Uri.parse(ApiUrls.trendingProductsUrl),
       headers: header);
  if (response.statusCode == 200 || response.statusCode == 400) {
    log(response.body);
    return TendingModel.fromJson(jsonDecode(response.body));
  } else {
    throw Exception(response.body);
  }
}