import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AboutUsScreen extends StatefulWidget {
  const AboutUsScreen({Key? key}) : super(key: key);
  static String route = "/AboutUsScreen";

  @override
  State<AboutUsScreen> createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
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
                  'About Us',
                  style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600),
                )
              ],
            ),
          )),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 5),
          child: Column(
            children: [
              Text(
                "Welcome to DIRISE application, your one-stop solution for the entrepreneurial path!",
                style: GoogleFonts.poppins(fontSize: 15, height: 1.7, color: const Color(0xff3B484A)),
              ),const SizedBox(height: 15,),
              Text(
                "DIRISE application combines all the resources you need in one centralized platform. No more time-consuming searches or scattered information. saving you precious time, effort, and money as you navigate entrepreneurship.",
                style: GoogleFonts.poppins(fontSize: 15, height: 1.7, color: const Color(0xff3B484A)),
              ),
              const SizedBox(height: 15,),
              Text(
                "With DIRISE application, you can access a collection of best selling books, specialized courses, interactive workshops, and enlightening webinars. With our app, you have digital access to a wealth of resources that will equip you with the essential tools and insights to kickstart your entrepreneurial path. You will find all the resources you need to learn or to start a business in one place.",
                style: GoogleFonts.poppins(fontSize: 15, height: 1.7, color: const Color(0xff3B484A)),
              ),
              const SizedBox(height: 15,),
              Text(
                "Download the DIRISE application today and let us be the catalyst for your entrepreneurial success.",
                style: GoogleFonts.poppins(fontSize: 15, height: 1.7, color: const Color(0xff3B484A)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
