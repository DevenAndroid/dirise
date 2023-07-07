import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../model/categories_modal.dart';
import '../utils/ApiConstant.dart';


Future<CategoriesModal> categoryRepo() async {
  var header = {
    HttpHeaders.contentTypeHeader: "application/json",
    HttpHeaders.acceptHeader: "application/json",
  };
  final response = await http.post(Uri.parse(ApiUrls.categoryUrl),
      headers: header);
  if (response.statusCode == 200 || response.statusCode == 400) {
    log(response.body);
    return CategoriesModal.fromJson(jsonDecode(response.body));
  } else {
    throw Exception(response.body);
  }
}