import 'package:dirise/routers/my_routers.dart';
import 'package:dirise/widgets/common_colour.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/common_button.dart';
import '../widgets/common_textfield.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
            padding: const EdgeInsets.only(left: 13, right: 13),
            child: Column(children: [
              SizedBox(
                height: 35,
              ),
              Row(
                children: [
                  InkWell(
                      onTap: (){
                     Get.back();
                      },
                    child: Image.asset(height: 30,'assets/icons/arrowback.png'),
                    ),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    'Forget Password',
                    style: GoogleFonts.poppins(
                        fontSize: 19, fontWeight: FontWeight.w600),
                  )
                ],
              ),
              SizedBox(
                height: size.height * .05,
              ),

              Padding(
                padding: const EdgeInsets.only(left: 8.0,right: 8),
                child: Text(
                  'Enter the email address associated with your account',
                  style: GoogleFonts.poppins(
                      color: AppTheme.buttonColor, fontSize: 18),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: size.height * .05,
              ),
              CommonTextfield(obSecure: false, hintText: 'Email'),

              SizedBox(
                height: size.height * .03,
              ),
              CustomOutlineButton(
                title: "Send Otp",

                onPressed: (){
                  Get.toNamed(MyRouters.otpScreen);
                },
              ),                                                                                 
            ])));
  }
}
