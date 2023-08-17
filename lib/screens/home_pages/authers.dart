import 'package:cached_network_image/cached_network_image.dart';
import 'package:dirise/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../controller/home_controller.dart';
import '../../widgets/common_colour.dart';

class AuthorScreen extends StatefulWidget {
  const AuthorScreen({super.key});

  @override
  State<AuthorScreen> createState() => _AuthorScreenState();
}

class _AuthorScreenState extends State<AuthorScreen> {
  final homeController = Get.put(TrendingProductsController());
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return homeController.authorModal.value.data != null
          ? Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Shop By Author',
                        style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w500),
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
                Container(
                  height: 230,
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  child: ListView.builder(
                    itemCount: homeController.authorModal.value.data!.length,
                    // itemScrollController: itemController2,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                          width: context.getSize.width * .5,
                          margin: const EdgeInsets.only(right: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Flexible(
                                child: CachedNetworkImage(
                                    imageUrl: homeController.authorModal.value.data![index].profileImage.toString(),
                                    fit: BoxFit.cover,
                                    errorWidget: (context, url, error) => Image.asset("assets/images/Soud Alsanousi.png")),
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
              ],
            )
          : const SizedBox.shrink();
    });
  }
}
