import 'package:dirise/screens/selectd_order_screen.dart';
import 'package:dirise/widgets/common_colour.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:google_fonts/google_fonts.dart';

class MyOrdersScreen extends StatefulWidget {
  const MyOrdersScreen({super.key});
  static var myOrdersScreen = "/myOrdersScreen";

  @override
  State<MyOrdersScreen> createState() => _MyOrdersScreenState();
}

class _MyOrdersScreenState extends State<MyOrdersScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppTheme.buttonColor,
        surfaceTintColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 20),
          onPressed: () => Navigator.of(context).pop(),
        ),
        titleSpacing: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Order",
              style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 22),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "MY Orders",
              style: GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 18),
            ),
            const SizedBox(
              height: 20,
            ),
            ListView.builder(
                itemCount: 3,
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xffD9D9D9).withOpacity(.7), width: 1.3),
                        borderRadius: BorderRadius.circular(10)),
                    padding: const EdgeInsets.all(15),
                    margin: const EdgeInsets.only(bottom: 20),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Image.asset(
                              "assets/images/bag.png",
                              height: 40,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "22.900 KWD",
                                    style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 17),
                                  ),
                                  Text(
                                    "#000584899",
                                    style: GoogleFonts.poppins(
                                        color: const Color(0xffA6A6A6), fontWeight: FontWeight.w400, fontSize: 14),
                                  ),
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Get.toNamed(SelectedOrderScreen.selectedOrderScreen);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: const Color(0xffE8E8E8).withOpacity(.6),
                                    borderRadius: BorderRadius.circular(22)),
                                padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                                child: Text(
                                  "View",
                                  style: GoogleFonts.poppins(
                                      fontSize: 16, fontWeight: FontWeight.w500, color: const Color(0xff014E70)),
                                ),
                              ),
                            )
                          ],
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 5, bottom: 5),
                          child: Divider(
                            thickness: .5,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Complete",
                              style: GoogleFonts.poppins(
                                  color: const Color(0xff616161), fontWeight: FontWeight.w400, fontSize: 16),
                            ),
                            Text(
                              "2023-05-05",
                              style: GoogleFonts.poppins(
                                  color: const Color(0xff616161), fontWeight: FontWeight.w400, fontSize: 16),
                            ),
                          ],
                        )
                      ],
                    ),
                  );
                })
          ],
        ),
      ),
    );
  }
}
