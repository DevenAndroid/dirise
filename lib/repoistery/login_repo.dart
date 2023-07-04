// import 'dart:convert';
// import 'dart:developer';
// import 'dart:io';
//
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
// import '../model/login_model.dart';
// import '../utils/ApiConstant.dart';
//
// Future<CommonModel> createLogin(String username, String password, BuildContext context) async {
//   OverlayEntry loader = Helpers.overlayLoader(context);
//   Overlay.of(context)!.insert(loader);
//   try{
//     var map = <String, dynamic>{};
//
//     map['email'] = username;
//     map['password'] = password;
//
//     var toekns = await FirebaseMessaging.instance.getToken();
//     map['fcm_token'] = toekns.toString();
//     if (kDebugMode) {
//       print("Login Details  $map");
//     }
//
//     final headers = {
//       HttpHeaders.contentTypeHeader: 'application/json',
//       HttpHeaders.acceptHeader: 'application/json',
//     };
//
//     http.Response response = await http.post(Uri.parse(ApiUrls.loginUrl),
//         body: jsonEncode(map), headers: headers);
//     if (response.statusCode == 200) {
//       Helpers.hideLoader(loader);
//       return CommonModel.fromJson(json.decode(response.body));
//     } else {
//       Helpers.hideLoader(loader);
//       throw Exception(response.body);
//     }
//   } on SocketException catch(e){
//     Helpers.hideLoader(loader);
//     log(ApiUrls.applyCouponUrl);
//     return CommonModel(status: false,message: "No internet connection");
//   } catch (e){
//     Helpers.hideLoader(loader);
//     log(ApiUrls.applyCouponUrl);
//     return CommonModel(status: false,message: e.toString());
//   }
// }
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http;
import '../model/login_model.dart';

import '../utils/ApiConstant.dart';


Future<LoginModel> login(email, password, context) async {
  // OverlayEntry loader = Helpers.overlayLoader(context);
  // Overlay.of(context).insert(loader);
  var map = <String, dynamic>{};
  map['email'] = email;
  map['password'] = password;
  var header = {
    HttpHeaders.contentTypeHeader: "application/json",
    HttpHeaders.acceptHeader: "application/json",
  };
  final response = await http.post(Uri.parse(ApiUrls.loginUrl),
      body: jsonEncode(map), headers: header);
  if (response.statusCode == 200 || response.statusCode == 400) {
    log(response.body);
    // Helpers.hideLoader(loader);
    return LoginModel.fromJson(jsonDecode(response.body));
  } else {
    // Helpers.hideLoader(loader);
    throw Exception('Failed to load data');
  }
}

