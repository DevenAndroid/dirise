import 'package:dirise/routers/my_routers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../widgets/common_colour.dart';
import '../../widgets/dimension_screen.dart';
import 'add_product_screen.dart';

class VendorProductScreen extends StatefulWidget {
  static String route = "/VendorProductScreen";
  const VendorProductScreen({Key? key}) : super(key: key);

  @override
  State<VendorProductScreen> createState() => _VendorProductScreenState();
}

class _VendorProductScreenState extends State<VendorProductScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffF4F4F4),
        appBar: AppBar(
          title: const Text('All Product',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w600,
                color: Color(0xff423E5E),
              )),
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
            child: Column(children: [
              Row(
                // mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: AddSize.size80 * 3.5,
                    decoration:
                        BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.circular(10), boxShadow: [
                      BoxShadow(
                          color: Colors.grey.shade300,
                          // offset: Offset(2, 2),
                          blurRadius: 05)
                    ]),
                    child: TextField(
                      maxLines: 1,
                      // controller: vendorProductListController
                      //     .searchController,
                      style: const TextStyle(fontSize: 17),
                      textAlignVertical: TextAlignVertical.center,
                      textInputAction: TextInputAction.search,
                      onChanged: (value) => {
                        // vendorProductListController
                        //     .getVendorProductList()
                      },
                      decoration: InputDecoration(
                          filled: true,
                          suffixIcon: IconButton(
                            onPressed: () {
                              // vendorProductListController
                              //     .getVendorProductList();
                            },
                            icon: Icon(
                              Icons.search,
                              color: AppTheme.lightblack,
                              size: AddSize.size25,
                            ),
                          ),
                          border: const OutlineInputBorder(
                              borderSide: BorderSide.none, borderRadius: BorderRadius.all(Radius.circular(10))),
                          fillColor: Colors.white,
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: AddSize.padding20, vertical: AddSize.padding10),
                          hintText: 'Search Products',
                          hintStyle: TextStyle(
                              fontSize: AddSize.font16, color: Colors.black, fontWeight: FontWeight.w400)),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(AddProductScreen.route);
                    },
                    child: Container(
                      height: AddSize.size20 * 2.5,
                      width: AddSize.size20 * 2.5,
                      decoration: BoxDecoration(
                        color: AppTheme.buttonColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                          child: Icon(
                        Icons.add,
                        color: Colors.white,
                        size: AddSize.size25,
                      )),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: 70,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                              padding:
                                  EdgeInsets.symmetric(horizontal: AddSize.padding16, vertical: AddSize.padding10),
                              child: Row(children: [
                                SizedBox(
                                    height: AddSize.size80,
                                    width: AddSize.size80,
                                    child: const Image(
                                      image: AssetImage('assets/images/voicebook.png'),
                                    )),
                                SizedBox(
                                  width: AddSize.size10,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              'Testasy Book',
                                              style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                          Container(
                                              height: AddSize.size25,
                                              width: AddSize.size25,
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(40),
                                                  border: Border.all(color: AppTheme.buttonColor)),
                                              child: Center(
                                                child: Icon(
                                                  Icons.edit,
                                                  color: AppTheme.buttonColor,
                                                  size: AddSize.size15,
                                                ),
                                              ))
                                        ],
                                      ),
                                      Text(
                                        'History Logic',
                                        style: GoogleFonts.poppins(
                                          color: const Color(0xff676E73),
                                          fontSize: 15,
                                        ),
                                        // vendorProductListController
                                        //     .model
                                        //     .value
                                        //     .data![index]
                                        //     .variants![0]
                                        //     .variantQty
                                        //     .toString(),
                                        // style: Theme.of(context)
                                        //     .textTheme
                                        //     .headline6!
                                        //     .copyWith(
                                        //     fontWeight:
                                        //     FontWeight.w500,
                                        //     fontSize:
                                        //     AddSize.font14,
                                        //     color:
                                        //     AppTheme.subText),
                                      ),
                                      Text(
                                        // vendorProductListController
                                        //     .model
                                        //     .value
                                        //     .data![index]
                                        //     .variants![0]
                                        //     .variantQtyType
                                        //     .toString(),
                                        // style: Theme.of(context)
                                        //     .textTheme
                                        //     .headline6!
                                        //     .copyWith(
                                        //     fontWeight:
                                        //     FontWeight.w500,
                                        //     fontSize:
                                        //     AddSize.font14,
                                        //     color:
                                        //     AppTheme.subText),
                                        '5 piece',
                                        style: GoogleFonts.poppins(
                                          color: const Color(0xff676E73),
                                          fontSize: 15,
                                        ),
                                      ),
                                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                        Text(
                                          'KD 6.350',
                                          style: GoogleFonts.poppins(
                                            color: AppTheme.buttonColor,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 15,
                                          ),
                                          // "₹${vendorProductListController
                                          //     .model
                                          //     .value
                                          //     .data![index]
                                          //     .variants![0]
                                          //     .price.toString()}",
                                          // //"100",
                                          // style: Theme.of(context)
                                          //     .textTheme
                                          //     .headline6!
                                          //     .copyWith(
                                          //     fontWeight:
                                          //     FontWeight.w500,
                                          //     fontSize:
                                          //     AddSize.font16,
                                          //     color: AppTheme
                                          //         .primaryColor),
                                        ),
                                        FlutterSwitch(
                                          showOnOff: true,
                                          width: AddSize.size30 * 2.2,
                                          height: AddSize.size20 * 1.4,
                                          padding: 2,
                                          valueFontSize: AddSize.font12,
                                          activeTextFontWeight: FontWeight.w600,
                                          inactiveText: " Out",
                                          activeText: "  In",
                                          inactiveTextColor: const Color(0xFFEBEBEB),
                                          activeTextColor: const Color(0xFFFFFFFF),
                                          inactiveTextFontWeight: FontWeight.w600,
                                          inactiveColor: Colors.grey.shade400,
                                          activeColor: AppTheme.buttonColor,
                                          onToggle: (val) {
                                            setState(() {
                                              // state1 = val;
                                            });
                                          },
                                          value: index.isEven,
                                        )
                                      ])
                                    ],
                                  ),
                                ),
                              ])),
                        ),
                        const SizedBox(
                          height: 13,
                        )
                      ],
                    );
                  },
                ),
              ),
            ])));
  }
}