import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/customsize.dart';
import '../widgets/dimension_screen.dart';


class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);
  static var dashboardScreen = "/dashboardScreen";

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
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
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        key: _scaffoldKey,
        drawer:Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              SizedBox(
                height: 230,
                child: DrawerHeader(
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color(0xFF7ED957),
                            Color(0xFF68C541),
                          ],
                        )
                    ),
                    child: Align(
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/images/Ellipse 67.png',
                            height: 100,
                          ),
                          Text('Williams Jones',
                              style: GoogleFonts.poppins(
                                fontSize: 18,
                                color: const Color(0xFFFFFFFF),
                                fontWeight: FontWeight.w600,)),
                          Text('williamsjones@gmail.com',
                              style: GoogleFonts.poppins(
                                fontSize: 15,
                                color: const Color(0xFFFFFFFF),
                                fontWeight: FontWeight.w400,)),
                        ],
                      ),
                    )),
              ),
              ListTile(
                visualDensity: const VisualDensity(horizontal: -4, vertical: -2),
                leading: Image.asset(
                  'assets/images/dashboard_icon.png',
                  height: 15,
                ),
                title:  Text('Dashboard',
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      color: const Color(0xFF4F535E),
                      fontWeight: FontWeight.w400,)),
                onTap: () {
                  setState(() {
                    currentDrawer = 0;
                    Get.back();
                  });
                },
              ),
              const Divider(
                height: 5,
                color: Color(0xffEFEFEF),
                thickness: 1,
              ),
              ListTile(
                visualDensity: const VisualDensity(horizontal: -4, vertical: -2),
                leading: Image.asset(
                  'assets/images/personImg.png',
                  height: 15,
                ),
                title:  Text('My Account',
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      color: const Color(0xFF4F535E),
                      fontWeight: FontWeight.w400,)),
                onTap: () {
                  setState(() {
                    currentDrawer = 1;
                    // Get.toNamed(MyRouters.myProfileScreen);
                    // Get.to(VendorOrderList());
                  });
                },
              ),
              const Divider(
                height: 5,
                color: Color(0xffEFEFEF),
                thickness: 1,
              ),
              ListTile(
                visualDensity: const VisualDensity(horizontal: -4, vertical: -2),
                leading: Image.asset(
                  'assets/images/time_track.png',
                  height: 18,
                ),
                title:  Text('My Order',
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      color: const Color(0xFF4F535E),
                      fontWeight: FontWeight.w400,)),
                onTap: () {
                  setState(() {
                    currentDrawer = 2;
                    // Get.toNamed(VendorOrderList.vendorOrderList);
                  });
                },
              ),
              const Divider(
                height: 5,
                color: Color(0xffEFEFEF),
                thickness: 1,
              ),
              ListTile(
                visualDensity: const VisualDensity(horizontal: -4, vertical: -2),
                leading: Image.asset(
                  'assets/images/cube.png',
                  height: 18,
                ),
                title:  Text('Products',
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      color: const Color(0xFF4F535E),
                      fontWeight: FontWeight.w400,)),
                onTap: () {
                  setState(() {
                    currentDrawer = 2;
                    // Get.toNamed(AllProductScreen.allProductScreen);
                  });
                },
              ),
              const Divider(
                height: 5,
                color: Color(0xffEFEFEF),
                thickness: 1,
              ),
              ListTile(
                visualDensity: const VisualDensity(horizontal: -4, vertical: -2),
                leading: Image.asset(
                  'assets/images/time_icon.png',
                  height: 18,
                ),
                title:  Text('Store open time',
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      color: const Color(0xFF4F535E),
                      fontWeight: FontWeight.w400,)),
                onTap: () {
                  setState(() {
                    currentDrawer = 2;
                    // Get.toNamed(MyRouters.notificationScreen);
                  });
                },
              ),
              const Divider(
                height: 5,
                color: Color(0xffEFEFEF),
                thickness: 1,
              ),
              ListTile(
                visualDensity: const VisualDensity(horizontal: -4, vertical: -2),
                leading: Image.asset(
                  'assets/images/store_setting.png',
                  height: 18,
                ),
                title:  Text('Store Setting',
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      color: const Color(0xFF4F535E),
                      fontWeight: FontWeight.w400,)),
                onTap: () {
                  setState(() {
                    currentDrawer = 2;
                    // Get.toNamed(SetTimeScreen.setTimeScreen);
                  });
                },
              ),

              const Divider(
                height: 5,
                color: Color(0xffEFEFEF),
                thickness: 1,
              ),
              ListTile(
                visualDensity: const VisualDensity(horizontal: -4, vertical: -2),
                leading: Image.asset(
                  'assets/images/bx_wallet.png',
                  height: 18,
                ),
                title:  Text('Bank Details',
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      color: const Color(0xFF4F535E),
                      fontWeight: FontWeight.w400,)),
                onTap: () {
                  setState(() {
                    currentDrawer = 3;
                    // Get.toNamed(BankDetailsScreen.bankDetailsScreen);
                  });
                },
              ),
              const Divider(
                height: 5,
                color: Color(0xffEFEFEF),
                thickness: 1,
              ),
              ListTile(
                visualDensity: const VisualDensity(horizontal: -4, vertical: -2),
                leading: Image.asset(
                  'assets/images/earn.png',
                  height: 17,
                ),
                title:  Text('Earning',
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      color: const Color(0xFF4F535E),
                      fontWeight: FontWeight.w400,)),
                onTap: () {
                  setState(() {
                    currentDrawer = 3;
                    // Get.toNamed(MyRouters.driverWithdrawMoney);
                  });
                },
              ),
              const Divider(
                height: 5,
                color: Color(0xffEFEFEF),
                thickness: 1,
              ),
              ListTile(
                visualDensity: const VisualDensity(horizontal: -4, vertical: -2),
                leading: Image.asset(
                  'assets/images/message.png',
                  height: 15,
                ),
                title:  Text('Message',
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      color: const Color(0xFF4F535E),
                      fontWeight: FontWeight.w400,)),
                onTap: () {
                  setState(() {
                    currentDrawer = 5;
                    // Get.toNamed(ChatScreen.chatScreen);
                  });
                },
              ),
              const Divider(
                height: 5,
                color: Color(0xffEFEFEF),
                thickness: 1,
              ),
              ListTile(
                visualDensity: const VisualDensity(horizontal: -4, vertical: -2),
                leading: Image.asset(
                  'assets/images/metro-security.png',
                  height: 15,
                ),
                title:  Text('Privacy Policy',
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      color: const Color(0xFF4F535E),
                      fontWeight: FontWeight.w400,)),
                onTap: () {
                  setState(() {
                    currentDrawer = 6;
                    // Get.to(VendorHelpCenterScreen());
                  });
                },
              ),
              const Divider(
                height: 5,
                color: Color(0xffEFEFEF),
                thickness: 1,
              ),
              ListTile(
                visualDensity: const VisualDensity(horizontal: -4, vertical: -2),
                leading: Image.asset(
                  'assets/images/help_center.png',
                  height: 15,
                ),
                title:  Text('Help Center',
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      color: const Color(0xFF4F535E),
                      fontWeight: FontWeight.w400,)),
                onTap: () {
                  setState(() {
                    currentDrawer = 7;
                    // Get.to(SettingScreenVendor());
                  });
                },
              ),
              const Divider(
                height: 5,
                color: Color(0xffEFEFEF),
                thickness: 1,
              ),
              ListTile(
                visualDensity: const VisualDensity(horizontal: -4, vertical: -2),
                leading: Image.asset(
                  'assets/images/logout.png',
                  height: 15,
                ),
                title:  Text('Logout',
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      color: const Color(0xFF4F535E),
                      fontWeight: FontWeight.w400,)),
                onTap: () {
                  setState(() {
                    currentDrawer = 7;
                    // Get.to(SettingScreenVendor());
                  });
                },
              ),
            ],
          ),
        ),
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Column(
              children: [
                GestureDetector(
                  onTap: (){
                    _scaffoldKey.currentState!.openDrawer();
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: Image.asset('assets/images/drawer.png',height: 24,),
                  ),
                ),
              ],
            ),
          ),
          toolbarHeight: 60,
          backgroundColor: Colors.transparent,
          elevation: 0,
          leadingWidth: AddSize.size20 * 3,
          title: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Hi, Demo Vendor...",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: AddSize.font20,
                      color: const Color(0xff292F45)),),
                Row(
                  children: [
                    const Text("Store Time :",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                          color:  Color(0xff737A8A)),),
                    const Text(" 10am to 9pm",
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          color:  Color(0xff73CF4C)),),
                    addWidth(5),
                    InkWell(
                      onTap: () {
                        // Get.toNamed(SetTimeScreen.setTimeScreen);
                      },
                      child: const Icon(
                        Icons.edit,
                        color: Color(0xFF73CF4C),
                        size: 15,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          actions: [
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 16.0,top: 8),
                  child: GestureDetector(
                    onTap: () async {
                    },
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 20,
                      child: Container(
                          height: 45,
                          width: 45,
                          clipBehavior: Clip.antiAlias,
                          // margin: EdgeInsets.all(1),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            // color: Colors.brown
                          ),
                          child: Image.asset('assets/images/avtar.png')
                        // Obx(() {
                        //   return CachedNetworkImage(
                        //     fit: BoxFit.cover,
                        //     imageUrl: profileController.isDataLoading.value
                        //         ? profileController
                        //         .model.value.data!.profileImage!
                        //         : '',
                        //     height: AddSize.size30,
                        //     width: AddSize.size30,
                        //     errorWidget: (_, __, ___) => const SizedBox(),
                        //     placeholder: (_, __) => const SizedBox(),
                        //   );
                        // })
                      ),
                    ),
                  ),
                ),
                Positioned(
                    top: 5,
                    child: Column(
                        children:[
                          Image.asset('assets/images/active.png',height: 12,),
                        ]
                    )
                )
              ],
            )
          ],
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: AddSize.size20,
                ),
                const Text(
                  "This Month Report",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Color(0xFF292F45)
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                GridView.count(
                    shrinkWrap: true,
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
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  height: 40,
                                  width: 40,
                                  child: Image.asset(imgList[index].toString()),
                                  // decoration:
                                  // ShapeDecoration(
                                  //     color: index == 0
                                  //         ? Colors.red
                                  //         : index == 1
                                  //             ? Colors.orange
                                  //             : index == 2
                                  //                 ? AppTheme.primaryColor
                                  //                 : Colors.cyan,
                                  //     shape: const CircleBorder()),
                                  // child: Image.asset(imgList[index].toString()),
                                  // child: Center(
                                  //     child: Image(
                                  //         height: AddSize.size25,
                                  //         width: AddSize.size25,
                                  //         image: const AssetImage(
                                  //             AppAssets
                                  //                 .vendorICON))),
                                ),
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(left: 15),
                                        child: Text(
                                          // index == 0
                                          // ? "${vendorDashboardController.model.value.data!.grossSalesPercent.toString()} %"
                                          //     : index == 1
                                          // ? "${vendorDashboardController.model.value.data!.earningPercent.toString()} %"
                                          //     : index == 2
                                          // ? "${vendorDashboardController.model.value.data!.soldItemsPercent.toString()} %"
                                          //     : "${vendorDashboardController.model.value.data!.orderReceivedPercent.toString()} %",
                                          "10%",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline5!
                                              .copyWith(
                                              height: 1.5,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 15,
                                              color: Color(0xFF65CD90)),
                                        ),
                                      ),
                                      Icon(
                                        Icons.arrow_upward_sharp,
                                        color: Color(0xFF65CD90),
                                        size: AddSize.size15,
                                      )
                                      // : Icon(
                                      //     Icons.arrow_downward,
                                      //     color: Colors.red,
                                      //     size: AddSize.size15,
                                      //   )
                                    ],
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: AddSize.size10,
                            ),
                            const Text(
                              '€234.00',
                              style: TextStyle(
                                  height: 1.5,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 22,
                                  color:  Color(0xFF454B5C)),
                            ),
                            Text(
                              index == 0
                                  ? "Gross Sales"
                                  : index == 1
                                  ? "Earning"
                                  : index == 2
                                  ? "Sold items"
                                  : "Order Received",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline5!
                                  .copyWith(
                                  height: 1.5,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                  color: Color(0xFF8C9BB2)),
                            ),
                          ],
                        ),
                      ),
                    )),
                addHeight(15),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF37C666).withOpacity(0.10),
                              offset: const Offset(.1, .1,
                              ),
                              blurRadius: 20.0,
                              spreadRadius: 1.0,
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Collection",
                                style: TextStyle(
                                    color : Color(0xFF454B5C),
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12
                                ),),
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
                                activeTextColor:  const Color(0xFFFFFFFF),
                                inactiveTextFontWeight: FontWeight.w600,
                                inactiveColor: Colors.grey.shade400,
                                activeColor: const Color(0xFF04666E),
                                onToggle: (val) {
                                  setState(() {
                                    state1= val;
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
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF37C666).withOpacity(0.10),
                              offset: const Offset(.1, .1,
                              ),
                              blurRadius: 20.0,
                              spreadRadius: 1.0,
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Self-Delivery",
                                style: TextStyle(
                                    color : Color(0xFF454B5C),
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12
                                ),),
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
                                activeTextColor:  const Color(0xFFFFFFFF),
                                inactiveTextFontWeight: FontWeight.w600,
                                inactiveColor: Colors.grey.shade400,
                                activeColor: const Color(0xFF04666E),
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
                addHeight(15),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF37C666).withOpacity(0.10),
                        offset: const Offset(.1, .1,
                        ),
                        blurRadius: 20.0,
                        spreadRadius: 1.0,
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0,horizontal: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Sustainable Packaging",
                          style: TextStyle(
                              color : Color(0xFF454B5C),
                              fontWeight: FontWeight.w600,
                              fontSize: 12
                          ),),
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
                          activeTextColor:  const Color(0xFFFFFFFF),
                          inactiveTextFontWeight: FontWeight.w600,
                          inactiveColor: Colors.grey.shade400,
                          activeColor: const Color(0xFF04666E),
                          onToggle: (val) {
                            setState(() {
                              state = val;
                            });
                          },
                          value: state,
                        )
                      ],
                    ),
                  ),
                ),
                addHeight(15),
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
                      borderRadius: BorderRadius.circular(20)),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: AddSize.padding16,
                        vertical: AddSize.padding10),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Latest Sales",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline5!
                                  .copyWith(
                                  height: 1.5,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15),
                            ),
                            TextButton(
                                onPressed: () {
                                  // Get.toNamed(VendorOrderList
                                  //     .vendorOrderList);
                                },
                                child: const Text(
                                  "See All",
                                  style: TextStyle(
                                      decoration:
                                      TextDecoration.underline,
                                      height: 1.5,
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xff7ED957),
                                      fontSize: 13),
                                ))
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const[
                            Text(
                              "Order No.",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                  color: Color(0xFF52AC1A)),
                            ),
                            Text(
                              "Status",
                              style: TextStyle(
                                  height: 1.5,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                  color: Color(0xFF52AC1A)),
                            ),
                            Text(
                              "Earning",
                              style: TextStyle(
                                  height: 1.5,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                  color: Color(0xFF52AC1A)),
                            )
                          ],
                        ),
                        const Divider(),
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
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: const[
                                        Text(
                                          "#1234",
                                          style: TextStyle(
                                              color: Color(0xFF454B5C),
                                              height: 1.5,
                                              fontWeight:
                                              FontWeight.w600,
                                              fontSize: 14),
                                        ),
                                        Text(
                                          '2 June, 2021 - 11:57PM',
                                          style: TextStyle(
                                              height: 1.5,
                                              fontWeight:
                                              FontWeight.w500,
                                              fontSize: 11,
                                              color: Color(0xFF8C9BB2)),
                                        ),
                                      ],
                                    ),
                                    addWidth(30),
                                    const Text(
                                      'Processing',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12,
                                          color:  Color(0xFFFFB26B)
                                      ),
                                    ),
                                    Spacer(),
                                    const Text(
                                      "€45.00",
                                      style: TextStyle(
                                          height: 1.5,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12,
                                          color: Color(0xFF454B5C)),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: AddSize.size5,
                                ),
                                const Divider(),
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
        ));
  }
}

