import 'package:dirise/widgets/common_colour.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../routers/my_routers.dart';
import '../widgets/customsize.dart';
import '../widgets/dimension_screen.dart';

class OrderDetails extends StatefulWidget {
  const OrderDetails({Key? key}) : super(key: key);
  static var orderDetails = "/orderDetails";

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  _makingPhoneCall(call) async {
    var url = Uri.parse(call);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: const Text(
            'Delivery Details',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w600,
              color: Color(0xff423E5E),
            ),
          ),
          leading: GestureDetector(
            onTap: () {
              Get.back();
              // _scaffoldKey.currentState!.openDrawer();
            },
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Image.asset(
                'assets/icons/backicon.png',
                height: 20,
              ),
            ),
          ),
        ),
        body: Padding(
            padding: EdgeInsets.symmetric(horizontal: AddSize.padding16, vertical: AddSize.padding10),
            child: SingleChildScrollView(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF37C666).withOpacity(0.10),
                          offset: const Offset(
                            .1,
                            .1,
                          ),
                          blurRadius: 20.0,
                          spreadRadius: 1.0,
                        ),
                      ],
                    ),
                    child: Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Column(children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.asset(
                                'assets/images/orderdetails.png',
                                height: 18,
                              ),
                              addWidth(15),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Order ID: 8520255',
                                    style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w600, fontSize: 15, color: AppTheme.buttonColor),
                                  ),
                                  Text(
                                    'Monday, 2 June, 2021',
                                    style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w400, fontSize: 11, color: const Color(0xFF303C5E)),
                                  ),
                                ],
                              ),
                              const Spacer(),
                              Container(
                                height: 25,
                                width: 72,
                                decoration:
                                    BoxDecoration(borderRadius: BorderRadius.circular(6), color: AppTheme.buttonColor),
                                child: Center(
                                  child: Text(
                                    'Pickup',
                                    style: GoogleFonts.poppins(
                                      color: const Color(0xFFFFFFFF),
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 13,
                          ),
                          ListView.builder(
                              shrinkWrap: true,
                              itemCount: 3,
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: (context, index) {
                                return Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                  Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              'Testasy Book',
                                              style: TextStyle(
                                                  color: Color(0xFF303C5E), fontWeight: FontWeight.w600, fontSize: 16),
                                            ),
                                            addHeight(5),
                                            const Text(
                                              '2 piece',
                                              style: TextStyle(
                                                  color: Color(0xFF6A8289), fontWeight: FontWeight.w500, fontSize: 14),
                                            ),
                                            const Divider(
                                              color: Colors.red,
                                            ),
                                          ],
                                        ),
                                        const Text(
                                          '€10.00',
                                          style: TextStyle(
                                              color: AppTheme.primaryColor, fontWeight: FontWeight.w600, fontSize: 17),
                                        ),
                                      ]),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                ]);
                              })
                        ]))),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Customer Detail',
                  style: GoogleFonts.poppins(color: const Color(0xff303C5E), fontSize: 18, fontWeight: FontWeight.w700),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF37C666).withOpacity(0.10),
                          offset: const Offset(
                            .1,
                            .1,
                          ),
                          blurRadius: 20.0,
                          spreadRadius: 1.0,
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: AddSize.screenWidth * 0.02, vertical: AddSize.screenHeight * .005),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: AddSize.padding15, vertical: AddSize.padding15),
                            child: Column(
                              children: [
                                ...[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Row(children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Driver Name",
                                              style: TextStyle(
                                                  color: Color(0xff486769), fontWeight: FontWeight.w300, fontSize: 14),
                                            ),
                                            Text(
                                              'Rajesh Sharma',
                                              style: TextStyle(height: 1.5, fontWeight: FontWeight.w600, fontSize: 16),
                                            ),
                                          ],
                                        ),
                                      ]),
                                      Container(
                                        height: 37,
                                        width: 37,
                                        decoration:
                                            const ShapeDecoration(color: Color(0xFFFE7E73), shape: CircleBorder()),
                                        child: const Center(
                                            child: Icon(
                                          Icons.person_rounded,
                                          color: Colors.white,
                                          size: 20,
                                        )),
                                      ),
                                    ],
                                  ),
                                  const Divider(),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Row(children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Driver Number",
                                              style: TextStyle(
                                                  color: Color(0xff486769), fontWeight: FontWeight.w300, fontSize: 14),
                                            ),
                                            Text(
                                              "86859654",
                                              style: TextStyle(height: 1.5, fontWeight: FontWeight.w600, fontSize: 16),
                                            ),
                                          ],
                                        ),
                                      ]),
                                      GestureDetector(
                                        onTap: () {
                                          _makingPhoneCall("tel:+916565656545");
                                        },
                                        child: Container(
                                            height: 37,
                                            width: 37,
                                            decoration:
                                                const ShapeDecoration(color: Color(0xFF71E189), shape: CircleBorder()),
                                            child: const Center(
                                                child: Icon(
                                              Icons.phone,
                                              color: Colors.white,
                                              size: 20,
                                            ))),
                                      ),
                                    ],
                                  ),
                                  const Divider(),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Expanded(
                                        child: Row(children: [
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Delivery Address",
                                                  style: TextStyle(
                                                      color: Color(0xff486769),
                                                      fontWeight: FontWeight.w300,
                                                      fontSize: 14),
                                                ),
                                                Text(
                                                  "Punjab",
                                                  style:
                                                      TextStyle(height: 1.5, fontWeight: FontWeight.w600, fontSize: 16),
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ]),
                                      ),
                                      GestureDetector(
                                        onTap: () {},
                                        child: Container(
                                          height: 37,
                                          width: 37,
                                          decoration:
                                              const ShapeDecoration(color: Color(0xFF7ED957), shape: CircleBorder()),
                                          child: const Center(
                                              child: Icon(
                                            Icons.location_on,
                                            color: Colors.white,
                                            size: 20,
                                          )),
                                        ),
                                      ),
                                    ],
                                  ),
                                ]
                              ],
                            ),
                          ),
                        )
                      ],
                    )),
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF37C666).withOpacity(0.10),
                          offset: const Offset(
                            .1,
                            .1,
                          ),
                          blurRadius: 20.0,
                          spreadRadius: 1.0,
                        ),
                      ],
                    ),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Subtotal:',
                            style: TextStyle(
                              color: Color(0xFF293044),
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            '€35.00',
                            style: TextStyle(
                              color: Color(0xFF797F90),
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    onPressed: () {
                      Get.toNamed(MyRouters.bankAccount);
                    },
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.maxFinite, 60),
                        backgroundColor: AppTheme.buttonColor,
                        elevation: 0,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AddSize.size10)),
                        textStyle: TextStyle(fontSize: AddSize.font20, fontWeight: FontWeight.w600)),
                    child: Text(
                      "Mark Delivered",
                      style: Theme.of(context)
                          .textTheme
                          .headline5!
                          .copyWith(color: Colors.white, fontWeight: FontWeight.w500, fontSize: AddSize.font18),
                    )),
              ]),
            )));
  }
}
