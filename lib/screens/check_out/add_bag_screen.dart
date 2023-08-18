import 'package:dirise/utils/helper.dart';
import 'package:dirise/utils/styles.dart';
import 'package:dirise/widgets/common_colour.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../controller/cart_controller.dart';
import 'check_out_screen.dart';

class BagsScreen extends StatefulWidget {
  const BagsScreen({super.key});

  static var addBagScreen = "/AddBagScreen";

  @override
  State<BagsScreen> createState() => _BagsScreenState();
}

class _BagsScreenState extends State<BagsScreen> {
  final cartController = Get.put(CartController());

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      cartController.getCart();
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: customAppBar(title: "Bag"),
        body: RefreshIndicator(
          onRefresh: () async {
            await cartController.getCart();
          },
          child: Obx(() {
            if (cartController.refreshInt.value > 0) {}
            return cartController.apiLoaded
                ? cartController.cartModel.cart!.isNotEmpty
                    ? ListView.builder(
                        itemCount: cartController.cartModel.cart!.length,
                        padding: const EdgeInsets.only(left: 15, right: 10),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          final cart = cartController.cartModel.cart![index];
                          return Slidable(
                            key: ValueKey(cart.id!),
                            endActionPane: ActionPane(
                              motion: const ScrollMotion(),
                              extentRatio: .25,
                              children: [
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Flexible(
                                        child: GestureDetector(
                                          onTap: () {
                                            // Get.back();
                                            cartController.removeItemFromCart(
                                                productId: cart.id.toString(), context: context);
                                          },
                                          child: Container(
                                              decoration: const BoxDecoration(color: Color(0xffEEEEEE)),
                                              padding: const EdgeInsets.fromLTRB(23, 8, 23, 8),
                                              child: const Icon(
                                                Icons.delete_rounded,
                                                color: Colors.red,
                                              )),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            child: Container(
                              decoration: const BoxDecoration(
                                border: Border(bottom: BorderSide(color: Color(0xffD9D9D9))),
                              ),
                              padding: const EdgeInsets.only(top: 16, bottom: 16),
                              child: IntrinsicHeight(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(top: size.height * .06 - 20),
                                      child: CircleAvatar(
                                        radius: 20,
                                        backgroundColor: const Color(0xffEEEEEE),
                                        child: Text(
                                          "${cart.qty}x",
                                          style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    Image.network(
                                      cart.featuredImage.toString(),
                                      height: size.height * .12,
                                      width: size.height * .12,
                                      errorBuilder: (_, __, ___) => const SizedBox.shrink(),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text(
                                            "${NewHelper.getDiscountPercentage(sellingPrice: cart.sPrice.toString(), actualPrice: cart.pPrice.toString())} %Off",
                                            style: GoogleFonts.poppins(
                                                fontSize: 12, fontWeight: FontWeight.w500, color: const Color(0xffC22E2E)),
                                          ),
                                          const SizedBox(
                                            height: 4,
                                          ),
                                          Text(
                                            cart.pname.toString(),
                                            style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 15),
                                            textAlign: TextAlign.start,
                                          ),
                                          const SizedBox(
                                            height: 4,
                                          ),
                                          Text(
                                            'USD ${cart.sPrice}',
                                            style: GoogleFonts.poppins(
                                                fontSize: 14, fontWeight: FontWeight.w500, color: const Color(0xff014E70)),
                                          ),
                                          if (cart.selectedSlotDate.toString() != "" &&
                                              cart.selectedSlotStart.toString() != "")
                                            GestureDetector(
                                              behavior: HitTestBehavior.translucent,
                                              onTap: () {
                                                cart.showDetails.value = !cart.showDetails.value;
                                              },
                                              child: Padding(
                                                padding: const EdgeInsets.symmetric(vertical: 6),
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                        child: Text(
                                                      "Booking Details",
                                                      style: normalStyle,
                                                    )),
                                                    Obx(() {
                                                      return cart.showDetails.value
                                                          ? const Icon(
                                                              Icons.keyboard_arrow_down_rounded,
                                                              color: AppTheme.buttonColor,
                                                              size: 22,
                                                            )
                                                          : const Icon(
                                                              Icons.arrow_forward_ios_rounded,
                                                              size: 16,
                                                            );
                                                    }),
                                                    const SizedBox(
                                                      width: 4,
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          Obx(() {
                                            return cart.showDetails.value
                                                ? Column(
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Expanded(
                                                              child: Text(
                                                            "Date: ${cart.selectedSlotDate}",
                                                            style: normalStyle,
                                                          )),
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          Expanded(
                                                              child: Text(
                                                            "Time: ${cart.selectedSlotStart} - ${cart.selectedSlotEnd}",
                                                            style: normalStyle,
                                                          )),
                                                        ],
                                                      ),
                                                    ],
                                                  )
                                                : const SizedBox.shrink();
                                          }),
                                          const SizedBox(
                                            height: 4,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        })
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Center(
                            child: Text(
                              "Bag is empty\n"
                              "Checkout products to added them in bag",
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Center(
                            child: TextButton(
                                onPressed: () {
                                  Get.back();
                                },
                                child: const Text("Browse")),
                          ),
                        ],
                      )
                : const Center(
                    child: CircularProgressIndicator.adaptive(),
                  );
          }),
        ),
        bottomNavigationBar: Obx(() {
          if (cartController.refreshInt.value > 0) {}
          return cartController.apiLoaded
              ? cartController.cartModel.cart!.isNotEmpty
                  ? Container(
                      height: 63,
                      decoration: const BoxDecoration(color: Color(0xff014E70)),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.white),
                                    padding: const EdgeInsets.fromLTRB(20, 7, 20, 7),
                                    child: Text(
                                      cartController.cartModel.cart!
                                          .map((e) => e.qty.toString().convertToNum ?? 0)
                                          .toList()
                                          .getTotal
                                          .toString(),
                                      style: GoogleFonts.poppins(fontWeight: FontWeight.w700, fontSize: 18),
                                    )),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text("KD ${cartController.cartModel.subtotal}",
                                    style:
                                        GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 18, color: Colors.white)),
                              ],
                            ),
                            Row(
                              children: [
                                InkWell(
                                    onTap: () {
                                      Get.toNamed(CheckOutScreen.checkOutScreen);
                                    },
                                    child: Text("Checkout",
                                        style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w500, fontSize: 18, color: Colors.white))),
                                const SizedBox(
                                  width: 10,
                                ),
                                const Image(
                                  height: 25,
                                  image: AssetImage(
                                    'assets/icons/whishlist.png',
                                  ),
                                  color: Colors.white,
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    )
                  : const SizedBox.shrink()
              : const SizedBox.shrink();
        }));
  }

  AppBar customAppBar({required String title}) {
    return AppBar(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios, color: Color(0xff014E70), size: 20),
        onPressed: () => Get.back(),
      ),
      titleSpacing: 0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 22),
          ),
        ],
      ),
    );
  }
}
