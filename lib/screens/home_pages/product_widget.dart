import 'dart:convert';
import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dirise/model/common_modal.dart';
import 'package:dirise/repository/repository.dart';
import 'package:dirise/utils/helper.dart';
import 'package:dirise/widgets/common_colour.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../controller/cart_controller.dart';
import '../../controller/wish_list_controller.dart';
import '../../model/order_models/model_direct_order_details.dart';
import '../../model/trending_products_modal.dart';
import '../../utils/ApiConstant.dart';
import '../../widgets/like_button.dart';
import '../check_out/direct_check_out.dart';

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
  void initState() {
    super.initState();
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
  final Repositories repositories = Repositories();
  repositories.postApi(url: ApiUrls.singleProductUrl,mapData: {
    "id" : productDetails.id.toString()
  }).then((value) {

  });
  Size size = MediaQuery
      .of(context)
      .size;
  RxInt productQuantity = 1.obs;
  // log("Product Details.....   ${productDetails.toJson()}");
  final cartController = Get.put(CartController());
  return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      constraints: BoxConstraints(
          maxHeight: size.height * .9, minHeight: size.height * .4),
      builder: (context) {
        return SizedBox(
          width: size.width,
          child: Padding(
            padding: const EdgeInsets.all(20).copyWith(bottom: 10).copyWith(top: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 5,
                      width: context.getSize.width*.22,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade400,
                        borderRadius: BorderRadius.circular(100)
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 6,),
                Flexible(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: CachedNetworkImage(
                            imageUrl: productDetails.featuredImage.toString(),
                            height: 100,
                            fit: BoxFit.cover,
                            errorWidget: (context, url, error) =>
                                Image.asset("assets/images/bag.png"),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Text(
                          "${productDetails.discountPercentage} Off",
                          style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xffC22E2E)),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          productDetails.pname.toString().capitalize!,
                          style: GoogleFonts.poppins(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          '${productDetails.inStock.toString()} pieces',
                          style: GoogleFonts.poppins(
                              color: const Color(0xff858484), fontSize: 17),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Text(
                              'KD ${productDetails.sPrice.toString()}',
                              style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(
                              width: 12,
                            ),
                            Expanded(
                              child: Text(
                                'KD ${productDetails.pPrice.toString()}',
                                style: GoogleFonts.poppins(
                                    decoration: TextDecoration.lineThrough,
                                    color: const Color(0xff858484),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Description',
                            style: GoogleFonts.poppins(
                              shadows: [
                                const Shadow(
                                    color: Colors.black, offset: Offset(0, -4))
                              ],
                              color: Colors.transparent,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          Bidi.stripHtmlIfNeeded(
                              productDetails.longDescription.toString()),
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              if (productQuantity.value > 1) {
                                productQuantity.value--;
                              }
                            },
                            child: CircleAvatar(
                              radius: 18,
                              backgroundColor: const Color(0xffEAEAEA),
                              child: Center(
                                  child: Text(
                                    "━",
                                    style: GoogleFonts.poppins(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black),
                                  )),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Obx(() {
                            return Text(
                              productQuantity.value.toString(),
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w500, fontSize: 20),
                            );
                          }),
                          const SizedBox(
                            width: 10,
                          ),
                          GestureDetector(
                            onTap: () {
                              if ((productDetails.inStock
                                  .toString()
                                  .convertToNum ??
                                  0) >
                                  productQuantity.value) {
                                productQuantity.value++;
                              } else {
                                showToast("Cannot add more");
                              }
                            },
                            child: CircleAvatar(
                              radius: 18,
                              backgroundColor: const Color(0xffEAEAEA),
                              child: Center(
                                  child: Text(
                                    "+",
                                    style: GoogleFonts.poppins(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black),
                                  )),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Flexible(
                      child: ElevatedButton(
                        onPressed: () {
                          Map<String, dynamic> map = {};
                          map["product_id"] = productDetails.id.toString();
                          map["quantity"] = productQuantity.value.toString();
                          repositories
                              .postApi(
                              url: ApiUrls.buyNowDetailsUrl,
                              mapData: map,
                              context: context)
                              .then((value) {
                            ModelDirectOrderResponse response =
                            ModelDirectOrderResponse.fromJson(
                                jsonDecode(value));
                            showToast(response.message.toString());
                            if (response.status == true) {
                              response.quantity = productQuantity.value;
                              if (kDebugMode) {
                                print(response.quantity);
                              }
                              Get.toNamed(DirectCheckOutScreen.route,
                                  arguments: response);
                            }
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.buttonColor,
                          surfaceTintColor: AppTheme.buttonColor,
                        ),
                        child: FittedBox(
                          child: Text(
                            "Buy Now",
                            style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      child: ElevatedButton(
                        onPressed: () {
                          Map<String, dynamic> map = {};
                          map["product_id"] = productDetails.id.toString();
                          map["quantity"] = productQuantity.value.toString();
                          repositories
                              .postApi(
                              url: ApiUrls.addToCartUrl,
                              mapData: map,
                              context: context)
                              .then((value) {
                            ModelCommonResponse response =
                            ModelCommonResponse.fromJson(jsonDecode(value));
                            showToast(response.message.toString());
                            if (response.status == true) {
                              Get.back();
                              cartController.getCart();
                            }
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.buttonColor,
                          surfaceTintColor: AppTheme.buttonColor,
                        ),
                        child: FittedBox(
                          child: Text(
                            "Add to Bag",
                            style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      });
}
