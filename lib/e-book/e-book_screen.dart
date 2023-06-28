import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/common_colour.dart';

class EBookScreen extends StatefulWidget {
  const EBookScreen({Key? key}) : super(key: key);

  @override
  State<EBookScreen> createState() => _EBookScreenState();
}

class _EBookScreenState extends State<EBookScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    int tt= 0;
    bool status= false;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(140),
        child: Container(
          color: const Color(0xffEBF1F4),
          child: SafeArea(
            child: Column(
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back_ios,
                          color: Color(0xff014E70), size: 20),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    Text(
                      'E books',
                      style: GoogleFonts.poppins(
                          fontSize: 18, fontWeight: FontWeight.w600),
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 13),
                  child: TextField(
                    maxLines: 1,
                    style: const TextStyle(fontSize: 17),
                    textAlign: TextAlign.center,
                    textInputAction: TextInputAction.search,
                    decoration: InputDecoration(
                        filled: true,
                        // prefixIcon:
                        //     Icon(Icons.search, color: Color(0xFFC33D18)),
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset(
                            'assets/icons/search.png',
                            height: 3,
                          ),
                        ),
                        border: InputBorder.none,
                        enabledBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            borderSide:
                                BorderSide(color: AppTheme.buttonColor)),
                        disabledBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            borderSide:
                                BorderSide(color: AppTheme.buttonColor)),
                        focusedBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            borderSide:
                                BorderSide(color: AppTheme.buttonColor)),
                        fillColor: Colors.white,
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 50),
                        hintText: 'Search E Book',
                        hintStyle:
                            GoogleFonts.poppins(color: AppTheme.buttonColor)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20),
        child: DefaultTabController(
          length: 2,
          child: Column(
            children: [
              Text(
                'My Book Library',
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600, fontSize: 20),
              ),
              const SizedBox(
                height: 20,
              ),
              TabBar(

                indicatorColor: Colors.transparent,
                unselectedLabelColor: Colors.black,
                labelColor: Colors.red,
                  dividerColor: Colors.white,
                onTap: (int ){
                  tt=int;
                  status=true;

                  print(status);
                  print("object");
                },
                tabs: [
                  Tab(
                    child: Container(
                      width: 80,
                      height: 35,
                      decoration:  tt==int?  BoxDecoration(
                          color: AppTheme.buttonColor,
                          borderRadius: BorderRadius.all(Radius.circular(20))):BoxDecoration(),
                      child: Center(
                          child: Text(
                        'E Book',
                        style: GoogleFonts.poppins(color:status==true? Colors.white: AppTheme.buttonColor),
                      )
                      ),
                    ),
                  ),
                  Tab(
                    text: 'Name',
                  )
                ],
                indicatorSize: TabBarIndicatorSize.tab,
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset(
                            height: size.height * .2,
                            'assets/images/notebook.png',
                          ),
                          Text(
                            'Roco NoteBook',
                            style: GoogleFonts.poppins(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset(
                            height: size.height * .2,
                            'assets/images/voicebook.png',
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Eustasy 165 days',
                            style: GoogleFonts.poppins(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}