import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../controller/home_controller.dart';
import '../../routers/my_routers.dart';
import '../../widgets/common_colour.dart';
import '../Authors/authors_screen.dart';
import '../Authors/teacher_screen.dart';
import '../categores/categories_screen.dart';
import '../categores/single_categorie.dart';
import '../officefurniture_sceen/officefurniture_screen.dart';
import '../school_nursery_category.dart';

class CategoryItems extends StatefulWidget {
  const CategoryItems({super.key});

  @override
  State<CategoryItems> createState() => _CategoryItemsState();
}

class _CategoryItemsState extends State<CategoryItems> {
  final homeController = Get.put(TrendingProductsController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (homeController.updateCate.value > 0) {}
      return homeController.updateCate.value != 0 ?
      GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: homeController.vendorCategory.usphone!.length + 1,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 100,
          childAspectRatio: .75,
          crossAxisSpacing: 14,
          mainAxisSpacing: 16,
        ),
        itemBuilder: (BuildContext context, int index) {
          if (index == homeController.vendorCategory.usphone!.length) {
            return Column(
              children: [
                InkWell(
                  onTap: () {
                    Get.toNamed(CategoriesScreen.categoriesScreen);
                  },
                  child: Container(
                      height: 70,

                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10), color: const Color(0xffF0F0F0)),
                      child: Padding(
                        padding: const EdgeInsets.all(18),
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: AppTheme.buttonColor, width: 1.2)),
                          child: const Icon(
                            Icons.arrow_forward,
                            color: AppTheme.buttonColor,
                          ),
                        ),
                      )),
                ),
                // ignore: prefer_const_constructors
                SizedBox(
                  height: 10,
                ),
                Text(
                  'More',
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500, fontSize: 15, color: AppTheme.buttonColor),
                )
              ],
            ).animate(
                delay: Duration(milliseconds: index*200))
                .scale(duration: 500.ms);
          }
          else {
            final item = homeController.vendorCategory.usphone![index];
            return InkWell(
              key: ValueKey(index*DateTime.now().millisecondsSinceEpoch),
              onTap: () {
                // if (index == 3) {
                //   Get.toNamed(OfficeFurnitureScreen.route);
                // } else if (index == 0) {
                //   // Get.toNamed(SingleCategories.singleCategoriesScreen);
                // } else if (index == 1) {
                //   Get.toNamed(AuthorsScreen.authorsScreen);
                // } else if (index == 2) {
                //   Get.toNamed(TeacherScreen.teacherScreen);
                // } else if (index == 4) {
                //   Get.toNamed(SchoolNurseryCategory.route);
                // }
              },
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: CachedNetworkImage(
                          imageUrl:
                          item.bannerProfile.toString(),
                          height: 65,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => const SizedBox(),
                          errorWidget: (context, url, error) => const SizedBox()),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    item.name.toString(),
                    maxLines: 1,
                    // overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500, fontSize: 14, color: AppTheme.buttonColor),
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            ).animate(
                delay: Duration(milliseconds: index*200))
              .scale(duration: 500.ms)
            ;
          }
        },
      ) : const SizedBox.shrink();
    });
  }
}
