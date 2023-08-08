import 'package:dirise/widgets/common_colour.dart';
import 'package:dirise/widgets/loading_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../controller/vendor_controllers/vendor_dashboard_controller.dart';
import '../../controller/vendor_controllers/vendor_profile_controller.dart';
import '../../widgets/customsize.dart';
import '../../widgets/dimension_screen.dart';
import 'app_bar.dart';

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
    return Scaffold(
        appBar: const AppBarScreen(),
        body: RefreshIndicator(
          onRefresh: () async {
            await vendorProfileController.getVendorDetails();
          },
          child: Obx(() {
            Map<String, dynamic> gg ={};
            if(controller.modelVendorDashboard.dashboard != null){
              gg = controller.modelVendorDashboard.dashboard!.getJson();
            }
            if (controller.refreshInt.value > 0) {}
            return controller.modelVendorDashboard.dashboard != null
                ? SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: AddSize.size20,
                          ),
                          Text(
                            "This Month Report",
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                color: const Color(0xFF292F45)),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          GridView.count(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              crossAxisSpacing: AddSize.size12,
                              mainAxisSpacing: AddSize.size12,
                              crossAxisCount: 2,
                              childAspectRatio: AddSize.size15 / AddSize.size12,
                              children: List.generate(
                                4,
                                (index) => Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: AddSize.padding16,
                                      vertical: AddSize.padding16),
                                  decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.shade300,
                                          offset: const Offset(
                                            .1,
                                            .1,
                                          ),
                                          blurRadius: 19.0,
                                          spreadRadius: 1.0,
                                        ),
                                      ],
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(
                                            height: 40,
                                            width: 40,
                                            child: SvgPicture.asset(
                                                imgList[index].toString()),
                                          ),
                                          Expanded(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 15),
                                                  child: Text(
                                                    "10%",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headlineSmall!
                                                        .copyWith(
                                                            height: 1.5,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontSize: 15,
                                                            color: const Color(
                                                                0xFF65CD90)),
                                                  ),
                                                ),
                                                Icon(
                                                  Icons.arrow_upward_sharp,
                                                  color:
                                                      const Color(0xFF65CD90),
                                                  size: AddSize.size15,
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: AddSize.size10,
                                      ),
                                      Flexible(
                                        child: Text(
                                          '€234.00',
                                          style: GoogleFonts.poppins(
                                              height: 1.5,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 20,
                                              color: const Color(0xFF454B5C)),
                                        ),
                                      ),
                                      Flexible(
                                        child: Text(
                                          index == 0
                                              ? "Gross Sales"
                                              : index == 1
                                                  ? "Earning"
                                                  : index == 2
                                                      ? "Sold items"
                                                      : "Order Received",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headlineSmall!
                                              .copyWith(
                                                  height: 1.5,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 12,
                                                  color:
                                                      const Color(0xFF8C9BB2)),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )),
                          addHeight(12),
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: const Color(0xFF37C666)
                                            .withOpacity(0.10),
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
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 16),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            // Get.toNamed(storeOpenScreen);
                                          },
                                          child: Text(
                                            "Store",
                                            style: GoogleFonts.poppins(
                                                color: const Color(0xFF454B5C),
                                                fontWeight: FontWeight.w500,
                                                fontSize: 15),
                                          ),
                                        ),
                                        FlutterSwitch(
                                          showOnOff: true,
                                          width: AddSize.size30 * 2.2,
                                          height: AddSize.size20 * 1.4,
                                          padding: 2,
                                          valueFontSize: AddSize.font12,
                                          activeTextFontWeight: FontWeight.w600,
                                          inactiveText: " OFF",
                                          activeText: "  On",
                                          inactiveTextColor:
                                              const Color(0xFFEBEBEB),
                                          activeTextColor:
                                              const Color(0xFFFFFFFF),
                                          inactiveTextFontWeight:
                                              FontWeight.w600,
                                          inactiveColor: Colors.grey.shade400,
                                          activeColor: AppTheme.buttonColor,
                                          onToggle: (val) {
                                            setState(() {
                                              // state1 = val;
                                            });
                                          },
                                          value: true,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              addWidth(15),
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: const Color(0xFF37C666)
                                            .withOpacity(0.10),
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
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 16),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Self\nDelivery",
                                          style: GoogleFonts.poppins(
                                              color: const Color(0xFF454B5C),
                                              fontWeight: FontWeight.w500,
                                              fontSize: 15),
                                        ),
                                        FlutterSwitch(
                                          showOnOff: true,
                                          width: AddSize.size30 * 2.2,
                                          height: AddSize.size20 * 1.4,
                                          padding: 2,
                                          valueFontSize: AddSize.font12,
                                          activeTextFontWeight: FontWeight.w600,
                                          inactiveText: " OFF",
                                          activeText: "  On",
                                          inactiveTextColor:
                                              const Color(0xFFEBEBEB),
                                          activeTextColor:
                                              const Color(0xFFFFFFFF),
                                          inactiveTextFontWeight:
                                              FontWeight.w600,
                                          inactiveColor: Colors.grey.shade400,
                                          activeColor: AppTheme.buttonColor,
                                          onToggle: (val) {},
                                          value: false,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          addHeight(10),
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.shade300,
                                    offset: const Offset(
                                      .1,
                                      .1,
                                    ),
                                    blurRadius: 19.0,
                                    spreadRadius: 1.0,
                                  ),
                                ],
                                borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: AddSize.padding16,
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Latest Sales",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineSmall!
                                            .copyWith(
                                                height: 1.5,
                                                color: const Color(0xff454B5C),
                                                fontWeight: FontWeight.w500,
                                                fontSize: 16),
                                      ),
                                      TextButton(
                                          onPressed: () {
                                            // Get.toNamed(VendorOrderList
                                            //     .vendorOrderList);
                                          },
                                          child: Text(
                                            "See All",
                                            style: GoogleFonts.poppins(
                                                decoration:
                                                    TextDecoration.underline,
                                                decorationColor:
                                                    AppTheme.buttonColor,
                                                height: 1.5,
                                                fontWeight: FontWeight.w700,
                                                color: AppTheme.buttonColor,
                                                fontSize: 14),
                                          ))
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Order No.",
                                        style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14,
                                            color: const Color(0xFF52AC1A)),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: Text(
                                          "Status",
                                          style: GoogleFonts.poppins(
                                              height: 1.5,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14,
                                              color: const Color(0xFF52AC1A)),
                                        ),
                                      ),
                                      Text(
                                        "Earning",
                                        style: GoogleFonts.poppins(
                                            height: 1.5,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14,
                                            color: const Color(0xFF52AC1A)),
                                      )
                                    ],
                                  ),
                                  const Divider(
                                    color: Color(0xffEFEFEF),
                                  ),
                                  ListView.builder(
                                    physics: const BouncingScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: 3,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Column(
                                        children: [
                                          SizedBox(
                                            height: AddSize.size5,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "#1234",
                                                    style: GoogleFonts.poppins(
                                                        color: const Color(
                                                            0xFF454B5C),
                                                        height: 1.5,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 15),
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(
                                                    '2 June, 2021 - 11:57PM',
                                                    style: GoogleFonts.poppins(
                                                        height: 1.5,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 13,
                                                        color: const Color(
                                                            0xFF8C9BB2)),
                                                  ),
                                                ],
                                              ),
                                              addWidth(15),
                                              Text(
                                                'Processing',
                                                style: GoogleFonts.poppins(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 14,
                                                    color: const Color(
                                                        0xFFFFB26B)),
                                              ),
                                              const Spacer(),
                                              Text(
                                                "€45.00",
                                                style: GoogleFonts.poppins(
                                                    height: 1.5,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 15,
                                                    color: const Color(
                                                        0xFF454B5C)),
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
                                      );
                                    },
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : const LoadingAnimation();
          }),
        ));
  }
}
