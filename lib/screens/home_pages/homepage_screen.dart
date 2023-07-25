import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:dirise/repoistery/repository.dart';
import 'package:dirise/widgets/common_colour.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scroll_loop_auto_scroll/scroll_loop_auto_scroll.dart';
import 'package:text_scroll/text_scroll.dart';
import '../../controller/cart_controller.dart';
import '../../controller/home_controller.dart';
import '../check_out/add_bag_screen.dart';
import 'product_widget.dart';
import 'category_items.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final homeController = Get.put(TrendingProductsController());
  final Repositories repositories = Repositories();
  final cartController = Get.put(CartController());

  int index1 = 0;
  bool gg = true;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
                              style: GoogleFonts.poppins(fontSize: 18, color: Colors.white),
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
                      style: const TextStyle(fontSize: 17),
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
                          hintText: 'what are you looking for?',
                          hintStyle: GoogleFonts.poppins(color: AppTheme.buttonColor)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        body: Obx(() {
          return homeController.trendingModel.value.status == true
              ? SingleChildScrollView(
                  child: Column(children: [
                  if (homeController.homeModal.value.home != null)
                    Padding(
                        padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
                        child: SizedBox(
                          height: size.height * 0.22,
                          child: Swiper(
                            autoplay: true,
                            outer: false,
                            autoplayDelay: 5000,
                            autoplayDisableOnInteraction: true,
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 15),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: CachedNetworkImage(
                                        imageUrl: homeController.homeModal.value.home!.slider![index].image.toString(),
                                        fit: BoxFit.cover,
                                        placeholder: (context, url) => const SizedBox(),
                                        errorWidget: (context, url, error) => const SizedBox()),
                                  ),
                                ),
                              );
                            },
                            itemCount: homeController.homeModal.value.home!.slider!.length,
                            pagination: const SwiperPagination(),
                            control: const SwiperControl(size: 0), // remove arrows
                          ),
                        )),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                    child: Row(
                      children: [
                        Container(
                          height: 60,
                          width: size.width * .40,
                          decoration: const BoxDecoration(
                              color: Color(0xffF0F0F0),
                              borderRadius:
                                  BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10))),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0, right: 8),
                            child: Row(
                              children: [
                                Text(
                                  'News & Trends',
                                  style: GoogleFonts.poppins(
                                    color: AppTheme.buttonColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                const Expanded(child: Image(height: 20, image: AssetImage('assets/icons/trends.png')))
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 60,
                            width: 200,
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: const Color(0xffF0F0F0),
                                ),
                                borderRadius: const BorderRadius.only(
                                    bottomRight: Radius.circular(10), topRight: Radius.circular(10))),
                            child: Padding(
                              padding: const EdgeInsets.only(top: 15, left: 7),
                              child: InkWell(
                                onTap: () {
                                  showModalBottomSheet(
                                      isScrollControlled: true,
                                      context: context,
                                      builder: (context) {
                                        return SizedBox(
                                          height: size.height * .7,
                                          child: Padding(
                                            padding: const EdgeInsets.only(top: 30, right: 18, left: 18),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Image.asset('assets/images/aritificial.png'),
                                                const SizedBox(
                                                  height: 20,
                                                ),
                                                Text(
                                                  "Artificial Intelligence Gains a Foot Hold In Writing",
                                                  style: GoogleFonts.poppins(
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.w600,
                                                      color: AppTheme.buttonColor),
                                                ),
                                                const SizedBox(
                                                  height: 20,
                                                ),
                                                Text(
                                                  "Artificial Intelligence (Al) is gaining a strong foothold in various niches, and blogging is no exception. By making use of the best Al writing tools, you can create a long-form affiliate blog post in 10 to 15 minutes (instead of spending hours writing it yourself) and generate traffic.",
                                                  style:
                                                      GoogleFonts.poppins(fontSize: 14, color: const Color(0xff484848)),
                                                ),
                                                const SizedBox(
                                                  height: 40,
                                                ),
                                                Text(
                                                  'Published: 06/06/2023',
                                                  style: GoogleFonts.poppins(
                                                      fontSize: 15, color: Colors.black, fontWeight: FontWeight.w500),
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      });
                                },
                                child: ScrollLoopAutoScroll(
                                  scrollDirection: Axis.vertical,
                                  delay: const Duration(seconds: 0),
                                  duration: const Duration(minutes: 1),
                                  gap: 0,
                                  reverseScroll: false,
                                  duplicateChild: 25,
                                  enableScrollInput: true,
                                  delayAfterScrollInput: const Duration(seconds: 1),
                                  child: Text(
                                    'Artificial Intelligence Gains  a Foot Hold In Writing',
                                    style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 13),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const CategoryItems(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Trending Products',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                        ),
                        InkWell(
                          onTap: () {
                            // index1 = index1 + 1;
                            // setState(() {
                            //   if (index1 == homeController.trendingModel.value.product!.product!.length - 1) {
                            //     index1 = 0;
                            //   }
                            // });
                            // scrollToItem(index1);
                          },
                          child: Container(
                            padding: const EdgeInsets.all(2),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle, border: Border.all(color: AppTheme.buttonColor, width: 1.2)),
                            child: const Icon(
                              Icons.arrow_forward,
                              color: AppTheme.buttonColor,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: 220,
                    margin: const EdgeInsets.fromLTRB(15, 20, 15, 0),
                    child: ListView.builder(
                        itemCount: homeController.trendingModel.value.product!.product!.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext context, int index) {
                          final item = homeController.trendingModel.value.product!.product![index];
                          return ProductUI(
                            productElement: item,
                            onLiked: (value) {
                              homeController.trendingModel.value.product!.product![index].inWishlist = value;
                            },
                          );
                        }),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Popular Products',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                        ),
                        InkWell(
                          onTap: () {
                            // index1 = index1 + 1;
                            // setState(() {
                            //   if (index1 == homeController.popularProdModal.value.product!.product!.length - 1) {
                            //     index1 = 0;
                            //   }
                            // });
                            // scrollToItem1(index1);
                          },
                          child: Container(
                            padding: const EdgeInsets.all(2),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle, border: Border.all(color: AppTheme.buttonColor, width: 1.2)),
                            child: const Icon(
                              Icons.arrow_forward,
                              color: AppTheme.buttonColor,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  if (homeController.popularProdModal.value.product != null)
                    Container(
                      height: 230,
                      margin: const EdgeInsets.fromLTRB(15, 20, 15, 0),
                      child: ListView.builder(
                          itemCount: homeController.popularProdModal.value.product!.product!.length,
                          // itemScrollController: itemController1,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext context, int index) {
                            final item = homeController.popularProdModal.value.product!.product![index];
                            return ProductUI(
                              productElement: item,
                              onLiked: (value) {
                                homeController.popularProdModal.value.product!.product![index].inWishlist = value;
                              },
                            );
                          }),
                    ),
                  if (homeController.homeModal.value.home != null)
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: SizedBox(
                          child: CachedNetworkImage(
                            imageUrl: homeController.homeModal.value.home!.bannerImg.toString(),
                            fit: BoxFit.cover,
                            width: size.width,
                          ),
                        )),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Shop By Author',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                        ),
                        Container(
                          padding: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, border: Border.all(color: AppTheme.buttonColor, width: 1.2)),
                          child: InkWell(
                            onTap: () {
                              // index1 = index1 + 1;
                              // setState(() {
                              //   if (index1 == homeController.authorModal.value.data!.length - 1) {
                              //     index1 = 0;
                              //   }
                              // });
                              // scrollToItem2(index1);
                            },
                            child: const Icon(
                              Icons.arrow_forward,
                              color: AppTheme.buttonColor,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  if (homeController.authorModal.value.data != null)
                    Container(
                      height: 230,
                      margin: const EdgeInsets.symmetric(horizontal: 15),
                      child: ListView.builder(
                        itemCount: homeController.authorModal.value.data!.length,
                        // itemScrollController: itemController2,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                              width: size.width * .5,
                              margin: const EdgeInsets.only(right: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Flexible(
                                    child: CachedNetworkImage(
                                        imageUrl: homeController.authorModal.value.data![index].profileImage.toString(),
                                        fit: BoxFit.cover,
                                        errorWidget: (context, url, error) =>
                                            Image.asset("assets/images/Soud Alsanousi.png")),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    homeController.authorModal.value.data![index].name.toString(),
                                    style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ));
                        },
                      ),
                    ),
                  const SizedBox(
                    height: 60,
                  ),
                ]))
              : const Center(
                  child: CircularProgressIndicator(
                  color: Colors.grey,
                ));
        }));
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
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.white),
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
                        style: const TextStyle(color: AppTheme.buttonColor, fontSize: 20),
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
