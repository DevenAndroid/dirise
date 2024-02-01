import 'dart:convert';
import 'dart:developer';
import 'package:dirise/model/common_modal.dart';
import 'package:dirise/utils/helper.dart';
import 'package:dirise/widgets/loading_animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../controller/cart_controller.dart';
import '../../controller/profile_controller.dart';
import '../../model/model_cart_response.dart';
import '../../model/vendor_models/model_payment_method.dart';
import '../../repository/repository.dart';
import '../../utils/api_constant.dart';
import '../../utils/styles.dart';
import '../../widgets/common_colour.dart';
import 'address/address_screen.dart';

class CheckOutScreen extends StatefulWidget {
  const CheckOutScreen({super.key});

  static var route = "/checkOutScreen";

  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  final cartController = Get.put(CartController());
  final profileController = Get.put(ProfileController());

  String couponApplied = "";
  String appliedCode = "";
  String paymentMethod1 = "";
  RxBool showValidation = false.obs;
  final TextEditingController couponController = TextEditingController();
  final TextEditingController deliveryInstructions = TextEditingController();
  ModelPaymentMethods? methods;

  getPaymentGateWays() {
    Repositories().getApi(url: ApiUrls.paymentMethodsUrl).then((value) {
      methods = ModelPaymentMethods.fromJson(jsonDecode(value));
      setState(() {});
    });
  }

  applyCouponCode() {
    if (couponController.text.trim().isEmpty) {
      showToast("Please enter coupon code".tr);
      return;
    }
    cartController.refreshInt.value = -2;
    Map<String, dynamic> map = {};
    map["coupon_code"] = couponController.text.trim();
    map["total_price"] = cartController.cartModel.subtotal.toString();
    cartController.repositories.postApi(url: ApiUrls.applyCouponUrl, context: context, mapData: map).then((value) {
      ModelCommonResponse response = ModelCommonResponse.fromJson(jsonDecode(value));
      showToast(response.message);
      if (response.status == true) {
        couponApplied = jsonDecode(value)["discount"].toString();
        appliedCode = couponController.text.trim();
        couponController.clear();
        setState(() {});
      }
      cartController.updateUI();
    }).catchError((e) {
      cartController.updateUI();
    });
  }

  RxString paymentOption = "".obs;

  bool get userLoggedIn => profileController.userLoggedIn;

  @override
  void initState() {
    super.initState();
    getPaymentGateWays();
    profileController.checkUserLoggedIn().then((value) {
      if (value == false) return;
      cartController.getAddress();
    });
  }

  goBack() {
    // if(cartController.cartModel.cart!.getAllProducts.isEmpty){
    //   Future.delayed(Duration(seconds: 1)).then((value) {
    //     Get.back();
    //   });
    // }
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
      body: CustomScrollView(
        shrinkWrap: true,
        slivers: [
          const AddressScreen(),
          30.spaceY.toBoxAdapter,
          paymentMethod(size).toBoxAdapter,
          deliveryInstruction().toBoxAdapter,
          products().toBoxAdapter,
          couponCode().toBoxAdapter,
          const SizedBox(
            height: 30,
          ).toBoxAdapter,
          orderDetails().toBoxAdapter
        ],
      ),
      bottomNavigationBar: ElevatedButton(
        onPressed: () {
          cartController.showValidation.value = true;
          showValidation.value = true;
          if (cartController.deliveryOption.value.isEmpty) {
            BuildContext? context1 = cartController.addressKey.currentContext;
            if (context1 != null) {
              Scrollable.ensureVisible(context1, duration: const Duration(milliseconds: 650));
            }
            showToast("Please select delivery options".tr);
            return;
          }
          if (cartController.deliveryOption.value == "delivery" && cartController.selectedAddress.id == null) {
            BuildContext? context1 = cartController.addressKey.currentContext;
            if (context1 != null) {
              Scrollable.ensureVisible(context1, duration: const Duration(milliseconds: 650));
            }
            showToast("Select delivery address to complete order".tr);
            return;
          }
          cartController.dialogOpened = false;
          if (paymentMethod1.isEmpty) {
            showToast("Please select payment Method".tr);
            return;
          }
          cartController.placeOrder(
              context: context,
              currencyCode: "usd",
              paymentMethod: paymentMethod1,
              deliveryOption: cartController.deliveryOption.value,
              subTotalPrice: cartController.cartModel.subtotal.toString(),
              totalPrice: cartController.cartModel.total.toString(),
              couponCode: couponApplied.isNotEmpty ? appliedCode : null,
              purchaseType: PurchaseType.cart,
              address: cartController.selectedAddress.toJson(),
              idd:  cartController.shippingId.toString(),
          );
        },
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
          backgroundColor: const Color(0xff014E70),
        ),
        child: Container(
          // decoration: const BoxDecoration(color: Color(0xff014E70)),
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

  Container orderDetails() {
    return Container(
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
              // Text("Subtotal (${cartController.cartModel.totalQuantity} items)",
              //     style: GoogleFonts.poppins(fontWeight: FontWeight.w400, color: const Color(0xff949495))),
              Text("KWD ${cartController.cartModel.subtotal.toString()}",
                  style: GoogleFonts.poppins(fontWeight: FontWeight.w400, color: const Color(0xff949495))),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Obx(() {
            if (cartController.refreshInt.value > 0) {}
            goBack();
            return couponApplied.isNotEmpty
                ? Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("${'Coupon Applied'.tr}: $appliedCode",
                              style: GoogleFonts.poppins(fontWeight: FontWeight.w400, color: CupertinoColors.activeGreen)),
                          Text("KWD $couponApplied",
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w400,
                                  color: CupertinoColors.activeGreen,
                                  decoration: TextDecoration.lineThrough,
                                  decorationColor: Colors.lightGreenAccent)),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  )
                : const SizedBox.shrink();
          }),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Total".tr, style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 18)),
              Text("KWD ${cartController.cartModel.total.toString().toNum - (couponApplied.convertToNum ?? 0)}",
                  style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 18)),
            ],
          ),
        ],
      ),
    );
  }

  Column couponCode() {
    return Column(
      children: [
        const SizedBox(
          height: 15,
        ),
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
                Text("Have a coupon code?".tr, style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 18)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Expanded(child: CommonTextfield(obSecure: false, hintText: 'Enter Code',)),
                    Expanded(
                      child: TextFormField(
                          style: GoogleFonts.poppins(),
                          controller: couponController,
                          decoration: InputDecoration.collapsed(
                            hintText: "Enter Code".tr,
                            hintStyle: GoogleFonts.poppins(color: const Color(0xff949495), fontSize: 14),
                          )),
                    ),
                    Obx(() {
                      return cartController.refreshInt.value == -2
                          ? const CupertinoActivityIndicator()
                          : const SizedBox.shrink();
                    }),
                    const SizedBox(
                      width: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        applyCouponCode();
                      },
                      child: Container(
                        decoration: BoxDecoration(color: const Color(0xff014E70), borderRadius: BorderRadius.circular(22)),
                        padding: const EdgeInsets.fromLTRB(22, 9, 22, 9),
                        child: Text(
                          "Apply".tr,
                          style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.white),
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Column products() {
    return Column(
      children: [
        Obx(() {
          if (cartController.refreshInt.value > 0) {}
          return SingleChildScrollView(
            child: Column(
              children: cartController.cartModel.cart!.carsShowroom!.entries
                  .map((e) => Column(
                        children: [
                          ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: e.value.products!.length,
                            itemBuilder: (context, ii) {
                              Products product = e.value.products![ii];
                              return Container(
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  //   border: ii != product.length - 1
                                  //       ? const Border(bottom: BorderSide(color: Color(0xffD9D9D9)))
                                  //       : null,
                                ),
                                margin: EdgeInsets.only(top: ii == 0 ? 16 : 0),
                                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    if (ii == 0)
                                      Padding(
                                        padding: const EdgeInsets.only(bottom: 16),
                                        child: Text(
                                          "${'Sold By'.tr} ${e.key}",
                                          style: titleStyle,
                                        ),
                                      ),
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
                                                product.featuredImage.toString(),
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
                                                  product.pname.toString(),
                                                  style: titleStyle.copyWith(fontWeight: FontWeight.w400),
                                                  textAlign: TextAlign.start,
                                                ),
                                                const SizedBox(
                                                  height: 6,
                                                ),
                                                Text(
                                                  '\$${product.sPrice}',
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
                                                            if (product.qty.toString().toNum > 1) {
                                                              cartController.updateCartQuantity(
                                                                  context: context,
                                                                  productId: product.id.toString(),
                                                                  quantity: (product.qty.toString().toNum - 1).toString());
                                                            } else {
                                                              cartController.removeItemFromCart(
                                                                  productId: product.id.toString(), context: context);
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
                                                          product.qty.toString(),
                                                          style: normalStyle,
                                                        ),
                                                      ),
                                                      5.spaceX,
                                                      IconButton(
                                                          onPressed: () {
                                                            if (product.qty.toString().toNum <
                                                                product.stockAlert.toString().toNum) {
                                                              cartController.updateCartQuantity(
                                                                  context: context,
                                                                  productId: product.id.toString(),
                                                                  quantity: (product.qty.toString().toNum + 1).toString());
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
                                                    productId: product.id.toString(), context: context);
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
                              );
                            },
                          ),
                          10.spaceY,
                          if (cartController.deliveryOption.value == "delivery")
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
                          if (cartController.deliveryOption.value == "delivery")
                          Container(
                            color: Colors.white,
                            child: ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: e.value.shippingTypes!.length,
                              padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 15).copyWith(top: 0),
                              itemBuilder: (context, ii) {
                                ShippingTypes product = e.value.shippingTypes![ii];
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
                                            groupValue: e.value.shippingOption.value,
                                            visualDensity: const VisualDensity(horizontal: -4.0),
                                            onChanged: (value) {
                                              setState(() {
                                                e.value.shippingOption.value = value.toString();
                                                cartController.shippingId =  e.value.shippingOption.value;
                                                log(e.value.shippingOption.value);
                                                log(cartController.shippingId);
                                              });
                                            },
                                          ),
                                          20.spaceX,
                                          Text(product.name.toString(),
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
                      ))
                  .toList(),
            ),
          );
          // CustomScrollView(
          //   shrinkWrap: true,
          //   physics: const NeverScrollableScrollPhysics(),
          //   slivers: cartController.cartModel.cart!.carsShowroom!.entries
          //       .map((e) => SliverList(
          //               delegate: SliverChildBuilderDelegate(
          //             childCount: e.value.products!.length,
          //             (context, ii) {
          //               Products product = e.value.products![ii];
          //               return Container(
          //                 decoration: const BoxDecoration(
          //                   color: Colors.white,
          //                   //   border: ii != product.length - 1
          //                   //       ? const Border(bottom: BorderSide(color: Color(0xffD9D9D9)))
          //                   //       : null,
          //                 ),
          //                 margin: EdgeInsets.only(top: ii == 0 ? 16 : 0),
          //                 padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          //                 child: Column(
          //                   crossAxisAlignment: CrossAxisAlignment.start,
          //                   children: [
          //                     if (ii == 0)
          //                       Padding(
          //                         padding: const EdgeInsets.only(bottom: 16),
          //                         child: Text(
          //                           "${'Sold By'.tr} ${e.key}",
          //                           style: titleStyle,
          //                         ),
          //                       ),
          //                     IntrinsicHeight(
          //                       child: Row(
          //                         crossAxisAlignment: CrossAxisAlignment.start,
          //                         children: [
          //                           Container(
          //                             width: 75,
          //                             height: 75,
          //                             decoration: BoxDecoration(
          //                               borderRadius: BorderRadius.circular(12),
          //                             ),
          //                             child: ClipRRect(
          //                               borderRadius: BorderRadius.circular(12),
          //                               child: Image.network(
          //                                 product.featuredImage.toString(),
          //                                 fit: BoxFit.contain,
          //                                 errorBuilder: (_, __, ___) => const SizedBox.shrink(),
          //                               ),
          //                             ),
          //                           ),
          //                           const SizedBox(
          //                             width: 16,
          //                           ),
          //                           Expanded(
          //                             child: Column(
          //                               crossAxisAlignment: CrossAxisAlignment.start,
          //                               // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //                               children: [
          //                                 Text(
          //                                   product.pname.toString(),
          //                                   style: titleStyle.copyWith(fontWeight: FontWeight.w400),
          //                                   textAlign: TextAlign.start,
          //                                 ),
          //                                 const SizedBox(
          //                                   height: 6,
          //                                 ),
          //                                 Text(
          //                                   '\$${product.sPrice}',
          //                                   style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w400),
          //                                 ),
          //                                 const SizedBox(
          //                                   height: 4,
          //                                 ),
          //                                 IntrinsicHeight(
          //                                   child: Row(
          //                                     children: [
          //                                       IconButton(
          //                                           onPressed: () {
          //                                             if (product.qty.toString().toNum > 1) {
          //                                               cartController.updateCartQuantity(
          //                                                   context: context,
          //                                                   productId: product.id.toString(),
          //                                                   quantity: (product.qty.toString().toNum - 1).toString());
          //                                             } else {
          //                                               cartController.removeItemFromCart(
          //                                                   productId: product.id.toString(), context: context);
          //                                             }
          //                                           },
          //                                           style: IconButton.styleFrom(
          //                                             shape:
          //                                                 RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
          //                                             backgroundColor: AppTheme.buttonColor,
          //                                           ),
          //                                           constraints: const BoxConstraints(minHeight: 0),
          //                                           padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
          //                                           visualDensity: VisualDensity.compact,
          //                                           icon: const Icon(
          //                                             Icons.remove,
          //                                             color: Colors.white,
          //                                             size: 20,
          //                                           )),
          //                                       5.spaceX,
          //                                       Container(
          //                                         decoration: BoxDecoration(
          //                                             borderRadius: BorderRadius.circular(2),
          //                                             // color: Colors.grey,
          //                                             border: Border.all(color: Colors.grey.shade800)),
          //                                         margin: const EdgeInsets.symmetric(vertical: 6),
          //                                         padding: const EdgeInsets.symmetric(horizontal: 15),
          //                                         alignment: Alignment.center,
          //                                         child: Text(
          //                                           product.qty.toString(),
          //                                           style: normalStyle,
          //                                         ),
          //                                       ),
          //                                       5.spaceX,
          //                                       IconButton(
          //                                           onPressed: () {
          //                                             if (product.qty.toString().toNum <
          //                                                 product.stockAlert.toString().toNum) {
          //                                               cartController.updateCartQuantity(
          //                                                   context: context,
          //                                                   productId: product.id.toString(),
          //                                                   quantity: (product.qty.toString().toNum + 1).toString());
          //                                             }
          //                                           },
          //                                           style: IconButton.styleFrom(
          //                                             shape:
          //                                                 RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
          //                                             backgroundColor: AppTheme.buttonColor,
          //                                           ),
          //                                           constraints: const BoxConstraints(minHeight: 0),
          //                                           padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
          //                                           visualDensity: VisualDensity.compact,
          //                                           icon: const Icon(
          //                                             Icons.add,
          //                                             color: Colors.white,
          //                                             size: 20,
          //                                           )),
          //                                     ],
          //                                   ),
          //                                 )
          //                               ],
          //                             ),
          //                           ),
          //                           IconButton(
          //                               onPressed: () {
          //                                 cartController.removeItemFromCart(
          //                                     productId: product.id.toString(), context: context);
          //                               },
          //                               visualDensity: VisualDensity.compact,
          //                               icon: SvgPicture.asset(
          //                                 "assets/svgs/delete.svg",
          //                                 height: 18,
          //                                 width: 18,
          //                               ))
          //                         ],
          //                       ),
          //                     ),
          //                   ],
          //                 ),
          //               );
          //             },
          //           )))
          //       .toList()
          //
          //   // slivers: List.generate(cartController.cartModel.cart!.carsShowroom!.length, (i) {
          //   //   List<SellersData> items = cartController.cartModel.cart!.getAllProducts[i];
          //   //   return SliverList(
          //   //       delegate: SliverChildBuilderDelegate(
          //   //     childCount: items.length,
          //   //     (context, ii) {
          //   //       SellersData product = items[ii];
          //   //       return Container(
          //   //         decoration: BoxDecoration(
          //   //           color: Colors.white,
          //   //           border: ii != items.length - 1
          //   //               ? const Border(bottom: BorderSide(color: Color(0xffD9D9D9)))
          //   //               : null,
          //   //         ),
          //   //         margin: EdgeInsets.only(top: ii == 0 ? 16 : 0),
          //   //         padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          //   //         child: Column(
          //   //           crossAxisAlignment: CrossAxisAlignment.start,
          //   //           children: [
          //   //             if (ii == 0)
          //   //               Padding(
          //   //                 padding: const EdgeInsets.only(bottom: 16),
          //   //                 child: Text(
          //   //                   "${'Sold By'.tr} ${product.storeName}",
          //   //                   style: titleStyle,
          //   //                 ),
          //   //               ),
          //   //             IntrinsicHeight(
          //   //               child: Row(
          //   //                 crossAxisAlignment: CrossAxisAlignment.start,
          //   //                 children: [
          //   //                   Container(
          //   //                     width: 75,
          //   //                     height: 75,
          //   //                     decoration: BoxDecoration(
          //   //                       borderRadius: BorderRadius.circular(12),
          //   //                     ),
          //   //                     child: ClipRRect(
          //   //                       borderRadius: BorderRadius.circular(12),
          //   //                       child: Image.network(
          //   //                         product.featuredImage.toString(),
          //   //                         fit: BoxFit.contain,
          //   //                         errorBuilder: (_, __, ___) => const SizedBox.shrink(),
          //   //                       ),
          //   //                     ),
          //   //                   ),
          //   //                   const SizedBox(
          //   //                     width: 16,
          //   //                   ),
          //   //                   Expanded(
          //   //                     child: Column(
          //   //                       crossAxisAlignment: CrossAxisAlignment.start,
          //   //                       // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //   //                       children: [
          //   //                         Text(
          //   //                           product.pName.toString(),
          //   //                           style: titleStyle.copyWith(fontWeight: FontWeight.w400),
          //   //                           textAlign: TextAlign.start,
          //   //                         ),
          //   //                         const SizedBox(
          //   //                           height: 6,
          //   //                         ),
          //   //                         Text(
          //   //                           '\$${product.sPrice}',
          //   //                           style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w400),
          //   //                         ),
          //   //                         const SizedBox(
          //   //                           height: 4,
          //   //                         ),
          //   //                         IntrinsicHeight(
          //   //                           child: Row(
          //   //                             children: [
          //   //                               IconButton(
          //   //                                   onPressed: () {
          //   //                                     if (product.qty.toString().toNum > 1) {
          //   //                                       cartController.updateCartQuantity(
          //   //                                           context: context,
          //   //                                           productId: product.id.toString(),
          //   //                                           quantity: (product.qty.toString().toNum - 1).toString());
          //   //                                     } else {
          //   //                                       cartController.removeItemFromCart(
          //   //                                           productId: product.id.toString(), context: context);
          //   //                                     }
          //   //                                   },
          //   //                                   style: IconButton.styleFrom(
          //   //                                     shape: RoundedRectangleBorder(
          //   //                                         borderRadius: BorderRadius.circular(2)),
          //   //                                     backgroundColor: AppTheme.buttonColor,
          //   //                                   ),
          //   //                                   constraints: const BoxConstraints(minHeight: 0),
          //   //                                   padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
          //   //                                   visualDensity: VisualDensity.compact,
          //   //                                   icon: const Icon(
          //   //                                     Icons.remove,
          //   //                                     color: Colors.white,
          //   //                                     size: 20,
          //   //                                   )),
          //   //                               5.spaceX,
          //   //                               Container(
          //   //                                 decoration: BoxDecoration(
          //   //                                     borderRadius: BorderRadius.circular(2),
          //   //                                     // color: Colors.grey,
          //   //                                     border: Border.all(color: Colors.grey.shade800)),
          //   //                                 margin: const EdgeInsets.symmetric(vertical: 6),
          //   //                                 padding: const EdgeInsets.symmetric(horizontal: 15),
          //   //                                 alignment: Alignment.center,
          //   //                                 child: Text(
          //   //                                   product.qty.toString(),
          //   //                                   style: normalStyle,
          //   //                                 ),
          //   //                               ),
          //   //                               5.spaceX,
          //   //                               IconButton(
          //   //                                   onPressed: () {
          //   //                                     if (product.qty.toString().toNum <
          //   //                                         product.stockAlert.toString().toNum) {
          //   //                                       cartController.updateCartQuantity(
          //   //                                           context: context,
          //   //                                           productId: product.id.toString(),
          //   //                                           quantity: (product.qty.toString().toNum + 1).toString());
          //   //                                     }
          //   //                                   },
          //   //                                   style: IconButton.styleFrom(
          //   //                                     shape: RoundedRectangleBorder(
          //   //                                         borderRadius: BorderRadius.circular(2)),
          //   //                                     backgroundColor: AppTheme.buttonColor,
          //   //                                   ),
          //   //                                   constraints: const BoxConstraints(minHeight: 0),
          //   //                                   padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
          //   //                                   visualDensity: VisualDensity.compact,
          //   //                                   icon: const Icon(
          //   //                                     Icons.add,
          //   //                                     color: Colors.white,
          //   //                                     size: 20,
          //   //                                   )),
          //   //                             ],
          //   //                           ),
          //   //                         )
          //   //                       ],
          //   //                     ),
          //   //                   ),
          //   //                   IconButton(
          //   //                       onPressed: () {
          //   //                         cartController.removeItemFromCart(
          //   //                             productId: product.id.toString(), context: context);
          //   //                       },
          //   //                       visualDensity: VisualDensity.compact,
          //   //                       icon: SvgPicture.asset(
          //   //                         "assets/svgs/delete.svg",
          //   //                         height: 18,
          //   //                         width: 18,
          //   //                       ))
          //   //                 ],
          //   //               ),
          //   //             ),
          //   //           ],
          //   //         ),
          //   //       );
          //   //     },
          //   //   ));
          //   // }),
          //   );
        })
      ],
    );
  }

  Column deliveryInstruction() {
    return Column(
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
                Text("Add delivery instructions".tr, style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 18)),
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
          height: 15,
        ),
      ],
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
          height: 25,
        ),
      ],
    );
  }
}
