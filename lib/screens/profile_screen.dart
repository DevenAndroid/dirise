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
          onTap: (){
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
              Image.asset(
                  height: size.height * .2, 'assets/images/profile.png'),
              TextFormField(

                decoration: InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppTheme.buttonColor),
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Image.asset(
                          'assets/icons/profile.png',
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  hintText: 'Williams Jones',
                  hintStyle: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500,color: const Color(0xff21181A)
                  ),
                  labelText: 'Name',
                  labelStyle: const TextStyle(
                      height: .5,
                      color: Color(0xff454545),
                      fontSize: 20
                  ),
                ),
              ),
              const SizedBox(height: 15,),
              const Divider(
color: Color(0xffEFEFEF),
              ),
              const SizedBox(height: 10,),
              TextFormField(

                decoration: InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppTheme.buttonColor),
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Image.asset(
                          'assets/icons/message.png',
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  hintText: 'williamsjones@gmail.com',
                  hintStyle: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500,color: const Color(0xff21181A)
                  ),
                  labelText: 'E-Mail',
                  labelStyle: const TextStyle(
                      height: .5,
                      color: Color(0xff454545),
                      fontSize: 20
                  ),
                ),
              ),
              const SizedBox(height: 15,),
              const Divider(
                color: Color(0xffEFEFEF),
              ),
              const SizedBox(height: 10,),
              TextFormField(

                decoration: InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppTheme.buttonColor),
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Image.asset(
                          'assets/icons/phone.png',
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  hintText: '+91 987-654-3210',
                  hintStyle: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500,color: const Color(0xff21181A)
                  ),
                  labelText: 'Mobile Number',
                  labelStyle: const TextStyle(
                      height: .5,
                      color: Color(0xff454545),
                      fontSize: 20
                  ),
                ),
              ),
              const SizedBox(height: 15,),
              const Divider(
                color: Color(0xffEFEFEF),
              ),
              const SizedBox(height: 10,),
              TextFormField(

                decoration: InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppTheme.buttonColor),
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Image.asset(
                          'assets/icons/location.png',
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  hintText: 'Riverside Building, County Hall, London SE1 7PB, United Kingdom',
                  hintStyle: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500,color: const Color(0xff21181A)
                  ),
                  labelText: 'Address',

                  labelStyle: const TextStyle(
                    height: .5,
                    color: Color(0xff454545),
                    fontSize: 20
                  ),
                ),
              ),
              const SizedBox(height: 15,),
              const Divider(
                color: Color(0xffEFEFEF),
              ),
              SizedBox(
                height: size.height*.09,
              ),
              SizedBox(
                width: double.infinity,
                height: size.height*.07,
                child: ElevatedButton(

                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.buttonColor,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),

                      textStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                      )), onPressed: () {
Get.toNamed(MyRouters.editprofileScreen);

                }, child: Text('Edit profile',style: GoogleFonts.poppins(
                    fontSize: 18,fontWeight: FontWeight.w600,color: Colors.white
                ),),

                ),
              ),
              SizedBox(height: size.height*.1,)

            ],
          ),
        ),
      ),
    );
  }
}
