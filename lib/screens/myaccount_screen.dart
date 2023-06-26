// import 'package:dirise/widgets/common_colour.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
//
// class Profile extends StatefulWidget {
//   const Profile({Key? key}) : super(key: key);
//
//   @override
//   State<Profile> createState() => _ProfileState();
// }
//
// class _ProfileState extends State<Profile> {
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return  Scaffold(
//
// appBar: AppBar(
//   title: Text('My profile',style: GoogleFonts.poppins(
//     color: Colors.white
//   ),),
//   centerTitle: true,
//   backgroundColor: AppTheme.buttonColor,
//   leading: Icon(Icons.arrow_back,color: Colors.white,),
// ),
// body: Column(
//   children: [
// SizedBox(height: size.height,),
//    SizedBox(height: 30,),
//     Image.asset('assets/images/profile.png'),
//   ],
// ),
//
//     );
//   }
// }
class MyAccount extends StatefulWidget {
  const MyAccount({Key? key}) : super(key: key);

  @override
  State<MyAccount> createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

