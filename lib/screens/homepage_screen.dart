import 'package:country_code_picker/country_code_picker.dart';
import 'package:dirise/widgets/common_colour.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/common_button.dart';

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
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 30, horizontal: 15),
            height: size.height * .25,
            width: size.width,
            decoration: const BoxDecoration(color: Color(0xffEBF1F4)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text(
                          'Driver order to',
                          style: GoogleFonts.poppins(fontSize: 18),
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
                    Text(
                      'DIRISE',
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500, fontSize: 20),
                    ),
                    Container(
                      height: 50,
                      width: 70,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image(
                            height: 25,
                            image: AssetImage(
                              'assets/icons/whishlist.png',
                            ),
                          ),
                          SizedBox(
                            width: 3,
                          ),
                          Text(
                            '0',
                            style: TextStyle(
                                color: AppTheme.buttonColor, fontSize: 23),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                TextField(
                  maxLines: 1,
                  style: const TextStyle(fontSize: 17),
                  textAlign: TextAlign.center,
                  textInputAction: TextInputAction.search,
                  decoration: InputDecoration(
                      filled: true,
                      // prefixIcon:
                      //     Icon(Icons.search, color: Color(0xFFC33D18)),
                      prefixIcon: const Icon(
                        Icons.search,
                        color: AppTheme.buttonColor,
                      ),
                      border: InputBorder.none,
                      enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          borderSide: BorderSide(color: AppTheme.buttonColor)),
                      disabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          borderSide: BorderSide(color: AppTheme.buttonColor)),
                      focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          borderSide: BorderSide(color: AppTheme.buttonColor)),
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.only(left: 13),
                      hintText: 'what are you looking for?',
                      hintStyle:
                          GoogleFonts.poppins(color: AppTheme.buttonColor)),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Image(image: AssetImage('assets/images/storybooks.png')),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Popular Products',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
                Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: AppTheme.buttonColor)),
                  child: const Icon(
                    Icons.arrow_forward,
                    color: AppTheme.buttonColor,
                  ),
                )
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(12),
            child:
                Image(image: AssetImage('assets/images/collectionbooks.png')),
          ),
        ],
      ),
    );
  }
}
