import 'dart:io';
import 'package:dirise/utils/api_constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../model/create_news_model.dart';
import '../model/login_model.dart';
import '../utils/helper.dart';


Future<CreateNewsModel> createNewsRepo({title, description, file, context}) async {
  Map<String, String> map = {};
  map['title'] = title;
  map['discription'] = description;
  map['file'] = file;


  SharedPreferences pref = await SharedPreferences.getInstance();
  LoginModal? user =
  LoginModal.fromJson(jsonDecode(pref.getString('user_info')!));
  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer ${user.token}'
  };
  OverlayEntry loader = Helpers.overlayLoader(context);
  Overlay.of(context)!.insert(loader);
  print(map);
  try {
    final response = await http.post(Uri.parse(ApiUrls.createPostUrl),
        body: jsonEncode(map), headers: headers);

    if (response.statusCode == 200 ||response.statusCode == 400) {
      Helpers.hideLoader(loader);
      print("Add Bank Details Repository...${response.body}");

      return CreateNewsModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(response.body);
    }
  } catch (e) {
    throw Exception(e.toString());
  }
}
