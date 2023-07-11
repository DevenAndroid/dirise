import 'package:dirise/widgets/common_colour.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SingleCategory extends StatefulWidget {
  const SingleCategory({Key? key}) : super(key: key);

  @override
  State<SingleCategory> createState() => _SingleCategoryState();
}

class _SingleCategoryState extends State<SingleCategory> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(200),
        child: Container(
          color: const Color(0xffEBF1F4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: IconButton(
                  icon: const Icon(Icons.arrow_back_ios, color: Color(0xff014E70), size: 20),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
              SizedBox(
                width: size.width * .20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 40),
                child: Image.asset(
                  height: size.height * .2,
                  'assets/images/voicebook.png',
                ),
              ),
            ],
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'The Fault in Our Stars',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Text('Author Name',
                  style:
                      GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 20, color: const Color(0XFFACACAC))),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 80,
                    width: 110,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)), color: Color(0xffE8E8E8)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '4.4',
                          style: GoogleFonts.poppins(
                              fontSize: 24, fontWeight: FontWeight.w500, color: AppTheme.buttonColor),
                        ),
                        Text('Rating', style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w500)),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Container(
                    height: 80,
                    width: 120,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)), color: Color(0xffE8E8E8)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '362',
                          style: GoogleFonts.poppins(
                              fontSize: 24, fontWeight: FontWeight.w500, color: AppTheme.buttonColor),
                        ),
                        Text('No. of page', style: GoogleFonts.poppins(fontSize: 17, fontWeight: FontWeight.w500)),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 90,
                    width: 110,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)), color: Color(0xffE8E8E8)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Eng',
                          style: GoogleFonts.poppins(
                              fontSize: 24, fontWeight: FontWeight.w500, color: AppTheme.buttonColor),
                        ),
                        Text('Language', style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w500)),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Container(
                    height: 90,
                    width: 110,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)), color: Color(0xffE8E8E8)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '2h14m',
                          style: GoogleFonts.poppins(
                              fontSize: 22, fontWeight: FontWeight.w500, color: AppTheme.buttonColor),
                        ),
                        Text('Audio', style: GoogleFonts.poppins(fontSize: 17, fontWeight: FontWeight.w500)),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
