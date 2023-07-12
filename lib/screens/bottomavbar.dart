import 'package:dirise/screens/home_pages/homepage_screen.dart';

import 'package:dirise/screens/whishlist_screen.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controller/homepage_controller.dart';
import '../e-book/ebooklogin_screen.dart';
import '../widgets/common_colour.dart';
import 'categores/categories_screen.dart';
import 'myaccount_scrren.dart';

class BottomNavbar extends StatefulWidget {
  static String route = "/BottomNavbar";
  const BottomNavbar({Key? key}) : super(key: key);

  @override
  State<BottomNavbar> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  final bottomController = Get.put(BottomNavBarController());

  final pages = [
    const HomePage(),
    const CategoriesScreen(),
    const Whishlist(),
    const MyAccountScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        body: pages.elementAt(bottomController.pageIndex.value),
        extendBody: true,
        backgroundColor: Colors.white,
        bottomNavigationBar: buildMyNavBar(context),
      );
    });
  }

  buildMyNavBar(BuildContext context) {
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: MaterialButton(
                        padding: const EdgeInsets.only(bottom: 10),
                        onPressed: () {
                          bottomController.updateIndexValue(0);
                        },
                        child: Column(
                          children: [
                            bottomController.pageIndex.value == 0
                                ? Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Image.asset(
                                      'assets/icons/home.png',
                                      color: AppTheme.buttonColor,
                                      height: 20,
                                    ),
                                  )
                                : Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Image.asset(
                                      'assets/icons/home.png',
                                      color: AppTheme.primaryColor,
                                      height: 20,
                                    ),
                                  ),
                            bottomController.pageIndex.value == 0
                                ? const Text(
                                    " Home ",
                                    style: TextStyle(
                                        color: AppTheme.buttonColor, fontSize: 15, fontWeight: FontWeight.w400),
                                  )
                                : const Text(
                                    "  Home ",
                                    style: TextStyle(
                                        color: AppTheme.primaryColor, fontSize: 15, fontWeight: FontWeight.w400),
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
                        padding: const EdgeInsets.only(bottom: 10),
                        onPressed: () {
                          bottomController.updateIndexValue(1);
                        },
                        child: Column(
                          children: [
                            bottomController.pageIndex.value == 1
                                ? Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Image.asset(
                                      'assets/icons/category.png',
                                      color: AppTheme.buttonColor,
                                      height: 20,
                                    ),
                                  )
                                : Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Image.asset(
                                      'assets/icons/category.png',
                                      color: AppTheme.primaryColor,
                                      height: 20,
                                    ),
                                  ),
                            bottomController.pageIndex.value == 1
                                ? const Text(
                                    " Categories ",
                                    style: TextStyle(
                                        color: AppTheme.buttonColor, fontSize: 15, fontWeight: FontWeight.w400),
                                  )
                                : const Text(
                                    "  Categories ",
                                    style: TextStyle(
                                        color: AppTheme.primaryColor, fontSize: 15, fontWeight: FontWeight.w400),
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
                        padding: const EdgeInsets.only(bottom: 10),
                        onPressed: () {
                          bottomController.updateIndexValue(2);
                        },
                        child: Column(
                          children: [
                            bottomController.pageIndex.value == 2
                                ? Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Image.asset(
                                      'assets/icons/heart.png',
                                      color: AppTheme.buttonColor,
                                      height: 20,
                                    ),
                                  )
                                : Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Image.asset(
                                      'assets/icons/heart.png',
                                      color: AppTheme.primaryColor,
                                      height: 20,
                                    ),
                                  ),
                            bottomController.pageIndex.value == 2
                                ? const Text(
                                    "Favorite ",
                                    style: TextStyle(
                                        color: AppTheme.buttonColor, fontSize: 15, fontWeight: FontWeight.w400),
                                  )
                                : const Text(
                                    "  Favorite ",
                                    style: TextStyle(
                                        color: AppTheme.primaryColor, fontSize: 15, fontWeight: FontWeight.w400),
                                  )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    child: MaterialButton(
                      padding: const EdgeInsets.only(bottom: 10),
                      onPressed: () {
                        bottomController.updateIndexValue(3);
                      },
                      child: Column(
                        children: [
                          bottomController.pageIndex.value == 3
                              ? Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.asset(
                                    'assets/icons/profile.png',
                                    height: 20,
                                    color: AppTheme.buttonColor,
                                  ),
                                )
                              : Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.asset(
                                    'assets/icons/profile.png',
                                    color: AppTheme.primaryColor,
                                    height: 20,
                                  ),
                                ),
                          bottomController.pageIndex.value == 3
                              ? const Text(
                                  "My Account",
                                  style:
                                      TextStyle(color: AppTheme.buttonColor, fontSize: 15, fontWeight: FontWeight.w400),
                                )
                              : const Text(
                                  "My Account",
                                  style: TextStyle(
                                      color: AppTheme.primaryColor, fontSize: 15, fontWeight: FontWeight.w400),
                                )
                        ],
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
