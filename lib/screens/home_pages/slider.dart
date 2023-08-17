import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:dirise/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scroll_loop_auto_scroll/scroll_loop_auto_scroll.dart';

import '../../controller/home_controller.dart';
import '../../widgets/common_colour.dart';
import '../../widgets/loading_animation.dart';

class SliderWidget extends StatefulWidget {
  const SliderWidget({super.key});

  @override
  State<SliderWidget> createState() => _SliderWidgetState();
}

class _SliderWidgetState extends State<SliderWidget> {
  final homeController = Get.put(TrendingProductsController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Obx(() {
      return homeController.homeModal.value.home != null
          ? Column(
              children: [
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
                        width: context.getSize.width * .40,
                        decoration: const BoxDecoration(
                            color: Color(0xffF0F0F0),
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10))),
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
                              borderRadius:
                                  const BorderRadius.only(bottomRight: Radius.circular(10), topRight: Radius.circular(10))),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 15, left: 7),
                            child: InkWell(
                              onTap: () {
                                showModalBottomSheet(
                                    isScrollControlled: true,
                                    context: context,
                                    builder: (context) {
                                      return SizedBox(
                                        height: context.getSize.height * .7,
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
                                                    fontSize: 16, fontWeight: FontWeight.w600, color: AppTheme.buttonColor),
                                              ),
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              Text(
                                                "Artificial Intelligence (Al) is gaining a strong foothold in various niches, and blogging is no exception. By making use of the best Al writing tools, you can create a long-form affiliate blog post in 10 to 15 minutes (instead of spending hours writing it yourself) and generate traffic.",
                                                style: GoogleFonts.poppins(fontSize: 14, color: const Color(0xff484848)),
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
                                  'Artificial Intelligence Gains a Foot Hold In Writing',
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
              ],
            ).animate().fade(duration: 400.ms)
          : const LoadingAnimation();
    });
  }
}
