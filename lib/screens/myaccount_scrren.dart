import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../routers/my_routers.dart';

class EbookAccount extends StatefulWidget {
  const EbookAccount({Key? key}) : super(key: key);

  @override
  State<EbookAccount> createState() => _EbookAccountState();
}

enum SingingCharacter { lafayette, jefferson }

class _EbookAccountState extends State<EbookAccount> {
  SingingCharacter? _character = SingingCharacter.lafayette;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(130),
        child: Container(
          color: Color(0xffEBF1F4),
          child: SafeArea(
            child: Container(
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
                  Image.asset(
                    'assets/images/myaccount.png',
                    height: 60,
                  ),
                  Text(
                    "Hi Bader",
                    style: GoogleFonts.poppins(
                        color: const Color(0xff000000),
                        fontSize: 16,
                        fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Column(children: [
            SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {
                Get.toNamed(MyRouters.profileScreen);
              },
              child: Row(
                children: [
                  Image.asset(height: 25, 'assets/icons/drawerprofile.png'),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    "Profile",
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
                ],
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Divider(
              thickness: 1,
              color: Color(0x1A000000),
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Image.asset(height: 25, 'assets/icons/ebook.png'),
                SizedBox(
                  width: 20,
                ),
                Text(
                  "E Books",
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
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Divider(
              thickness: 1,
              color: Color(0x1A000000),
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Image.asset(height: 25, 'assets/icons/order.png'),
                SizedBox(
                  width: 20,
                ),
                Text(
                  "Orders",
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
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Divider(
              thickness: 1,

              color: Color(0x1A000000),
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Image.asset(height: 25, 'assets/icons/calendar.png'),
                SizedBox(
                  width: 20,
                ),
                Text(
                  "My Calender",
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
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Divider(
              thickness: 1,
              color: Color(0x1A000000),
            ),
            SizedBox(
              height: 5,
            ),
            InkWell(
              onTap: (){

              },
              child: Row(
                children: [
                  Image.asset(height: 25, 'assets/icons/faq.png'),
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
                ],
              ),
            ),
            SizedBox(
              height:5,
            ),
            Divider(
              thickness: 1,
              color: Color(0x1A000000),
            ),
            SizedBox(
              height: 5,
            ),
            InkWell(
              onTap: () {
                showModalBottomSheet<void>(
                    context: context,
                    builder: (BuildContext context) {
                      return Container(
                        height: 330,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20))),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 20, right: 20),
                                child: Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Color(0xffDCDCDC)),
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: ListTile(
                                      title: const Text('Arabic'),
                                      leading: Radio<SingingCharacter>(
                                        value: SingingCharacter.lafayette,
                                        groupValue: _character,
                                        activeColor: Color(0xff014E70),
                                        onChanged: (SingingCharacter? value) {
                                          setState(() {
                                            _character = value;
                                          });
                                        },
                                      ),
                                    )),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 20, right: 20),
                                child: Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Color(0xffDCDCDC)),
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: ListTile(
                                      title: const Text('English'),
                                      leading: Radio<SingingCharacter>(
                                        value: SingingCharacter.lafayette,
                                        groupValue: _character,
                                        activeColor: Color(0xff014E70),
                                        onChanged: (SingingCharacter? value) {
                                          setState(() {
                                            _character = value;
                                          });
                                        },
                                      ),
                                    )),
                              ),
                              SizedBox(
                                height: size.height * .08,
                              ),
                              Center(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20),
                                  child: Container(
                                    height: 56,
                                    width: MediaQuery.sizeOf(context).width,
                                    color: Color(0xff014E70),
                                    child: Center(
                                      child: Text(
                                        'Apply',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    });
              },
              child: Row(
                children: [
                  Image.asset(height: 25, 'assets/icons/language.png'),
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
                ],
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Divider(
              thickness: 1,
              color: Color(0x1A000000),
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              children: [

                Image.asset(height: 25, 'assets/icons/aboutus.png'),
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


              ],
            ),
            SizedBox(
              height: 5,
            ),
            Divider(

              thickness: 1,
              color: Color(0x1A000000),
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              children: [

                Image.asset(height: 25, 'assets/icons/termscondition.png'),
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

              ],
            ),
            SizedBox(
              height: 5,
            ),
            Divider(

              thickness: 1,
              color: Color(0x1A000000),
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              children: [

                Image.asset(height: 25, 'assets/icons/policy.png'),
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

              ],
            ),
            SizedBox(
              height: 5,
            ),
            Divider(

              thickness: 1,
              color: Color(0x1A000000),
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              children: [

                Image.asset(height: 25, 'assets/icons/signout.png'),
                SizedBox(
                  width: 20,
                ),
                Text(
                  "Sign Out",
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

              ],
            ),
            SizedBox(
              height: 5,
            ),
            Divider(

              thickness: 1,
              color: Color(0x1A000000),
            ),
            SizedBox(
              height: 50,
            ),
          ]),
        ),
      ),
    );
  }
}
