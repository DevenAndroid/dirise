import 'dart:io';
import 'package:dirise/language/app_strings.dart';
import 'package:dirise/screens/auth_screens/login_screen.dart';
import 'package:dirise/utils/helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../controller/cart_controller.dart';
import '../../controller/home_controller.dart';
import '../../controller/profile_controller.dart';
import '../../vendor/authentication/vendor_plans_screen.dart';
import '../../vendor/dashboard/dashboard_screen.dart';
import '../../vendor/dashboard/store_open_time_screen.dart';
import '../../vendor/orders/vendor_order_list_screen.dart';
import '../../vendor/payment_info/bank_account_screen.dart';
import '../../vendor/payment_info/withdrawal_screen.dart';
import '../../vendor/products/all_product_screen.dart';
import '../../widgets/common_colour.dart';
import '../calender.dart';
import '../order_screens/my_orders_screen.dart';
import '../virtual_assets/virtual_assets_screen.dart';
import 'about_us_screen.dart';
import 'faqs_screen.dart';
import 'profile_screen.dart';
import 'return_policy_screen.dart';
import 'termsconditions_screen.dart';

Locale locale = const Locale('en', 'US');

class MyAccountScreen extends StatefulWidget {
  const MyAccountScreen({Key? key}) : super(key: key);

  @override
  State<MyAccountScreen> createState() => _MyAccountScreenState();
}

enum SingingCharacter { lafayette, jefferson }

class _MyAccountScreenState extends State<MyAccountScreen> {
  RxString selectedLAnguage = "English".obs;

  @override
  void initState() {
    super.initState();
    checkLanguage();
  }

  updateLanguage(String gg) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("app_language", gg);
  }

  checkLanguage() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getString("app_language") == null ||
        sharedPreferences.getString("app_language") == "english") {
      Get.updateLocale(const Locale('en', 'US'));
      selectedLAnguage.value = "English";
    } else {
      Get.updateLocale(const Locale('ro', 'Ro'));
      selectedLAnguage.value = "Engleză";
    }
  }

  RxString language = "".obs;
  final RxBool _isValue = false.obs;
  var vendor = ['Dashboard', 'Order', 'Products', 'Store open time', 'Bank Details', 'Withdraw'];
  var vendorRoutes = [
    VendorDashBoardScreen.route,
    VendorOrderList.route,
    VendorProductScreen.route,
    SetTimeScreen.route,
    BankDetailsScreen.route,
    WithdrawMoney.route,
  ];

  final profileController = Get.put(ProfileController());
  final cartController = Get.put(CartController());
  final homeController = Get.put(TrendingProductsController());

  showVendorDialog() {
    if (Platform.isAndroid) {
      showDialog(
          context: context,
          builder: (context) {
            return Dialog(
              backgroundColor: Colors.white,
              surfaceTintColor: Colors.white,
              insetPadding: const EdgeInsets.symmetric(horizontal: 20),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      AppStrings.vendorRegister,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 16),
                    ),
                    10.spaceY,
                    TextButton(
                        onPressed: () {
                          Get.back();
                          Get.toNamed(
                            LoginScreen.route,
                          );
                        },
                        child:  Text(AppStrings.createAccount))
                  ],
                ),
              ),
            );
          });
      return;
    }
    if (Platform.isIOS) {
      showDialog(
          context: context,
          builder: (context) {
            return CupertinoAlertDialog(
              title: Text(
                "To register as vendor partner need to "
                "create an account first.",
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 16),
              ),
              actions: [
                CupertinoDialogAction(
                    onPressed: () {
                      Get.back();
                      Get.toNamed(
                        LoginScreen.route,
                      );
                    },
                    child: const Text("Create Account"))
              ],
            );
          });
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
            colors: [
              AppTheme.buttonColor,
              Colors.white,
              Colors.white,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [.1, .11, 1]),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: RefreshIndicator(
            onRefresh: () async {
              await profileController.getDataProfile();
              setState(() {});
            },
            child: Column(
              children: [
                Container(
                  width: MediaQuery.sizeOf(context).width,
                  color: AppTheme.buttonColor,
                  child: Obx(() {
                    if (profileController.refreshInt.value > 0) {}
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          profileController.userLoggedIn
                              ? profileController.apiLoaded && profileController.model.user != null
                                  ? profileController.model.user!.name ?? ""
                                  : ""
                              : "Guest User",
                          style: GoogleFonts.poppins(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w600),
                        ),
                        4.spaceY,
                        ClipRRect(
                          borderRadius: BorderRadius.circular(1000),
                          child: SizedBox(
                            height: 65,
                            width: 65,
                            child: profileController.userLoggedIn
                                ? Image.network(
                                    profileController.apiLoaded && profileController.model.user != null
                                        ? profileController.model.user!.profileImage.toString()
                                        : "",
                                    fit: BoxFit.cover,
                                    height: 65,
                                    width: 65,
                                    errorBuilder: (_, __, ___) => Image.asset(
                                      'assets/images/myaccount.png',
                                      height: 65,
                                      width: 65,
                                    ),
                                  )
                                : Image.asset(
                                    'assets/images/myaccount.png',
                                    height: 65,
                                    width: 65,
                                  ),
                          ),
                        ),
                        5.spaceY,
                        Text(
                          profileController.userLoggedIn
                              ? profileController.apiLoaded && profileController.model.user != null
                                  ? profileController.model.user!.email ?? ""
                                  : ""
                              : "",
                          style: GoogleFonts.poppins(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w400),
                        ),
                        5.spaceY,
                      ],
                    );
                  }),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: Column(children: [
                      16.spaceY,
                      ListTile(
                        onTap: () {
                          if (profileController.userLoggedIn) {
                            Get.toNamed(ProfileScreen.route);
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
                                AppStrings.myProfile,
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
                          Get.toNamed(VirtualAssetsScreen.route);
                        },
                        child: Row(
                          children: [
                            Image.asset(height: 25, 'assets/icons/ebook.png'),
                            const SizedBox(
                              width: 20,
                            ),
                            Text(
                            AppStrings.eBooks,
                              style: GoogleFonts.poppins(
                                  color: const Color(0xFF2A3032), fontSize: 16, fontWeight: FontWeight.w500),
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
                            Get.toNamed(MyOrdersScreen.route);
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
                              AppStrings.orders,
                              style: GoogleFonts.poppins(
                                  color: const Color(0xFF2A3032), fontSize: 16, fontWeight: FontWeight.w500),
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
                          Get.toNamed(EventCalendarScreen.route);
                        },
                        child: Row(
                          children: [
                            Image.asset(height: 25, 'assets/icons/calendar.png'),
                            const SizedBox(
                              width: 20,
                            ),
                            Text(
                              AppStrings.calendar,
                              style: GoogleFonts.poppins(
                                  color: const Color(0xFF2A3032), fontSize: 16, fontWeight: FontWeight.w500),
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
                          Get.toNamed(FrequentlyAskedQuestionsScreen.route);
                        },
                        child: Row(
                          children: [
                            Image.asset(height: 25, 'assets/icons/faq.png'),
                            const SizedBox(
                              width: 20,
                            ),
                            Text(
                              AppStrings.faq,
                              style: GoogleFonts.poppins(
                                  color: const Color(0xFF2A3032), fontSize: 16, fontWeight: FontWeight.w500),
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
                              AppStrings.pdfReader,
                              style: GoogleFonts.poppins(
                                  color: const Color(0xFF2A3032), fontSize: 16, fontWeight: FontWeight.w500),
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
                      ...vendorPartner(),
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
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(20), topRight: Radius.circular(20))),
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
                                                    value: "Engleză",
                                                    groupValue: selectedLAnguage.value,
                                                    onChanged: (value) {
                                                      locale = const Locale('ro', 'Ro');
                                                      Get.updateLocale(locale);
                                                      selectedLAnguage.value = value!;
                                                      updateLanguage("Engleză");
                                                      setState(() {});
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
                                                    value: "English",
                                                    groupValue: selectedLAnguage.value,
                                                    onChanged: (value) {
                                                      locale = const Locale('en', 'US');
                                                      Get.updateLocale(locale);
                                                      selectedLAnguage.value = value!;
                                                      updateLanguage("english");
                                                      setState(() {});
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
                                                  width: MediaQuery.sizeOf(context).width,
                                                  color: const Color(0xff014E70),
                                                  child: Center(
                                                    child: Text(
                                                      'Apply',
                                                      style: GoogleFonts.poppins(
                                                          fontSize: 18,
                                                          fontWeight: FontWeight.w500,
                                                          color: Colors.white),
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
                              AppStrings.language,
                              style: GoogleFonts.poppins(
                                  color: const Color(0xFF2A3032), fontSize: 16, fontWeight: FontWeight.w500),
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
                          Get.toNamed(AboutUsScreen.route);
                        },
                        child: Row(
                          children: [
                            SvgPicture.asset(height: 24, 'assets/svgs/about.svg'),
                            const SizedBox(
                              width: 20,
                            ),
                            Text(
                              AppStrings.aboutUs,
                              style: GoogleFonts.poppins(
                                  color: const Color(0xFF2A3032), fontSize: 16, fontWeight: FontWeight.w500),
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
                          Get.toNamed(TermConditionScreen.route);
                        },
                        child: Row(
                          children: [
                            Image.asset(height: 25, 'assets/icons/termscondition.png'),
                            const SizedBox(
                              width: 20,
                            ),
                            Text(
                              AppStrings.termsCondition,
                              style: GoogleFonts.poppins(
                                  color: const Color(0xFF2A3032), fontSize: 16, fontWeight: FontWeight.w500),
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
                          Get.toNamed(ReturnPolicyScreen.route);
                        },
                        child: Row(
                          children: [
                            Image.asset(height: 18, 'assets/icons/policy.png'),
                            const SizedBox(
                              width: 20,
                            ),
                            Text(
                              AppStrings.returnPolicy,
                              style: GoogleFonts.poppins(
                                  color: const Color(0xFF2A3032), fontSize: 16, fontWeight: FontWeight.w500),
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
                            profileController.userLoggedIn = false;
                            profileController.updateUI();
                            profileController.getDataProfile();
                            cartController.getCart();
                            homeController.getAll();
                          } else {
                            Get.toNamed(LoginScreen.route);
                          }
                        },
                        child: Row(
                          children: [
                            Image.asset(height: 25, 'assets/icons/signout.png'),
                            const SizedBox(
                              width: 20,
                            ),
                            Text(
                              profileController.userLoggedIn ? AppStrings.signOut : AppStrings.login,
                              style: GoogleFonts.poppins(
                                  color: const Color(0xFF2A3032), fontSize: 16, fontWeight: FontWeight.w500),
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
                        height: 40,
                      ),
                    ]),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> vendorPartner() {
    return [
      ListTile(
        contentPadding: EdgeInsets.zero,
        dense: true,
        visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
        textColor: AppTheme.primaryColor,
        iconColor: AppTheme.primaryColor,
        minLeadingWidth: 0,
        onTap: () {
          if (profileController.model.user == null) {
            showVendorDialog();
            return;
          }
          if (profileController.model.user!.isVendor != true) {
            Get.to(() => const VendorPlansScreen());
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
                AppStrings.vendorPartner,
                style: GoogleFonts.poppins(color: const Color(0xFF2A3032), fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ),
            Icon(
              !_isValue.value == true ? Icons.arrow_forward_ios : Icons.keyboard_arrow_down,
              color: Colors.black,
              size: 15,
            ),
          ],
        ),
      ),
      _isValue.value == true
          ? Obx(() {
              if (profileController.refreshInt.value > 0) {}

              return profileController.model.user != null
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: profileController.model.user!.isVendor == true
                          ? List.generate(
                              vendor.length,
                              (index) => Row(
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
                                              padding: EdgeInsets.zero.copyWith(left: 16)),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  vendor[index],
                                                  style: GoogleFonts.poppins(
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.w400,
                                                      color: Colors.grey.shade500),
                                                ),
                                              ),
                                              const Icon(
                                                Icons.arrow_forward_ios_rounded,
                                                size: 14,
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ))
                          : [],
                    )
                  : const SizedBox();
            })
          : const SizedBox(),
    ];
  }
}
