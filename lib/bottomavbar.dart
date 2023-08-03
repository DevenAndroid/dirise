import 'package:dirise/screens/home_pages/homepage_screen.dart';
import 'package:dirise/screens/whishlist_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'controller/cart_controller.dart';
import 'controller/homepage_controller.dart';
import 'controller/profile_controller.dart';
import 'widgets/common_colour.dart';
import 'screens/categores/categories_screen.dart';
import 'screens/my_account_screens/myaccount_scrren.dart';

class BottomNavbar extends StatefulWidget {
  static String route = "/BottomNavbar";
  const BottomNavbar({Key? key}) : super(key: key);

  @override
  State<BottomNavbar> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {

  final bottomController = Get.put(BottomNavBarController());
  final profileController = Get.put(ProfileController());
  final cartController = Get.put(CartController());

  final pages = [
    const HomePage(),
    const CategoriesScreen(),
    const WishListScreen(),
    const MyAccountScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        body: IndexedStack(
          index: bottomController.pageIndex.value,
          children: pages,
        ),
        extendBody: true,
        backgroundColor: Colors.white,
        bottomNavigationBar: buildMyNavBar(),
      );
    });
  }

  buildMyNavBar() {
    const padding = EdgeInsets.only(bottom: 7,top: 3);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: double.maxFinite,
          decoration: const BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                offset: Offset(0.0, 1.0), //(x,y)
                blurRadius: 6.0,
              ),
            ],
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: MaterialButton(
                        padding: padding,
                        onPressed: () {
                          bottomController.updateIndexValue(0);
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SvgPicture.asset(
                                'assets/svgs/home.svg',
                                colorFilter: ColorFilter.mode(
                                    bottomController.pageIndex.value == 0
                                    ? AppTheme.buttonColor
                                    : AppTheme.primaryColor, BlendMode.srcIn),
                                height: 20,
                              ),
                            ),
                            FittedBox(
                              child: Text(
                                "Home",
                                style: GoogleFonts.poppins(
                                    color: bottomController.pageIndex.value == 0
                                        ? AppTheme.buttonColor
                                        : AppTheme.primaryColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: MaterialButton(
                        padding: padding,
                        onPressed: () {
                          bottomController.updateIndexValue(1);
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SvgPicture.asset(
                                'assets/svgs/category.svg',
                                colorFilter: ColorFilter.mode(
                                    bottomController.pageIndex.value == 1
                                        ? AppTheme.buttonColor
                                        : AppTheme.primaryColor, BlendMode.srcIn),
                                height: 20,
                              ),
                            ),
                            Text(
                              "Categories",
                              style: GoogleFonts.poppins(
                                  color: bottomController.pageIndex.value == 1
                                      ? AppTheme.buttonColor
                                      : AppTheme.primaryColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: MaterialButton(
                        padding: padding,
                        onPressed: () {
                          bottomController.updateIndexValue(2);
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SvgPicture.asset(
                                'assets/svgs/fav.svg',
                                colorFilter: ColorFilter.mode(
                                    bottomController.pageIndex.value == 2
                                        ? AppTheme.buttonColor
                                        : AppTheme.primaryColor, BlendMode.srcIn),
                                height: 20,
                              ),
                            ),
                            Text(
                              "Favorite",
                              style: GoogleFonts.poppins(
                                  color: bottomController.pageIndex.value == 2
                                      ? AppTheme.buttonColor
                                      : AppTheme.primaryColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: MaterialButton(
                        padding: padding,
                        onPressed: () {
                          bottomController.updateIndexValue(3);
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SvgPicture.asset(
                                'assets/svgs/person.svg',
                                height: 20,
                                colorFilter: ColorFilter.mode(
                                    bottomController.pageIndex.value == 3
                                        ? AppTheme.buttonColor
                                        : AppTheme.primaryColor, BlendMode.srcIn),
                              ),
                            ),
                            Text(
                              "My Account",
                              style: GoogleFonts.poppins(
                                  color: bottomController.pageIndex.value == 3
                                      ? AppTheme.buttonColor
                                      : AppTheme.primaryColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}