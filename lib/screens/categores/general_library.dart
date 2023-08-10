import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dirise/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../model/model_category_stores.dart';
import '../../model/vendor_models/model_vendor_product_list.dart';
import '../../repository/repository.dart';
import '../../utils/ApiConstant.dart';
import '../../widgets/common_app_bar.dart';
import '../check_out/add_bag_screen.dart';

class GeneralLibrary extends StatefulWidget {
  const GeneralLibrary({super.key, required this.storeDetails});
  final VendorStoreData storeDetails;

  @override
  State<GeneralLibrary> createState() => _GeneralLibraryState();
}

class _GeneralLibraryState extends State<GeneralLibrary> {
  final Repositories repositories = Repositories();
  int paginationPage = 1;

  VendorStoreData get storeInfo => widget.storeDetails;
  String get vendorId => widget.storeDetails.id.toString();

  bool allLoaded = false;
  bool paginationLoading = false;

  ModelProductsList modelProductsList = ModelProductsList(product: null);

  getCategoryStores({required int page, String? search, bool? resetAll}) {
    if (resetAll == true) {
      allLoaded = false;
      paginationLoading = false;
      paginationPage = 1;
      modelProductsList.product = null;
      page = 1;
    }
    if (allLoaded) return;
    if (paginationLoading) return;

    String url = "vendor_id=$vendorId";
    paginationLoading = true;

    repositories.getApi(url: "${ApiUrls.vendorProductListUrl}$url").then((value) {
      paginationLoading = false;

      modelProductsList.product ??= [];
      final response = ModelProductsList.fromJson(jsonDecode(value));
      if(response.product != null && response.product!.isNotEmpty){
        modelProductsList.product!.addAll(response.product!);
      } else {
        allLoaded = true;
      }
      setState(() {});
    });
  }

  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    getCategoryStores(page: paginationPage);
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      scrollController.addListener(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: CommonAppBar(
          titleText: 'General Libraries',
        ),
      ),
      body: CustomScrollView(
        shrinkWrap: true,
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16).copyWith(top: 10),
              child: Column(
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: SizedBox(
                          width: double.maxFinite,
                          height: context.getSize.width * .4,
                          child: Hero(
                            tag: storeInfo.storeLogo.toString(),
                            child: Material(
                              color: Colors.transparent,
                              surfaceTintColor: Colors.transparent,
                              child: CachedNetworkImage(
                                imageUrl: storeInfo.storeLogo.toString(),
                                errorWidget: (_, __, ___) => const Icon(Icons.error_outline),
                              ),
                            ),
                          ))),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16).copyWith(top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Image(
                    image: AssetImage('assets/images/singleCategories.png'),
                    height: 85,
                  ),
                  const SizedBox(
                    width: 6,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          ("General Library"),
                          style: GoogleFonts.poppins(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5, bottom: 5),
                          child: Text(
                            ("Books, Stationary and Electronics"),
                            style: GoogleFonts.poppins(
                                color: const Color(0xff8F8F8F), fontSize: 13, fontWeight: FontWeight.w500),
                          ),
                        ),
                        Text(
                          ("1457 items"),
                          style: GoogleFonts.poppins(
                              color: const Color(0xff014E70), fontSize: 17, fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          SliverAppBar(
            primary: false,
            pinned: true,
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.white,
            leading: const SizedBox.shrink(),
            titleSpacing: 0,
            leadingWidth: 16,
            title: InkWell(
              onTap: () {},
              child: Container(
                height: 36,
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xff014E70)),
                    color: const Color(0xffEBF1F4),
                    borderRadius: BorderRadius.circular(22)),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8, right: 10),
                      child: Text(
                        "${storeInfo.storeName.toString()} Type",
                        style:
                        GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500, color: const Color(0xff014E70)),
                      ),
                    ),
                    const Icon(Icons.keyboard_arrow_down_outlined, color: Color(0xff014E70))
                  ],
                ),
              ),
            ),
          ),
          // Column(
          //   mainAxisAlignment: MainAxisAlignment.start,
          //   crossAxisAlignment: CrossAxisAlignment.start,
          //   children: [
          //     const SizedBox(
          //       height: 10,
          //     ),
          //     const Image(image: AssetImage('assets/images/storybooks.png')),
          //     const SizedBox(
          //       height: 25,
          //     ),
          //     const SizedBox(
          //       height: 25,
          //     ),
          //     InkWell(
          //       onTap: () {
          //         // showModalBottomSheet(
          //         //     context: context,
          //         //     builder: (context) {
          //         // return Column(
          //         //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //         //   crossAxisAlignment: CrossAxisAlignment.start,
          //         //   children: [
          //         //     Column(
          //         //       crossAxisAlignment: CrossAxisAlignment.start,
          //         //       children: [
          //         //         Padding(
          //         //           padding: const EdgeInsets.only(left: 27, top: 15),
          //         //           child: Text(
          //         //             "Library Type",
          //         //             style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w600),
          //         //           ),
          //         //         ),
          //         //         const SizedBox(
          //         //           height: 10,
          //         //         ),
          //         //         Obx(() {
          //         //           return Column(
          //         //             children: List.generate(
          //         //                 data.length,
          //         //                 (index) => Column(
          //         //                       mainAxisSize: MainAxisSize.min,
          //         //                       children: [
          //         //                         Theme(
          //         //                           data: ThemeData(unselectedWidgetColor: const Color(0xff014E70)),
          //         //                           child: ListTileTheme(
          //         //                             horizontalTitleGap: 5,
          //         //                             child: CheckboxListTile(
          //         //
          //         //                               controlAffinity: ListTileControlAffinity.leading,
          //         //                               dense: true,
          //         //                               visualDensity: VisualDensity.compact,
          //         //                               activeColor: const Color(0xff014E70),
          //         //                               value: status.value,
          //         //                               onChanged: (value) {
          //         //                                 setState(() {
          //         //                                   status.value = value!;
          //         //                                 });
          //         //                               },
          //         //                               title: Text(
          //         //                                 data[index],
          //         //                                 style: GoogleFonts.poppins(
          //         //                                   fontWeight: FontWeight.w500,
          //         //                                   color: Colors.black,
          //         //                                   fontSize: 16,
          //         //                                 ),
          //         //                               ),
          //         //                             ),
          //         //                           ),
          //         //                         ),
          //         //                       ],
          //         //                     )),
          //         //           );
          //         //         }),
          //         //       ],
          //         //     ),
          //         //     Align(
          //         //       alignment: Alignment.bottomCenter,
          //         //       child: Column(
          //         //         children: [
          //         //           Container(
          //         //             alignment: Alignment.center,
          //         //             height: 47,
          //         //             width: MediaQuery.of(context).size.width * .87,
          //         //             decoration: const BoxDecoration(color: Color(0xff014E70)),
          //         //             child: Text(
          //         //               "Apply",
          //         //               style: GoogleFonts.poppins(
          //         //                   fontSize: 18, fontWeight: FontWeight.w500, color: Colors.white),
          //         //             ),
          //         //           ),
          //         //           const SizedBox(
          //         //             height: 20,
          //         //           ),
          //         //           Container(
          //         //             alignment: Alignment.center,
          //         //             height: 47,
          //         //             margin: const EdgeInsets.only(bottom: 10),
          //         //             width: MediaQuery.of(context).size.width * .87,
          //         //             decoration: BoxDecoration(border: Border.all(color: const Color(0xff014E70))),
          //         //             child: Text(
          //         //               "Clear All",
          //         //               style: GoogleFonts.poppins(
          //         //                   fontSize: 18, fontWeight: FontWeight.w500, color: const Color(0xff014E70)),
          //         //             ),
          //         //           ),
          //         //         ],
          //         //       ),
          //         //     ),
          //         //   ],
          //         // );
          //         // });
          //       },
          //       child: Container(
          //         height: 36,
          //         padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          //         decoration: BoxDecoration(
          //             border: Border.all(color: const Color(0xff014E70)),
          //             color: const Color(0xffEBF1F4),
          //             borderRadius: BorderRadius.circular(22)),
          //         child: Row(
          //           mainAxisSize: MainAxisSize.min,
          //           children: [
          //             Padding(
          //               padding: const EdgeInsets.only(left: 8, right: 10),
          //               child: Text(
          //                 "product Type",
          //                 style: GoogleFonts.poppins(
          //                     fontSize: 14, fontWeight: FontWeight.w500, color: const Color(0xff014E70)),
          //               ),
          //             ),
          //             const Icon(Icons.keyboard_arrow_down_outlined, color: Color(0xff014E70))
          //           ],
          //         ),
          //       ),
          //     ),
          //     const SizedBox(
          //       height: 20,
          //     ),
          //     GridView.builder(
          //       physics: const NeverScrollableScrollPhysics(),
          //       itemCount: 5,
          //       shrinkWrap: true,
          //       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          //           crossAxisCount: 2,
          //           crossAxisSpacing: 10,
          //           mainAxisSpacing: 20,
          //           childAspectRatio: MediaQuery.of(context).size.width / (MediaQuery.of(context).size.height / 1.3)),
          //       itemBuilder: (BuildContext context, int index) {
          //         return InkWell(
          //           onTap: () {
          //             bottemSheet();
          //           },
          //           child: Stack(
          //             children: [
          //               Container(
          //                 decoration: BoxDecoration(
          //                   borderRadius: BorderRadius.circular(10),
          //                 ),
          //                 margin: const EdgeInsets.only(left: 5),
          //                 child: Column(
          //                   crossAxisAlignment: CrossAxisAlignment.start,
          //                   children: [
          //                     Image.asset(
          //                       height: size.height * .2,
          //                       'assets/images/bag.png',
          //                     ),
          //                     const SizedBox(
          //                       height: 5,
          //                     ),
          //                     Text(
          //                       '50% off',
          //                       style: GoogleFonts.poppins(
          //                           fontSize: 18, fontWeight: FontWeight.w500, color: const Color(0xffC22E2E)),
          //                     ),
          //                     const SizedBox(
          //                       height: 4,
          //                     ),
          //                     Text(
          //                       'Ecstasy 165 days ',
          //                       style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 16),
          //                     ),
          //                     const SizedBox(
          //                       height: 4,
          //                     ),
          //                     Text(
          //                       '1 piece',
          //                       style: GoogleFonts.poppins(color: const Color(0xff858484), fontSize: 16),
          //                     ),
          //                     const SizedBox(
          //                       height: 4,
          //                     ),
          //                     Text(
          //                       'KD 12.700',
          //                       style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500),
          //                     )
          //                   ],
          //                 ),
          //               ),
          //               const Positioned(top: 5, right: 10, child: Icon(Icons.favorite_border))
          //             ],
          //           ),
          //         );
          //       },
          //     ),
          //     const SizedBox(
          //       height: 10,
          //     ),
          //     const Image(
          //       image: AssetImage('assets/images/collectionbooks.png'),
          //     ),
          //   ],
          // )
        ],
      ),
    );
  }

  bottemSheet() {
    Size size = MediaQuery.of(context).size;
    return showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.white,
        builder: (context) {
          return SizedBox(
            width: size.width,
            height: size.height * .77,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 25.0),
                      child: Align(
                        alignment: Alignment.center,
                        child: Image.asset(
                          height: size.height * .2,
                          width: size.width * .7,
                          'assets/images/bag.png',
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Text(
                        '50% off',
                        style:
                            GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w500, color: const Color(0xffC22E2E)),
                      ),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Text(
                        'Ecstasy 165 days ',
                        style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 16),
                      ),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Text(
                        '1 piece',
                        style: GoogleFonts.poppins(color: const Color(0xff858484), fontSize: 16),
                      ),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15, right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                'KD 6.350',
                                style: GoogleFonts.poppins(
                                    fontSize: 16, fontWeight: FontWeight.w500, color: const Color(0xff014E70)),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                'KD 12.700',
                                style: GoogleFonts.poppins(
                                    decoration: TextDecoration.lineThrough,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: const Color(0xff858484)),
                              ),
                            ],
                          ),
                          Text(
                            'Add to list',
                            style: GoogleFonts.poppins(
                              shadows: [const Shadow(color: Colors.black, offset: Offset(0, -4))],
                              color: Colors.transparent,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              decoration: TextDecoration.underline,
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Description',
                        style: GoogleFonts.poppins(
                          shadows: [const Shadow(color: Colors.black, offset: Offset(0, -4))],
                          color: Colors.transparent,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Text(
                        'to the rich father and the poor father; What the rich teach and the poor and middle class do not teach their children about to the Publisher s Synopsis: This book will shatter the myth that you need a big income to get rich... -Challenging',
                        style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w400, height: 1.7),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
                Card(
                  elevation: 10,
                  child: Container(
                    color: Colors.white,
                    width: size.width,
                    height: 60,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 18,
                                backgroundColor: const Color(0xffEAEAEA),
                                child: Center(
                                    child: Text(
                                  "━",
                                  style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black),
                                )),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                "1",
                                style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 20),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              CircleAvatar(
                                radius: 18,
                                backgroundColor: const Color(0xffEAEAEA),
                                child: Center(
                                    child: Text(
                                  "+",
                                  style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.black),
                                )),
                              ),
                            ],
                          ),
                          InkWell(
                            onTap: () {
                              Get.offNamed(BagsScreen.addBagScreen);
                            },
                            child: Container(
                              decoration:
                                  BoxDecoration(color: const Color(0xff014E70), borderRadius: BorderRadius.circular(22)),
                              padding: const EdgeInsets.fromLTRB(20, 9, 20, 9),
                              child: Text(
                                "Add to Bag",
                                style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
