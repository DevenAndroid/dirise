import 'package:dirise/widgets/common_colour.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controller/wish_list_controller.dart';

class Whishlist extends StatefulWidget {
  const Whishlist({Key? key}) : super(key: key);

  @override
  State<Whishlist> createState() => _WhishlistState();
}

class _WhishlistState extends State<Whishlist> {
  final _wishListController = Get.put(WishListController());
@override
  void initState() {

    // TODO: implement initState
    super.initState();
    _wishListController.getYourWishList();
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

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
          return _wishListController.isDataLoading.value
              ? SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 10),
                    child: GridView.builder(
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
                        return InkWell(
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
                                    Image.asset(
                                      height: size.height * .2,
                                      'assets/images/bag.png',
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      '50% off',
                                      style: GoogleFonts.poppins(
                                          fontSize: 18, fontWeight: FontWeight.w500, color: const Color(0xffC22E2E)),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      'Ecstasy 165 days ',
                                      style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 16),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      '1 piece',
                                      style: GoogleFonts.poppins(color: const Color(0xff858484), fontSize: 16),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          'KD 6.350',
                                          style: GoogleFonts.poppins(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                              color: const Color(0xff014E70)),
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
                                  ],
                                ),
                              ),
                              const Positioned(
                                  top: 7,
                                  right: 10,
                                  child: Icon(
                                    Icons.favorite,
                                    color: AppTheme.buttonColor,
                                    size: 23,
                                  )),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                )
              : CircularProgressIndicator();
        }),
      ),
    );
  }
}
