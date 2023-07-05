import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dirise/model/common_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../model/sinup_otpverify.dart';
import '../utils/ApiConstant.dart';
import '../utils/helper.dart';

Future<SignupVerifyOtp> verifyOtp(email,otp,context) async {
  OverlayEntry loader = Helpers.overlayLoader(context);
  Overlay.of(context)!.insert(loader);
  try{
    SharedPreferences pref = await SharedPreferences.getInstance();
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
      return SignupVerifyOtp.fromJson(json.decode(response.body));
    } else {
      Helpers.hideLoader(loader);
      throw Exception(response.body);
    }
  } on SocketException catch(e){
    Helpers.hideLoader(loader);
    // log(ApiUrls.applyCouponUrl);
    return SignupVerifyOtp(status: false,message: "No internet connection");
  } catch (e){
    Helpers.hideLoader(loader);
    // log(ApiUrls.applyCouponUrl);
    return SignupVerifyOtp(status: false,message: e.toString());
  }
}