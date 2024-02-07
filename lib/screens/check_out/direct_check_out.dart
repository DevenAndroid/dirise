import 'dart:convert';
import 'dart:developer';

import 'package:dirise/utils/helper.dart';
import 'package:dirise/widgets/customsize.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../controller/cart_controller.dart';
import '../../controller/profile_controller.dart';
import '../../model/model_address_list.dart';
import '../../model/model_cart_response.dart';
import '../../model/order_models/model_direct_order_details.dart';
import '../../model/vendor_models/model_payment_method.dart';
import '../../repository/repository.dart';
import '../../utils/api_constant.dart';
import '../../utils/styles.dart';
import '../../widgets/common_colour.dart';
import '../../widgets/common_textfield.dart';
import '../../widgets/loading_animation.dart';

class DirectCheckOutScreen extends StatefulWidget {
  static String route = "/DirectCheckOutScreen";
  const DirectCheckOutScreen({super.key});

  @override
  State<DirectCheckOutScreen> createState() => _DirectCheckOutScreenState();
}

class _DirectCheckOutScreenState extends State<DirectCheckOutScreen> {
  final cartController = Get.put(CartController());
  final profileController = Get.put(ProfileController());
  final TextEditingController deliveryInstructions = TextEditingController();
  AddressData selectedAddress = AddressData();
  final GlobalKey addressKey = GlobalKey();

  ModelPaymentMethods? methods;
  getPaymentGateWays() {
    Repositories().getApi(url: ApiUrls.paymentMethodsUrl).then((value) {
      methods = ModelPaymentMethods.fromJson(jsonDecode(value));
      setState(() {});
    });
  }

  String paymentMethod1 = "";
  RxBool showValidation = false.obs;
  RxString deliveryOption = "".obs;
  RxString paymentOption = "".obs;

  bool get userLoggedIn => profileController.userLoggedIn;
  ModelDirectOrderResponse directOrderResponse = ModelDirectOrderResponse();

  @override
  void initState() {
    super.initState();

    getPaymentGateWays();
    if (Get.arguments != null) {
      directOrderResponse = Get.arguments;
    }
    profileController.checkUserLoggedIn().then((value) {
      if (value == false) return;
    });
    cartController.getAddress();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xffF5F5F5),
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Color(0xff014E70), size: 20),
          onPressed: () => Navigator.of(context).pop(),
        ),
        titleSpacing: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Checkout".tr,
              style: GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 22),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            addressPart(size),
            const SizedBox(
              height: 30,
            ),
            paymentMethod(size),
            Column(
              children: [
                Obx(() {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 15).copyWith(top: 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                              Text(
                                "${'Sold By'.tr} ${directOrderResponse.prodcutData!.slug.toString()}",
                                style: titleStyle,
                              ),
                            addHeight(20),
                            IntrinsicHeight(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 75,
                                    height: 75,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: Image.network(
                                        directOrderResponse.prodcutData!.featureImageApp.toString(),
                                        fit: BoxFit.contain,
                                        errorBuilder: (_, __, ___) => const SizedBox.shrink(),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 16,
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          directOrderResponse.prodcutData!.pName.toString(),
                                          style: titleStyle.copyWith(fontWeight: FontWeight.w400),
                                          textAlign: TextAlign.start,
                                        ),
                                        const SizedBox(
                                          height: 6,
                                        ),
                                        Text(
                                          '\$${directOrderResponse.prodcutData!.pPrice.toString()}',
                                          style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w400),
                                        ),
                                        const SizedBox(
                                          height: 4,
                                        ),
                                        IntrinsicHeight(
                                          child: Row(
                                            children: [
                                              IconButton(
                                                  onPressed: () {
                                                    if (directOrderResponse.returnData!.quantity.toNum > 1) {
                                                      cartController.updateCartQuantity(
                                                          context: context,
                                                          productId: directOrderResponse.prodcutData!.id.toString(),
                                                          quantity: (directOrderResponse.returnData!.quantity.toNum - 1).toString());
                                                    } else {
                                                      cartController.removeItemFromCart(
                                                          productId: directOrderResponse.prodcutData!.id.toString(), context: context);
                                                    }
                                                  },
                                                  style: IconButton.styleFrom(
                                                    shape: RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.circular(2)),
                                                    backgroundColor: AppTheme.buttonColor,
                                                  ),
                                                  constraints: const BoxConstraints(minHeight: 0),
                                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                                                  visualDensity: VisualDensity.compact,
                                                  icon: const Icon(
                                                    Icons.remove,
                                                    color: Colors.white,
                                                    size: 20,
                                                  )),
                                              5.spaceX,
                                              Container(
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(2),
                                                    // color: Colors.grey,
                                                    border: Border.all(color: Colors.grey.shade800)),
                                                margin: const EdgeInsets.symmetric(vertical: 6),
                                                padding: const EdgeInsets.symmetric(horizontal: 15),
                                                alignment: Alignment.center,
                                                child: Text(
                                                  directOrderResponse.returnData!.quantity.toString(),
                                                  style: normalStyle,
                                                ),
                                              ),
                                              5.spaceX,
                                              IconButton(
                                                  onPressed: () {
                                                    if (directOrderResponse.returnData!.quantity.toString().toNum <
                                                        directOrderResponse.prodcutData!.stockAlert.toString().toNum) {
                                                      cartController.updateCartQuantity(
                                                          context: context,
                                                          productId:   directOrderResponse.prodcutData!.id.toString(),
                                                          quantity: (directOrderResponse.returnData!.quantity.toString().toNum + 1).toString());
                                                    }
                                                  },
                                                  style: IconButton.styleFrom(
                                                    shape: RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.circular(2)),
                                                    backgroundColor: AppTheme.buttonColor,
                                                  ),
                                                  constraints: const BoxConstraints(minHeight: 0),
                                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                                                  visualDensity: VisualDensity.compact,
                                                  icon: const Icon(
                                                    Icons.add,
                                                    color: Colors.white,
                                                    size: 20,
                                                  )),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        cartController.removeItemFromCart(
                                            productId:   directOrderResponse.prodcutData!.id.toString(), context: context);
                                      },
                                      visualDensity: VisualDensity.compact,
                                      icon: SvgPicture.asset(
                                        "assets/svgs/delete.svg",
                                        height: 18,
                                        width: 18,
                                      ))
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      10.spaceY,
                      if (deliveryOption.value == "delivery")
                     directOrderResponse.prodcutData!.isShipping == true ? Column(
                        children: [

                            Container(
                              color: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image.asset('assets/images/shipping_icon.png', height: 32, width: 32),
                                    20.spaceX,
                                    Text("Shipping Method".tr,
                                        style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 18)),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              color: Colors.white,
                              child: ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount:    directOrderResponse.shippingType!.length,
                                padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 15).copyWith(top: 0),
                                itemBuilder: (context, ii) {
                                  var product = directOrderResponse.shippingType![ii];
                                  return Obx(() {
                                    return Column(
                                      children: [
                                        10.spaceY,
                                        ii == 0 ? 0.spaceY : const Divider(
                                          color: Color(0xFFD9D9D9),
                                          thickness: 0.8,
                                        ),
                                        Row(
                                          children: [
                                            Radio(
                                              value: product.id.toString(),
                                              groupValue: directOrderResponse.shippingOption.value,
                                              visualDensity: const VisualDensity(horizontal: -4.0),
                                              onChanged: (value) {
                                                setState(() {
                                                  directOrderResponse.shippingOption.value = value.toString();
                                                  cartController.shippingId =  directOrderResponse.shippingOption.value;
                                                  log( directOrderResponse.shippingOption.value);
                                                  log(cartController.shippingId);
                                                });
                                              },
                                            ),
                                            20.spaceX,
                                            Text(product.name.toString().capitalize!.replaceAll('_', ' '),
                                                style: GoogleFonts.poppins(fontWeight: FontWeight.w400, fontSize: 16)),
                                          ],
                                        ),
                                      ],
                                    );
                                  });
                                  // : 0.spaceY,;
                                },
                              ),
                            ),
                        ],
                      ): 
                      const Text('No Shipping Found For This Product'),
                    ],
                  );
                })
              ],
            ),
            Column(
              children: [
                Container(
                  decoration: const BoxDecoration(color: Colors.white),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 15,
                        ),
                        Text("Add delivery instructions".tr,
                            style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 18)),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          style: GoogleFonts.poppins(),
                          controller: deliveryInstructions,
                          decoration: InputDecoration.collapsed(
                              hintText: "Add delivery instructions to help us with the delivery".tr,
                              hintStyle: GoogleFonts.poppins(color: const Color(0xff949495), fontSize: 14)),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
            Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Your Order".tr, style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 18)),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("${'Subtotal'.tr} (${directOrderResponse.quantity} ${'items'.tr})",
                          style: GoogleFonts.poppins(fontWeight: FontWeight.w400, color: const Color(0xff949495))),
                      Text("KWD ${directOrderResponse.subtotal.toString()}",
                          style: GoogleFonts.poppins(fontWeight: FontWeight.w400, color: const Color(0xff949495))),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Shipping".tr,
                          style: GoogleFonts.poppins(fontWeight: FontWeight.w400, color: const Color(0xff949495))),
                      Text("KWD ${directOrderResponse.shipping.toString()}",
                          style: GoogleFonts.poppins(fontWeight: FontWeight.w400, color: const Color(0xff949495))),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Total".tr, style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 18)),
                      Text("KWD ${directOrderResponse.total.toString()}",
                          style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 18)),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: InkWell(
        onTap: () {
          showValidation.value = true;
          if (deliveryOption.value.isEmpty) {
            BuildContext? context1 = addressKey.currentContext;
            if (context1 != null) {
              Scrollable.ensureVisible(context1, duration: const Duration(milliseconds: 650));
            }
            showToast("Please select delivery options".tr);
            return;
          }
          if (deliveryOption.value == "delivery" && selectedAddress.id == null) {
            BuildContext? context1 = addressKey.currentContext;
            if (context1 != null) {
              Scrollable.ensureVisible(context1, duration: const Duration(milliseconds: 650));
            }
            showToast("Select delivery address to complete order".tr);
            return;
          }
          cartController.dialogOpened = false;
          cartController.placeOrder(
              idd: cartController.shippingId,
              context: context,
              currencyCode: "usd",
              paymentMethod: paymentMethod1,
              deliveryOption: deliveryOption.value,
              productID: directOrderResponse.prodcutData!.id.toString(),
              subTotalPrice: directOrderResponse.subtotal.toString(),
              totalPrice: directOrderResponse.total.toString(),
              quantity: directOrderResponse.quantity.toString(),
              purchaseType: PurchaseType.buy,
              address: selectedAddress.toJson());
        },
        child: Container(
          decoration: const BoxDecoration(color: Color(0xff014E70)),
          height: 56,
          alignment: Alignment.bottomCenter,
          child: Align(
              alignment: Alignment.center,
              child: Text("Complete Payment".tr,
                  style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 18, color: Colors.white))),
        ),
      ),
    );
  }

  Column paymentMethod(Size size) {
    return Column(
      children: [
        Container(
          decoration: const BoxDecoration(color: Colors.white),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 15),
                Text("Payment".tr, style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 18)),
                const SizedBox(
                  height: 15,
                ),
                // Row(
                //   children: [
                //     Container(
                //       width: size.width * .3,
                //       height: size.height * .08,
                //       decoration: BoxDecoration(
                //           border: Border.all(color: const Color(0xffAFB1B1)), borderRadius: BorderRadius.circular(12)),
                //       alignment: Alignment.center,
                //       child: Column(
                //         crossAxisAlignment: CrossAxisAlignment.center,
                //         mainAxisAlignment: MainAxisAlignment.center,
                //         children: [
                //           Image.asset(
                //             "assets/images/knet.png",
                //             width: 50,
                //             height: 55,
                //           )
                //         ],
                //       ),
                //     ),
                //     const SizedBox(
                //       width: 15,
                //     ),
                //     Container(
                //       width: size.width * .3,
                //       height: size.height * .08,
                //       decoration: BoxDecoration(
                //           border: Border.all(color: const Color(0xffAFB1B1)), borderRadius: BorderRadius.circular(12)),
                //       alignment: Alignment.center,
                //       child: Column(
                //         mainAxisAlignment: MainAxisAlignment.center,
                //         children: [
                //           const Icon(
                //             Icons.credit_card,
                //             color: Color(0xffAFB1B1),
                //           ),
                //           Text("Credit Card".tr, style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 12)),
                //         ],
                //       ),
                //     )
                //   ],
                // ),
                if (methods != null && methods!.data != null)
                  DropdownButtonFormField(
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          borderSide: BorderSide(color: AppTheme.secondaryColor),
                        ),
                        enabled: true,
                        filled: true,
                        hintText: "Select Payment Method".tr,
                        labelStyle: GoogleFonts.poppins(color: Colors.black),
                        labelText: "Select Payment Method".tr,
                        fillColor: const Color(0xffE2E2E2).withOpacity(.35),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 14),
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          borderSide: BorderSide(color: AppTheme.secondaryColor),
                        ),
                      ),
                      isExpanded: true,
                      items: methods!.data!
                          .map((e) => DropdownMenuItem(
                          value: e.paymentMethodId.toString(),
                          child: Row(
                            children: [
                              Expanded(child: Text(e.paymentMethodEn.toString())),
                              SizedBox(width: 35, height: 35, child: Image.network(e.imageUrl.toString()))
                            ],
                          )))
                          .toList(),
                      onChanged: (value) {
                        if (value == null) return;
                        paymentMethod1 = value;
                        setState(() {});
                      })
                else
                  const LoadingAnimation(),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 30,
        ),
      ],
    );
  }

  Container addressPart(Size size) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Padding(
        key: addressKey,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Obx(() {
          if (cartController.refreshInt.value > 0) {}
          return cartController.addressLoaded || profileController.userLoggedIn == false
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                            child:
                                Text("Delivery to".tr, style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 18))),
                        Radio<String>(
                            value: "delivery",
                            groupValue: deliveryOption.value,
                            visualDensity: VisualDensity.compact,
                            fillColor: deliveryOption.value.isEmpty && showValidation.value
                                ? MaterialStateProperty.all(Colors.red)
                                : null,
                            onChanged: (value) {
                              deliveryOption.value = value!;
                            })
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    if (deliveryOption.value == "delivery") ...[
                      Material(
                        child: InkWell(
                          onTap: () {
                            if (userLoggedIn) {
                              bottomSheetChangeAddress();
                            } else {
                              addAddressWithoutLogin(addressData: selectedAddress);
                            }
                          },
                          child: DottedBorder(
                            color: const Color(0xff014E70),
                            strokeWidth: 1.2,
                            dashPattern: const [6, 3, 0, 3],
                            child: Container(
                              // height: 50,
                              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                              width: size.width,
                              alignment: Alignment.center,
                              child: selectedAddress.id != null
                                  ? Text(selectedAddress.getShortAddress,
                                      style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 16))
                                  : Text("Select Address ".tr,
                                      style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 16)),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      if (selectedAddress.id != null)
                        InkWell(
                            onTap: () {
                              if (userLoggedIn) {
                                bottomSheetChangeAddress();
                              } else {
                                addAddressWithoutLogin(addressData: selectedAddress);
                              }
                            },
                            child: Align(
                                alignment: Alignment.topRight,
                                child: Text("Change Address".tr,
                                    style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500)))),
                    ],
                    Row(
                      children: [
                        Expanded(
                            child: Text("Pick Up".tr, style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 18))),
                        Radio<String>(
                            value: "pickup",
                            groupValue: deliveryOption.value,
                            visualDensity: VisualDensity.compact,
                            fillColor: deliveryOption.value.isEmpty && showValidation.value
                                ? MaterialStateProperty.all(Colors.red)
                                : null,
                            onChanged: (value) {
                              deliveryOption.value = value!;
                            })
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                )
              : const LoadingAnimation();
        }),
      ),
    );
  }

  Future bottomSheet({required AddressData addressData}) {
    Size size = MediaQuery.of(context).size;
    final TextEditingController firstNameController = TextEditingController(text: addressData.firstName ?? "");
    final TextEditingController lastNameController = TextEditingController(text: addressData.lastName ?? "");
    final TextEditingController phoneController = TextEditingController(text: addressData.phone ?? "");
    final TextEditingController alternatePhoneController = TextEditingController(text: addressData.alternatePhone ?? "");
    final TextEditingController addressController = TextEditingController(text: addressData.address ?? "");
    final TextEditingController address2Controller = TextEditingController(text: addressData.address2 ?? "");
    final TextEditingController cityController = TextEditingController(text: addressData.city ?? "");
    final TextEditingController countryController = TextEditingController(text: addressData.country ?? "");
    final TextEditingController stateController = TextEditingController(text: addressData.state ?? "");
    final TextEditingController zipCodeController = TextEditingController(text: addressData.zipCode ?? "");
    final TextEditingController landmarkController = TextEditingController(text: addressData.landmark ?? "");
    final TextEditingController titleController = TextEditingController(text: addressData.type ?? "");

    final formKey = GlobalKey<FormState>();

    return showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.white,
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.all(20),
            child: SizedBox(
              width: size.width,
              height: size.height * .8,
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ...commonField(
                          textController: titleController,
                          title: "${'Title'.tr}*",
                          hintText: "Title".tr,
                          keyboardType: TextInputType.name,
                          validator: (value) {
                            if (value!.trim().isEmpty) {
                              return "Please enter address title".tr;
                            }
                            return null;
                          }),
                      ...commonField(
                          textController: firstNameController,
                          title: "${'First Name'.tr}*",
                          hintText: "First Name".tr,
                          keyboardType: TextInputType.name,
                          validator: (value) {
                            if (value!.trim().isEmpty) {
                              return "Please enter first name".tr;
                            }
                            return null;
                          }),
                      ...commonField(
                          textController: lastNameController,
                          title: "${'Last Name'.tr}*",
                          hintText: "Last Name".tr,
                          keyboardType: TextInputType.name,
                          validator: (value) {
                            if (value!.trim().isEmpty) {
                              return "Please enter Last name".tr;
                            }
                            return null;
                          }),
                      ...commonField(
                          textController: phoneController,
                          title: "${'Phone'.tr}*",
                          hintText: "Enter your phone number".tr,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value!.trim().isEmpty) {
                              return "Please enter phone number".tr;
                            }
                            if (value.trim().length > 15) {
                              return "Please enter valid phone number".tr;
                            }
                            if (value.trim().length < 8) {
                              return "Please enter valid phone number".tr;
                            }
                            return null;
                          }),
                      ...commonField(
                          textController: alternatePhoneController,
                          title: "${'Alternate Phone'.tr}*",
                          hintText: "Enter your alternate phone number".tr,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            // if(value!.trim().isEmpty){
                            //   return "Please enter phone number";
                            // }
                            // if(value.trim().length > 15){
                            //   return "Please enter valid phone number";
                            // }
                            // if(value.trim().length < 8){
                            //   return "Please enter valid phone number";
                            // }
                            return null;
                          }),
                      ...commonField(
                          textController: addressController,
                          title: "${'Address'.tr}*",
                          hintText: "Enter your delivery address".tr,
                          keyboardType: TextInputType.streetAddress,
                          validator: (value) {
                            if (value!.trim().isEmpty) {
                              return "Please enter delivery address".tr;
                            }
                            return null;
                          }),
                      ...commonField(
                          textController: address2Controller,
                          title: "${'Address'.tr} 2",
                          hintText: "Enter your delivery address".tr,
                          keyboardType: TextInputType.streetAddress,
                          validator: (value) {
                            // if(value!.trim().isEmpty){
                            //   return "Please enter delivery address";
                            // }
                            return null;
                          }),
                      ...commonField(
                          textController: landmarkController,
                          title: "Landmark".tr,
                          hintText: "Enter your nearby landmark".tr,
                          keyboardType: TextInputType.streetAddress,
                          validator: (value) {
                            // if(value!.trim().isEmpty){
                            //   return "Please enter delivery address";
                            // }
                            return null;
                          }),
                      ...commonField(
                          textController: cityController,
                          title: "${'City'}*",
                          hintText: "Enter your city".tr,
                          keyboardType: TextInputType.streetAddress,
                          validator: (value) {
                            if (value!.trim().isEmpty) {
                              return "${'Please enter City'.tr}*";
                            }
                            return null;
                          }),
                      ...commonField(
                          textController: zipCodeController,
                          title: "${'Zip-Code'.tr}*",
                          hintText: "Enter location Zip-Code".tr,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value!.trim().isEmpty) {
                              return "${'Please enter Zip-Code'.tr}*";
                            }
                            return null;
                          }),
                      ...commonField(
                          textController: stateController,
                          title: "${'State'.tr}*",
                          hintText: "Enter your state".tr,
                          keyboardType: TextInputType.streetAddress,
                          validator: (value) {
                            if (value!.trim().isEmpty) {
                              return "${'Please enter state'.tr}*";
                            }
                            return null;
                          }),
                      ...commonField(
                          textController: countryController,
                          title: "${'Country'.tr}*",
                          hintText: "Enter your country".tr,
                          keyboardType: TextInputType.streetAddress,
                          validator: (value) {
                            if (value!.trim().isEmpty) {
                              return "${'Please enter country'.tr}*";
                            }
                            return null;
                          }),
                      const SizedBox(
                        height: 16,
                      ),
                      GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () {
                          if (formKey.currentState!.validate()) {
                            cartController.updateAddressApi(
                                context: context,
                                firstName: firstNameController.text.trim(),
                                title: titleController.text.trim(),
                                lastName: lastNameController.text.trim(),
                                state: stateController.text.trim(),
                                country: countryController.text.trim(),
                                city: cityController.text.trim(),
                                address2: address2Controller.text.trim(),
                                address: addressController.text.trim(),
                                alternatePhone: alternatePhoneController.text.trim(),
                                landmark: landmarkController.text.trim(),
                                phone: phoneController.text.trim(),
                                zipCode: zipCodeController.text.trim(),
                                id: addressData.id);
                          }
                        },
                        child: Container(
                          decoration: const BoxDecoration(color: Color(0xff014E70)),
                          height: 56,
                          alignment: Alignment.bottomCenter,
                          child: Align(
                              alignment: Alignment.center,
                              child: Text("Save".tr,
                                  style:
                                      GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 19, color: Colors.white))),
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  List<Widget> commonField({
    required TextEditingController textController,
    required String title,
    required String hintText,
    required FormFieldValidator<String>? validator,
    required TextInputType keyboardType,
  }) {
    return [
      const SizedBox(
        height: 5,
      ),
      Text(
        title,
        style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 18, color: const Color(0xff585858)),
      ),
      const SizedBox(
        height: 8,
      ),
      CommonTextField(
        controller: textController,
        obSecure: false,
        hintText: hintText,
        validator: validator,
        keyboardType: keyboardType,
      ),
    ];
  }

  Future bottomSheetChangeAddress() {
    Size size = MediaQuery.of(context).size;
    return showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.white,
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.all(20).copyWith(top: 10),
            child: SizedBox(
              width: size.width,
              height: size.height * .88,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 100,
                        height: 6,
                        decoration: BoxDecoration(color: Colors.grey.shade400, borderRadius: BorderRadius.circular(100)),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CommonTextField(
                    onTap: () {
                      // bottomSheet();
                    },
                    obSecure: false,
                    hintText: '+ ${'Add Address'.tr}',
                  ),
                  Expanded(
                    child: Obx(() {
                      if (cartController.refreshInt.value > 0) {}
                      List<AddressData> shippingAddress = cartController.addressListModel.address!.shipping ?? [];

                      return CustomScrollView(
                        shrinkWrap: true,
                        slivers: [
                          SliverToBoxAdapter(
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "Shipping Address".tr,
                                    style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 16),
                                  ),
                                ),
                                TextButton.icon(
                                    onPressed: () {
                                      bottomSheet(addressData: AddressData());
                                    },
                                    style: TextButton.styleFrom(padding: EdgeInsets.zero),
                                    icon: const Icon(
                                      Icons.add,
                                      size: 20,
                                    ),
                                    label: Text(
                                      "Add New".tr,
                                      style: GoogleFonts.poppins(fontSize: 15),
                                    ))
                              ],
                            ),
                          ),
                          const SliverPadding(padding: EdgeInsets.only(top: 4)),
                          shippingAddress.isNotEmpty
                              ? SliverList(
                                  delegate: SliverChildBuilderDelegate(
                                  childCount: shippingAddress.length,
                                  (context, index) {
                                    final address = shippingAddress[index];
                                    return GestureDetector(
                                      behavior: HitTestBehavior.translucent,
                                      onTap: () {
                                        selectedAddress = address;
                                        Get.back();
                                        setState(() {});
                                      },
                                      child: Container(
                                        width: size.width,
                                        margin: const EdgeInsets.only(bottom: 15),
                                        padding: const EdgeInsets.all(15),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            border: Border.all(color: const Color(0xffDCDCDC))),
                                        child: IntrinsicHeight(
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              const Icon(Icons.location_on_rounded),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Expanded(
                                                child: Text(
                                                  address.getCompleteAddressInFormat,
                                                  style: GoogleFonts.poppins(
                                                      fontWeight: FontWeight.w500,
                                                      fontSize: 15,
                                                      color: const Color(0xff585858)),
                                                ),
                                              ),
                                              Column(
                                                children: [
                                                  Flexible(
                                                    child: IconButton(
                                                        onPressed: () {
                                                          cartController
                                                              .deleteAddress(
                                                            context: context,
                                                            id: address.id.toString(),
                                                          )
                                                              .then((value) {
                                                            if (value == true) {
                                                              cartController.addressListModel.address!.shipping!.removeWhere(
                                                                  (element) =>
                                                                      element.id.toString() == address.id.toString());
                                                              cartController.updateUI();
                                                            }
                                                          });
                                                        },
                                                        icon: const Icon(Icons.delete)),
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      bottomSheet(addressData: address);
                                                    },
                                                    child: Text(
                                                      'Edit'.tr,
                                                      style: GoogleFonts.poppins(
                                                          shadows: [
                                                            const Shadow(color: Color(0xff014E70), offset: Offset(0, -4))
                                                          ],
                                                          color: Colors.transparent,
                                                          fontSize: 16,
                                                          fontWeight: FontWeight.w500,
                                                          decoration: TextDecoration.underline,
                                                          decorationColor: const Color(0xff014E70)),
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ))
                              : SliverToBoxAdapter(
                                  child: Text(
                                    "No Shipping Address Added!".tr,
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 16),
                                  ),
                                ),
                          SliverToBoxAdapter(
                            child: SizedBox(
                              height: MediaQuery.of(context).viewInsets.bottom,
                            ),
                          ),
                        ],
                      );
                    }),
                  ),
                ],
              ),
            ),
          );
        });
  }

  Future addAddressWithoutLogin({required AddressData addressData}) {
    Size size = MediaQuery.of(context).size;
    final TextEditingController firstNameController = TextEditingController(text: addressData.firstName ?? "");
    final TextEditingController emailController = TextEditingController(text: addressData.email ?? "");
    final TextEditingController lastNameController = TextEditingController(text: addressData.lastName ?? "");
    final TextEditingController phoneController = TextEditingController(text: addressData.phone ?? "");
    final TextEditingController alternatePhoneController = TextEditingController(text: addressData.alternatePhone ?? "");
    final TextEditingController addressController = TextEditingController(text: addressData.address ?? "");
    final TextEditingController address2Controller = TextEditingController(text: addressData.address2 ?? "");
    final TextEditingController cityController = TextEditingController(text: addressData.city ?? "");
    final TextEditingController countryController = TextEditingController(text: addressData.country ?? "");
    final TextEditingController stateController = TextEditingController(text: addressData.state ?? "");
    final TextEditingController zipCodeController = TextEditingController(text: addressData.zipCode ?? "");
    final TextEditingController landmarkController = TextEditingController(text: addressData.landmark ?? "");
    final TextEditingController titleController = TextEditingController(text: addressData.type ?? "");

    final formKey = GlobalKey<FormState>();

    return showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.white,
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.all(20),
            child: SizedBox(
              width: size.width,
              height: size.height * .8,
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ...commonField(
                          textController: titleController,
                          title: "${'Title'.tr}*",
                          hintText: "Title".tr,
                          keyboardType: TextInputType.name,
                          validator: (value) {
                            if (value!.trim().isEmpty) {
                              return "Please enter address title".tr;
                            }
                            return null;
                          }),
                      ...commonField(
                          textController: emailController,
                          title: "${'Email Address'.tr}*",
                          hintText: "Email Address".tr,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value!.trim().isEmpty) {
                              return "Please enter email address".tr;
                            }
                            if (value.trim().invalidEmail) {
                              return "Please enter valid email address".tr;
                            }
                            return null;
                          }),
                      ...commonField(
                          textController: firstNameController,
                          title: "${'First Name'.tr}*",
                          hintText: "First Name".tr,
                          keyboardType: TextInputType.name,
                          validator: (value) {
                            if (value!.trim().isEmpty) {
                              return "Please enter first name".tr;
                            }
                            return null;
                          }),
                      ...commonField(
                          textController: lastNameController,
                          title: "${'Last Name'.tr}*",
                          hintText: "Last Name".tr,
                          keyboardType: TextInputType.name,
                          validator: (value) {
                            if (value!.trim().isEmpty) {
                              return "Please enter Last name".tr;
                            }
                            return null;
                          }),
                      ...commonField(
                          textController: phoneController,
                          title: "${'Phone'.tr}*",
                          hintText: "Enter your phone number".tr,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value!.trim().isEmpty) {
                              return "Please enter phone number".tr;
                            }
                            if (value.trim().length > 15) {
                              return "Please enter valid phone number".tr;
                            }
                            if (value.trim().length < 8) {
                              return "Please enter valid phone number".tr;
                            }
                            return null;
                          }),
                      ...commonField(
                          textController: alternatePhoneController,
                          title: "${'Alternate Phone'.tr}*",
                          hintText: "Enter your alternate phone number".tr,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            // if(value!.trim().isEmpty){
                            //   return "Please enter phone number";
                            // }
                            // if(value.trim().length > 15){
                            //   return "Please enter valid phone number";
                            // }
                            // if(value.trim().length < 8){
                            //   return "Please enter valid phone number";
                            // }
                            return null;
                          }),
                      ...commonField(
                          textController: addressController,
                          title: "${'Address'.tr}*",
                          hintText: "Enter your delivery address".tr,
                          keyboardType: TextInputType.streetAddress,
                          validator: (value) {
                            if (value!.trim().isEmpty) {
                              return "Please enter delivery address".tr;
                            }
                            return null;
                          }),
                      ...commonField(
                          textController: address2Controller,
                          title: "${'Address'.tr} 2",
                          hintText: "Enter your delivery address".tr,
                          keyboardType: TextInputType.streetAddress,
                          validator: (value) {
                            // if(value!.trim().isEmpty){
                            //   return "Please enter delivery address";
                            // }
                            return null;
                          }),
                      ...commonField(
                          textController: landmarkController,
                          title: "Landmark".tr,
                          hintText: "Enter your nearby landmark".tr,
                          keyboardType: TextInputType.streetAddress,
                          validator: (value) {
                            // if(value!.trim().isEmpty){
                            //   return "Please enter delivery address";
                            // }
                            return null;
                          }),
                      ...commonField(
                          textController: cityController,
                          title: "${'City'.tr}*",
                          hintText: "Enter your city",
                          keyboardType: TextInputType.streetAddress,
                          validator: (value) {
                            if (value!.trim().isEmpty) {
                              return "${'Please enter City'.tr}*";
                            }
                            return null;
                          }),
                      ...commonField(
                          textController: zipCodeController,
                          title: "${'Zip-Code'.tr}*",
                          hintText: "Enter location Zip-Code".tr,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value!.trim().isEmpty) {
                              return "${'Please enter Zip-Code'.tr}*";
                            }
                            return null;
                          }),
                      ...commonField(
                          textController: stateController,
                          title: "${'State'.tr}*",
                          hintText: "Enter your state".tr,
                          keyboardType: TextInputType.streetAddress,
                          validator: (value) {
                            if (value!.trim().isEmpty) {
                              return "${'Please enter state'.tr}*";
                            }
                            return null;
                          }),
                      ...commonField(
                          textController: countryController,
                          title: "${'Country'.tr}*",
                          hintText: "Enter your country".tr,
                          keyboardType: TextInputType.streetAddress,
                          validator: (value) {
                            if (value!.trim().isEmpty) {
                              return "${'Please enter country'.tr}*";
                            }
                            return null;
                          }),
                      const SizedBox(
                        height: 16,
                      ),
                      GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () {
                          if (formKey.currentState!.validate()) {
                            selectedAddress = AddressData(
                              id: "",
                              type: titleController.text.trim(),
                              firstName: firstNameController.text.trim(),
                              lastName: lastNameController.text.trim(),
                              state: stateController.text.trim(),
                              country: countryController.text.trim(),
                              city: cityController.text.trim(),
                              address2: address2Controller.text.trim(),
                              address: addressController.text.trim(),
                              alternatePhone: alternatePhoneController.text.trim(),
                              landmark: landmarkController.text.trim(),
                              phone: phoneController.text.trim(),
                              zipCode: zipCodeController.text.trim(),
                              email: emailController.text.trim(),
                            );
                            setState(() {});
                            Get.back();
                            // cartController.updateAddressApi(
                            //     context: context,
                            //     firstName: firstNameController.text.trim(),
                            //     title: titleController.text.trim(),
                            //     lastName: lastNameController.text.trim(),
                            //     state: stateController.text.trim(),
                            //     country: countryController.text.trim(),
                            //     city: cityController.text.trim(),
                            //     address2: address2Controller.text.trim(),
                            //     address: addressController.text.trim(),
                            //     alternatePhone: alternatePhoneController.text.trim(),
                            //     landmark: landmarkController.text.trim(),
                            //     phone: phoneController.text.trim(),
                            //     zipCode: zipCodeController.text.trim(),
                            //     id: addressData.id);
                          }
                        },
                        child: Container(
                          decoration: const BoxDecoration(color: Color(0xff014E70)),
                          height: 56,
                          alignment: Alignment.bottomCenter,
                          child: Align(
                              alignment: Alignment.center,
                              child: Text("Save".tr,
                                  style:
                                      GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 19, color: Colors.white))),
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
