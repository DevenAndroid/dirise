import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../model/order_models/model_single_order_response.dart';
import '../../repoistery/repository.dart';
import '../../utils/ApiConstant.dart';

class SelectedOrderScreen extends StatefulWidget {
  const SelectedOrderScreen({super.key});
  static var route = "/selectedOrderScreen";

  @override
  State<SelectedOrderScreen> createState() => _SelectedOrderScreenState();
}

class _SelectedOrderScreenState extends State<SelectedOrderScreen> {
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
    return Scaffold(
      backgroundColor: Colors.white,
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
              "Order Details",
              style: GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 22),
            ),
          ],
        ),
      ),
      body: singleOrder.order != null ?
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  "Order #00069899",
                  style: GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 18),
                ),
              ),
            ),
            SliverList(
                delegate: SliverChildBuilderDelegate(
              childCount: singleOrder.order!.orderItem!.length,
              (context, index) {
                final item = singleOrder.order!.orderItem![index];
                return Container(
                  decoration: const BoxDecoration(
                    border: Border(bottom: BorderSide(color: Color(0xffD9D9D9))),
                  ),
                  padding: const EdgeInsets.only(bottom: 6, top: 6),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundColor: const Color(0xffEEEEEE),
                        child: Text("${item.quantity.toString()}x"),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Image.network(
                        height: size.height * .12,
                        width: size.height * .12,
                        item.featuredImage.toString(),
                        errorBuilder: (_,__,___)=> const SizedBox.shrink(),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.productName.toString(),
                              style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 14),
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            Text(
                              '${item.quantity.toString()} piece',
                              style: GoogleFonts.poppins(color: const Color(0xff858484)),
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Order Date",
                          style: GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 18),
                        ),
                        Text(
                          singleOrder.order!.createdDate.toString(),
                          style: GoogleFonts.poppins(
                              color: const Color(0xff9B9B9B), fontWeight: FontWeight.w500, fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Status",
                          style: GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 18),
                        ),
                        Text(
                          singleOrder.order!.status.toString().capitalize!,
                          style: GoogleFonts.poppins(
                              color: const Color(0xff9B9B9B), fontWeight: FontWeight.w500, fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Payment",
                          style: GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 18),
                        ),
                        Text(
                          "${singleOrder.order!.orderMeta!.totalPrice.toString()} ${singleOrder.order!.orderMeta!.currencySign.toString()}",
                          style: GoogleFonts.poppins(
                              color: const Color(0xff9B9B9B), fontWeight: FontWeight.w500, fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Deliver",
                          style: GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 18),
                        ),
                        Text(
                          "Static 2 KWD",
                          style: GoogleFonts.poppins(
                              color: const Color(0xff9B9B9B), fontWeight: FontWeight.w500, fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ) :
      const Center(child: CircularProgressIndicator.adaptive(),),
    );
  }
}
