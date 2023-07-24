import 'dart:developer';

import 'package:dirise/routers/my_routers.dart';
import 'package:dirise/utils/helper.dart';
import 'package:dirise/vendorflow/drawer_screens/vendor_drawer_screen.dart';
import 'package:dirise/widgets/common_colour.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import '../controller/vendor_controllers/vendor_profile_controller.dart';
import '../widgets/customsize.dart';
import '../widgets/dimension_screen.dart';

class VendorDashBoardScreen extends StatefulWidget {
  const VendorDashBoardScreen({Key? key}) : super(key: key);
  static String route = "/VendorDashBoardScreen";

  @override
  State<VendorDashBoardScreen> createState() => _VendorDashBoardScreenState();
}

class _VendorDashBoardScreenState extends State<VendorDashBoardScreen> {
  int currentDrawer = 0;
  bool state = false;
  bool state1 = true;
  bool state2 = true;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  List imgList = [
    'assets/images/Group 1000004268.png',
    'assets/images/Group 1000004267.png',
    'assets/images/Group 1000004270.png',
    'assets/images/Group 1000004269.png',
  ];
  final vendorController = Get.put(VendorProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        // drawer: const VendorDrawerScreen(),
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Get.back();
                    // _scaffoldKey.currentState!.openDrawer();
                  },
                  child: Image.asset(
                    'assets/icons/backicon.png',
                    height: 25,
                  ),
                ),
              ],
            ),
          ),
          toolbarHeight: 60,
          backgroundColor: Colors.transparent,
          elevation: 0,
          titleSpacing: 0,
          title: Obx(() {
            if (vendorController.refreshInt.value > 0) {}
            return vendorController.apiLoaded ?
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Hi, ${vendorController.model.data!.name.toString().checkNullable}",
                  style: TextStyle(
                      fontWeight: FontWeight.w600, fontSize: AddSize.font22, color: const Color(0xff292F45)),
                ),
                const SizedBox(
                  height: 3,
                ),
                Row(
                  children: [
                    const Flexible(
                      child: Text(
                        "Store Time :",
                        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, color: Color(0xff737A8A)),
                      ),
                    ),
                    const Expanded(
                      child: Text(
                        " 10am to 9pm",
                        style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16, color: AppTheme.buttonColor),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        // Get.toNamed(SetTimeScreen.setTimeScreen);
                      },
                      child: const Icon(
                        Icons.edit,
                        color: AppTheme.buttonColor,
                        size: 15,
                      ),
                    ),
                  ],
                )
              ],
            ) : const SizedBox();
          }),
          actions: [
            Obx(() {
              // log(vendorController.model.data!.storeBusinessId.toString());
              if (vendorController.refreshInt.value > 0) {}
              return vendorController.apiLoaded ?
              Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 16.0, top: 8),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(1000),
                      child: Container(
                          height: 45,
                          width: 45,
                          clipBehavior: Clip.antiAlias,
                          // margin: EdgeInsets.all(1),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            // color: Colors.brown
                          ),
                          child: Image.network(vendorController.model.data!.storeImage.toString(),
                          errorBuilder: (_,__,___)=> const SizedBox(),)
                      ),
                    ),
                  ),
                  Positioned(
                      top: 9,
                      child: Column(children: [
                        Image.asset(
                          'assets/icons/active.png',
                          height: 12,
                        ),
                      ]))
                ],
              ) : const Padding(
                padding: EdgeInsets.only(right: 14),
                child: Center(child: CupertinoActivityIndicator(),),
              );
            })
          ],
        ),
        body: RefreshIndicator(
          onRefresh: ()async{
            await vendorController.getVendorDetails();
          },
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: AddSize.size20,
                  ),
                  const Text(
                    "This Month Report",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, color: Color(0xFF292F45)),
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
                            (index) =>
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: AddSize.padding16, vertical: AddSize.padding16),
                              decoration: BoxDecoration(boxShadow: [
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        height: 40,
                                        width: 40,
                                        child: Image.asset(imgList[index].toString()),
                                      ),
                                      Expanded(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(left: 15),
                                              child: Text(
                                                "10%",
                                                style: Theme
                                                    .of(context)
                                                    .textTheme
                                                    .headlineSmall!
                                                    .copyWith(
                                                    height: 1.5,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 15,
                                                    color: const Color(0xFF65CD90)),
                                              ),
                                            ),
                                            Icon(
                                              Icons.arrow_upward_sharp,
                                              color: const Color(0xFF65CD90),
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
                                  const Flexible(
                                    child: Text(
                                      '€234.00',
                                      style: TextStyle(
                                          height: 1.5,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 20,
                                          color: Color(0xFF454B5C)),
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
                                      style: Theme
                                          .of(context)
                                          .textTheme
                                          .headlineSmall!
                                          .copyWith(
                                          height: 1.5,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12,
                                          color: const Color(0xFF8C9BB2)),
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
                            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Get.toNamed(MyRouters.storeOpenScreen);
                                  },
                                  child: const Text(
                                    "Store",
                                    style: TextStyle(color: Color(0xFF454B5C), fontWeight: FontWeight.w500, fontSize: 15),
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
                                  inactiveTextColor: const Color(0xFFEBEBEB),
                                  activeTextColor: const Color(0xFFFFFFFF),
                                  inactiveTextFontWeight: FontWeight.w600,
                                  inactiveColor: Colors.grey.shade400,
                                  activeColor: AppTheme.buttonColor,
                                  onToggle: (val) {
                                    setState(() {
                                      state1 = val;
                                    });
                                  },
                                  value: state1,
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
                            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Self\nDelivery",
                                  style: TextStyle(color: Color(0xFF454B5C), fontWeight: FontWeight.w500, fontSize: 15),
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
                                  inactiveTextColor: const Color(0xFFEBEBEB),
                                  activeTextColor: const Color(0xFFFFFFFF),
                                  inactiveTextFontWeight: FontWeight.w600,
                                  inactiveColor: Colors.grey.shade400,
                                  activeColor: AppTheme.buttonColor,
                                  onToggle: (val) {
                                    setState(() {
                                      state2 = val;
                                    });
                                  },
                                  value: state2,
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Latest Sales",
                                style: Theme
                                    .of(context)
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
                                  child: const Text(
                                    "See All",
                                    style: TextStyle(
                                        decoration: TextDecoration.underline,
                                        decorationColor: AppTheme.buttonColor,
                                        height: 1.5,
                                        fontWeight: FontWeight.w700,
                                        color: AppTheme.buttonColor,
                                        fontSize: 14),
                                  ))
                            ],
                          ),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Order No.",
                                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: Color(0xFF52AC1A)),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: Text(
                                  "Status",
                                  style: TextStyle(
                                      height: 1.5, fontWeight: FontWeight.w600, fontSize: 14, color: Color(0xFF52AC1A)),
                                ),
                              ),
                              Text(
                                "Earning",
                                style: TextStyle(
                                    height: 1.5, fontWeight: FontWeight.w600, fontSize: 14, color: Color(0xFF52AC1A)),
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
                            itemBuilder: (BuildContext context, int index) {
                              return Column(
                                children: [
                                  SizedBox(
                                    height: AddSize.size5,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "#1234",
                                            style: TextStyle(
                                                color: Color(0xFF454B5C),
                                                height: 1.5,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 15),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            '2 June, 2021 - 11:57PM',
                                            style: TextStyle(
                                                height: 1.5,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 13,
                                                color: Color(0xFF8C9BB2)),
                                          ),
                                        ],
                                      ),
                                      addWidth(15),
                                      const Text(
                                        'Processing',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600, fontSize: 14, color: Color(0xFFFFB26B)),
                                      ),
                                      const Spacer(),
                                      const Text(
                                        "€45.00",
                                        style: TextStyle(
                                            height: 1.5,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 15,
                                            color: Color(0xFF454B5C)),
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
          ),
        ));
  }
}
