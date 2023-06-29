import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:google_fonts/google_fonts.dart';

import '../widgets/common_colour.dart';
import '../widgets/common_textfield.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return  Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit profile',
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
          padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Name',style: GoogleFonts.poppins(fontSize: 15,fontWeight: FontWeight.w500),),
              const SizedBox(height: 10,),
              CommonTextfield(obSecure: false, hintText: 'Williams jones'),
              const SizedBox(height: 10,),
              Text('Email',style: GoogleFonts.poppins(fontSize: 15,fontWeight: FontWeight.w500),),
              const SizedBox(height: 10,),
              CommonTextfield(obSecure: false, hintText: 'williamsjones@gmail.com'),
              const SizedBox(height: 10,),
              Text('Mobile number',style: GoogleFonts.poppins(fontSize: 15,fontWeight: FontWeight.w500),),
              const SizedBox(height: 10,),
              CommonTextfield(obSecure: false, hintText: '+91 987-654-3210'),
              const SizedBox(height: 10,),
              Text('Address',style: GoogleFonts.poppins(fontSize: 15,fontWeight: FontWeight.w500),),
              const SizedBox(height: 10,),
              CommonTextfield(obSecure: false, hintText: 'Riverside Building, County hall,'),
               SizedBox(
                height: size.height*.3,
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


                }, child: Text('Save',style: GoogleFonts.poppins(
                    fontSize: 18,fontWeight: FontWeight.w600,color: Colors.white
                ),),

                ),
              ),

            ],
          ),
        ),
      ),

    );
  }
}
