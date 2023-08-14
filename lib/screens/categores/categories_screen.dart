
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dirise/screens/categores/single_category_with_stores/single_categorie.dart';
import 'package:dirise/utils/helper.dart';
import 'package:dirise/widgets/loading_animation.dart';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../controller/home_controller.dart';
import '../../widgets/cart_widget.dart';
import '../app_bar/common_app_bar.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});
  static var categoriesScreen = "/categoriesScreen";

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  final homeController = Get.put(TrendingProductsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: CommonAppBar(
          titleText: 'Categories',
          actions: [
            CartBagCard(isBlackTheme: true),
          ],
        ),
      ),
      body: Obx(() {
        if (homeController.updateCate.value > 0) {}
        return homeController.vendorCategory.usphone != null
            ? SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Padding(
                    padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 5,
                        ),
                        const ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(10)),

                            child: Image(image: AssetImage('assets/images/storybooks.png'))),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          "What are you  looking for ... we back you !",
                          style: GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 18),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          child: GridView.builder(
                            shrinkWrap: true,
                            padding: const EdgeInsets.only(bottom: 25),
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: homeController.vendorCategory.usphone!.length,
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2, crossAxisSpacing: 15, mainAxisSpacing: 10, mainAxisExtent: 80),
                            itemBuilder: (BuildContext context, int index) {
                              final item = homeController.vendorCategory.usphone![index];
                              return InkWell(
                                onTap: () {
                                  Get.to(()=> SingleCategories(vendorCategories: item,));
                                },
                                borderRadius: BorderRadius.circular(10),
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: const Color(0xffEBF1F4).withOpacity(.5)),
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: context.getSize.width*.5*.3,
                                        child: Hero(
                                          tag: item.bannerProfile.toString(),
                                          child: Material(
                                            color: Colors.transparent,
                                            surfaceTintColor: Colors.transparent,
                                            child: CachedNetworkImage(
                                              imageUrl: item.bannerProfile.toString(),
                                              height: 50,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        child: Text(
                                          item.name.toString(),
                                          style: GoogleFonts.poppins(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              color: const Color(0xff014E70)),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ).animate(
                                  delay: Duration(milliseconds: index*80))
                                  .scale(duration: 500.ms);
                            },
                          ),
                        ),
                        const SizedBox(height: 60,),
                      ],
                    )),
              )
            : const LoadingAnimation();
      }),
    );
  }
}
