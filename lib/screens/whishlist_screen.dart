import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dirise/routers/my_routers.dart';
import 'package:dirise/utils/helper.dart';
import 'package:dirise/widgets/common_colour.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controller/cart_controller.dart';
import '../controller/wish_list_controller.dart';
import '../model/common_modal.dart';
import '../model/trending_products_modal.dart';
import '../model/trending_products_modal.dart';
import '../model/trending_products_modal.dart';
import '../repoistery/repository.dart';
import '../utils/ApiConstant.dart';

class WishListScreen extends StatefulWidget {
  const WishListScreen({Key? key}) : super(key: key);

  @override
  State<WishListScreen> createState() => _WishListScreenState();
}

class _WishListScreenState extends State<WishListScreen> {
  final _wishListController = Get.put(WishListController());
  final cartController = Get.put(CartController());
  final Repositories repositories = Repositories();

  removeFromWishList(id, int index) {
    repositories
        .postApi(
            url: ApiUrls.removeFromWishListUrl,
            mapData: {
              "product_id": id,
            },
            context: context)
        .then((value) {
      ModelCommonResponse response = ModelCommonResponse.fromJson(jsonDecode(value));
      showToast(response.message);
      if(response.status == true){
        _wishListController.model.value.wishlist!.removeAt(index);
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        title: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Text(
            'My Favourite',
            style: GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 18),
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          _wishListController.getYourWishList();
        },
        child: Obx(() {
          if(_wishListController.refreshInt.value > 0){}
          return _wishListController.apiLoaded
              ? SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    child: _wishListController.model.value.wishlist!.isEmpty
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image(
                                  height: context.getSize.height * .24,
                                  image: const AssetImage(
                                    'assets/images/bucket.png',
                                  )),
                              const Center(
                                child: Text(
                                  'Your bag is empty',
                                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              ElevatedButton(
                                  onPressed: () {
                                    // Get.toNamed(editprofileScreen);
                                  },
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(AppTheme.buttonColor),
                                    padding: MaterialStateProperty.all(
                                        const EdgeInsets.symmetric(horizontal: 35, vertical: 13)),
                                  ),
                                  child: Text(
                                    'Shop now!',
                                    style: GoogleFonts.poppins(
                                        color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),
                                  ))
                            ],
                          )
                        : GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: _wishListController.model.value.wishlist!.length,
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 20,
                                childAspectRatio:
                                    MediaQuery.of(context).size.width / (MediaQuery.of(context).size.height / 1.3)),
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                onTap: () {
                                  // bottemSheet();
                                },
                                child: Stack(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      margin: const EdgeInsets.only(left: 5),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Flexible(
                                            child: CachedNetworkImage(
                                              imageUrl: _wishListController.model.value.wishlist![index].featuredImage
                                                  .toString(),
                                              height: 100,
                                              fit: BoxFit.cover,
                                              errorWidget: (context, url, error) =>
                                                  Image.asset("assets/images/bag.png"),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            _wishListController.model.value.wishlist![index].pname.toString(),
                                            style: GoogleFonts.poppins(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500,
                                                color: const Color(0xffC22E2E)),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            _wishListController.model.value.wishlist![index].pname.toString(),
                                            style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 16),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            _wishListController.model.value.wishlist![index].inStock.toString(),
                                            style: GoogleFonts.poppins(color: const Color(0xff858484), fontSize: 16),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                'KD ${_wishListController.model.value.wishlist![index].sPrice.toString()}',
                                                style: GoogleFonts.poppins(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w500,
                                                    color: const Color(0xff014E70)),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                'KD ${_wishListController.model.value.wishlist![index].pPrice.toString()}',
                                                style: GoogleFonts.poppins(
                                                    decoration: TextDecoration.lineThrough,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w500,
                                                    color: const Color(0xff858484)),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Positioned(
                                        top: 0,
                                        right: 10,
                                        child: IconButton(
                                          onPressed: () {
                                            removeFromWishList(
                                                _wishListController.model.value.wishlist![index].id.toString(),index);
                                          },
                                          icon:
                                              const Icon(Icons.favorite_rounded),
                                        ))
                                  ],
                                ),
                              );
                            },
                          ),
                  ),
                )
              : const Center(child: CircularProgressIndicator());
        }),
      ),
    );
  }
}
