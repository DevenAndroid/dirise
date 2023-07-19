import 'package:dirise/routers/my_routers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../bottomavbar.dart';
import '../../controller/cart_controller.dart';
import '../../model/model_add_cart.dart';

class OrderCompleteScreen extends StatefulWidget {

  const OrderCompleteScreen({super.key});
  static var route = "/orderCompleteScreen";
  // final cartController = Get.put(CartController());

  @override
  State<OrderCompleteScreen> createState() => _OrderCompleteScreenState();
}

class _OrderCompleteScreenState extends State<OrderCompleteScreen> {
  ModelAddOrder addCart = ModelAddOrder();


  final cartController = Get.put(CartController());
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body:
      addCart.data ==  true?

      Padding(
        padding: const EdgeInsets.fromLTRB(20, 60, 20, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 35,
              backgroundColor: Color(0xffEBF1F4),
              child: Icon(
                Icons.check,
                color: Color(0xff014E70),
                size: 35,
                weight: 100.0,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 5, top: 15),
              child: Text(
                "Your order has been confirmed",
                style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 18),
              ),
            ),
            Text('',
           // {cartController.cartModel}
              style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 18),
            ),
            const SizedBox(
              height: 30,
            ),
            Column(
              children: [
                Row(
                  children: [
                    Text(
                      "Order ",
                      style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 18),
                    ),
                    Text(
                      addCart.data!.id.toString(),
                      style: GoogleFonts.poppins(color: const Color(0xff858484)),
                    ),
                  ],
                ),
                ListView.builder(
                    itemCount: 2,
                    scrollDirection: Axis.vertical,
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        decoration: const BoxDecoration(
                          border: Border(bottom: BorderSide(color: Color(0xffD9D9D9))),
                        ),
                        padding: const EdgeInsets.only(bottom: 20, top: 20),
                        child: Row(
                          children: [
                             CircleAvatar(
                              radius: 20,
                              backgroundColor: Color(0xffEEEEEE),
                              child: Text(addCart.data!.quantity.toString()),
                            ),
                            const SizedBox(
                              width: 7,
                            ),
                            Image.asset(
                              height: size.height * .12,
                              'assets/images/bag.png',
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  'Ecstasy 165 days ',
                                  style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 14),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  '1 piece',
                                  style: GoogleFonts.poppins(color: const Color(0xff858484)),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    }),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              "you will recieve a confirmation email soon. \n           Thank you for using DIRISE.",
              style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 16, height: 1.8),
            ),
          ],
        ),
      ): Center(child: CircularProgressIndicator()),
      bottomNavigationBar: InkWell(
        onTap: () {
          Get.offAllNamed(BottomNavbar.route);
        },
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Container(
            decoration: BoxDecoration(color: const Color(0xff014E70), borderRadius: BorderRadius.circular(32)),
            height: 55,
            alignment: Alignment.bottomCenter,
            child: Align(
                alignment: Alignment.center,
                child: Text("Home",
                    style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 19, color: Colors.white))),
          ),
        ),
      ),
    );
  }
}
