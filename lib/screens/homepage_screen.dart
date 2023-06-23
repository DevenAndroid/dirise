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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 15),
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
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: const Row(
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
                            borderSide:
                                BorderSide(color: AppTheme.buttonColor)),
                        disabledBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            borderSide:
                                BorderSide(color: AppTheme.buttonColor)),
                        focusedBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            borderSide:
                                BorderSide(color: AppTheme.buttonColor)),
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.only(left: 13),
                        hintText: 'what are you looking for?',
                        hintStyle:
                            GoogleFonts.poppins(color: AppTheme.buttonColor)),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(15),
              child: Image(image: AssetImage('assets/images/storybooks.png')),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  Container(
                    height: 70,
                    width: 130,
                    decoration: BoxDecoration(
                        color: Color(0xffF0F0F0),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            bottomLeft: Radius.circular(10))),
                    
                    
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0,right: 8),
                      child: Row(children: [
                        Text('News & Trends',style: GoogleFonts.poppins(color: AppTheme.buttonColor,fontWeight: FontWeight.w500,),),
                        Image(height: 20,image: AssetImage('assets/icons/trends.png'))
                      ],),
                    ),
                  ),
                  Container(
                    height: 70,
                    width: 180,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Color(0xffF0F0F0),
                        ),
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(10),
                            topRight: Radius.circular(10))),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                          onTap: (){

                            showDialogue1(context);
                          },
                          child: Text("Artificial Intelligence Gains a Foot Hold In Writing",style: GoogleFonts.poppins(fontWeight: FontWeight.w500,fontSize: 16),)),
                    ),
                  ),
                ],
              ),
            ),



            Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Trending Products',
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
            Container(
              margin: EdgeInsets.all(20),
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
                            fontSize: 15, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        '1 piece',
                        style:
                            GoogleFonts.poppins(color: const Color(0xff858484)),
                      ),
                      SizedBox(
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
              padding: const EdgeInsets.symmetric(horizontal: 15),
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
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              height: 270,
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
                            GoogleFonts.poppins(color: const Color(0xff858484)),
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
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child:
                  Image(image: AssetImage('assets/images/collectionbooks.png')),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Shop By Author',
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
            Container(
              height: 300,
              margin: EdgeInsets.symmetric(horizontal: 15),
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
                      SizedBox(
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
          ],
        ),
      ),
    );
  }
  showDialogue1(context) {
    showDialog(
        context: context,
        builder: (context) {
          return const PopUpScreen();
        });
  }
}
