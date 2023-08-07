import 'dart:convert';
import 'package:dirise/model/common_modal.dart';
import 'package:dirise/repository/repository.dart';
import 'package:dirise/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';
import '../model/model_address_list.dart';
import '../model/model_cart_response.dart';
import '../model/order_models/place_order_response.dart';
import '../screens/check_out/order_completed_screen.dart';
import '../utils/ApiConstant.dart';

enum PurchaseType { buy, cart }

class CartController extends GetxController {
  RxInt refreshInt = 0.obs;
  final Repositories repositories = Repositories();
  ModelCartResponse cartModel = ModelCartResponse(cart: []);
  bool apiLoaded = false;
  ModelUserAddressList addressListModel = ModelUserAddressList();
  bool addressLoaded = false;
  // AddressData selectedAddress = AddressData();
  // String? cou ponCode1;

  placeOrder({
    required BuildContext context,
    required String subTotalPrice,
    required String totalPrice,
    required String currencyCode,
    required String deliveryOption,
    String? couponCode,
    String? shippingPrice,
    String? productID,
    String? quantity,
    String? otp,
    required PurchaseType purchaseType,
    Map<String, dynamic>? address,
  }) {
    Map<String, dynamic> gg = {
      if (shippingPrice != null) "shipping_price": shippingPrice,
      if (otp != null) "otp": otp,
      if (productID != null) "product_id": productID,
      if (quantity != null) "quantity": quantity,
      "type": purchaseType.name,
      "subtotPrice": subTotalPrice,
      "total": totalPrice,
      "delivery_type": deliveryOption, // delivery or pickup
      "totPrice": totalPrice,
      if (couponCode != null) "coupon_code": couponCode,
      "currency_code": currencyCode,
      "refund_amount_in": "bank",
      "shipping_method": "test",
      "currency_sign": "\$",
      "shipping": [
        {
          "store_id": 13,
          "store_name": "vendor",
          "title": "Normal Shipping",
          "ship_price": "2"
        }
      ],
      "cart_id": [
        "2"
      ],
      if (address != null) "shipping_address": address,
      if (address != null) "billing_address": address
    };
    repositories
        .postApi(url: ApiUrls.placeOrderUrl, context: context, mapData: gg)
        .then((value) {
      // ModelCommonResponse response = ModelCommonResponse.fromJson(jsonDecode(value));
      ModelPlaceOrderResponse response =
          ModelPlaceOrderResponse.fromJson(jsonDecode(value));
      showToast(response.message.toString());
      if (response.status == true) {
        getCart();
        // if(re)
        if (dialogOpened) {
          Get.back();
        }
        Get.offNamed(OrderCompleteScreen.route,
            arguments: response.order_id.toString());
      } else {
        if (response.message.toString().toLowerCase().contains("otp")) {
          if (dialogOpened == false) {
            showOTPDialog(
                context: context,
                purchaseType: purchaseType,
                subTotalPrice: subTotalPrice,
                currencyCode: currencyCode,
                totalPrice: totalPrice,
                address: address,
                productID: productID,
                quantity: quantity,
                deliveryOption: deliveryOption,
                couponCode: couponCode);
          }
        }
      }
    });
  }

  bool dialogOpened = false;

  showOTPDialog({
    required BuildContext context,
    required PurchaseType purchaseType,
    required String subTotalPrice,
    required String totalPrice,
    required String currencyCode,
    required String deliveryOption,
    String? couponCode,
    String? quantity,
    String? productID,
    Map<String, dynamic>? address,
  }) {
    dialogOpened = true;
    final TextEditingController otpController = TextEditingController();
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "OPT has been sent to your given email address\n"
                    "Verify email to place order",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                  12.spaceY,
                  Pinput(
                    controller: otpController,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    keyboardType: TextInputType.number,
                    length: 4,
                    defaultPinTheme: defaultPinTheme,
                  ),
                  15.spaceY,
                  Text(
                    "Didn't you receive the OTP?",
                    style: GoogleFonts.poppins(
                        color: const Color(0xff3D4260), fontSize: 17),
                  ),
                  15.spaceY,
                  GestureDetector(
                    onTap: () async {
                      placeOrder(
                          context: context,
                          currencyCode: currencyCode,
                          subTotalPrice: subTotalPrice,
                          totalPrice: totalPrice,
                          couponCode: couponCode,
                          quantity: quantity,
                          deliveryOption: deliveryOption,
                          productID: productID,
                          purchaseType: purchaseType,
                          address: address);
                    },
                    child: Text(
                      "Resend OTP",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          color: const Color(0xff578AE8),
                          fontSize: 16),
                    ),
                  ),
                  15.spaceY,
                  GestureDetector(
                    onTap: () async {
                      if (otpController.text.trim().isEmpty) {
                        showToast("Please enter otp");
                        return;
                      }
                      if (otpController.text.trim().length != 4) {
                        showToast("Please enter valid otp");
                        return;
                      }
                      placeOrder(
                          context: context,
                          currencyCode: currencyCode,
                          subTotalPrice: subTotalPrice,
                          totalPrice: totalPrice,
                          couponCode: couponCode,
                          quantity: quantity,
                          productID: productID,
                          deliveryOption: deliveryOption,
                          address: address,
                          purchaseType: purchaseType,
                          otp: otpController.text.trim());
                    },
                    child: Text(
                      "Submit",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          color: const Color(0xff578AE8),
                          fontSize: 16),
                    ),
                  ),
                  15.spaceY,
                ],
              ),
            ),
          );
        });
  }

  final defaultPinTheme = PinTheme(
      width: 45,
      height: 45,
      textStyle: GoogleFonts.poppins(
        fontSize: 18,
        color: const Color.fromRGBO(30, 60, 87, 1),
      ),
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
        color: Colors.grey.shade300,
        width: 4.0,
      ))));

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
    repositories
        .postApi(url: ApiUrls.editAddressUrl, context: context, mapData: map)
        .then((value) {
      ModelCommonResponse response =
          ModelCommonResponse.fromJson(jsonDecode(value));
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

    repositories
        .postApi(url: ApiUrls.editAddressUrl, context: context, mapData: map)
        .then((value) {
      ModelCommonResponse response =
          ModelCommonResponse.fromJson(jsonDecode(value));
      showToast(response.message.toString());
      if (response.status == true) {
        getAddress();
        Get.back();
      }
    });
  }

  Future<bool> deleteAddress(
      {required BuildContext context, required String id}) async {
    Map<String, dynamic> map = {};
    map["id"] = id;

    await repositories
        .postApi(url: ApiUrls.deleteAddressUrl, context: context, mapData: map)
        .then((value) {
      ModelCommonResponse response =
          ModelCommonResponse.fromJson(jsonDecode(value));
      showToast(response.message.toString());
      if (response.status == true) {
        getAddress();
        return true;
        // Get.back();
      }
    }).catchError((e) {
      return false;
    });
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
    repositories
        .postApi(url: ApiUrls.deleteCartUrl, context: context, mapData: map)
        .then((value) {
      ModelCommonResponse response =
          ModelCommonResponse.fromJson(jsonDecode(value));
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
