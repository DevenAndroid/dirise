import 'dart:async';
import 'dart:convert';
import 'package:dirise/repository/repository.dart';
import 'package:dirise/screens/app_bar/common_app_bar.dart';
import 'package:dirise/screens/product_details/product_widget.dart';
import 'package:dirise/utils/api_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../model/model_virtual_assets.dart';
import '../widgets/common_colour.dart';

class SearchProductsScreen extends StatefulWidget {
  final String searchText;

  const SearchProductsScreen({Key? key, required this.searchText}) : super(key: key);

  @override
  State<SearchProductsScreen> createState() => _SearchProductsScreenState();
}

class _SearchProductsScreenState extends State<SearchProductsScreen> {
  late TextEditingController textEditingController;
  final Repositories repositories = Repositories();
  ModelVirtualAssets modelProductsList = ModelVirtualAssets(product: []);
  RxInt refreshInt = 0.obs;
  int page = 1;
  bool allLoaded = false;
  bool paginating = false;
  final ScrollController scrollController = ScrollController();
  Timer? timer;

  debounceSearch() {
    if (timer != null) {
      timer!.cancel();
    }
    searchProducts(reset: true);
  }

  addScrollListener() {
    scrollController.addListener(() {
      if (scrollController.offset > (scrollController.position.maxScrollExtent - 10)) {
        searchProducts();
      }
    });
  }

  searchProducts({bool? reset}) {
    if (reset == true) {
      allLoaded = false;
      paginating = false;
      page = 1;
    }

    if (allLoaded) return;
    if (paginating) return;
    paginating = true;
    refreshInt.value = -2;
    repositories.postApi(url: ApiUrls.searchProductUrl, mapData: {
      'search': textEditingController.text.trim(),
      'page': page,
      'limit': "20",
    }).then((value) {
      paginating = false;
      if (reset == true) {
        modelProductsList.product = [];
      }
      ModelVirtualAssets response = ModelVirtualAssets.fromJson(jsonDecode(value));
      response.product ??= [];
      if (response.product!.isNotEmpty) {
        modelProductsList.product!.addAll(response.product!);
        page++;
      } else {
        allLoaded = true;
      }
      refreshInt.value = DateTime.now().millisecondsSinceEpoch;
    });
  }

  @override
  void initState() {
    super.initState();
    textEditingController = TextEditingController(text: widget.searchText);
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      searchProducts();
      addScrollListener();
    });
  }

  @override
  void dispose() {
    super.dispose();
    textEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CommonAppBar(
          titleText: "Search",
          backGroundColor: AppTheme.buttonColor,
          textColor: Colors.white,
        ),
        body: RefreshIndicator(
            onRefresh: () async {
              // await getAllAsync();
            },
            child: Column(
              children: [
                Container(
                  color: AppTheme.buttonColor,
                  child: Column(
                    children: [
                      Hero(
                        tag: "search_tag",
                        child: Material(
                          color: Colors.transparent,
                          surfaceTintColor: Colors.transparent,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: TextField(
                              controller: textEditingController,
                              style: GoogleFonts.poppins(fontSize: 16),
                              textInputAction: TextInputAction.search,
                              onChanged: (value) {
                                debounceSearch();
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
                    child: Obx(() {
                      if (refreshInt.value > 0) {}
                      return GridView.builder(
                        controller: scrollController,
                        shrinkWrap: true,
                        itemCount: modelProductsList.product!.length,
                        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 20,
                            childAspectRatio:
                                MediaQuery.of(context).size.width / (MediaQuery.of(context).size.height / 1.3)),
                        itemBuilder: (BuildContext context, int index) {
                          final item = modelProductsList.product![index];
                          return ProductUI(
                            productElement: item,
                            onLiked: (value) {
                              item.inWishlist = value;
                            },
                          );
                        },
                      );
                    }),
                  ),
                ),
              ],
            )));
  }
}
