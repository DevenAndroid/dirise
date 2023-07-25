import 'dart:convert';
import 'dart:ui';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/login_model.dart';
import '../widgets/common_colour.dart';

class ApiUrls {
  static const String apiBaseUrlNew = 'https://dirise.eoxyslive.com/api/';
  static const String signInUrl = "${apiBaseUrlNew}register";
  static const String loginUrl = "${apiBaseUrlNew}login";
  static const String verifyOtpEmail = "${apiBaseUrlNew}verify-otp-email";
  static const String forgotPasswordUrl = "${apiBaseUrlNew}userforgototp";
  static const String changePasswordUrl = "${apiBaseUrlNew}change-password";
  static const String trendingProductsUrl = "${apiBaseUrlNew}trending-product";
  static const String homeUrl = "${apiBaseUrlNew}home";
  static const String categoryUrl = "${apiBaseUrlNew}category";
  static const String popularProductUrl = "${apiBaseUrlNew}popular-product";
  static const String authorUrl = "${apiBaseUrlNew}authers-list";
  static const String addToCartUrl = "${apiBaseUrlNew}add-cart";
  static const String cartListUrl = "${apiBaseUrlNew}cart-list";
  static const String deleteCartUrl = "${apiBaseUrlNew}delete-cart";
  static const String applyCouponUrl = "${apiBaseUrlNew}apply-coupon";
  static const String updateProfile = "${apiBaseUrlNew}edit-account";
  static const String userProfile = "${apiBaseUrlNew}my-account";
  static const String addressListUrl = "${apiBaseUrlNew}address";
  static const String editAddressUrl = "${apiBaseUrlNew}edit-address";
  static const String placeOrderUrl = "${apiBaseUrlNew}add-order";
  static const String myOrdersListUrl = "${apiBaseUrlNew}orders";
  static const String orderDetailsUrl = "${apiBaseUrlNew}order-details";
  static const String addToWishListUrl = "${apiBaseUrlNew}add-to-wishlist";
  static const String removeFromWishListUrl = "${apiBaseUrlNew}delete-from-wishlist";
  static const String wishListUrl = "${apiBaseUrlNew}wishlist";
  static const String storesUrl = "${apiBaseUrlNew}stores";
  static const String vendorCategoryListUrl = "${apiBaseUrlNew}vendor-category-list";
  static const String vendorRegistrationUrl = "${apiBaseUrlNew}vendor-signup";
  static const String verifyVendorOTPEmailUrl = "${apiBaseUrlNew}verify-otp-email";
  static const String vendorResendOTPUrl = "${apiBaseUrlNew}vendor-resend-otp";
  static const String deleteAddressUrl = "${apiBaseUrlNew}delete-address";
  static const String getVendorDetailUrl = "${apiBaseUrlNew}get-vendor-details";
  static const String addVendorProductUrl = "${apiBaseUrlNew}add-vendor-prodect";
  static const String productCategoryListUrl = "${apiBaseUrlNew}prodect-category-list";

}

showToast(message) {
  Fluttertoast.cancel();
  Fluttertoast.showToast(
      msg: message.toString().capitalize!,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 4,
      backgroundColor: AppTheme.buttonColor,
      textColor: const Color(0xffffffff),
      fontSize: 15);
}

Future getUserToken() async {
  SharedPreferences sharedPreference = await SharedPreferences.getInstance();
  LoginModal model = LoginModal.fromJson(jsonDecode(sharedPreference.getString("userData")!));
  return model.token.toString();
}
