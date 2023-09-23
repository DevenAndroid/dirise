import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import '../../controller/cart_controller.dart';
import '../../controller/wish_list_controller.dart';
import '../../model/common_modal.dart';
import '../../repository/repository.dart';
import '../../utils/ApiConstant.dart';
import '../../widgets/cart_widget.dart';
import '../product_details/product_widget.dart';

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
        actions: const [
          CartBagCard(isBlackTheme: true),
        ],
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
                              Lottie.asset("assets/loti/wishlist.json"),
                              Center(
                                child: Text(
                                  'Your wishlist is empty',
                                  style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 22),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                            ],
                          )
                        : GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: _wishListController.model.value.wishlist!.length,
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 20,
                                childAspectRatio:
                                    .7),
                            itemBuilder: (BuildContext context, int index) {
                              return ProductUI(
                                productElement: _wishListController.model.value.wishlist![index],
                                onLiked: (value) {
                                  removeFromWishList(
                                      _wishListController.model.value.wishlist![index].id.toString(),index);
                                },
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
