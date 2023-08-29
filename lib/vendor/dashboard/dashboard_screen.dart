import 'dart:convert';
import 'package:dirise/widgets/loading_animation.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../controller/vendor_controllers/vendor_dashboard_controller.dart';
import '../../controller/vendor_controllers/vendor_profile_controller.dart';
import '../../widgets/dimension_screen.dart';
import '../orders/orderdetailsscreen.dart';
import 'app_bar.dart';
import 'charts.dart';
import 'sliver_bar.dart';

class VendorDashBoardScreen extends StatefulWidget {
  const VendorDashBoardScreen({Key? key}) : super(key: key);
  static String route = "/VendorDashBoardScreen";

  @override
  State<VendorDashBoardScreen> createState() => _VendorDashBoardScreenState();
}

class _VendorDashBoardScreenState extends State<VendorDashBoardScreen> {
  final controller = Get.put(VendorDashboardController());
  final vendorProfileController = Get.put(VendorProfileController());

  @override
  void initState() {
    super.initState();
    controller.getVendorDashBoard();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade100,
      child: SafeArea(
        child: Scaffold(
            appBar: const AppBarScreen(),
            backgroundColor: Colors.grey.shade100,
            body: RefreshIndicator(
              onRefresh: () async {
                await controller.getVendorDashBoard();
              },
              child: Obx(() {
                if (controller.refreshInt.value > 0) {}
                return controller.modelVendorDashboard.dashboard != null
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: CustomScrollView(
                          shrinkWrap: true,
                          slivers: [
                            thisMonth(),
                            const DashBoardCharts(),
                            const SliverToBoxAdapter(
                              child: SizedBox(
                                height: 14,
                              ),
                            ),
                            const LatestSalesAppBar(),
                            SliverList.builder(
                                itemCount: controller.modelVendorDashboard.order!.length,
                                itemBuilder: (context, index) {
                                  final order = controller.modelVendorDashboard.order![index];
                                  if (kDebugMode) {
                                    print(jsonEncode(order));
                                    print("SliverList....    $index");
                                  }
                                  return GestureDetector(
                                    behavior: HitTestBehavior.translucent,
                                    onTap: (){
                                      Get.to(()=> OrderDetails(orderId: order.orderId.toString(),));
                                    },
                                    child: Container(
                                      color: Colors.white,
                                      padding: const EdgeInsets.symmetric(horizontal: 15),
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: AddSize.size5,
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                flex: 5,
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "#${order.orderId.toString()}",
                                                      style: GoogleFonts.poppins(
                                                          color: const Color(0xFF454B5C),
                                                          height: 1.5,
                                                          fontWeight: FontWeight.w500,
                                                          fontSize: 15),
                                                    ),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    if (DateTime.tryParse(order.updatedAt.toString()) != null)
                                                      Text(
                                                        DateFormat("HH:mm a - dd MMM, yyyy")
                                                            .format(DateTime.tryParse(order.updatedAt.toString())!),
                                                        style: GoogleFonts.poppins(
                                                            fontWeight: FontWeight.w500,
                                                            fontSize: 13,
                                                            color: const Color(0xFF8C9BB2)),
                                                      ),
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 6,
                                              ),
                                              Expanded(
                                                flex: 3,
                                                child: Text(
                                                  order.status.toString().capitalize!,
                                                  style: GoogleFonts.poppins(
                                                      fontWeight: FontWeight.w600, fontSize: 14, color: const Color(0xFFFFB26B)),
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 6,
                                              ),
                                              Expanded(
                                                flex: 2,
                                                child: Text(
                                                  "\$${order.totalPrice}",
                                                  textAlign: TextAlign.end,
                                                  style: GoogleFonts.poppins(
                                                      height: 1.5,
                                                      fontWeight: FontWeight.w500,
                                                      fontSize: 15,
                                                      color: const Color(0xFF454B5C)),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: AddSize.size5,
                                          ),
                                          const Divider(
                                            color: Color(0xffEFEFEF),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                          ],
                        ),
                      )
                    : const LoadingAnimation();
              }),
            )),
      ),
    );
  }

  SliverToBoxAdapter thisMonth() {
    return const SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 18,
          ),
          Text(
            "This Month Report",
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, color: Color(0xFF292F45)),
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}