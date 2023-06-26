import 'package:country_code_picker/country_code_picker.dart';
import 'package:dirise/widgets/common_colour.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../popup_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(150),
          child: Container(
            color: Color(0xffEBF1F4),
            margin: const EdgeInsets.only(top: 5),
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 18),
                            child: Text(
                              'Driver order to',
                              style: GoogleFonts.poppins(fontSize: 18),
                            ),
                          ),
                          const CountryCodePicker(
                            onChanged: print,
                            initialSelection: 'IT',
                            hideMainText: true,
                            showDropDownButton: true,
                            showCountryOnly: false,


                            showOnlyCountryWhenClosed: false,
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20, top: 7),
                        child: Text(
                          'DIRISE',
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600, fontSize: 21),
                        ),
                      ),
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(right: 15, top: 10),
                        child: Container(
                          alignment: Alignment.center,
                          height: 40,
                          width: 60,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image(
                                height: 25,
                                image: AssetImage(
                                  'assets/icons/whishlist.png',
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                '0',
                                style: TextStyle(
                                    color: AppTheme.buttonColor, fontSize: 23),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
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
                            padding: const EdgeInsets.all(10),
                            child: Image.asset(
                              'assets/icons/search.png',
                              height: 5,
                            ),
                          ),
                          border: InputBorder.none,
                          enabledBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                              borderSide:
                                  BorderSide(color: AppTheme.buttonColor)),
                          disabledBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                              borderSide:
                                  BorderSide(color: AppTheme.buttonColor)),
                          focusedBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                              borderSide:
                                  BorderSide(color: AppTheme.buttonColor)),
                          fillColor: Colors.white,
                          contentPadding: const EdgeInsets.only(left: 13),
                          hintText: 'what are you looking for?',
                          hintStyle:
                              GoogleFonts.poppins(color: AppTheme.buttonColor)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
            child: Column(children: [
          Padding(
              padding: EdgeInsets.all(15),
              child: Image.asset(
                'assets/images/storybooks.png',
              )),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              children: [
                Container(
                  height: 60,
                  width: 140,
                  decoration: const BoxDecoration(
                      color: Color(0xffF0F0F0),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          bottomLeft: Radius.circular(10))),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8),
                    child: Row(
                      children: [
                        Text(
                          'News & Trends',
                          style: GoogleFonts.poppins(
                            color: AppTheme.buttonColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        const Image(
                            height: 20,
                            image: AssetImage('assets/icons/trends.png'))
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 60,
                  width: 170,
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color(0xffF0F0F0),
                      ),
                      borderRadius: const BorderRadius.only(
                          bottomRight: Radius.circular(10),
                          topRight: Radius.circular(10))),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 15,left: 7),
                    child: InkWell(
                        onTap: () {
                          showModalBottomSheet(
                          
                              context: context,
                              builder: (context) {

                                return

                                  SafeArea(
                                    child: Padding(
                                    padding: const EdgeInsets.only(top: 20,right: 15,left:
                                    15),
                                    child: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Image.asset('assets/images/aritificial.png'),
                                       SizedBox(height: 10,),

                                       Text("Artificial Intelligence Gains a Foot Hold In Writing",style: GoogleFonts.poppins(
                                         fontSize: 16,fontWeight: FontWeight.w600,color: AppTheme.buttonColor



                                       ),),
                                        SizedBox(height: 20,),
                                        Text("Artificial Intelligence (Al) is gaining a strong foothold in various niches, and blogging is no exception. By making use of the best Al writing tools, you can create a long-form affiliate blog post in 10 to 15 minutes (instead of spending hours writing it yourself) and generate traffic.",
                                          style: GoogleFonts.poppins(
                                              fontSize: 14,color: Color(0xff484848)
                                          ),),
                                        SizedBox(height: 20,),
                                        Text('Published: 06/06/2023',style: GoogleFonts.poppins(
                                          fontSize: 14
                                        ),)
                                      ],
                                    ),
                                ),
                                  );
                              });
                        },
                        child: Text(
                          "Artificial Intelligence Gains a Foot Hold In Writing",
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500, fontSize: 13),
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
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 6,
            padding: EdgeInsets.only(left: 15),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4, mainAxisExtent: 110, crossAxisSpacing: 20),
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                onTap: () {},
                child: Column(
                  children: [
                    Container(
                      height: 70,
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color(0xffF0F0F0)),
                      child: Center(
                        child: Image.asset(
                          'assets/images/book.png',
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Libraries',
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                          color: AppTheme.buttonColor),
                    )
                  ],
                ),
              );
            },
          ),
          SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Trending Products',
                  style: TextStyle(fontSize: 19, fontWeight: FontWeight.w500),
                ),
                Container(
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border:
                          Border.all(color: AppTheme.buttonColor, width: 1.2)),
                  child: const Icon(
                    Icons.arrow_forward,
                    color: AppTheme.buttonColor,
                  ),
                )
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.all(20),
            height: 240,
            child: GridView.builder(
              itemCount: 2,
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 200,
                  childAspectRatio: 0.1),
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      height: size.height * .2,
                      'assets/images/bag.png',
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Atrium Classic Backpack Accessory',
                      style: GoogleFonts.poppins(
                          fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      '1 piece',
                      style:
                          GoogleFonts.poppins(color: const Color(0xff858484),fontSize: 16),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      'KD 12.700',
                      style: GoogleFonts.poppins(
                          fontSize: 16, fontWeight: FontWeight.w500),
                    )
                  ],
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Popular Products',
                  style: TextStyle(fontSize: 19, fontWeight: FontWeight.w500),
                ),
                Container(
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border:
                      Border.all(color: AppTheme.buttonColor, width: 1.2)),
                  child: const Icon(
                    Icons.arrow_forward,
                    color: AppTheme.buttonColor,
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 20,),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            height: 250,
            child: GridView.builder(
              itemCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 100,
                  childAspectRatio: 0.1),
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      height: size.height * .2,
                      'assets/images/notebook.png',
                    ),
                    Text(
                      'Atrium Classic Backpack Accessory',
                      style: GoogleFonts.poppins(
                          fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    Text(
                      '1 piece',
                      style:
                          GoogleFonts.poppins(color: const Color(0xff858484),fontSize: 16),
                    ),
                    Text(
                      'KD 12.700',
                      style: GoogleFonts.poppins(
                          fontSize: 16, fontWeight: FontWeight.w500),
                    )
                  ],
                );
              },
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child:
                Image(image: AssetImage('assets/images/collectionbooks.png')),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Shop By Author',
                  style: TextStyle(fontSize: 19, fontWeight: FontWeight.w500),
                ),

                Container(
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border:
                      Border.all(color: AppTheme.buttonColor, width: 1.2)),
                  child: const Icon(
                    Icons.arrow_forward,
                    color: AppTheme.buttonColor,
                  ),
                )
              ],
            ),
          ),
              SizedBox(height: 20,),
          Container(
            height: 300,
            margin: const EdgeInsets.symmetric(horizontal: 15),
            child: GridView.builder(
              itemCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 200,
                  childAspectRatio: 0.1),
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      height: size.height * .19,
                      'assets/images/Soud Alsanousi.png',
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Soud Alsanousi',
                      style: GoogleFonts.poppins(
                          fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                  ],
                );
              },
            ),
          ),
        ])));
  }


}
