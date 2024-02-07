import 'dart:async';
import 'dart:convert';
import 'package:dirise/model/common_modal.dart';
import 'package:dirise/repository/repository.dart';
import 'package:dirise/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';
import '../language/app_strings.dart';
import '../model/model_address_list.dart';
import '../model/model_cart_response.dart';
import '../model/order_models/place_order_response.dart';
import '../screens/check_out/order_completed_screen.dart';
import '../utils/api_constant.dart';
import '../vendor/authentication/payment_screen.dart';
import '../vendor/authentication/thank_you_screen.dart';

enum PurchaseType { buy, cart }

class CartController extends GetxController {
  RxInt refreshInt = 0.obs;
  final Repositories repositories = Repositories();
  ModelCartResponse cartModel = ModelCartResponse();
  bool apiLoaded = false;
  ModelUserAddressList addressListModel = ModelUserAddressList();
  bool addressLoaded = false;
  String shippingId = "";
  AddressData selectedAddress = AddressData();
  final GlobalKey addressKey = GlobalKey();
  RxString deliveryOption = "".obs;

  RxBool showValidation = false.obs;
  RxBool showValidationShipping = false.obs;

  RxInt countDown = 30.obs;
  Timer? _timer;
  List<int> shippingList = [];
  startTimer() {
    stopTimer();
    countDown.value = 30;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (countDown.value != 0) {
        countDown.value--;
      } else {
        stopTimer();
      }
    });
  }

  stopTimer() {
    try {
      if (_timer == null) return;
      _timer!.cancel();
      _timer = null;
    } catch (e) {
      return;
    }
  }

  placeOrder({
    required BuildContext context,
    required String subTotalPrice,
    required String totalPrice,
    required String currencyCode,
    required String deliveryOption,
    required String paymentMethod,
    String? couponCode,
    required String idd,
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
      "payment_method": paymentMethod,
      "delivery_type": deliveryOption, // delivery or pickup
      "totPrice": totalPrice,
      if (couponCode != null) "coupon_code": couponCode,
      "currency_code": currencyCode,
      "refund_amount_in": "bank",
      "shipping_method": "online",
      "currency_sign": "\$",
      'callback_url': 'https://dirise.eoxyslive.com/home/$navigationBackUrl',
      'failure_url': 'https://dirise.eoxyslive.com/home/$failureUrl',
      "shipping": [
        {"store_id": 13, "store_name": "vendor", "title": "Normal Shipping", "ship_price": "2" , "shipping_type_id": shippingList.join(',')}
      ],
      "cart_id": ["2"],
      if (address != null) "shipping_address": address,
      if (address != null) "billing_address": address
    };
    repositories.postApi(url: ApiUrls.placeOrderUrl, context: context, mapData: gg).then((value) {
      // ModelCommonResponse response = ModelCommonResponse.fromJson(jsonDecode(value));
      ModelPlaceOrderResponse response = ModelPlaceOrderResponse.fromJson(jsonDecode(value));
      showToast(response.message.toString());
      if (response.status == true) {
        getCart();
        // if(re)
        if (dialogOpened) {
          Get.back();
        }
        Get.to(() => PaymentScreen(
              paymentUrl: response.URL.toString(),
              onSuccess: () {
                Get.offNamed(OrderCompleteScreen.route, arguments: response.order_id.toString());
              },
            ));
      } else {
        if (response.message.toString().toLowerCase().contains("otp")) {
          startTimer();
          if (dialogOpened == false) {
            showOTPDialog(
                context: context,
                paymentMethod: paymentMethod,
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
    required String paymentMethod,
    String? couponCode,
    String? quantity,
    String? productID,
    Map<String, dynamic>? address,
  }) {
    dialogOpened = true;
    final TextEditingController otpController = TextEditingController();
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return Dialog(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  6.spaceY,
                  Text(
                    AppStrings.otpHasBeenSent,
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
                    AppStrings.doNotReceivedOtp,
                    style:
                        GoogleFonts.poppins(color: const Color(0xff3D4260), fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  TextButton(
                    onPressed: () async {
                      if (countDown.value != 0) return;
                      placeOrder(
                          context: context,
                          paymentMethod: paymentMethod,
                          currencyCode: currencyCode,
                          subTotalPrice: subTotalPrice,
                          totalPrice: totalPrice,
                          couponCode: couponCode,
                          quantity: quantity,
                          deliveryOption: deliveryOption,
                          productID: productID,
                          purchaseType: purchaseType,
                          address: address, idd: '');
                    },
                    child: Obx(() => Text(
                          countDown.value != 0 ? "Resend OTP in ${countDown.value}s" : AppStrings.resendOtp,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600, color: const Color(0xff578AE8), fontSize: 16),
                        )),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: () async {
                            Get.back();
                            stopTimer();
                          },
                          child: Text(
                            "Cancel",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w600, color: Theme.of(context).colorScheme.error, fontSize: 16),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: TextButton(
                          onPressed: () async {
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
                                paymentMethod: paymentMethod,
                                currencyCode: currencyCode,
                                subTotalPrice: subTotalPrice,
                                totalPrice: totalPrice,
                                couponCode: couponCode,
                                quantity: quantity,
                                productID: productID,
                                deliveryOption: deliveryOption,
                                address: address,
                                purchaseType: purchaseType,
                                otp: otpController.text.trim(), idd: shippingId);
                          },
                          child: Text(
                            "Submit",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w600, color: const Color(0xff578AE8), fontSize: 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                  5.spaceY,
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
    final map = {
      if(id != null)
        'id': id,
      'first_name': firstName,
      'last_name': lastName,
      'phone': phone,
      'alternate_phone': alternatePhone,
      'address_type': 'shipping',
      'address': address,
      'address2': address2,
      'zip_code': zipCode,
      'landmark': landmark,
      'title': title,
      'country_id': country,
      'state_id': state,
      'city_id': city
    };

    // Map<String, dynamic> map = {};
    //
    // if (id != null) {
    //   map["id"] = id;
    // }
    // map["first_name"] = firstName;
    // map["last_name"] = lastName;
    // map["phone"] = phone;
    // map["alternate_phone"] = alternatePhone;
    // map["address"] = address;
    // map["address2"] = address2;
    // map["city"] = city;
    // map["address_type"] = "shipping";
    // map["country"] = country;
    // map["state"] = state;
    // map["zip_code"] = zipCode;
    // map["landmark"] = landmark;
    // map["title"] = title;

    repositories.postApi(url: ApiUrls.editAddressUrl, context: context, mapData: map).then((value) {
      ModelCommonResponse response = ModelCommonResponse.fromJson(jsonDecode(value));
      showToast(response.message.toString());
      if (response.status == true) {
        getAddress();
        Get.back();
      }
    });
  }

  Future<bool> deleteAddress({required BuildContext context, required String id}) async {
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
    }).catchError((e) {
      return false;
    });
    return false;
  }

  Future updateCartQuantity({
    required BuildContext context,
    required String productId,
    required String quantity,
  }) async {
    final map = {
      "product_id": productId,
      "qty": quantity,
    };

    await repositories.postApi(url: ApiUrls.quantityUpdateUrl, context: context, mapData: map).then((value) {
      ModelCommonResponse response = ModelCommonResponse.fromJson(jsonDecode(value));
      showToast(response.message.toString());
      getCart();
    }).catchError((e) {});
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
    // if (cartModel.cart != null) {
    //   for (var element in cartModel.cart!) {
    //     element.showDetails.value = false;
    //   }
    // }
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

  @override
  void dispose() {
    super.dispose();
    stopTimer();
  }
}
