import 'dart:convert';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dirise/repository/repository.dart';
import 'package:dirise/utils/helper.dart';
import 'package:dirise/widgets/loading_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../model/model_category_stores.dart';
import '../../../model/trending_products_modal.dart';
import '../../../model/vendor_models/vendor_category_model.dart';
import '../../../utils/ApiConstant.dart';
import '../../../widgets/cart_widget.dart';
import '../../app_bar/common_app_bar.dart';
import '../../product_details/product_widget.dart';
import 'single_store_screen.dart';

class SingleCategories extends StatefulWidget {
  const SingleCategories({super.key, required this.vendorCategories});
  final VendorCategoriesData vendorCategories;

  @override
  State<SingleCategories> createState() => _SingleCategoriesState();
}

class _SingleCategoriesState extends State<SingleCategories> {
  final Repositories repositories = Repositories();
  int paginationPage = 1;

  VendorCategoriesData get mainCategory => widget.vendorCategories;

  String get categoryID => widget.vendorCategories.id.toString();
  List<ModelCategoryStores>? modelCategoryStores;
  bool allLoaded = false;
  bool paginationLoading = false;

  @override
  void initState() {
    super.initState();
    getCategoryStores(
      page: paginationPage,
    );
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _scrollController.addListener(() {
        paginateApi();
      });
    });
  }

  paginateApi() {
    if (_scrollController.offset > _scrollController.position.maxScrollExtent - 40) {
      getCategoryStores(page: paginationPage);
    }
  }

  RxInt refreshInt = 0.obs;

  Future getCategoryStores({required int page, String? search, bool? resetAll}) async {
    if (resetAll == true) {
      allLoaded = false;
      paginationLoading = false;
      paginationPage = 1;
      modelCategoryStores = null;
      page = 1;
      setState(() {});
    }
    if (allLoaded) return;
    if (paginationLoading) return;

    String url = "";
    if (search != null) {
      url = "category_id=$categoryID&pagination=4&page=$page&search=$search";
    } else {
      url = "category_id=$categoryID&pagination=4&page=$page";
    }
    paginationLoading = true;
    refreshInt.value = DateTime.now().millisecondsSinceEpoch;
    await repositories.getApi(url: "${ApiUrls.getCategoryStoresUrl}$url").then((value) {
      modelCategoryStores ??= [];
      paginationLoading = false;
      refreshInt.value = DateTime.now().millisecondsSinceEpoch;
      final response = ModelCategoryStores.fromJson(jsonDecode(value));
      if (response.user!.data!.isNotEmpty &&
          !modelCategoryStores!
              .map((e) => e.user!.currentPage.toString())
              .toList()
              .contains(response.user!.currentPage.toString())) {
        modelCategoryStores!.add(response);
        paginationPage++;
      } else {
        allLoaded = true;
      }
      setState(() {});
    });
  }

  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: CommonAppBar(
          titleText: mainCategory.name.toString(),
          actions: const [
            CartBagCard(isBlackTheme: true),
          ],
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await getCategoryStores(
            page: paginationPage,
            resetAll: true
          );
        },
        child: CustomScrollView(
          shrinkWrap: true,
          controller: _scrollController,
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
                              tag: mainCategory.bannerProfile.toString(),
                              child: Material(
                                color: Colors.transparent,
                                surfaceTintColor: Colors.transparent,
                                child: CachedNetworkImage(
                                  imageUrl: mainCategory.bannerProfile.toString(),
                                  errorWidget: (_, __, ___) => const Icon(Icons.error_outline),
                                ),
                              ),
                            ))),
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
                          "${mainCategory.name.toString()} Type",
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
            if (modelCategoryStores != null)
              for (var i = 0; i < modelCategoryStores!.length; i++) ...list(i)
            else
              const SliverToBoxAdapter(
                child: LoadingAnimation(),
              ),

            if (modelCategoryStores != null && modelCategoryStores!.isEmpty)
            const SliverToBoxAdapter(
              child: Center(
                child: Text("Category don't have any store."),
              ),
            ),
            SliverToBoxAdapter(
              child: Obx(() {
                if (refreshInt.value > 0) {}
                return paginationLoading && modelCategoryStores != null ? const LoadingAnimation() : const SizedBox.shrink();
              }),
            )
          ],
        ),
      ),
    );
  }

  List<Widget> list(int i) {
    return [
      SliverList.builder(
          itemCount: modelCategoryStores![i].user!.data!.length,
          itemBuilder: (context, index) {
            final store = modelCategoryStores![i].user!.data![index];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: InkWell(
                  onTap: () {
                    Get.to(() => SingleStoreScreen(
                          storeDetails: store,
                        ));
                  },
                  child: Container(
                      margin: const EdgeInsets.only(
                        bottom: 10,
                      ),
                      decoration: BoxDecoration(
                          border: Border.all(color: const Color(0xffDCDCDC)), borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(8, 10, 15, 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 85,
                              width: 100,
                              child: Hero(
                                tag: store.storeLogo.toString(),
                                child: Material(
                                  color: Colors.transparent,
                                  surfaceTintColor: Colors.transparent,
                                  child: CachedNetworkImage(
                                    imageUrl: store.storeLogo.toString(),
                                    fit: BoxFit.cover,
                                    errorWidget: (_, __, ___) => const Icon(
                                      Icons.error_outline_outlined,
                                      color: Colors.red,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 12,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    store.storeName.toString(),
                                    style:
                                        GoogleFonts.poppins(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 5, bottom: 5),
                                    child: Text(
                                      store.description.toString(),
                                      maxLines: 1,
                                      style: GoogleFonts.poppins(
                                          color: Colors.grey.withOpacity(.7), fontSize: 12, fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                  Text(
                                    ("1457 items"),
                                    style: GoogleFonts.poppins(
                                        color: const Color(0xff014E70), fontSize: 16, fontWeight: FontWeight.w600),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ))),
            );
          }),
      if (modelCategoryStores![i].promotionData != null && modelCategoryStores![i].promotionData!.isNotEmpty)
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(16).copyWith(top: 10),
            child: GestureDetector(
              onTap: (){
              },
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: SizedBox(
                      key: ValueKey(i * DateTime.now().millisecond),
                      height: context.getSize.width * .4,
                      width: double.maxFinite,
                      child: CachedNetworkImage(
                        imageUrl: modelCategoryStores![i]
                            .promotionData![min(i % 3, modelCategoryStores![i].promotionData!.length - 1)]
                            .banner
                            .toString(),
                        fit: BoxFit.cover,
                        errorWidget: (_, __, ___) => const Icon(
                          Icons.error_outline,
                          color: Colors.red,
                        ),
                      )).animate().fade(duration: 300.ms)),
            ),
          ),
        ),
      if (modelCategoryStores![i].product!.isNotEmpty)
        SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                child: Text(
                  'Related Products',
                  style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w500),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 230,
                margin: const EdgeInsets.only(top: 20),
                child: ListView.builder(
                    itemCount: modelCategoryStores![i].product!.length,
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemBuilder: (BuildContext context, int index) {
                      final item = modelCategoryStores![i].product![index];
                      return ProductUI(
                        productElement: ProductElement.fromJson(item.toJson()),
                        onLiked: (value) {
                          modelCategoryStores![i].product![index].inWishlist = value;
                        },
                      );
                    }),
              ),
            ],
          ),
        ),
      const SliverToBoxAdapter(
        child: SizedBox(
          height: 20,
        ),
      ),
    ];
  }
}
