import 'package:dirise/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../controller/cart_controller.dart';
import '../categores/check_out_screen.dart';

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
    cartController.getCart();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Color(0xff014E70), size: 20),
            onPressed: () => Navigator.of(context).pop(),
          ),
          titleSpacing: 0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Bag",
                style: GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 22),
              ),
            ],
          ),
        ),
        body: Obx(() {
          if (cartController.refreshInt.value > 0) {}
          return cartController.apiLoaded ?
          ListView.builder(
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
                    children: [
                      const SizedBox(
                        width: 20,
                      ),
                      GestureDetector(
                        onTap: (){
                          // Get.back();
                          cartController.removeItemFromCart(productId: cart.id.toString(),context: context);
                        },
                        child: Container(
                            decoration: const BoxDecoration(color: Color(0xffEEEEEE)),
                            padding: const EdgeInsets.fromLTRB(23, 8, 23, 8),
                            child: const Icon(
                              Icons.delete_rounded,
                              color: Colors.red,
                            )),
                      )
                    ],
                  ),
                  child: Container(
                    decoration: const BoxDecoration(
                      border: Border(bottom: BorderSide(color: Color(0xffD9D9D9))),
                    ),
                    padding: const EdgeInsets.only(bottom: 20, top: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 20,
                                backgroundColor: const Color(0xffEEEEEE),
                                child: Text(
                                  "${cart.qty}x",
                                  style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
                                ),
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              Image.network(
                                cart.featuredImage.toString(),
                                height: size.height * .12,
                                width: size.height * .12,
                                errorBuilder: (_,__,___)=> const SizedBox.shrink(),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '50% off -Static',
                                      style: GoogleFonts.poppins(
                                          fontSize: 12, fontWeight: FontWeight.w500, color: const Color(0xffC22E2E)),
                                    ),
                                    const SizedBox(
                                      height: 4,
                                    ),
                                    Text(
                                      cart.pname.toString(),
                                      style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 14),
                                      textAlign: TextAlign.center,
                                    ),
                                    const SizedBox(
                                      height: 4,
                                    ),
                                    Text(
                                      '${cart.qty.toString()} piece',
                                      style: GoogleFonts.poppins(color: const Color(0xff858484)),
                                    ),
                                    const SizedBox(
                                      height: 4,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          'KD ${cart.pPrice}',
                          style: GoogleFonts.poppins(
                              fontSize: 14, fontWeight: FontWeight.w500, color: const Color(0xff014E70)),
                        ),
                      ],
                    ),
                  ),
                );
              }) :
          const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        }),
        bottomNavigationBar: Obx(() {
          if (cartController.refreshInt.value > 0) {}
          return cartController.apiLoaded ?
          Container(
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
                            cartController.cartModel.cart!.map((e) => e.qty.toString().convertToNum ?? 0).toList().getTotal.toString(),
                            style: GoogleFonts.poppins(fontWeight: FontWeight.w700, fontSize: 18),
                          )),
                      const SizedBox(
                        width: 10,
                      ),
                      Text("KD ${cartController.cartModel.cart!.map((e) => e.pPrice.toString().convertToNum ?? 0).toList().getTotal}",
                          style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 18, color: Colors.white)),
                    ],
                  ),
                  Row(
                    children: [
                      InkWell(
                          onTap: () {
                            Get.toNamed(CheckOutScreen.checkOutScreen);
                          },
                          child: Text("Checkout",
                              style:
                              GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 18, color: Colors.white))),
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
          ) :
          const SizedBox.shrink();
        }));
  }
}
