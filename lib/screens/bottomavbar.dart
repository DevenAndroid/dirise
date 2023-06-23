import 'package:dirise/screens/homepage_screen.dart';
import 'package:dirise/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../controller/homepage_controller.dart';
import '../widgets/common_colour.dart';

class BottomNavbar extends StatefulWidget {
  const BottomNavbar({Key? key}) : super(key: key);

  @override
  State<BottomNavbar> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  final bottomController = Get.put(BottomNavBarController());

  final pages = [
    const HomePage(),
    LoginScreen(),
    LoginScreen(),
    LoginScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        body: pages.elementAt(bottomController.pageIndex.value),
        extendBody: true,
        // extendBodyBehindAppBar: true,
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
                    child: MaterialButton(
                      padding: const EdgeInsets.only(bottom: 10),
                      onPressed: () {
                        bottomController.updateIndexValue(0);
                      },
                      child: Row(

                        children: [

                          bottomController.pageIndex.value == 0
                              ? Image.asset(
                                  'assets/icons/home.png',
                                  // height: 10,
                                  color: Colors.black,
                                )
                              : Image.asset(
                                  'assets/icons/home.png',
                            color: AppTheme.buttonColor,
                                ),
                          bottomController.pageIndex.value == 0
                              ? Text(
                                  "Home",
                                  style: TextStyle(
                                      color: AppTheme.secondaryColor,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400),
                                )
                              : Text(
                            "  Home",
                            style: TextStyle(
                                color: AppTheme.buttonColor,
                                fontSize: 15,
                                fontWeight: FontWeight.w400),
                          )
                        ],
                      ),
                    ),
                  ),
                  Flexible(
                    child: MaterialButton(
                      padding: const EdgeInsets.only(bottom: 10),
                      onPressed: () {
                        bottomController.updateIndexValue(1);
                      },
                      child: Column(
                        children: [
                          bottomController.pageIndex.value == 1
                              ? SvgPicture.asset(
                                  'assets/images/card.svg',
                                  color: AppTheme.secondaryColor,
                                )
                              : SvgPicture.asset(
                                  'assets/images/card.svg',
                                ),
                        ],
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
                                ? SvgPicture.asset(
                                    'assets/images/Wallet.svg',
                                    color: AppTheme.primaryColor,
                                  )
                                : SvgPicture.asset(
                                    'assets/images/Wallet.svg',
                                  ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    child: MaterialButton(
                      padding: EdgeInsets.only(bottom: 10),
                      onPressed: () {
                        bottomController.updateIndexValue(3);
                      },
                      child: Column(
                        children: [
                          bottomController.pageIndex.value == 3
                              ? SvgPicture.asset(
                                  'assets/images/profile.svg',
                                  color: AppTheme.secondaryColor,
                                )
                              : SvgPicture.asset(
                                  'assets/images/profile.svg',
                                ),
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
