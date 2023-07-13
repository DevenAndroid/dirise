import 'dart:convert';

import 'package:dirise/model/common_modal.dart';
import 'package:dirise/repoistery/repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../model/model_address_list.dart';
import '../model/model_cart_response.dart';
import '../utils/ApiConstant.dart';

class CartController extends GetxController{

  RxInt refreshInt = 0.obs;
  final Repositories repositories = Repositories();
  ModelCartResponse cartModel = ModelCartResponse(cart: []);
  bool apiLoaded = false;
  ModelUserAddressList addressListModel = ModelUserAddressList();
  bool addressLoaded = false;


  placeOrder({required BuildContext context}){
    Map<String, dynamic> gg = {
      "shipping_price": "2",
      "subtotPrice": "1800",
      "gift_card_amount": "0",
      "totPrice": "1800",
      "cart_id": [
        "2"
      ],

      "coupon_code": "OMI007",
      "currency_code": "usd",
      "refund_amount_in": "bank",
      "shipping_method": "test",
      "shipping": [
        {
          "store_id": 13,
          "store_name": "vendor",
          "title": "Normal Shipping",
          "ship_price": "2"
        }
        ],
      "currency_sign": "\$",
      "shipping_address": {
        "first_name": "Dheeraj",
        "last_name": "Malviya",
        "phone": "7689060758",
        "alternate_phone": "",
        "address": "Basantgarh",
        "address2": "Sirohi",
        "address_type": "shipping",
        "city": "Fuan",
        "country": "United Kingdom",
        "state": "Fujian",
        "zip_code": "1111",
        "landmark": "Rajasthan"
      },
      "billing_address": {
        "first_name": "neha sharma",
        "last_name": "neha sharma",
        "phone": "567890543",
        "alternate_phone": "1234354",
        "address": "Ls Nagar, Vidyadharnagar, jaipur",
        "address2": "Ls Nagar, Vidyadharnagar, jaipur",
        "address_type": "billing",
        "city": "Jaipur",
        "country": "india",
        "state": "Jaipur",
        "zip_code": "302050",
        "landmark": "near biyani college"
      }
    };
    repositories.postApi(url: "url",context: context,mapData: gg);
  }



  updateAddressApi({
    required String firstName,
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
      if(response.status == true) {
        getAddress();
        Get.back();
      }
    });
  }

  getAddress(){
    repositories.postApi(url: ApiUrls.addressListUrl).then((value) {
      addressListModel = ModelUserAddressList.fromJson(jsonDecode(value));
      addressLoaded = true;
      updateUI();
    });
  }

  removeItemFromCart({
    required String productId,
    BuildContext? context,
  }){
    Map<String, dynamic> map = {};
    map["product_id"] = productId;
    repositories.postApi(url: ApiUrls.deleteCartUrl,context: context,mapData: map).then((value) {
      ModelCommonResponse response = ModelCommonResponse.fromJson(jsonDecode(value));
      showToast(response.message.toString());
      getCart();
    });
  }
  
  getCart(){
    repositories.postApi(url: ApiUrls.cartListUrl).then((value) {
      cartModel = ModelCartResponse.fromJson(jsonDecode(value));
      apiLoaded = true;
      updateUI();
    });
  }

  updateUI(){
    refreshInt.value = DateTime.now().microsecondsSinceEpoch;
  }

  @override
  void onInit() {
    super.onInit();
    getCart();
  }


}