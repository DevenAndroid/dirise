import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../model/author_modal.dart';
import '../utils/ApiConstant.dart';

Future<AuthorModal> authorRepo() async {
  var header = {
    HttpHeaders.contentTypeHeader: "application/json",
    HttpHeaders.acceptHeader: "application/json",
  };
  final response = await http.get(Uri.parse(ApiUrls.authorUrl),
      headers: header);
  if (response.statusCode == 200 || response.statusCode == 400) {
    log(response.body);
    return AuthorModal.fromJson(jsonDecode(response.body));
  } else {
    throw Exception(response.body);
  }
}