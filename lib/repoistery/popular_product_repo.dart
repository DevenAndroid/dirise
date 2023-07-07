import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../model/popular_product_modal.dart';
import '../utils/ApiConstant.dart';

Future<PopularProductsModal> popularProductsRepo() async {
  var header = {
    HttpHeaders.contentTypeHeader: "application/json",
    HttpHeaders.acceptHeader: "application/json",
  };
  final response = await http.post(Uri.parse(ApiUrls.popularProductUrl),
      headers: header);
  if (response.statusCode == 200 || response.statusCode == 400) {
    log(response.body);
    return PopularProductsModal.fromJson(jsonDecode(response.body));
  } else {
    throw Exception(response.body);
  }
}