import 'dart:ui';
import 'package:fluttertoast/fluttertoast.dart';
import '../widgets/common_colour.dart';

class ApiUrls {
  static const String apiBaseUrlNew = 'https://dirise.eoxyslive.com/api/';
  static const String signInUrl = "${apiBaseUrlNew}register";
  static const String loginUrl = "${apiBaseUrlNew}login";
  static const String verifyOtpEmail = "${apiBaseUrlNew}verify-otp-email";
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