import 'package:dirise/screens/auth_screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../controller/cart_controller.dart';
import '../../controller/home_controller.dart';
import '../../controller/profile_controller.dart';
import '../../routers/my_routers.dart';
import '../../vendorflow/add_money_screen.dart';
import '../../vendorflow/all_product_screen.dart';
import '../../vendorflow/bank_account_screen.dart';
import '../../vendorflow/dashboard_screen.dart';
import '../../vendorflow/store_open_time_screen.dart';
import '../../vendorflow/vendor_order_list_screen.dart';
import '../../vendorflow/vendor_registration_screen.dart';
import '../../widgets/common_colour.dart';
import '../../widgets/dimension_screen.dart';
import '../order_screens/my_orders_screen.dart';

class MyAccountScreen extends StatefulWidget {
  const MyAccountScreen({Key? key}) : super(key: key);

  @override
  State<MyAccountScreen> createState() => _MyAccountScreenState();
}

enum SingingCharacter { lafayette, jefferson }

class _MyAccountScreenState extends State<MyAccountScreen> {
  RxString language = "".obs;
  final RxBool _isValue = false.obs;
  var vendor = ['Dashboard', 'Order', 'Products', 'Store open time', 'Vendor Information', 'Bank Details', 'Withdraw'];
  var vendorRoutes = [
    DashboardScreen.dashboardScreen,
    VendorOrderList.vendorOrderList,
    ProductScreen.allProductScreen,
    SetTimeScreen.setTimeScreen,
    VendorRegistrationScreen.registrationScreen,
    BankDetailsScreen.bankDetailsScreen,
    WithdrawMoney.withdrawMoney,
  ];

  final profileController = Get.put(ProfileController());
  final cartController = Get.put(CartController());
  final homeController = Get.put(TrendingProductsController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(130),
        child: Container(
          color: AppTheme.buttonColor,
          child: SafeArea(
            child: Container(
              height: 194,
              width: MediaQuery.sizeOf(context).width,
              color: AppTheme.buttonColor,
              child: Obx(() {
                if (profileController.refreshInt.value > 0) {}
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Account",
                      style: GoogleFonts.poppins(
                          color:  Colors.white, fontSize: 24, fontWeight: FontWeight.w600),
                    ),
                    profileController.userLoggedIn
                        ? Image.network(
                      profileController.apiLoaded ? profileController.model.user!.profileImage.toString() : "",
                      errorBuilder: (_, __, ___) =>
                      const SizedBox(
                        height: 60,
                        width: 60,
                      ),
                    )
                        : Image.asset(
                      'assets/images/myaccount.png',
                      height: 60,
                      width: 60,
                    ),
                    Text(
                      profileController.userLoggedIn
                          ? profileController.apiLoaded
                          ? profileController.model.user!.name
                          : ""
                          : "Guest User",
                      style: GoogleFonts.poppins(
                          color:  Colors.white, fontSize: 16, fontWeight: FontWeight.w400),
                    ),
                  ],
                );
              }),
            ),
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await profileController.getDataProfile();
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Column(children: [
              const SizedBox(
                height: 20,
              ),
              ListTile(
                onTap: () {
                  if (profileController.userLoggedIn) {
                    Get.toNamed(MyRouters.profileScreen);
                  } else {
                    Get.toNamed(LoginScreen.route);
                  }
                },
                dense: true,
                minLeadingWidth: 0,
                contentPadding: EdgeInsets.zero,
                minVerticalPadding: 0,
                visualDensity: const VisualDensity(vertical: -4, horizontal: -4),
                title: Row(
                  children: [
                    Image.asset(height: 25, 'assets/icons/drawerprofile.png'),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: Text(
                        "Profile",
                        style: GoogleFonts.poppins(
                            color: const Color(0xFF2A3032), fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                    ),
                    const Icon(
                      Icons.arrow_forward_ios,
                      size: 15,
                    ),
                  ],
                ),
              ),
              const Divider(
                thickness: 1,
                color: Color(0x1A000000),
              ),
              const SizedBox(
                height: 5,
              ),
              GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  Get.toNamed(MyRouters.eBookScreen);
                },
                child: Row(
                  children: [
                    Image.asset(height: 25, 'assets/icons/ebook.png'),
                    const SizedBox(
                      width: 20,
                    ),
                    Text(
                      "E Books",
                      style:
                      GoogleFonts.poppins(color: const Color(0xFF2A3032), fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    const Spacer(),
                    const Icon(
                      Icons.arrow_forward_ios,
                      size: 15,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              const Divider(
                thickness: 1,
                color: Color(0x1A000000),
              ),
              const SizedBox(
                height: 5,
              ),
              InkWell(
                onTap: () {
                  if (profileController.userLoggedIn) {
                    Get.toNamed(MyOrdersScreen.myOrdersScreen);
                  } else {
                    Get.toNamed(LoginScreen.route);
                  }
                },
                child: Row(
                  children: [
                    Image.asset(height: 25, 'assets/icons/order.png'),
                    const SizedBox(
                      width: 20,
                    ),
                    Text(
                      "Orders",
                      style:
                      GoogleFonts.poppins(color: const Color(0xFF2A3032), fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    const Spacer(),
                    const Icon(
                      Icons.arrow_forward_ios,
                      size: 15,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              const Divider(
                thickness: 1,
                color: Color(0x1A000000),
              ),
              const SizedBox(
                height: 5,
              ),
              GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  Get.toNamed(MyRouters.calendarScreen);
                },
                child: Row(
                  children: [
                    Image.asset(height: 25, 'assets/icons/calendar.png'),
                    const SizedBox(
                      width: 20,
                    ),
                    Text(
                      "My Calender",
                      style:
                      GoogleFonts.poppins(color: const Color(0xFF2A3032), fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    const Spacer(),
                    const Icon(
                      Icons.arrow_forward_ios,
                      size: 15,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              const Divider(
                thickness: 1,
                color: Color(0x1A000000),
              ),
              const SizedBox(
                height: 5,
              ),
              GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  Get.toNamed(MyRouters.faqsScreen);
                },
                child: Row(
                  children: [
                    Image.asset(height: 25, 'assets/icons/faq.png'),
                    const SizedBox(
                      width: 20,
                    ),
                    Text(
                      "Faq's",
                      style:
                      GoogleFonts.poppins(color: const Color(0xFF2A3032), fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    const Spacer(),
                    const Icon(
                      Icons.arrow_forward_ios,
                      size: 15,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              const Divider(
                thickness: 1,
                color: Color(0x1A000000),
              ),
              const SizedBox(
                height: 5,
              ),
              GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {},
                child: Row(
                  children: [
                    Image.asset(height: 25, 'assets/images/digitalreader.png'),
                    const SizedBox(
                      width: 20,
                    ),
                    Text(
                      "Digital Pdf Reader",
                      style:
                      GoogleFonts.poppins(color: const Color(0xFF2A3032), fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    const Spacer(),
                    const Icon(
                      Icons.arrow_forward_ios,
                      size: 15,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              const Divider(
                thickness: 1,
                color: Color(0x1A000000),
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                dense: true,
                visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                textColor: AppTheme.primaryColor,
                iconColor: AppTheme.primaryColor,
                minLeadingWidth: 0,
                onTap: () {
                  if(profileController.model.user != null && profileController.model.user!.isVendor != true){
                    Get.toNamed(VendorRegistrationScreen.registrationScreen,);
                    return;
                  }
                  _isValue.value = !_isValue.value;
                  setState(() {});
                },
                title: Row(
                  children: [
                    const Image(
                      height: 25,
                      image: AssetImage(
                        'assets/icons/vendoricon.png',
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: Text(
                        'Vendor partner',
                        style: GoogleFonts.poppins(
                            color: const Color(0xFF2A3032), fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                    ),
                    Icon(
                      !_isValue.value == true
                          ? Icons.arrow_forward_ios
                          : Icons.keyboard_arrow_down,
                      color: Colors.black,
                      size: 15,
                    ),
                  ],
                ),
              ),
              _isValue.value == true
                  ? Obx(() {
                    if(profileController.refreshInt.value > 0){}

                return profileController.model.user != null ?
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: profileController.model.user!.isVendor == true ?
                  List.generate(
                      vendor.length,
                          (index) =>
                          Row(
                            children: [
                              const SizedBox(
                                width: 30,
                              ),
                              Expanded(
                                child: TextButton(
                                  onPressed: () {
                                    Get.toNamed(vendorRoutes[index]);
                                  },
                                  style: TextButton.styleFrom(
                                      visualDensity: const VisualDensity(vertical: -3, horizontal: -3),
                                      padding: EdgeInsets.zero.copyWith(left: 16)
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          vendor[index],
                                          style: TextStyle(
                                              fontSize: 16, fontWeight: FontWeight.w400, color: Colors.grey.shade500),
                                        ),
                                      ),
                                      const Icon(Icons.arrow_forward_ios_rounded, size: 14,)
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          )) : [

                  ],
                ) : const SizedBox();
              })
                  : const SizedBox(),
              const Divider(
                thickness: 1,
                color: Color(0x1A000000),
              ),
              GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  showModalBottomSheet<void>(
                      context: context,
                      builder: (BuildContext context) {
                        return Container(
                            height: 330,
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))),
                            child: Obx(() {
                              return Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                                      child: Container(
                                          decoration: BoxDecoration(
                                              border: Border.all(color: const Color(0xffDCDCDC)),
                                              borderRadius: BorderRadius.circular(15)),
                                          child: RadioListTile(
                                            title: const Text('Arabic'),
                                            activeColor: const Color(0xff014E70),
                                            value: "arabic",
                                            groupValue: language.value,
                                            onChanged: (value) {
                                              setState(() {
                                                language.value = value!;
                                              });
                                            },
                                          )),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 20, right: 20),
                                      child: Container(
                                          decoration: BoxDecoration(
                                              border: Border.all(color: const Color(0xffDCDCDC)),
                                              borderRadius: BorderRadius.circular(15)),
                                          child: RadioListTile(
                                            title: const Text('English'),
                                            activeColor: const Color(0xff014E70),
                                            value: "english",
                                            groupValue: language.value,
                                            onChanged: (value) {
                                              setState(() {
                                                language.value = value!;
                                              });
                                            },
                                          )),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Padding(
                                        padding: const EdgeInsets.only(left: 20, right: 20),
                                        child: Container(
                                            decoration: BoxDecoration(
                                                border: Border.all(color: const Color(0xffDCDCDC)),
                                                borderRadius: BorderRadius.circular(15)),
                                            child: RadioListTile(
                                              title: const Text('Several languages'),
                                              activeColor: const Color(0xff014E70),
                                              value: "Several languages",
                                              groupValue: language.value,
                                              onChanged: (value) {
                                                setState(() {
                                                  language.value = value!;
                                                });
                                              },
                                            ))),
                                    SizedBox(
                                      height: size.height * .08,
                                    ),
                                    Center(
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 20, right: 20),
                                        child: Container(
                                          height: 56,
                                          width: MediaQuery
                                              .sizeOf(context)
                                              .width,
                                          color: const Color(0xff014E70),
                                          child: const Center(
                                            child: Text(
                                              'Apply',
                                              style: TextStyle(
                                                  fontSize: 18, fontWeight: FontWeight.w500, color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              );
                            }));
                      });
                },
                child: Row(
                  children: [
                    Image.asset(height: 25, 'assets/icons/language.png'),
                    const SizedBox(
                      width: 20,
                    ),
                    Text(
                      "Language",
                      style:
                      GoogleFonts.poppins(color: const Color(0xFF2A3032), fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    const Spacer(),
                    const Icon(
                      Icons.arrow_forward_ios,
                      size: 15,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              const Divider(
                thickness: 1,
                color: Color(0x1A000000),
              ),
              const SizedBox(
                height: 5,
              ),
              GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  Get.toNamed(MyRouters.aboutUs);
                },
                child: Row(
                  children: [
                    Image.asset(height: 25, 'assets/icons/aboutus.png'),
                    const SizedBox(
                      width: 20,
                    ),
                    Text(
                      "About Us",
                      style:
                      GoogleFonts.poppins(color: const Color(0xFF2A3032), fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    const Spacer(),
                    const Icon(
                      Icons.arrow_forward_ios,
                      size: 15,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              const Divider(
                thickness: 1,
                color: Color(0x1A000000),
              ),
              const SizedBox(
                height: 5,
              ),
              GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  Get.toNamed(MyRouters.termsConditionScreen);
                },
                child: Row(
                  children: [
                    Image.asset(height: 25, 'assets/icons/termscondition.png'),
                    const SizedBox(
                      width: 20,
                    ),
                    Text(
                      "Terms Of Conditions",
                      style:
                      GoogleFonts.poppins(color: const Color(0xFF2A3032), fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    const Spacer(),
                    const Icon(
                      Icons.arrow_forward_ios,
                      size: 15,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              const Divider(
                thickness: 1,
                color: Color(0x1A000000),
              ),
              const SizedBox(
                height: 5,
              ),
              GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  Get.toNamed(MyRouters.returnPolicy);
                },
                child: Row(
                  children: [
                    Image.asset(height: 18, 'assets/icons/policy.png'),
                    const SizedBox(
                      width: 20,
                    ),
                    Text(
                      "Return policy",
                      style:
                      GoogleFonts.poppins(color: const Color(0xFF2A3032), fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    const Spacer(),
                    const Icon(
                      Icons.arrow_forward_ios,
                      size: 15,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              const Divider(
                thickness: 1,
                color: Color(0x1A000000),
              ),
              const SizedBox(
                height: 5,
              ),
              GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () async {
                  if (profileController.userLoggedIn) {
                    SharedPreferences shared = await SharedPreferences.getInstance();
                    await shared.clear();
                    setState(() {});
                    Get.toNamed(LoginScreen.route);
                  } else {
                    Get.toNamed(LoginScreen.route);
                  }
                  profileController.userLoggedIn = false;
                  profileController.updateUI();
                  profileController.getDataProfile();
                  cartController.getCart();
                  homeController.getAll();
                },
                child: Row(
                  children: [
                    Image.asset(height: 25, 'assets/icons/signout.png'),
                    const SizedBox(
                      width: 20,
                    ),
                    Text(
                      profileController.userLoggedIn ? "Sign Out" : "Login",
                      style:
                      GoogleFonts.poppins(color: const Color(0xFF2A3032), fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    const Spacer(),
                    const Icon(
                      Icons.arrow_forward_ios,
                      size: 15,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 80,
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
