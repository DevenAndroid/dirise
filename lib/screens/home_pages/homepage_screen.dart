import 'package:country_code_picker/country_code_picker.dart';
import 'package:dirise/widgets/common_colour.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../controller/cart_controller.dart';
import '../../controller/home_controller.dart';
import '../../widgets/cart_widget.dart';
import '../search_products.dart';
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

  Future getAllAsync() async {
    if (!mounted) return;
    homeController.homeData();
    if (!mounted) return;
    homeController.getVendorCategories();
    if (!mounted) return;
    homeController.trendingData();
    if (!mounted) return;
    homeController.popularProductsData();
    if (!mounted) return;
    homeController.authorData();
    if (!mounted) return;
  }

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      getAllAsync();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // centerTitle: true,
          toolbarHeight: kToolbarHeight + 10,
          backgroundColor: AppTheme.buttonColor,
          surfaceTintColor: AppTheme.buttonColor,
          title: const Padding(
            padding: EdgeInsets.only(left: 16),
            child: SizedBox(
              height: kToolbarHeight - 14,
              child: Image(
                  color: Colors.white,
                  image: AssetImage(
                    'assets/images/diries logo.png',
                  )),
            ),
          ),
          actions: const [
            CartBagCard(),
          ],
        ),
        backgroundColor: AppTheme.buttonColor,
        body: RefreshIndicator(
            onRefresh: () async {
              await getAllAsync();
            },
            child: Column(
              children: [
                Container(
                  color: AppTheme.buttonColor,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 5,
                      ),
                      Hero(
                        tag: "search_tag",
                        child: Material(
                          color: Colors.transparent,
                          surfaceTintColor: Colors.transparent,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: TextField(
                              maxLines: 1,
                              style: GoogleFonts.poppins(fontSize: 16),
                              textInputAction: TextInputAction.search,
                              onSubmitted: (vb) {
                                Get.to(() => SearchProductsScreen(
                                      searchText: vb,
                                    ));
                              },
                              decoration: InputDecoration(
                                  filled: true,
                                  prefixIcon: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Image.asset(
                                      'assets/icons/search.png',
                                      height: 5,
                                    ),
                                  ),
                                  border: InputBorder.none,
                                  enabledBorder: const OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(8)),
                                      borderSide: BorderSide(color: AppTheme.buttonColor)),
                                  disabledBorder: const OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(8)),
                                      borderSide: BorderSide(color: AppTheme.buttonColor)),
                                  focusedBorder: const OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(8)),
                                      borderSide: BorderSide(color: AppTheme.buttonColor)),
                                  fillColor: Colors.white,
                                  contentPadding: const EdgeInsets.all(15),
                                  hintText: 'What are you looking for?',
                                  hintStyle:
                                      GoogleFonts.poppins(color: AppTheme.buttonColor, fontWeight: FontWeight.w400)),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    color: Colors.white,
                    child: const SingleChildScrollView(
                        child: Column(children: [
                      SliderWidget(),
                      CategoryItems(),
                      TrendingProducts(),
                      PopularProducts(),
                      AdBannerUI(),
                      AuthorScreen(),
                      SizedBox(
                        height: 30,
                      ),
                    ])),
                  ),
                ),
              ],
            )));
  }
}
