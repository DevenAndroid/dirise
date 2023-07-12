import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';

import 'package:google_fonts/google_fonts.dart';

import 'check_out_screen.dart';

class AddBagScreen extends StatefulWidget {
  const AddBagScreen({super.key});

  static var addBagScreen = "/AddBagScreen";

  @override
  State<AddBagScreen> createState() => _AddBagScreenState();
}

class _AddBagScreenState extends State<AddBagScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios,
                color: Color(0xff014E70), size: 20),
            onPressed: () => Navigator.of(context).pop(),
          ),
          titleSpacing: 0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Bag",
                style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 22),
              ),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 15, right: 10),
          child: Column(
            children: [
              ListView.builder(
                  itemCount: 3,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return Slidable(
                      key: const ValueKey(0),
                      endActionPane: ActionPane(
                        motion: const ScrollMotion(),
                        children: [
                          const SizedBox(
                            width: 20,
                          ),
                          Container(
                              height: 50,
                              width: 80,
                              decoration:
                                  const BoxDecoration(color: Color(0xffEEEEEE)),
                              child: const Icon(
                                Icons.delete_rounded,
                                color: Colors.red,
                              ))
                        ],
                      ),
                      child: Container(
                        decoration: const BoxDecoration(
                          border: Border(
                              bottom: BorderSide(color: Color(0xffD9D9D9))),
                        ),
                        padding: const EdgeInsets.only(bottom: 20, top: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 20,
                                  backgroundColor: const Color(0xffEEEEEE),
                                  child: Text(
                                    "2x",
                                    style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                Image.asset(
                                  height: size.height * .12,
                                  'assets/images/bag.png',
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '50% off',
                                      style: GoogleFonts.poppins(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: const Color(0xffC22E2E)),
                                    ),
                                    const SizedBox(
                                      height: 4,
                                    ),
                                    Text(
                                      'Ecstasy 165 days ',
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14),
                                      textAlign: TextAlign.center,
                                    ),
                                    const SizedBox(
                                      height: 4,
                                    ),
                                    Text(
                                      '1 piece',
                                      style: GoogleFonts.poppins(
                                          color: const Color(0xff858484)),
                                    ),
                                    const SizedBox(
                                      height: 4,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Text(
                              'KD 12.700',
                              style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xff014E70)),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          decoration: const BoxDecoration(color: Color(0xff014E70)),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.white),
                        padding: const EdgeInsets.fromLTRB(20, 7, 20, 7),
                        child: Text(
                          "4",
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w700, fontSize: 18),
                        )),
                    const SizedBox(
                      width: 10,
                    ),
                    Text("KD 12.700",
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                            color: Colors.white)),
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
                                fontWeight: FontWeight.w500,
                                fontSize: 19,
                                color: Colors.white))),
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
        ));
  }
}
