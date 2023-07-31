import 'dart:convert';
import 'dart:developer';

import 'package:dirise/model/order_models/model_single_order_response.dart';
import 'package:dirise/repository/repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../bottomavbar.dart';
import '../../controller/cart_controller.dart';
import '../../utils/ApiConstant.dart';

class OrderCompleteScreen extends StatefulWidget {
  const OrderCompleteScreen({super.key});
  static var route = "/orderCompleteScreen";

  @override
  State<OrderCompleteScreen> createState() => _OrderCompleteScreenState();
}

class _OrderCompleteScreenState extends State<OrderCompleteScreen> {
  final cartController = Get.put(CartController());
  final Repositories repositories = Repositories();
  String orderId = "";
  ModelSingleOrderResponse singleOrder = ModelSingleOrderResponse();

  getOrderDetails() {
    repositories.postApi(url: ApiUrls.orderDetailsUrl, mapData: {
      "order_id": orderId,
    }).then((value) {
      singleOrder = ModelSingleOrderResponse.fromJson(jsonDecode(value));
      setState(() {});
    });
  }

  @override
  void initState() {
    super.initState();
    if (Get.arguments != null) {
      orderId = Get.arguments;
      getOrderDetails();
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    log(jsonEncode(singleOrder));
    return WillPopScope(
      onWillPop: ()async{
        Get.back();
        Get.back();
        Get.back();
        Get.back();
        Get.back();
        Get.back();
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: singleOrder.order != null
            ? SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: CustomScrollView(
                    slivers: [
                      SliverToBoxAdapter(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(
                              height: 24,
                            ),
                            const CircleAvatar(
                              radius: 35,
                              backgroundColor: Color(0xffEBF1F4),
                              child: Icon(
                                Icons.check,
                                color: Color(0xff014E70),
                                size: 35,
                                weight: 100.0,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 5, top: 15),
                              child: Text(
                                "Your order has been confirmed\n"
                                "Order Id: #${singleOrder.order!.id.toString()}",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 18),
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Order Details",
                                style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 18),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SliverList(
                          delegate: SliverChildBuilderDelegate(
                        childCount: singleOrder.order!.orderItem!.length,
                        (context, index) {
                          final orderItems = singleOrder.order!.orderItem![index];
                          return Container(
                            decoration: const BoxDecoration(
                              border: Border(bottom: BorderSide(color: Color(0xffD9D9D9))),
                            ),
                            padding: const EdgeInsets.only(bottom: 20, top: 20),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: 20,
                                  backgroundColor: const Color(0xffEEEEEE),
                                  child: Text("${orderItems.quantity}x"),
                                ),
                                const SizedBox(
                                  width: 7,
                                ),
                                Image.network(
                                  height: size.height * .12,
                                  width: size.height * .12,
                                  orderItems.featuredImage.toString(),
                                  errorBuilder: (_, __, ___) => const SizedBox.shrink(),
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        orderItems.productName.toString(),
                                        style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 14),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        '${orderItems.quantity} piece',
                                        style: GoogleFonts.poppins(color: const Color(0xff858484)),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      )),
                      SliverToBoxAdapter(
                        child: SizedBox(
                          width: double.maxFinite,
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      "Total",
                                      style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 16, height: 1.8),
                                    ),
                                  ),
                                  Text(
                                    "${singleOrder.order!.orderMeta!.totalPrice} USD",
                                    style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 16, height: 1.8),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 50,
                              ),
                              Text(
                                "Thank you for using DIRISE.",
                                style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 16, height: 1.8),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            : const Center(child: CircularProgressIndicator.adaptive()),
        bottomNavigationBar: singleOrder.order != null
            ? Padding(
              padding: const EdgeInsets.all(20),
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  // Get.offAllNamed(BottomNavbar.route);
                  Get.back();
                  Get.back();
                  Get.back();
                  Get.back();
                  Get.back();
                  Get.back();
                },
                child: Container(
                  decoration: BoxDecoration(color: const Color(0xff014E70), borderRadius: BorderRadius.circular(32)),
                  height: 55,
                  alignment: Alignment.bottomCenter,
                  child: Align(
                      alignment: Alignment.center,
                      child: Text("Home",
                          style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 19, color: Colors.white))),
                ),
              ),
            )
            : const SizedBox.shrink(),
      ),
    );
  }
}
