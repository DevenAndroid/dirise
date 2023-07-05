import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../model/common_modal.dart';
import '../utils/ApiConstant.dart';
import '../utils/helper.dart';

Future<CommonModel> verifyOtpRepo(email,otp,context) async {
  OverlayEntry loader = Helpers.overlayLoader(context);
  Overlay.of(context)!.insert(loader);
  try{
    var map = <String, dynamic>{};
    map['email'] = email;
    map['otp'] = otp;
    print(map);

    final headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      'accept': 'text/plain',
    };
    http.Response response = await http.post(Uri.parse(ApiUrls.verifyOtpEmail),
        body: jsonEncode(map), headers: headers);

    if (response.statusCode == 200) {
      Helpers.hideLoader(loader);
      return CommonModel.fromJson(json.decode(response.body));
    } else {
      Helpers.hideLoader(loader);
      throw Exception(response.body);
    }
  } catch (e){
    Helpers.hideLoader(loader);
    return CommonModel(status: false,message: e.toString());
  }
}