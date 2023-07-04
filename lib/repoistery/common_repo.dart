
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../model/common_model.dart';
import '../utils/ApiConstant.dart';

Future<CommonModel> registerRepo({email, name,phone,password}) async {
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
    log(response.body);
    //Helpers.hideLoader(loader);
    return CommonModel.fromJson(jsonDecode(response.body));
  } else {
   // Helpers.hideLoader(loader);
    throw Exception(response.body);
  }
}
