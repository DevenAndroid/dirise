import 'dart:convert';

import 'package:dirise/utils/helper.dart';
import 'package:dirise/widgets/common_colour.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../model/order_models/model_single_order_response.dart';
import '../../repository/repository.dart';
import '../../utils/api_constant.dart';
import '../../widgets/customsize.dart';
import '../../widgets/dimension_screen.dart';
import '../../widgets/loading_animation.dart';
import '../payment_info/bank_account_screen.dart';

class OrderDetails extends StatefulWidget {
  final String orderId;
  const OrderDetails({Key? key, required this.orderId}) : super(key: key);

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  final Repositories repositories = Repositories();
  String get orderId => widget.orderId;
  ModelSingleOrderResponse singleOrder = ModelSingleOrderResponse();

  Future getOrderDetails() async {
    await repositories.postApi(url: ApiUrls.orderDetailsUrl, mapData: {
      "order_id": orderId,
    }).then((value) {
      singleOrder = ModelSingleOrderResponse.fromJson(jsonDecode(value));
      setState(() {});
    });
  }

  _makingPhoneCall(call) async {
    var url = Uri.parse(call);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  SingleOrderData get order => singleOrder.order!;

  @override
  void initState() {
    super.initState();
    getOrderDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text(
            'Delivery Details'.tr,
            style: GoogleFonts.poppins(
              fontSize: 17,
              fontWeight: FontWeight.w600,
              color: const Color(0xff423E5E),
            ),
          ),
          leading: GestureDetector(
            onTap: () {
              Get.back();
              // _scaffoldKey.currentState!.openDrawer();
            },
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Image.asset(
                'assets/icons/backicon.png',
                height: 20,
              ),
            ),
          ),
        ),
        body: singleOrder.order != null
            ? Padding(
                padding: EdgeInsets.symmetric(horizontal: AddSize.padding16, vertical: AddSize.padding10),
                child: SingleChildScrollView(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xFF37C666).withOpacity(0.10),
                                  offset: const Offset(
                                    .1,
                                    .1,
                                  ),
                                  blurRadius: 20.0,
                                  spreadRadius: 1.0,
                                ),
                              ],
                            ),
                            child: Padding(
                                padding: const EdgeInsets.all(18.0).copyWith(bottom: 8),
                                child: Column(children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Image.asset(
                                        'assets/images/orderdetails.png',
                                        height: 18,
                                      ),
                                      addWidth(15),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              '${'Order ID'.tr}: ${order.id.toString()}',
                                              style: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.w600, fontSize: 15, color: AppTheme.buttonColor),
                                            ),
                                            Text(
                                              order.createdDate.toString(),
                                              style: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.w500, fontSize: 12, color: Colors.grey.shade800),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        height: 25,
                                        padding: const EdgeInsets.symmetric(horizontal: 10),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(6), color: AppTheme.buttonColor),
                                        child: Center(
                                          child: Text(
                                            order.status,
                                            style: GoogleFonts.poppins(
                                              color: const Color(0xFFFFFFFF),
                                              fontSize: 13,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 13,
                                  ),
                                  ...order.orderItem!
                                      .map((e) => Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(bottom: 2),
                                                child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Expanded(
                                                        child: Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            Text(
                                                              e.productName.toString(),
                                                              style: GoogleFonts.poppins(
                                                                  color: const Color(0xFF303C5E),
                                                                  fontWeight: FontWeight.w600,
                                                                  fontSize: 16),
                                                            ),
                                                            addHeight(5),
                                                            Text(
                                                              '${e.quantity.toString()} ${'piece'.tr}',
                                                              style: GoogleFonts.poppins(
                                                                  color: const Color(0xFF6A8289),
                                                                  fontWeight: FontWeight.w500,
                                                                  fontSize: 14),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Text(
                                                        "\$${(e.productPrice.toString().toNum * e.quantity.toString().toNum).toStringAsFixed(2)}",
                                                        style: GoogleFonts.poppins(
                                                            color: AppTheme.primaryColor,
                                                            fontWeight: FontWeight.w600,
                                                            fontSize: 16),
                                                      ),
                                                    ]),
                                              ),
                                              const Divider(),
                                              const SizedBox(
                                                height: 10,
                                              )
                                            ],
                                          ))
                                      .toList(),
                                ]))),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Customer Detail'.tr,
                          style:
                              GoogleFonts.poppins(color: const Color(0xff303C5E), fontSize: 18, fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xFF37C666).withOpacity(0.10),
                                  offset: const Offset(
                                    .1,
                                    .1,
                                  ),
                                  blurRadius: 20.0,
                                  spreadRadius: 1.0,
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: AddSize.screenWidth * 0.02, vertical: AddSize.screenHeight * .005),
                                  child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: AddSize.padding15, vertical: AddSize.padding15),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(children: [
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Customer Name".tr,
                                                    style: GoogleFonts.poppins(
                                                        color: const Color(0xff486769),
                                                        fontWeight: FontWeight.w300,
                                                        fontSize: 14),
                                                  ),
                                                  Text(
                                                    order.user != null
                                                        ? order.user!.name.toString()
                                                        : order.orderMeta!.billingFirstName ??
                                                            order.orderMeta!.billingLastName ??
                                                            "",
                                                    style: GoogleFonts.poppins(
                                                        height: 1.5, fontWeight: FontWeight.w600, fontSize: 16),
                                                  ),
                                                ],
                                              ),
                                            ]),
                                            Container(
                                              height: 37,
                                              width: 37,
                                              decoration:
                                                  const ShapeDecoration(color: Color(0xFFFE7E73), shape: CircleBorder()),
                                              child: const Center(
                                                  child: Icon(
                                                Icons.person_rounded,
                                                color: Colors.white,
                                                size: 20,
                                              )),
                                            ),
                                          ],
                                        ),
                                        const Divider(),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(children: [
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Customer Number".tr,
                                                    style: GoogleFonts.poppins(
                                                        color: const Color(0xff486769),
                                                        fontWeight: FontWeight.w300,
                                                        fontSize: 14),
                                                  ),
                                                  Text(
                                                    order.orderMeta!.billingPhone ?? "",
                                                    style: GoogleFonts.poppins(
                                                        height: 1.5, fontWeight: FontWeight.w600, fontSize: 16),
                                                  ),
                                                ],
                                              ),
                                            ]),
                                            GestureDetector(
                                              onTap: () {
                                                if (order.orderMeta!.billingPhone != null &&
                                                    order.orderMeta!.billingPhone.toString().isNotEmpty) {
                                                  _makingPhoneCall("tel:${order.orderMeta!.billingPhone}");
                                                }
                                              },
                                              child: Container(
                                                  height: 37,
                                                  width: 37,
                                                  decoration:
                                                      const ShapeDecoration(color: Color(0xFF71E189), shape: CircleBorder()),
                                                  child: const Center(
                                                      child: Icon(
                                                    Icons.phone,
                                                    color: Colors.white,
                                                    size: 20,
                                                  ))),
                                            ),
                                          ],
                                        ),
                                        const Divider(),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Customer Address".tr,
                                                    style: GoogleFonts.poppins(
                                                        color: const Color(0xff486769),
                                                        fontWeight: FontWeight.w300,
                                                        fontSize: 14),
                                                  ),
                                                  Text(
                                                    order.orderMeta!.completeOrder,
                                                    style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 15),
                                                  ),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {},
                                              child: Container(
                                                height: 37,
                                                width: 37,
                                                decoration:
                                                    const ShapeDecoration(color: Color(0xFF7ED957), shape: CircleBorder()),
                                                child: const Center(
                                                    child: Icon(
                                                  Icons.location_on,
                                                  color: Colors.white,
                                                  size: 20,
                                                )),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            )),
                        Padding(
                          padding: const EdgeInsets.only(top: 15),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xFF37C666).withOpacity(0.10),
                                  offset: const Offset(
                                    .1,
                                    .1,
                                  ),
                                  blurRadius: 20.0,
                                  spreadRadius: 1.0,
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                              child: Column(
                                children: [
                                  // order.couponCode
                                  if (order.couponCode != null) ...[
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            'Coupon Code:'.tr,
                                            style: GoogleFonts.poppins(
                                              color: const Color(0xFF293044),
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          order.couponCode.toString(),
                                          style: GoogleFonts.poppins(
                                            color: const Color(0xFF797F90),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 12,
                                    ),
                                  ],
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          'Subtotal:'.tr,
                                          style: GoogleFonts.poppins(
                                            color: const Color(0xFF293044),
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        "\$${order.orderMeta!.subtotalPrice}",
                                        style: GoogleFonts.poppins(
                                          color: const Color(0xFF797F90),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          'Total:'.tr,
                                          style: GoogleFonts.poppins(
                                            color: const Color(0xFF293044),
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        "\$${order.orderMeta!.totalPrice}",
                                        style: GoogleFonts.poppins(
                                          color: const Color(0xFF797F90),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                            onPressed: () {
                              Get.toNamed(BankDetailsScreen.route);
                            },
                            style: ElevatedButton.styleFrom(
                                minimumSize: const Size(double.maxFinite, 60),
                                backgroundColor: AppTheme.buttonColor,
                                elevation: 0,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AddSize.size10)),
                                textStyle: GoogleFonts.poppins(fontSize: AddSize.font20, fontWeight: FontWeight.w600)),
                            child: Text(
                              "Mark Delivered".tr,
                              style: GoogleFonts.poppins(
                                  color: Colors.white, fontWeight: FontWeight.w600, fontSize: 16,
                              ),
                            )),
                      ].animate(interval: 80.ms, autoPlay: true).fade(duration: 160.ms)),
                ))
            : const LoadingAnimation());
  }
}
