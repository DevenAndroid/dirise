import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';



class TermCondition extends StatefulWidget {
  const TermCondition({Key? key}) : super(key: key);

  @override
  State<TermCondition> createState() => _TermConditionState();
}

class _TermConditionState extends State<TermCondition> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(140),
          child: Container(

              child: SafeArea(
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back_ios,
                          color: Color(0xff014E70), size: 20),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    Text(
                      'Terms And Conditions',
                      style: GoogleFonts.poppins(
                          fontSize: 18, fontWeight: FontWeight.w600),
                    )
                  ],
                ),
              ))),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18,vertical: 20),
          child: Column(
            children: [
              Text(
                'This is essentially Legal statement or policy',
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600, fontSize: 18),
              ),
              const SizedBox(
                height: 20,
              ),
              RichText(
                text: TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                      text:
                          "Lorem ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining",
                      style: GoogleFonts.poppins(
                          height: 1.7,
                          fontSize: 12.5,
                          color: const Color(0xff3B484A)),
                    ),
                    TextSpan(
                      text: '(',
                      style: GoogleFonts.poppins(
                          fontSize: 12.5, color: const Color(0xff3B484A)),
                    ),
                    TextSpan(
                        text: 'essentially',
                        style: GoogleFonts.poppins(
                            color: const Color(0xff51A8E8), fontSize: 12.5)),
                    TextSpan(
                      text: ')',
                      style: GoogleFonts.poppins(
                          fontSize: 12.5, color: const Color(0xff3B484A)),
                    ),
                    TextSpan(
                        text: '...',
                        style: GoogleFonts.poppins(
                          fontSize: 12.5,
                          color: const Color(0xff3B484A),
                        ))
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Lorem ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book...",
                style: GoogleFonts.poppins(fontSize: 15, height: 1.7),
              )
            ],
          ),
        ),
      ),
    );
  }
}
