
import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../model/login_model.dart';
import '../utils/ApiConstant.dart';
import '../utils/helper.dart';

Future<LoginModel> registerRepo({email, name,phone,password,context}) async {
  OverlayEntry loader = Helpers.overlayLoader(context);
  Overlay.of(context).insert(loader);
  var map = <String, dynamic>{};
  map['email'] = email;
  map['name'] = name;
  map['phone'] = phone;
  map['password'] = password;
  var header = {
    HttpHeaders.contentTypeHeader: "application/json",
    HttpHeaders.acceptHeader: "application/json",
  };
  final response = await http.post(Uri.parse(ApiUrls.signInUrl),
      body: jsonEncode(map), headers: header);
  if (response.statusCode == 200 || response.statusCode == 400) {
    print(response.body);
    Helpers.hideLoader(loader);
    return LoginModel.fromJson(jsonDecode(response.body));
  } else {

    Helpers.hideLoader(loader);

    throw Exception(response.body);
  }
}
