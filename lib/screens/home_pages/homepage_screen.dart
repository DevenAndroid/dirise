import 'package:country_code_picker/country_code_picker.dart';
import 'package:dirise/repository/repository.dart';
import 'package:dirise/widgets/common_colour.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../controller/cart_controller.dart';
import '../../controller/home_controller.dart';
import '../check_out/add_bag_screen.dart';
import 'ad_banner.dart';
import 'authers.dart';
import 'popular_products.dart';
import 'category_items.dart';
import 'slider.dart';
import 'trending_products.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final homeController = Get.put(TrendingProductsController());
  final cartController = Get.put(CartController());

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      homeController.getAllAsync();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(155),
          child: Container(
            color: AppTheme.buttonColor,
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 18, top: 5),
                            child: Text(
                              'Deliver order to',
                              style: GoogleFonts.poppins(
                                  fontSize: 18, color: Colors.white),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(left: 8.0),
                            child: CountryCodePicker(
                              padding: EdgeInsets.zero,
                              onChanged: print,
                              initialSelection: 'IT',
                              hideMainText: true,
                              showDropDownButton: true,
                              showCountryOnly: false,
                              showOnlyCountryWhenClosed: false,
                            ),
                          ),
                        ],
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 20, top: 7),
                        child: Image(
                            height: 23,
                            color: Colors.white,
                            image: AssetImage(
                              'assets/images/diries logo.png',
                            )),
                      ),
                      const Spacer(),
                      cartWidget(),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: TextField(
                      maxLines: 1,
                      style: GoogleFonts.poppins(fontSize: 17),
                      textAlign: TextAlign.center,
                      textInputAction: TextInputAction.search,
                      decoration: InputDecoration(
                          filled: true,
                          // prefixIcon:
                          //     Icon(Icons.search, color: Color(0xFFC33D18)),
                          prefixIcon: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Image.asset(
                              'assets/icons/search.png',
                              height: 5,
                            ),
                          ),
                          border: InputBorder.none,
                          enabledBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                              borderSide:
                                  BorderSide(color: AppTheme.buttonColor)),
                          disabledBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                              borderSide:
                                  BorderSide(color: AppTheme.buttonColor)),
                          focusedBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                              borderSide:
                                  BorderSide(color: AppTheme.buttonColor)),
                          fillColor: Colors.white,
                          contentPadding: const EdgeInsets.all(15),
                          hintText: 'what are you looking for?',
                          hintStyle:
                              GoogleFonts.poppins(color: AppTheme.buttonColor)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        body: RefreshIndicator(
            onRefresh: () async {
              await homeController.getAllAsync();
            },
            child: const SingleChildScrollView(
                child: Column(children: [
              SliderWidget(),
              CategoryItems(),
              TrendingProducts(),
              PopularProducts(),
              AdBannerUI(),
              AuthorScreen(),
            ]))));
  }

  cartWidget() {
    return Obx(() {
      if (cartController.refreshInt.value > 0) {}
      return GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          Get.toNamed(BagsScreen.addBagScreen);
        },
        child: Padding(
          padding: const EdgeInsets.only(right: 15, top: 10),
          child: Container(
            alignment: Alignment.center,
            height: 40,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8), color: Colors.white),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  width: 10,
                ),
                const Image(
                  height: 25,
                  image: AssetImage(
                    'assets/icons/whishlist.png',
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                cartController.apiLoaded
                    ? Text(
                        cartController.cartModel.totalQuantity.toString(),
                        style: GoogleFonts.poppins(
                            color: AppTheme.buttonColor, fontSize: 20),
                      )
                    : const CupertinoActivityIndicator(),
                const SizedBox(
                  width: 10,
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
