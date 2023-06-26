import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EbookAccount extends StatefulWidget {
  const EbookAccount({Key? key}) : super(key: key);

  @override
  State<EbookAccount> createState() => _EbookAccountState();
}

class _EbookAccountState extends State<EbookAccount> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [
          Container(
            height: 194,
            width: MediaQuery.sizeOf(context).width,
            color: Color(0xffEBF1F4),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Account",
                  style: GoogleFonts.poppins(
                      color: const Color(0xFF014E70),
                      fontSize: 24,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Container(
                    height: 56,
                    width: MediaQuery.sizeOf(context).width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: const Color(0xFF014E70),
                    ),
                    child: Center(
                      child: Text(
                        'Login Or Sign up',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              SizedBox(
                width: 20,
              ),
              Icon(Icons.question_mark_rounded),
              SizedBox(
                width: 20,
              ),
              Text(
                "Faq's",
                style: GoogleFonts.poppins(
                    color: const Color(0xFF2A3032),
                    fontSize: 16,
                    fontWeight: FontWeight.w500),
              ),
              Spacer(),
              Icon(
                Icons.arrow_forward_ios,
                size: 15,
              ),
              SizedBox(
                width: 20,
              ),
            ],
          ),
          SizedBox(
            height: 12,
          ),
          Divider(
            thickness: 1,
            color: Color(0x1A000000),
          ),
          SizedBox(
            height: 12,
          ),
          Row(
            children: [
              SizedBox(
                width: 20,
              ),
              Icon(Icons.roundabout_left),
              SizedBox(
                width: 20,
              ),
              Text(
                "Language",
                style: GoogleFonts.poppins(
                    color: const Color(0xFF2A3032),
                    fontSize: 16,
                    fontWeight: FontWeight.w500),
              ),
              Spacer(),
              Icon(
                Icons.arrow_forward_ios,
                size: 15,
              ),
              SizedBox(
                width: 20,
              ),
            ],
          ),
          SizedBox(
            height: 12,
          ),
          Divider(
            thickness: 1,
            color: Color(0x1A000000),
          ),
          SizedBox(
            height: 12,
          ),
          Row(
            children: [
              SizedBox(
                width: 20,
              ),
              Icon(Icons.add_circle_outline),
              SizedBox(
                width: 20,
              ),
              Text(
                "About Us",
                style: GoogleFonts.poppins(
                    color: const Color(0xFF2A3032),
                    fontSize: 16,
                    fontWeight: FontWeight.w500),
              ),
              Spacer(),
              Icon(
                Icons.arrow_forward_ios,
                size: 15,
              ),
              SizedBox(
                width: 20,
              ),
            ],
          ),
          SizedBox(
            height: 12,
          ),
          Divider(
            thickness: 1,
            color: Color(0x1A000000),
          ),
          SizedBox(
            height: 12,
          ),
          Row(
            children: [
              SizedBox(
                width: 20,
              ),
              Icon(Icons.file_open_sharp),
              SizedBox(
                width: 20,
              ),
              Text(
                "Terms Of Conditions",
                style: GoogleFonts.poppins(
                    color: const Color(0xFF2A3032),
                    fontSize: 16,
                    fontWeight: FontWeight.w500),
              ),
              Spacer(),
              Icon(
                Icons.arrow_forward_ios,
                size: 15,
              ),
              SizedBox(
                width: 20,
              ),
            ],
          ),
          SizedBox(
            height: 12,
          ),
          Divider(
            thickness: 1,
            color: Color(0x1A000000),
          ),
          SizedBox(
            height: 12,
          ),
          Row(
            children: [
              SizedBox(
                width: 20,
              ),
              Icon(Icons.back_hand),
              SizedBox(
                width: 20,
              ),
              Text(
                "Return policy",
                style: GoogleFonts.poppins(
                    color: const Color(0xFF2A3032),
                    fontSize: 16,
                    fontWeight: FontWeight.w500),
              ),
              Spacer(),
              Icon(
                Icons.arrow_forward_ios,
                size: 15,
              ),
              SizedBox(
                width: 20,
              ),
            ],
          ),
          SizedBox(
            height: 12,
          ),
          Divider(
            thickness: 1,
            color: Color(0x1A000000),
          ),
          SizedBox(
            height: 12,
          ),
        ]),
      ),
    );
  }
}
