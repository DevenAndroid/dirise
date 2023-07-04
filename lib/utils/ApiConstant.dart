import 'dart:ui';

import 'package:fluttertoast/fluttertoast.dart';

import '../widgets/common_colour.dart';

class ApiUrls {

  // static const String stripeApiKey = "pk_test_51Ldat6Eh9lYQpdiH9sNGYdSx2PXUQvwafLW0bj0XtoFxAAkZEAeAuMcvfwri34RuJjcVYhkbkJ1xrTQc3u5iV2gv00wJUghfFu";
  static const String apiBaseUrlNew = 'https://dirise.eoxyslive.com/api/';
  static const String signInUrl = "${apiBaseUrlNew}register";
  static const String loginUrl = "${apiBaseUrlNew}login";
}

showToast(message) {
  Fluttertoast.cancel();
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: AppTheme.primaryColor,
      textColor: Color(0xffffffff),
      fontSize: 14);
}