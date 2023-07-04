import 'package:dirise/routers/my_routers.dart';
import 'package:dirise/widgets/common_colour.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My profile',
          style: GoogleFonts.poppins(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: AppTheme.buttonColor,
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 20),
          child: Column(
            children: [
              GestureDetector(onTap: (){

                Get.toNamed(MyRouters.editprofileScreen);
              },
                child: Image.asset(
                    height: size.height * .2, 'assets/images/profile.png'),
              ),
              Row(
                children: [
                  Container(
                    height: 50,
                    width: 50,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: AppTheme.buttonColor),
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Image.asset(
                        'assets/icons/profile.png',
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Name',
                        style: GoogleFonts.poppins(
                         fontSize: 14,
                            color: const Color(0xff454545),
                          ),

                      ),
                      const SizedBox(height: 3,),
                      Text(
                        'Williams Jones',
                        style: GoogleFonts.poppins(
                            color: const Color(0xff21181A),fontSize: 16,fontWeight: FontWeight.w500),
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              const Divider(
                color: Color(0xffEFEFEF),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Container(
                    height: 50,
                    width: 50,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: AppTheme.buttonColor),
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Image.asset(
                        'assets/icons/message.png',
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'E-Mail',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: const Color(0xff454545),
                        ),

                      ),
                      const SizedBox(height: 3,),
                      Text(
                        'williamsjones@gmail.com',
                        style: GoogleFonts.poppins(
                            color: const Color(0xff21181A),fontSize: 16,fontWeight: FontWeight.w500),
                      ),
                    ],
                  )

                ],
              ),
              const SizedBox(
                height: 15,
              ),
              const Divider(
                color: Color(0xffEFEFEF),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Container(
                    height: 50,
                    width: 50,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: AppTheme.buttonColor),
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Image.asset(
                        'assets/icons/phone.png',
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Mobile Number',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: const Color(0xff454545),
                        ),

                      ),
                      const SizedBox(height: 3,),
                      Text(
                        '+91 987-654-3210',
                        style: GoogleFonts.poppins(
                            color: const Color(0xff21181A),fontSize: 16,fontWeight: FontWeight.w500),
                      ),
                    ],
                  )

                ],
              ),
              const SizedBox(
                height: 15,
              ),
              const Divider(
                color: Color(0xffEFEFEF),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Container(
                    height: 50,
                    width: 50,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: AppTheme.buttonColor),
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Image.asset(
                        'assets/icons/location.png',
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Address',
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: const Color(0xff454545),
                          ),

                        ),
                        const SizedBox(height: 3,),
                        Text(
                          'Riverside Building, County Hall, London SE1 7PB, United Kingdom',
                          style: GoogleFonts.poppins(
                              color: const Color(0xff21181A),fontSize: 16,fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  )
       
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              const Divider(
                color: Color(0xffEFEFEF),
              ),
              SizedBox(
                height: size.height * .09,
              ),
              SizedBox(
                width: double.infinity,
                height: size.height * .07,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.buttonColor,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      textStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                      )),
                  onPressed: () {
                    Get.toNamed(MyRouters.editprofileScreen);
                  },
                  child: Text(
                    'Edit profile',
                    style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),
                ),
              ),
              SizedBox(
                height: size.height * .1,
              )
            ],
          ),
        ),
      ),
    );
  }
}
