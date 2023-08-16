import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dirise/model/common_modal.dart';
import 'package:dirise/repository/repository.dart';
import 'package:dirise/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../controller/cart_controller.dart';
import '../../controller/wish_list_controller.dart';
import '../../model/trending_products_modal.dart';
import '../../utils/ApiConstant.dart';
import '../../widgets/like_button.dart';
import 'single_product.dart';

class ProductUI extends StatefulWidget {
  final ProductElement productElement;
  final Function(bool gg) onLiked;

  const ProductUI({super.key, required this.productElement, required this.onLiked});

  @override
  State<ProductUI> createState() => _ProductUIState();
}

class _ProductUIState extends State<ProductUI> {
  final cartController = Get.put(CartController());
  final wishListController = Get.put(WishListController());

  Size size = Size.zero;
  final Repositories repositories = Repositories();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    size = MediaQuery
        .of(context)
        .size;
  }

  addToWishList() {
    repositories
        .postApi(
        url: ApiUrls.addToWishListUrl,
        mapData: {
          "product_id": widget.productElement.id.toString(),
        },
        context: context)
        .then((value) {
      widget.onLiked(true);
      ModelCommonResponse response =
      ModelCommonResponse.fromJson(jsonDecode(value));
      showToast(response.message);
      if (response.status == true) {
        wishListController.getYourWishList();
        wishListController.favoriteItems.add(widget.productElement.id.toString());
        wishListController.updateFav;
      }
    });
  }

  removeFromWishList() {
    repositories
        .postApi(
        url: ApiUrls.removeFromWishListUrl,
        mapData: {
          "product_id": widget.productElement.id.toString(),
        },
        context: context)
        .then((value) {
      widget.onLiked(false);
      ModelCommonResponse response =
      ModelCommonResponse.fromJson(jsonDecode(value));
      showToast(response.message);
      if (response.status == true) {
        wishListController.getYourWishList();
        wishListController.favoriteItems.removeWhere((element) => element == widget.productElement.id.toString());
        wishListController.updateFav;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        bottomSheet(productDetails: widget.productElement, context: context);
      },
      child: Container(
        constraints: BoxConstraints(
          minWidth: 0,
          maxWidth: size.width * .45,
        ),
        // color: Colors.red,
        margin: const EdgeInsets.only(right: 18),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  child: CachedNetworkImage(
                    imageUrl: widget.productElement.featuredImage.toString(),
                    height: 100,
                    fit: BoxFit.cover,
                    errorWidget: (context, url, error) =>
                        Image.asset("assets/images/bag.png"),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "${widget.productElement.discountPercentage ?? (
                      (((widget.productElement.pPrice
                          .toString()
                          .toNum - widget.productElement.sPrice
                          .toString()
                          .toNum)
                          / widget.productElement.pPrice
                              .toString()
                              .toNum) * 100).toStringAsFixed(2)
                  )} Off",
                  style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xffC22E2E)),
                ),
                const SizedBox(
                  height: 3,
                ),
                Text(
                  widget.productElement.pname.toString(),
                  style: GoogleFonts.poppins(
                      fontSize: 16, fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 3,
                ),
                Text(
                  '${widget.productElement.inStock.toString()} pieces',
                  style: GoogleFonts.poppins(
                      color: const Color(0xff858484), fontSize: 17),
                ),
                const SizedBox(
                  height: 3,
                ),
                Row(
                  children: [
                    Text(
                      'KD ${widget.productElement.sPrice.toString()}',
                      style: GoogleFonts.poppins(
                          fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Text(
                      'KD ${widget.productElement.pPrice.toString()}',
                      style: GoogleFonts.poppins(
                          decoration: TextDecoration.lineThrough,
                          color: const Color(0xff858484),
                          fontSize: 13,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                )
              ],
            ),
            Positioned(
              top: 0,
              right: 10,
              child: Obx(() {
                if(wishListController.refreshFav.value > 0){}
                return LikeButton(
                  onPressed: () {
                    if (wishListController.favoriteItems.contains(widget.productElement.id.toString())) {
                      removeFromWishList();
                    } else {
                      addToWishList();
                    }
                  },
                  isLiked: wishListController.favoriteItems.contains(widget.productElement.id.toString()),
                );
              }),
            )
          ],
        ),
      ),
    );
  }
}

Future bottomSheet({required ProductElement productDetails, required BuildContext context}) {
  return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      constraints: BoxConstraints(
          maxHeight: context.getSize.height * .9, minHeight: context.getSize.height * .4),
      builder: (context) {
        return SingleProductDetails(
          productDetails: productDetails,
        );
      });
}
