// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
//
// class EbookAccount extends StatefulWidget {
//   const EbookAccount({Key? key}) : super(key: key);
//
//   @override
//   State<EbookAccount> createState() => _EbookAccountState();
// }
//
// class _EbookAccountState extends State<EbookAccount> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Column(children: [
//           Container(
//             height: 194,
//             width: MediaQuery.sizeOf(context).width,
//             color: const Color(0xffEBF1F4),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Text(
//                   "Account",
//                   style: GoogleFonts.poppins(color: const Color(0xFF014E70), fontSize: 24, fontWeight: FontWeight.w600),
//                 ),
//                 const SizedBox(
//                   height: 20,
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(left: 20, right: 20),
//                   child: Container(
//                     height: 56,
//                     width: MediaQuery.sizeOf(context).width,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(50),
//                       color: const Color(0xFF014E70),
//                     ),
//                     child: Center(
//                       child: Text(
//                         'Login Or Sign up',
//                         style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.white),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           const SizedBox(
//             height: 20,
//           ),
//           Row(
//             children: [
//               const SizedBox(
//                 width: 20,
//               ),
//               const Icon(Icons.question_mark_rounded),
//               const SizedBox(
//                 width: 20,
//               ),
//               Text(
//                 "Faq's",
//                 style: GoogleFonts.poppins(color: const Color(0xFF2A3032), fontSize: 16, fontWeight: FontWeight.w500),
//               ),
//               const Spacer(),
//               const Icon(
//                 Icons.arrow_forward_ios,
//                 size: 15,
//               ),
//               const SizedBox(
//                 width: 20,
//               ),
//             ],
//           ),
//           const SizedBox(
//             height: 12,
//           ),
//           const Divider(
//             thickness: 1,
//             color: Color(0x1A000000),
//           ),
//           const SizedBox(
//             height: 12,
//           ),
//           Row(
//             children: [
//               const SizedBox(
//                 width: 20,
//               ),
//               const Icon(Icons.roundabout_left),
//               const SizedBox(
//                 width: 20,
//               ),
//               Text(
//                 "Language",
//                 style: GoogleFonts.poppins(color: const Color(0xFF2A3032), fontSize: 16, fontWeight: FontWeight.w500),
//               ),
//               const Spacer(),
//               const Icon(
//                 Icons.arrow_forward_ios,
//                 size: 15,
//               ),
//               const SizedBox(
//                 width: 20,
//               ),
//             ],
//           ),
//           const SizedBox(
//             height: 12,
//           ),
//           const Divider(
//             thickness: 1,
//             color: Color(0x1A000000),
//           ),
//           const SizedBox(
//             height: 12,
//           ),
//           Row(
//             children: [
//               const SizedBox(
//                 width: 20,
//               ),
//               const Icon(Icons.add_circle_outline),
//               const SizedBox(
//                 width: 20,
//               ),
//               Text(
//                 "About Us",
//                 style: GoogleFonts.poppins(color: const Color(0xFF2A3032), fontSize: 16, fontWeight: FontWeight.w500),
//               ),
//               const Spacer(),
//               const Icon(
//                 Icons.arrow_forward_ios,
//                 size: 15,
//               ),
//               const SizedBox(
//                 width: 20,
//               ),
//             ],
//           ),
//           const SizedBox(
//             height: 12,
//           ),
//           const Divider(
//             thickness: 1,
//             color: Color(0x1A000000),
//           ),
//           const SizedBox(
//             height: 12,
//           ),
//           Row(
//             children: [
//               const SizedBox(
//                 width: 20,
//               ),
//               const Icon(Icons.file_open_sharp),
//               const SizedBox(
//                 width: 20,
//               ),
//               Text(
//                 "Terms Of Conditions",
//                 style: GoogleFonts.poppins(color: const Color(0xFF2A3032), fontSize: 16, fontWeight: FontWeight.w500),
//               ),
//               const Spacer(),
//               const Icon(
//                 Icons.arrow_forward_ios,
//                 size: 15,
//               ),
//               const SizedBox(
//                 width: 20,
//               ),
//             ],
//           ),
//           const SizedBox(
//             height: 12,
//           ),
//           const Divider(
//             thickness: 1,
//             color: Color(0x1A000000),
//           ),
//           const SizedBox(
//             height: 12,
//           ),
//           Row(
//             children: [
//               const SizedBox(
//                 width: 20,
//               ),
//               const Icon(Icons.back_hand),
//               const SizedBox(
//                 width: 20,
//               ),
//               Text(
//                 "Return policy",
//                 style: GoogleFonts.poppins(color: const Color(0xFF2A3032), fontSize: 16, fontWeight: FontWeight.w500),
//               ),
//               const Spacer(),
//               const Icon(
//                 Icons.arrow_forward_ios,
//                 size: 15,
//               ),
//               const SizedBox(
//                 width: 20,
//               ),
//             ],
//           ),
//           const SizedBox(
//             height: 12,
//           ),
//           const Divider(
//             thickness: 1,
//             color: Color(0x1A000000),
//           ),
//           const SizedBox(
//             height: 12,
//           ),
//         ]),
//       ),
//     );
//   }
// }
