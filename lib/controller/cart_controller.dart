import 'dart:convert';
import 'package:dirise/model/common_modal.dart';
import 'package:dirise/repository/repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../model/model_address_list.dart';
import '../model/model_cart_response.dart';
import '../model/order_models/place_order_response.dart';
import '../screens/check_out/order_completed_screen.dart';
import '../utils/ApiConstant.dart';

class CartController extends GetxController {
  RxInt refreshInt = 0.obs;
  final Repositories repositories = Repositories();
  ModelCartResponse cartModel = ModelCartResponse(cart: []);
  bool apiLoaded = false;
  ModelUserAddressList addressListModel = ModelUserAddressList();
  bool addressLoaded = false;

  placeOrder({
    required BuildContext context,
    required String subTotalPrice,
    required String totalPrice,
    required String currencyCode,
    String? couponCode,
    Map<String, dynamic>? address,
  }) {
    Map<String, dynamic> gg = {
      "shipping_price": "2",
      "subtotPrice": subTotalPrice,
      "gift_card_amount": "0",
      "totPrice": totalPrice,
      "cart_id": ["2"],
      if (couponCode != null) "coupon_code": couponCode,
      "currency_code": currencyCode,
      "refund_amount_in": "bank",
      "shipping_method": "test",
      "shipping": [
        {"store_id": 13, "store_name": "vendor", "title": "Normal Shipping", "ship_price": "2"}
      ],
      "currency_sign": "\$",
      if (address != null) "shipping_address": address,
      if (address != null) "billing_address": address
    };
    repositories.postApi(url: ApiUrls.placeOrderUrl, context: context, mapData: gg).then((value) {
      // ModelCommonResponse response = ModelCommonResponse.fromJson(jsonDecode(value));
      ModelPlaceOrderResponse response = ModelPlaceOrderResponse.fromJson(jsonDecode(value));
      showToast(response.message.toString());
      if (response.status == true) {
        Get.offNamed(OrderCompleteScreen.route, arguments: response.data!.orderId.toString());
        getCart();
      }
    });
  }

  addCart({
    required BuildContext context,
    required String id,
    required String orderId,
    required String productId,
    required String productName,
  }) {
    Map<String, dynamic> map = {};
    map["id"] = id;
    map["orderId"] = orderId;
    map["productId"] = productId;
    map["productName"] = productName;
    repositories.postApi(url: ApiUrls.editAddressUrl, context: context, mapData: map).then((value) {
      ModelCommonResponse response = ModelCommonResponse.fromJson(jsonDecode(value));
      showToast(response.message.toString());
      if (response.status == true) {
        getAddress();
        Get.back();
      }
    });
  }

  updateAddressApi(
      {required String firstName,
      required String lastName,
      required String phone,
      required String alternatePhone,
      required String address,
      required String address2,
      required String city,
      required String country,
      required String state,
      required String zipCode,
      required String landmark,
      required String title,
      required BuildContext context,
      id}) {
    Map<String, dynamic> map = {};

    if (id != null) {
      map["id"] = id;
    }
    map["first_name"] = firstName;
    map["last_name"] = lastName;
    map["phone"] = phone;
    map["alternate_phone"] = alternatePhone;
    map["address"] = address;
    map["address2"] = address2;
    map["city"] = city;
    map["address_type"] = "shipping";
    map["country"] = country;
    map["state"] = state;
    map["zip_code"] = zipCode;
    map["landmark"] = landmark;
    map["title"] = title;

    repositories.postApi(url: ApiUrls.editAddressUrl, context: context, mapData: map).then((value) {
      ModelCommonResponse response = ModelCommonResponse.fromJson(jsonDecode(value));
      showToast(response.message.toString());
      if (response.status == true) {
        getAddress();
        Get.back();
      }
    });
  }

  Future<bool> deleteAddress(
      {required BuildContext context,
      required String id
      }) async {
    Map<String, dynamic> map = {};
    map["id"] = id;

    await repositories.postApi(url: ApiUrls.deleteAddressUrl, context: context, mapData: map).then((value) {
      ModelCommonResponse response = ModelCommonResponse.fromJson(jsonDecode(value));
      showToast(response.message.toString());
      if (response.status == true) {
        getAddress();
        return true;
        // Get.back();
      }
    }).catchError((e){return false;});
    return false;
  }

  getAddress() {
    repositories.postApi(url: ApiUrls.addressListUrl).then((value) {
      addressListModel = ModelUserAddressList.fromJson(jsonDecode(value));
      addressLoaded = true;
      updateUI();
    });
  }

  removeItemFromCart({
    required String productId,
    BuildContext? context,
  }) {
    Map<String, dynamic> map = {};
    map["product_id"] = productId;
    repositories.postApi(url: ApiUrls.deleteCartUrl, context: context, mapData: map).then((value) {
      ModelCommonResponse response = ModelCommonResponse.fromJson(jsonDecode(value));
      showToast(response.message.toString());
      getCart();
    });
  }

  Future getCart() async {
    await repositories.postApi(url: ApiUrls.cartListUrl).then((value) {
      cartModel = ModelCartResponse.fromJson(jsonDecode(value));
      apiLoaded = true;
      updateUI();
    });
  }

  updateUI() {
    refreshInt.value = DateTime.now().microsecondsSinceEpoch;
  }

  @override
  void onInit() {
    super.onInit();
    getCart();
  }
}
