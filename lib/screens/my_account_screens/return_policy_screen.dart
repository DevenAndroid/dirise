import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ReturnPolicyScreen extends StatefulWidget {
  const ReturnPolicyScreen({Key? key}) : super(key: key);
  static String route = "/ReturnPolicyScreen";

  @override
  State<ReturnPolicyScreen> createState() => _ReturnPolicyScreenState();
}

class _ReturnPolicyScreenState extends State<ReturnPolicyScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: SafeArea(
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios, color: Color(0xff014E70), size: 20),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                Text(
                  'Return Policy',
                  style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600),
                )
              ],
            ),
          )),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 20),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Lorem Ipsum is simply dummy text of the printing',
                style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 18),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Lorem ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley",
                style: GoogleFonts.poppins(fontSize: 15, height: 1.7, color: const Color(0xff3B484A)),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Lorem Ipsum is simply dummy',
                style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 18),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Lorem ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard ",
                style: GoogleFonts.poppins(fontSize: 15, height: 1.7, color: const Color(0xff3B484A)),
              ),
              // ignore: prefer_const_constructors
              SizedBox(height: 10,),
              Text(
                'Lorem Ipsum is simply',
                style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 18),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Lorem ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley ",
                style: GoogleFonts.poppins(fontSize: 15, height: 1.7, color: const Color(0xff3B484A)),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Lorem Ipsum is simply dummy',
                style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 18),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Lorem ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard ",
                style: GoogleFonts.poppins(fontSize: 15, height: 1.7, color: const Color(0xff3B484A)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
