// import 'package:dirise/routers/my_routers.dart';
// import 'package:dirise/widgets/common_colour.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
//
// import '../screens/myaccount_scrren.dart';
//
// class EBook extends StatefulWidget {
//   const EBook({Key? key}) : super(key: key);
//
//   @override
//   State<EBook> createState() => _EBookState();
// }
//
// class _EBookState extends State<EBook> {
//   List data = ["E Book", "Voice", "Both"];
//   RxBool? status = false.obs;
//   List<CheckBoxListTileModel> data1 = CheckBoxListTileModel.getList();
//   SingingCharacter? _character = SingingCharacter.lafayette;
//
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Scaffold(
//       appBar: PreferredSize(
//           preferredSize: const Size.fromHeight(140),
//           child: Container(
//               child: SafeArea(
//             child: Row(
//               children: [
//                 IconButton(
//                   icon: const Icon(Icons.arrow_back_ios, color: Color(0xff014E70), size: 20),
//                   onPressed: () => Navigator.of(context).pop(),
//                 ),
//                 Text(
//                   'E book',
//                   style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600),
//                 ),
//                 const Spacer(),
//                 Padding(
//                   padding: const EdgeInsets.only(right: 12),
//                   child: Container(
//                     alignment: Alignment.center,
//                     height: 42,
//                     width: 70,
//                     decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: AppTheme.buttonColor),
//                     child: const Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         Image(
//                           height: 25,
//                           image: AssetImage(
//                             'assets/icons/whishlist.png',
//                           ),
//                           color: Colors.white,
//                         ),
//                         SizedBox(
//                           width: 10,
//                         ),
//                         Text(
//                           '0',
//                           style: TextStyle(color: Colors.white, fontSize: 23),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ))),
//       body: SingleChildScrollView(
//         physics: const AlwaysScrollableScrollPhysics(),
//         child: Padding(
//             padding: const EdgeInsets.all(15.0),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 const Image(image: AssetImage('assets/images/storybooks.png')),
//                 const SizedBox(
//                   height: 20,
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     InkWell(
//                       onTap: () {
//                         showModalBottomSheet(
//                             isScrollControlled: true,
//                             context: context,
//                             builder: (context) {
//                               return Container(
//                                 height: size.height * .6,
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Padding(
//                                       padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 15),
//                                       child: Text(
//                                         "Type",
//                                         style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w600),
//                                       ),
//                                     ),
//                                     Obx(() {
//                                       return Column(
//                                         children: List.generate(
//                                             data.length,
//                                             (index) => Column(
//                                                   mainAxisSize: MainAxisSize.min,
//                                                   children: [
//                                                     ListTileTheme(
//                                                       horizontalTitleGap: 0.0,
//                                                       child: CheckboxListTile(
//                                                         controlAffinity: ListTileControlAffinity.leading,
//                                                         activeColor: const Color(0xff014E70),
//                                                         value: data1[index].isCheck!.value,
//                                                         onChanged: (value) {
//                                                           setState(() {
//                                                             data1[index].isCheck!.value = value!;
//                                                           });
//                                                         },
//                                                         title: Text(
//                                                           data1[index].title.toString(),
//                                                           style: GoogleFonts.poppins(
//                                                             fontWeight: FontWeight.w500,
//                                                             color: Colors.black,
//                                                             fontSize: 16,
//                                                           ),
//                                                         ),
//                                                       ),
//                                                     ),
//                                                   ],
//                                                 )),
//                                       );
//                                     }),
//                                     const SizedBox(
//                                       height: 50,
//                                     ),
//                                     Align(
//                                       alignment: Alignment.bottomCenter,
//                                       child: Column(
//                                         children: [
//                                           Container(
//                                             alignment: Alignment.center,
//                                             height: 60,
//                                             width: MediaQuery.of(context).size.width * .9,
//                                             decoration: const BoxDecoration(color: Color(0xff014E70)),
//                                             child: Text(
//                                               "Apply",
//                                               style: GoogleFonts.poppins(
//                                                   fontSize: 18, fontWeight: FontWeight.w500, color: Colors.white),
//                                             ),
//                                           ),
//                                           const SizedBox(
//                                             height: 20,
//                                           ),
//                                           Container(
//                                             alignment: Alignment.center,
//                                             height: 60,
//                                             width: MediaQuery.of(context).size.width * .9,
//                                             decoration: BoxDecoration(border: Border.all(color: AppTheme.buttonColor)),
//                                             child: Text(
//                                               "Clear All",
//                                               style: GoogleFonts.poppins(
//                                                   fontSize: 18,
//                                                   fontWeight: FontWeight.w500,
//                                                   color: const Color(0xff014E70)),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                     const SizedBox(
//                                       height: 5,
//                                     )
//                                   ],
//                                 ),
//                               );
//                             });
//                       },
//                       child: Container(
//                         height: 36,
//                         padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
//                         decoration: BoxDecoration(
//                             border: Border.all(color: const Color(0xff014E70)),
//                             color: const Color(0xffEBF1F4),
//                             borderRadius: BorderRadius.circular(22)),
//                         child: Row(
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             Padding(
//                               padding: const EdgeInsets.only(left: 8, right: 10),
//                               child: Text(
//                                 "Type",
//                                 style: GoogleFonts.poppins(
//                                     fontSize: 14, fontWeight: FontWeight.w500, color: const Color(0xff014E70)),
//                               ),
//                             ),
//                             Image.asset(
//                               'assets/icons/arrowdown.png',
//                               height: 10,
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     InkWell(
//                       onTap: () {
//                         showModalBottomSheet<void>(
//                             context: context,
//                             builder: (BuildContext context) {
//                               return Container(
//                                 height: size.height * .6,
//                                 decoration: const BoxDecoration(
//                                     color: Colors.white,
//                                     borderRadius:
//                                         BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))),
//                                 child: Center(
//                                   child: Column(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     mainAxisSize: MainAxisSize.min,
//                                     children: <Widget>[
//                                       Padding(
//                                         padding: const EdgeInsets.only(left: 20, right: 20),
//                                         child: Container(
//                                             decoration: BoxDecoration(
//                                                 border: Border.all(color: const Color(0xffDCDCDC)),
//                                                 borderRadius: BorderRadius.circular(15)),
//                                             child: ListTile(
//                                               title: const Text('Arabic'),
//                                               leading: Radio<SingingCharacter>(
//                                                 value: SingingCharacter.lafayette,
//                                                 groupValue: _character,
//                                                 activeColor: const Color(0xff014E70),
//                                                 onChanged: (SingingCharacter? value) {
//                                                   setState(() {
//                                                     _character = value;
//                                                   });
//                                                 },
//                                               ),
//                                             )),
//                                       ),
//                                       const SizedBox(
//                                         height: 10,
//                                       ),
//                                       Padding(
//                                         padding: const EdgeInsets.only(left: 20, right: 20),
//                                         child: Container(
//                                             decoration: BoxDecoration(
//                                                 border: Border.all(color: const Color(0xffDCDCDC)),
//                                                 borderRadius: BorderRadius.circular(15)),
//                                             child: ListTile(
//                                               title: const Text('English'),
//                                               leading: Radio<SingingCharacter>(
//                                                 value: SingingCharacter.lafayette,
//                                                 groupValue: _character,
//                                                 activeColor: const Color(0xff014E70),
//                                                 onChanged: (SingingCharacter? value) {
//                                                   setState(() {
//                                                     _character = value;
//                                                   });
//                                                 },
//                                               ),
//                                             )),
//                                       ),
//                                       SizedBox(
//                                         height: size.height * .08,
//                                       ),
//                                       Center(
//                                         child: Padding(
//                                           padding: const EdgeInsets.only(left: 20, right: 20),
//                                           child: Container(
//                                             height: 56,
//                                             width: MediaQuery.sizeOf(context).width,
//                                             color: const Color(0xff014E70),
//                                             child: const Center(
//                                               child: Text(
//                                                 'Apply',
//                                                 style: TextStyle(
//                                                     fontSize: 18, fontWeight: FontWeight.w500, color: Colors.white),
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                       )
//                                     ],
//                                   ),
//                                 ),
//                               );
//                             });
//                       },
//                       child: Container(
//                         height: 36,
//                         padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
//                         decoration: BoxDecoration(
//                             border: Border.all(color: const Color(0xff014E70)),
//                             color: const Color(0xffEBF1F4),
//                             borderRadius: BorderRadius.circular(22)),
//                         child: Row(
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             Padding(
//                               padding: const EdgeInsets.only(left: 8, right: 10),
//                               child: Text(
//                                 "Language",
//                                 style: GoogleFonts.poppins(
//                                     fontSize: 14, fontWeight: FontWeight.w500, color: const Color(0xff014E70)),
//                               ),
//                             ),
//                             Image.asset(
//                               'assets/icons/arrowdown.png',
//                               height: 10,
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     Container(
//                       height: 36,
//                       padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
//                       decoration: BoxDecoration(
//                           border: Border.all(color: const Color(0xff014E70)),
//                           color: const Color(0xffEBF1F4),
//                           borderRadius: BorderRadius.circular(22)),
//                       child: Row(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           Padding(
//                             padding: const EdgeInsets.only(left: 8, right: 10),
//                             child: Text(
//                               "Gender",
//                               style: GoogleFonts.poppins(
//                                   fontSize: 14, fontWeight: FontWeight.w500, color: const Color(0xff014E70)),
//                             ),
//                           ),
//                           Image.asset(
//                             'assets/icons/arrowdown.png',
//                             height: 10,
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(
//                   height: 25,
//                 ),
//                 SizedBox(
//                   child: GridView.builder(
//                     shrinkWrap: true,
//                     physics: const NeverScrollableScrollPhysics(),
//                     itemCount: 5,
//                     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                         crossAxisCount: 2,
//                         crossAxisSpacing: 10,
//                         mainAxisSpacing: 20,
//                         mainAxisExtent: size.height * .34),
//                     itemBuilder: (BuildContext context, int index) {
//                       return InkWell(
//                         onTap: () {
//                           Get.toNamed(MyRouters.singleCategory);
//                         },
//                         child: Container(
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                           margin: const EdgeInsets.only(left: 5),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Image.asset(
//                                 height: size.height * .2,
//                                 'assets/images/notebook.png',
//                               ),
//                               const SizedBox(
//                                 height: 5,
//                               ),
//                               Text(
//                                 'Atrium Classic Backpack Accessory',
//                                 style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500),
//                               ),
//                               Text(
//                                 '1 piece',
//                                 style: GoogleFonts.poppins(color: const Color(0xff858484), fontSize: 16),
//                               ),
//                               Text(
//                                 'KD 12.700',
//                                 style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500),
//                               )
//                             ],
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//               ],
//             )),
//       ),
//     );
//   }
// }
//
// class CheckBoxListTileModel {
//   String title;
//   RxBool? isCheck;
//
//   CheckBoxListTileModel({
//     required this.title,
//     required this.isCheck,
//   });
//
//   static List<CheckBoxListTileModel> getList() {
//     return <CheckBoxListTileModel>[
//       CheckBoxListTileModel(
//         title: "E Book",
//         isCheck: true.obs,
//       ),
//       CheckBoxListTileModel(
//         title: "Voice",
//         isCheck: false.obs,
//       ),
//       CheckBoxListTileModel(
//         title: "Both",
//         isCheck: false.obs,
//       ),
//     ];
//   }
// }
