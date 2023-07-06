import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/common_colour.dart';
import '../widgets/dimension_screen.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  String? selectProduct;
  final List<String> product = ["vendor", "vendor"];
  bool state1 = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffF4F4F4),
        appBar: AppBar(
          backgroundColor: const Color(0xffF4F4F4),
          surfaceTintColor: Colors.white,
          leading: GestureDetector(
            onTap: () {
              // _scaffoldKey.currentState!.openDrawer();
            },
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Image.asset(
                'assets/icons/backicon.png',
                height: 20,
              ),
            ),
          ),
          title: Text(
            "All Product",
            style: GoogleFonts.raleway(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: const Color(0xff303C5E)),
          ),
        ),
        body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: AddSize.padding16, vertical: AddSize.padding10),
                child: Column(children: [
                  Row(
                    // mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: AddSize.size80 * 3.6,
                        decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
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
                                  showDialogForItem();
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
                                  borderSide: BorderSide.none,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              fillColor: Colors.white,
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: AddSize.padding20,
                                  vertical: AddSize.padding10),
                              hintText: 'Search Products',
                              hintStyle: TextStyle(
                                  fontSize: AddSize.font16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400)),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          // Get.toNamed(AddVendorProduct.addVendorProduct);
                        },
                        child: Container(
                          height: AddSize.size20 * 2.2,
                          width: AddSize.size20 * 2.2,
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
                  const SizedBox(height: 20,),
                  ListView.builder(itemCount: 7,
                    scrollDirection: Axis.vertical,
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
                                padding: EdgeInsets.symmetric(
                                    horizontal: AddSize.padding16,
                                    vertical: AddSize.padding10),
                                child: Row(children: [
                                  SizedBox(
                                      height: AddSize.size80,
                                      width: AddSize.size80,
                                      child: const Image(
                                        image:
                                        AssetImage('assets/images/voicebook.png'),
                                      )),
                                  SizedBox(
                                    width: AddSize.size10,
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              child: Text(
                                                'Testasy Book',
                                                style: GoogleFonts.poppins(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w500),
                                              ),
                                            ),
                                            Container(
                                                height: AddSize.size25,
                                                width: AddSize.size25,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                    BorderRadius.circular(40),
                                                    border: Border.all(
                                                        color: AppTheme.buttonColor)),
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
                                        Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
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
                                                inactiveTextColor:
                                                const Color(0xFFEBEBEB),
                                                activeTextColor:
                                                const Color(0xFFFFFFFF),
                                                inactiveTextFontWeight:
                                                FontWeight.w600,
                                                inactiveColor: Colors.grey.shade400,
                                                activeColor: AppTheme.buttonColor,
                                                onToggle: (val) {
                                                  setState(() {
                                                    state1 = val;
                                                  });
                                                },
                                                value: state1,
                                              )
                                            ])
                                      ],
                                    ),
                                  ),
                                ])),
                          ),
                          const SizedBox(height: 13,)
                        ],
                      );
                    },

                  ),
                ]))));
  }

  showDialogForItem(){
    return showDialog(context: context, builder: (context){
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Select Product Type',
                style:
                TextStyle(color: Colors.black, fontSize: 15,fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: const Color(0xffE2E2E2).withOpacity(.4)

                      ),
                      child: Row(
                        //mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(
                            child: DropdownButtonFormField(
                                icon: const Icon(Icons
                                    .keyboard_arrow_down_rounded),
                                focusColor: Colors.grey.shade50,
                                isExpanded: true,
                                // iconEnabledColor: Colors.green,
                                hint: Text(
                                  'Category',
                                  style: GoogleFonts.poppins(
                                    // color: const Color(0xff4F5D62),
                                      fontSize: AddSize.font16),
                                  textAlign: TextAlign.start,
                                ),
                                decoration: InputDecoration(
                                  fillColor: Colors.grey.shade50,
                                  contentPadding:
                                  const EdgeInsets.symmetric(
                                      horizontal: 15,
                                      vertical: 18),
                                  // .copyWith(top: maxLines! > 4 ? AddSize.size18 : 0),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.grey.shade300),
                                    borderRadius:
                                    BorderRadius.circular(10.0),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.grey.shade300),
                                    borderRadius:
                                    BorderRadius.circular(10.0),
                                  ),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.grey.shade300,
                                          width: 3.0),
                                      borderRadius:
                                      BorderRadius.circular(
                                          15.0)),
                                ),
                                value: selectProduct,
                                items: product.map((value) {
                                  return DropdownMenuItem(
                                    value: value.toString(),
                                    child: Row(
                                      //mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                          value.toString(),
                                          style: TextStyle(
                                              color: Colors.black45,
                                              fontSize:
                                              AddSize.font14),
                                        ),
                                      ],
                                    ),
                                  );
                                }).toList(),
                                onChanged: (newValue) {
                                  selectProduct =
                                      newValue.toString();
                                  setState(() {});
                                },
                                validator: (valid) {
                                  if (selectProduct == null) {
                                    return "Type is required";
                                  } else {
                                    return null;
                                  }
                                }),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10,),


              ElevatedButton(
                  onPressed: () {

                  },
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.maxFinite, 50),
                      backgroundColor: AppTheme.buttonColor,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.circular(AddSize.size10)),
                      textStyle: TextStyle(
                          fontSize: AddSize.font20,
                          fontWeight: FontWeight.w600)),
                  child: Text(
                    "Save",
                    style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: AddSize.font18),
                  )),
            ],
          ),
        ),
      );
    });
  }
}
