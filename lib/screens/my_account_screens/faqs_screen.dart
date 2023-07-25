import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../widgets/common_colour.dart';

class FrequentlyAskedQuestionsScreen extends StatefulWidget {
  static String route = "/FrequentlyAskedQuestionsScreen";
  const FrequentlyAskedQuestionsScreen({Key? key}) : super(key: key);

  @override
  State<FrequentlyAskedQuestionsScreen> createState() => _FrequentlyAskedQuestionsScreenState();
}

class _FrequentlyAskedQuestionsScreenState extends State<FrequentlyAskedQuestionsScreen> {
  bool senderExpansion = true;

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
                  icon: const Icon(Icons.arrow_back_ios, color: Color(0xff014E70), size: 20),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                Text(
                  'Faqs',
                  style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600),
                )
              ],
            ),
          ))),
      body: ListView.builder(
        itemCount: 6,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: const Color(0xffDCDCDC), width: 1),
                  ),
                  child: Theme(
                    data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                    child: ListTileTheme(
                      contentPadding: EdgeInsets.all(0),
                      dense: true,
                      horizontalTitleGap: 0.0,
                      minLeadingWidth: 0,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0,right: 8),
                        child: ExpansionTile(
                          trailing: (senderExpansion == false)
                              ? const Icon(
                                  Icons.add,
                                  color: AppTheme.buttonColor,
                                )
                              : const Icon(
                                  Icons.remove,
                                  color: AppTheme.buttonColor,
                                ),
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
                            ListTile(
                              visualDensity: VisualDensity.compact,
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
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
