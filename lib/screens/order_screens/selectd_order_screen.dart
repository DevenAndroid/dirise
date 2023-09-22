import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../model/order_models/model_single_order_response.dart';
import '../../repository/repository.dart';
import '../../utils/api_constant.dart';
import '../../utils/styles.dart';
import '../../widgets/common_colour.dart';
import '../virtual_assets/virtual_assets_screen.dart';

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

  Future getOrderDetails() async {
    await repositories.postApi(url: ApiUrls.orderDetailsUrl, mapData: {
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
          icon: const Icon(Icons.arrow_back_ios,
              color: Color(0xff014E70), size: 20),
          onPressed: () => Navigator.of(context).pop(),
        ),
        titleSpacing: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Order Details",
              style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 22),
            ),
          ],
        ),
      ),
      body: singleOrder.order != null
          ? RefreshIndicator(
              onRefresh: () async {
                await getOrderDetails();
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          "Order #${singleOrder.order!.orderId}",
                          style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 18),
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
                            border: Border(
                                bottom: BorderSide(color: Color(0xffD9D9D9))),
                          ),
                          padding: const EdgeInsets.only(bottom: 12, top: 12),
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
                                errorBuilder: (_, __, ___) =>
                                    const SizedBox.shrink(),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item.productName.toString(),
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14),
                                    ),
                                    const SizedBox(
                                      height: 4,
                                    ),
                                    Text(
                                      'USD ${item.productPrice}',
                                      style: GoogleFonts.poppins(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: const Color(0xff014E70)),
                                    ),
                                    if (item.orderTrackData != null) ...[
                                      const SizedBox(
                                        height: 4,
                                      ),
                                      Text(
                                        '${item.orderTrackData!.reversed.toList().firstWhere((element) => element.completed.toString() == "true", orElse: () => OrderTrackData(title: "Order Placed")).title.toString().capitalize}',
                                        style: GoogleFonts.poppins(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            color: const Color(0xff014E70)),
                                      ),
                                    ],
                                    const SizedBox(
                                      height: 4,
                                    ),
                                    Text(
                                      '${item.quantity.toString()} piece',
                                      style: GoogleFonts.poppins(
                                          color: const Color(0xff858484)),
                                    ),
                                    if (item.isVirtualProduct)
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          InkWell(
                                              onTap: () {
                                                Get.toNamed(VirtualAssetsScreen.route);
                                                // if (item.isVirtualProductPDF) {
                                                //   Get.to(() => PDFOpener(
                                                //         pdfUrl: item,
                                                //       ));
                                                // } else {
                                                //   656erwfa
                                                //   print(item.toJson());
                                                //   Get.to(
                                                //       () => SingleCategoryScreen(
                                                //         product: VirtualProductData.fromJson(item.toJson()),
                                                //           ));
                                                // }
                                              },
                                              child: Text(
                                                "View",
                                                style: normalStyle,
                                              )),
                                        ],
                                      ),
                                    if (item.selectedSlotDate.toString() !=
                                            "" &&
                                        item.selectedSlotStart.toString() != "")
                                      GestureDetector(
                                        behavior: HitTestBehavior.translucent,
                                        onTap: () {
                                          item.showDetails.value =
                                              !item.showDetails.value;
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 6),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                  child: Text(
                                                "Booking Details",
                                                style: normalStyle,
                                              )),
                                              Obx(() {
                                                return item.showDetails.value
                                                    ? const Icon(
                                                        Icons
                                                            .keyboard_arrow_down_rounded,
                                                        color: AppTheme
                                                            .buttonColor,
                                                        size: 22,
                                                      )
                                                    : const Icon(
                                                        Icons
                                                            .arrow_forward_ios_rounded,
                                                        size: 16,
                                                      );
                                              }),
                                              const SizedBox(
                                                width: 4,
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    Obx(() {
                                      return item.showDetails.value
                                          ? Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    Expanded(
                                                        child: Text(
                                                      "Date: ${item.selectedSlotDate}",
                                                      style: normalStyle,
                                                    )),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Expanded(
                                                        child: Text(
                                                      "Time: ${item.selectedSlotStart} - ${item.selectedSlotEnd}",
                                                      style: normalStyle,
                                                    )),
                                                  ],
                                                ),
                                              ],
                                            )
                                          : const SizedBox.shrink();
                                    }),
                                    const SizedBox(
                                      height: 4,
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
                                  style: GoogleFonts.poppins(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18),
                                ),
                                Text(
                                  singleOrder.order!.createdDate.toString(),
                                  style: GoogleFonts.poppins(
                                      color: const Color(0xff9B9B9B),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14),
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
                                  style: GoogleFonts.poppins(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18),
                                ),
                                Text(
                                  singleOrder.order!.status
                                      .toString()
                                      .capitalize!,
                                  style: GoogleFonts.poppins(
                                      color: const Color(0xff9B9B9B),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14),
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
                                  style: GoogleFonts.poppins(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18),
                                ),
                                Text(
                                  "${singleOrder.order!.orderMeta!.totalPrice.toString()} ${singleOrder.order!.orderMeta!.currencySign.toString()}",
                                  style: GoogleFonts.poppins(
                                      color: const Color(0xff9B9B9B),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14),
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
                                  style: GoogleFonts.poppins(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18),
                                ),
                                Text(
                                  "Static 2 KWD",
                                  style: GoogleFonts.poppins(
                                      color: const Color(0xff9B9B9B),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          : const Center(
              child: CircularProgressIndicator.adaptive(),
            ),
    );
  }
}
