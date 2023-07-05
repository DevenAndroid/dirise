import 'dart:convert';
import 'dart:ui';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/login_model.dart';
import '../widgets/common_colour.dart';

class ApiUrls {
  static const String apiBaseUrlNew = 'https://dirise.eoxyslive.com/api/';
  static const String signInUrl = "${apiBaseUrlNew}register";
  static const String loginUrl = "${apiBaseUrlNew}login";
  static const String forgotPasswordUrl = "${apiBaseUrlNew}userforgototp";
}

showToast(message) {
  Fluttertoast.cancel();
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 3,
      backgroundColor: AppTheme.buttonColor,
      textColor: const Color(0xffffffff),
      fontSize: 15);
}
Future<String> getUserToken() async {
  SharedPreferences sharedPreference = await SharedPreferences.getInstance();
  LoginModal model = LoginModal.fromJson(
      jsonDecode(sharedPreference.getString("userData")!));
  return model.token.toString();
}