// import 'dart:html';
//
// import 'package:dotted_border/dotted_border.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:get/get_rx/src/rx_types/rx_types.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:image_picker/image_picker.dart';
//
// import '../utils/helper.dart';
// import '../widgets/common_colour.dart';
// import '../widgets/dimension_screen.dart';
// import '../widgets/vendor_common_textfield.dart';
//
// class UpdateProduct extends StatefulWidget {
//   const UpdateProduct({Key? key}) : super(key: key);
//
//   @override
//   State<UpdateProduct> createState() => _UpdateProductState();
// }
//
// class _UpdateProductState extends State<UpdateProduct> {
//   String? chooseOptionType;
//   final List<String> optionMenu = ["vendor", "vendor"];
//   RxList<File> imageList = <File>[].obs;
//
//   @override
//   Widget build(BuildContext context) {
//     var height = MediaQuery.of(context).size.height;
//     var width = MediaQuery.of(context).size.width;
//     return Scaffold(
//         appBar: AppBar(
//           backgroundColor: const Color(0xffF4F4F4),
//           surfaceTintColor: Colors.white,
//           leading: GestureDetector(
//             onTap: () {
//               // _scaffoldKey.currentState!.openDrawer();
//             },
//             child: Padding(
//               padding: const EdgeInsets.all(18),
//               child: Image.asset(
//                 'assets/icons/backicon.png',
//                 height: 20,
//               ),
//             ),
//           ),
//           title: Text(
//             "Update Product",
//             style: GoogleFonts.raleway(
//                 fontSize: 18,
//                 fontWeight: FontWeight.w700,
//                 color: const Color(0xff303C5E)),
//           ),
//         ),
//         body: SingleChildScrollView(
//             scrollDirection: Axis.vertical,
//             physics: const BouncingScrollPhysics(),
//             child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Column(children: [
//                   Card(
//                       color: Colors.white,
//                       surfaceTintColor: Colors.white,
//                       child: Padding(
//                           padding: EdgeInsets.symmetric(
//                               horizontal: AddSize.padding16,
//                               vertical: AddSize.padding20),
//                           child: Column(children: [
//                             Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   DottedBorder(
//                                     radius: const Radius.circular(10),
//                                     borderType: BorderType.RRect,
//                                     dashPattern: const [3, 5],
//                                     color: Colors.grey.shade500,
//                                     strokeWidth: 1,
//                                     child: Container(
//                                       padding: EdgeInsets.symmetric(
//                                           horizontal: AddSize.padding16,
//                                           vertical: AddSize.padding16),
//                                       width: AddSize.screenWidth,
//                                       decoration: BoxDecoration(
//                                         color: Colors.grey.shade50,
//                                         borderRadius: BorderRadius.circular(10),
//                                       ),
//                                       child: Column(
//                                         children: [
//                                           const Image(
//                                             height: 30,
//                                             image: AssetImage(
//                                               'assets/icons/pdfdownload.png',
//                                             ),
//                                           ),
//                                           const SizedBox(
//                                             height: 15,
//                                           ),
//                                           Text(
//                                             "Upload Product image",
//                                             style: GoogleFonts.poppins(
//                                                 fontWeight: FontWeight.w300,
//                                                 color: const Color(0xff4F5D62),
//                                                 fontSize: AddSize.font14),
//                                           ),
//                                           SizedBox(
//                                             height: height * .01,
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                   SizedBox(
//                                     height: height * .02,
//                                   ),
//                                   VendorCommonTextfield(
//                                       obSecure: true,
//
//                                       // controller: cookNameController,
//                                       hintText: "Eastesy Book",
//                                    ),
//                                   SizedBox(
//                                     height: height * .007,
//                                   ),
//                                   Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       Expanded(
//                                         child: VendorCommonTextfield(
//                                             obSecure: true,
//                                             // controller: phoneController,
//                                             hintText: "8521",
//                                       ),
//                                       ),
//                                       const SizedBox(
//                                         width: 20,
//                                       ),
//                                       Expanded(
//                                         child: VendorCommonTextfield(
//                                             obSecure: true,
//                                             // controller: phoneController,
//                                             hintText: "Price",
//
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                   SizedBox(
//                                     height: height * .007,
//                                   ),
//                                   Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       Expanded(
//                                         child: Container(
//                                           decoration: BoxDecoration(
//                                               borderRadius:
//                                                   BorderRadius.circular(10.0),
//                                               color: const Color(0xffE2E2E2)
//                                                   .withOpacity(.4)),
//                                           child: Row(
//                                             //mainAxisSize: MainAxisSize.min,
//                                             children: [
//                                               Expanded(
//                                                 child: DropdownButtonFormField(
//                                                     icon: const Icon(Icons
//                                                         .keyboard_arrow_down_rounded),
//                                                     focusColor:
//                                                         Colors.grey.shade50,
//                                                     isExpanded: true,
//                                                     // iconEnabledColor: Colors.green,
//                                                     hint: Text(
//                                                       'History Book',
//                                                       style:
//                                                           GoogleFonts.poppins(
//                                                               // color: const Color(0xff4F5D62),
//                                                               fontSize: AddSize
//                                                                   .font16),
//                                                       textAlign:
//                                                           TextAlign.start,
//                                                     ),
//                                                     decoration: InputDecoration(
//                                                       fillColor:
//                                                           Colors.grey.shade50,
//                                                       contentPadding:
//                                                           const EdgeInsets
//                                                                   .symmetric(
//                                                               horizontal: 15,
//                                                               vertical: 18),
//                                                       // .copyWith(top: maxLines! > 4 ? AddSize.size18 : 0),
//                                                       focusedBorder:
//                                                           OutlineInputBorder(
//                                                         borderSide: BorderSide(
//                                                             color: Colors
//                                                                 .grey.shade300),
//                                                         borderRadius:
//                                                             BorderRadius
//                                                                 .circular(10.0),
//                                                       ),
//                                                       enabledBorder:
//                                                           OutlineInputBorder(
//                                                         borderSide: BorderSide(
//                                                             color: Colors
//                                                                 .grey.shade300),
//                                                         borderRadius:
//                                                             BorderRadius
//                                                                 .circular(10.0),
//                                                       ),
//                                                       border: OutlineInputBorder(
//                                                           borderSide:
//                                                               BorderSide(
//                                                                   color: Colors
//                                                                       .grey
//                                                                       .shade300,
//                                                                   width: 3.0),
//                                                           borderRadius:
//                                                               BorderRadius
//                                                                   .circular(
//                                                                       15.0)),
//                                                     ),
//                                                     value: chooseOptionType,
//                                                     items:
//                                                         optionMenu.map((value) {
//                                                       return DropdownMenuItem(
//                                                         value: value.toString(),
//                                                         child: Row(
//                                                           //mainAxisAlignment: MainAxisAlignment.end,
//                                                           children: [
//                                                             Text(
//                                                               value.toString(),
//                                                               style: TextStyle(
//                                                                   color: Colors
//                                                                       .black45,
//                                                                   fontSize: AddSize
//                                                                       .font14),
//                                                             ),
//                                                           ],
//                                                         ),
//                                                       );
//                                                     }).toList(),
//                                                     onChanged: (newValue) {
//                                                       chooseOptionType =
//                                                           newValue.toString();
//                                                       setState(() {});
//                                                     },
//                                                     validator: (valid) {
//                                                       // if (chooseOptionType == null) {
//                                                       //   return "Type is required";
//                                                       // } else {
//                                                       //   return null;
//                                                       // }
//                                                     }),
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                   SizedBox(
//                                     height: height * .02,
//                                   ),
//                                   Row(
//                                     children: [
//                                       Expanded(
//                                         child: VendorCommonTextfield(
//                                             obSecure: true,
//                                             // controller: addressController,
//                                             hintText: "10",
//
//                                         ),
//                                       ),
//                                       const SizedBox(
//                                         width: 15,
//                                       ),
//                                       Expanded(
//                                         child: VendorCommonTextfield(
//                                             obSecure: true,
//                                             // controller: addressController,
//                                             hintText: "12",
//
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                   SizedBox(
//                                     height: height * .02,
//                                   ),
//                                   VendorCommonTextfield(
//                                       obSecure: true,
//                                       // controller: ppsController,
//                                       hintText: "Lorem ipsum dollar sit amet",
//
//
//                                   ),
//                                 ])
//                           ]))),
//                   const SizedBox(
//                     height: 15,
//                   ),
//
//
//
//                   Card(
//                       color: Colors.white,
//                       surfaceTintColor: Colors.white,
//                       child: Padding(
//                           padding: EdgeInsets.symmetric(
//                               horizontal: AddSize.padding16,
//                               vertical: AddSize.padding20),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 "Upload PDF And Voice",
//                                 style: GoogleFonts.poppins(
//                                     fontWeight: FontWeight.w500,
//                                     color: const Color(0xff2F2F2F),
//                                     fontSize: AddSize.font18),
//                               ),
//                               SizedBox(
//                                 height: height * .02,
//                               ),
//                               DottedBorder(
//                                 radius: const Radius.circular(10),
//                                 borderType: BorderType.RRect,
//                                 dashPattern: const [3, 5],
//                                 color: Colors.grey.shade500,
//                                 strokeWidth: 1,
//                                 child: Container(
//                                   padding: EdgeInsets.symmetric(
//                                       horizontal: AddSize.padding16,
//                                       vertical: AddSize.padding16),
//                                   width: AddSize.screenWidth,
//                                   decoration: BoxDecoration(
//                                     color: Colors.grey.shade50,
//                                     borderRadius: BorderRadius.circular(10),
//                                   ),
//                                   child:
//                                       const Image(
//                                         height: 40,
//                                         image: AssetImage(
//                                           'assets/images/pdf.png',
//                                         ),
//                                       ),
//
//
//
//                                 ),
//                               ),
//                               SizedBox(
//                                 height: height * .02,
//                               ),
//                               DottedBorder(
//                                 radius: const Radius.circular(10),
//                                 borderType: BorderType.RRect,
//                                 dashPattern: const [3, 5],
//                                 color: Colors.grey.shade500,
//                                 strokeWidth: 1,
//                                 child: Container(
//                                   padding: EdgeInsets.symmetric(
//                                       horizontal: AddSize.padding16,
//                                       vertical: AddSize.padding16),
//                                   width: AddSize.screenWidth,
//                                   decoration: BoxDecoration(
//                                     color: Colors.grey.shade50,
//                                     borderRadius: BorderRadius.circular(10),
//                                   ),
//                                   child:
//                                       const Image(
//                                         height: 30,
//                                         image: AssetImage(
//                                           'assets/images/voice.png',
//                                         ),
//                                       ),
//
//
//                                 ),
//                               ),
//
//                             ],
//                           ))),
//
//                   Container(
//                       width: MediaQuery.of(context).size.width,
//                       height: MediaQuery.of(context).size.height * 0.2,
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(10.0),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.grey.shade300,
//                             offset: const Offset(
//                               .1,
//                               .1,
//                             ),
//                             blurRadius: 20.0,
//                             spreadRadius: 1.0,
//                           ),
//                         ],
//                       ),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Padding(
//                             padding: const EdgeInsets.fromLTRB(16, 11, 20, 0),
//                             child: Row(
//                               mainAxisAlignment:
//                               MainAxisAlignment.spaceBetween,
//                               children: [
//                                 const Text(
//                                   'Image Gallery',
//                                   // fontSize: 14,
//                                   // fontWeight: FontWeight.w600,
//                                   // color: Color(0xFF000000),
//                                 ),
//                                 InkWell(
//                                   onTap: () {
//
//                                     // showModalBottomSheet(
//                                     //     context: context,
//                                     //     isScrollControlled: true,
//                                     //     enableDrag: false,
//                                     //     backgroundColor: Colors.transparent,
//                                     //     elevation: 0,
//                                     //     builder: (context) {
//                                     //       return Column(
//                                     //         mainAxisSize: MainAxisSize.min,
//                                     //         children: [
//                                     //           SizedBox(
//                                     //             height: AddSize.size20,
//                                     //           ),
//                                     //           Container(
//                                     //             width: double.maxFinite,
//                                     //             decoration: const BoxDecoration(
//                                     //               color: Colors.white,
//                                     //             ),
//                                     //             child: Padding(
//                                     //               padding: EdgeInsets.symmetric(
//                                     //                   horizontal: AddSize.padding16,
//                                     //                   vertical: AddSize.padding16),
//                                     //               child: Column(
//                                     //                 children: [
//                                     //                   InkWell(
//                                     //                     onTap: () {
//                                     //                       // NewHelper()
//                                     //                       //     .addImagePicker(imageSource: ImageSource.camera)
//                                     //                       //     .then((value) {
//                                     //                       //   for (var i = 0; i < imageList.length; i++) {
//                                     //                       //     if (imageList[i].path == "") {
//                                     //                       //       imageList[i] = value!;
//                                     //                       //       Get.back();
//                                     //                       //       break;
//                                     //                       //     }
//                                     //                       //   }
//                                     //                       // });
//                                     //                     },
//                                     //                     child: Text(
//                                     //                       "Take picture",
//                                     //                       style: Theme.of(context)
//                                     //                           .textTheme
//                                     //                           .headlineSmall!
//                                     //                           .copyWith(
//                                     //                           color: AppTheme.buttonColor,
//                                     //                           fontWeight: FontWeight.w500,
//                                     //                           fontSize: AddSize.font16),
//                                     //                     ),
//                                     //                   ),
//                                     //                   SizedBox(
//                                     //                     height: AddSize.size12,
//                                     //                   ),
//                                     //                   const Divider(),
//                                     //                   SizedBox(
//                                     //                     height: AddSize.size12,
//                                     //                   ),
//                                     //                   InkWell(
//                                     //                     onTap: () {
//                                     //                       // NewHelper().addFilePickerList().then((value) {
//                                     //                       //   if (value != null) {
//                                     //                       //     for (var item in value) {
//                                     //                       //       if (imageList.length < 6) {
//                                     //                       //         imageList.add(item);
//                                     //                       //       }
//                                     //                       //     }
//                                     //                       //   }
//                                     //                       // });
//                                     //                     },
//                                     //                     child: Text(
//                                     //                       "Choose From Gallery",
//                                     //                       style: Theme.of(context)
//                                     //                           .textTheme
//                                     //                           .headlineSmall!
//                                     //                           .copyWith(
//                                     //                           color: AppTheme.buttonColor,
//                                     //                           fontWeight: FontWeight.w500,
//                                     //                           fontSize: AddSize.font16),
//                                     //                     ),
//                                     //                   ),
//                                     //                   SizedBox(
//                                     //                     height: AddSize.size12,
//                                     //                   ),
//                                     //                   ElevatedButton(
//                                     //                       onPressed: () {
//                                     //                         // Get.toNamed(MyRouters.thankUScreen);
//                                     //                       },
//                                     //                       style: ElevatedButton.styleFrom(
//                                     //                           minimumSize: const Size(double.maxFinite, 60),
//                                     //                           backgroundColor: AppTheme.buttonColor,
//                                     //                           elevation: 0,
//                                     //                           shape: RoundedRectangleBorder(
//                                     //                               borderRadius:
//                                     //                               BorderRadius.circular(AddSize.size10)),
//                                     //                           textStyle: TextStyle(
//                                     //                               fontSize: AddSize.font20,
//                                     //                               fontWeight: FontWeight.w600)),
//                                     //                       child: Text(
//                                     //                         "Submit",
//                                     //                         style: Theme.of(context)
//                                     //                             .textTheme
//                                     //                             .headline5!
//                                     //                             .copyWith(
//                                     //                             color: Colors.white,
//                                     //                             fontWeight: FontWeight.w500,
//                                     //                             fontSize: AddSize.font18),
//                                     //                       )),
//                                     //                 ],
//                                     //               ),
//                                     //             ),
//                                     //           ),
//                                     //         ],
//                                     //       );
//                                     //     });
//
//
//                                   },
//                                   child: const Text(
//                                     'Choose From Gallery',
//                                     // fontSize: 12,
//                                     // color: Color(0xFFFF6100),
//                                     // fontWeight: FontWeight.w600,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           SizedBox(
//                             height: 100,
//                             child: ListView.builder(
//                               shrinkWrap: true,
//                               scrollDirection: Axis.horizontal,
//                               physics: const BouncingScrollPhysics(),
//                               itemCount: imageList.length,
//                               itemBuilder: (context, index) {
//                                 return Row(
//                                   mainAxisAlignment:
//                                   MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Padding(
//                                       padding: const EdgeInsets.all(8.0),
//
//                                       child: Stack(
//                                         children: [
//                                           Container(
//
//
//                                             padding: EdgeInsets.symmetric(
//                                                 horizontal: AddSize.padding16,
//                                                 vertical: AddSize.padding16),
//                                             width: 80,
//                                             decoration: BoxDecoration(
//                                               color: Colors.grey.shade50,
//                                               borderRadius: BorderRadius.circular(15),
//                                             ),
//                                             child: Image.file(imageList[index],
//
//                                               width: 40,
//                                             ),
//
//
//                                           ),
//                                           const Positioned(
//
//
//                                               right: 5,
//                                               top: 5,
//                                               child:
//                                               Image(height: 13,image: AssetImage('assets/icons/delete.png'),))
//                                         ],
//                                       ),
//
//
//                                     ),
//                                   ],
//                                 );
//                               },
//                             ),
//                           ),
//                         ],
//                       )),
//                   SizedBox(
//                     height: height * .02,
//                   ),
//                   ElevatedButton(
//                       onPressed: () {
//                         Get.toNamed(MyRouters.updateProductScreen);
//                       },
//                       style: ElevatedButton.styleFrom(
//                           minimumSize: const Size(double.maxFinite, 60),
//                           backgroundColor: AppTheme.buttonColor,
//                           elevation: 0,
//                           shape: RoundedRectangleBorder(
//                               borderRadius:
//                               BorderRadius.circular(AddSize.size10)),
//                           textStyle: TextStyle(
//                               fontSize: AddSize.font20,
//                               fontWeight: FontWeight.w600)),
//                       child: Text(
//                         "Upload",
//                         style: Theme.of(context)
//                             .textTheme
//                             .headline5!
//                             .copyWith(
//                             color: Colors.white,
//                             fontWeight: FontWeight.w500,
//                             fontSize: AddSize.font18),
//                       )),
//                 ]))));
//   }
// }
