import 'dart:convert';
import 'dart:ui';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/login_model.dart';
import '../widgets/common_colour.dart';

class ApiUrls {
  static const String baseUrl = 'https://dirise.eoxyslive.com/api/';
  static const String signInUrl = "${baseUrl}register";
  static const String loginUrl = "${baseUrl}login";
  static const String verifyOtpEmail = "${baseUrl}verify-otp-email";
  static const String forgotPasswordUrl = "${baseUrl}forget-password";
  static const String changePasswordUrl = "${baseUrl}change-password";
  static const String trendingProductsUrl = "${baseUrl}trending-product";
  static const String homeUrl = "${baseUrl}home";
  static const String categoryUrl = "${baseUrl}category";
  static const String popularProductUrl = "${baseUrl}popular-product";
  static const String authorUrl = "${baseUrl}authers-list";
  static const String addToCartUrl = "${baseUrl}add-cart";
  static const String buyNowDetailsUrl = "${baseUrl}buy-now-checkout-details";
  static const String cartListUrl = "${baseUrl}cart-list";
  static const String deleteCartUrl = "${baseUrl}delete-cart";
  static const String applyCouponUrl = "${baseUrl}apply-coupon";
  static const String updateProfile = "${baseUrl}edit-account";
  static const String userProfile = "${baseUrl}my-account";
  static const String addressListUrl = "${baseUrl}address";
  static const String editAddressUrl = "${baseUrl}edit-address";
  static const String placeOrderUrl = "${baseUrl}add-order";
  static const String myOrdersListUrl = "${baseUrl}orders";
  static const String orderDetailsUrl = "${baseUrl}order-details";
  static const String addToWishListUrl = "${baseUrl}add-to-wishlist";
  static const String removeFromWishListUrl = "${baseUrl}delete-from-wishlist";
  static const String wishListUrl = "${baseUrl}wishlist";
  static const String storesUrl = "${baseUrl}stores";
  static const String vendorCategoryListUrl = "${baseUrl}vendor-category-list";
  static const String vendorRegistrationUrl = "${baseUrl}vendor-signup";
  static const String verifyVendorOTPEmailUrl = "${baseUrl}verify-otp-email";
  static const String vendorResendOTPUrl = "${baseUrl}vendor-resend-otp";
  static const String deleteAddressUrl = "${baseUrl}delete-address";
  static const String getVendorDetailUrl = "${baseUrl}my-vendor-details";
  static const String addVendorProductUrl = "${baseUrl}add-vendor-prodect";
  static const String productCategoryListUrl = "${baseUrl}prodect-category-list";
  static const String myProductsListUrl = "${baseUrl}my-product-list";
  static const String getProductDetailsUrl = "${baseUrl}edit-product/";
  static const String aboutUsUrl = "${baseUrl}page-data";
  static const String editVendorDetailsUrl = "${baseUrl}edit-vendor-details";
  static const String updateProductStatusUrl = "${baseUrl}update-product-status";
  static const String vendorDashBoardUrl = "${baseUrl}vendor-dashboard";
  static const String getCategoryStoresUrl = "${baseUrl}get-vendor-details?";
  static const String vendorProductListUrl = "${baseUrl}vendor-product-list?";
  static const String singleProductUrl = "${baseUrl}product";
  static const String getEventsUrl = "${baseUrl}get-events";
  static const String addEventUrl = "${baseUrl}event";
  static const String deleteEventUrl = "${baseUrl}delete-event";
  static const String storeTimingUrl = "${baseUrl}store-timing";
  static const String storeAvailabilityUrl = "${baseUrl}store-availability";
  static const String virtualAssetsPDFUrl = "${baseUrl}my-e-book?type=digital_reader";
  static const String virtualAssetsVoiceUrl = "${baseUrl}my-e-book?type=voice";
  static const String accountDetailsUrl = "${baseUrl}account-details";
  static const String bankListUrl = "${baseUrl}banks-list";
  static const String addAccountDetailsUrl = "${baseUrl}add-account-details";
  static const String getVendorInfoUrl = "${baseUrl}get-vendor-information?user_id=";
  static const String searchProductUrl = "${baseUrl}search-product";
  static const String vendorPlanUrl = "${baseUrl}vendor-plan";
  static const String createPaymentUrl = "${baseUrl}create-payment";
  static const String getAttributeUrl = "${baseUrl}get-attributes";
  static const String quantityUpdateUrl = "${baseUrl}qty-update";
  static const String paymentMethodsUrl = "${baseUrl}payment-methods";
  static const String allCountriesUrl = "${baseUrl}all-countries";
  static const String allStatesUrl = "${baseUrl}all-states";
  static const String allCityUrl = "${baseUrl}all-cities";
  static const String withdrawalListUrl = "${baseUrl}withdrawal-list";
  static const String withdrawalRequestUrl= "${baseUrl}withdraw-request";
  static const String deleteProductUrl= "${baseUrl}delete-product";



}

showToast(message, {ToastGravity? gravity, bool? center}) {
  Fluttertoast.cancel();
  Fluttertoast.showToast(
      msg: message.toString().capitalize!,
      toastLength: Toast.LENGTH_LONG,
      gravity: center == true ? ToastGravity.CENTER :  gravity ?? ToastGravity.BOTTOM,
      timeInSecForIosWeb: 4,
      backgroundColor: AppTheme.buttonColor,
      textColor: const Color(0xffffffff),
      fontSize: 15);
}

hideToast() {
  Fluttertoast.cancel();
}

Future getUserToken() async {
  SharedPreferences sharedPreference = await SharedPreferences.getInstance();
  LoginModal model = LoginModal.fromJson(jsonDecode(sharedPreference.getString("userData")!));
  return model.token.toString();
}