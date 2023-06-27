import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/common_colour.dart';

class FaqsScreen extends StatefulWidget {
  const FaqsScreen({Key? key}) : super(key: key);

  @override
  State<FaqsScreen> createState() => _FaqsScreenState();
}

class _FaqsScreenState extends State<FaqsScreen> {
  bool senderExpansion  = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios,
              color: Color(0xff014E70), size: 20),
          onPressed: () => Navigator.of(context).pop(),
        ),

        title: Text(
          "Faqs",
          style: GoogleFonts.poppins(
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: 22),
        ),
      ),
      body: ListView.builder(itemCount: 6,itemBuilder: (context, index) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Container(

                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: const Color(0xffDCDCDC), width: 1),

                ),
                child: Theme(
                  data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                  child: ExpansionTile(
                    trailing: (senderExpansion == false )
                        ? const Icon(Icons.add,color: AppTheme.buttonColor,)
                        :const Icon(Icons.remove,color: AppTheme.buttonColor,),
                    onExpansionChanged: (value) {
                      setState(() {
                        senderExpansion = value;
                      });

                    },


                    title: Text(
                      "What is agarwood? ",
                      style: GoogleFonts.poppins(
                        color: const Color(0xFF1D1D1D),
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                      ),
                    ),
                    children: <Widget>[
                      ListTile(visualDensity: VisualDensity.compact,

                        dense: true,
                        iconColor: const Color(0xFF07B6CA),

                        subtitle: Text(
                          "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley..",
                          style: GoogleFonts.poppins(
                            color: const Color(0xFFBBBBBB),
                            fontWeight: FontWeight.w400,
                            fontSize: 13,

                          ),
                        ),

                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15,),
          ],
        );
      },

      ),
    );
  }
}
