import 'package:dirise/routers/my_routers.dart';
import 'package:dirise/widgets/common_colour.dart';
import 'package:dirise/widgets/common_textfield.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:google_fonts/google_fonts.dart';

import '../widgets/common_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 50),
                child: Image(
                    height: 170, image: AssetImage('assets/images/logo.png')),
              ),
              SizedBox(
                height: size.height * .04,
              ),
              CommonTextfield(obSecure: false, hintText: 'Email'),
              SizedBox(
                height: size.height * .01,
              ),
              CommonTextfield(obSecure: false, hintText: 'Password'),
              const SizedBox(
                height: 35,
              ),
              CustomOutlineButton(
                title: "Sign In",

                onPressed: (){
 Get.toNamed(MyRouters.bottomNavBar);
                },
              ),
              SizedBox(
                height: size.height * .02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      Get.toNamed(MyRouters.forgetPassword);
                    },
                    child: Text(
                      'Forget Password?',
                      style: GoogleFonts.poppins(fontSize: 16,fontWeight: FontWeight.w500),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Get.toNamed(MyRouters.createAccScreen);
                    },
                    child: Text(
                      'Sign Up',
                      style: GoogleFonts.poppins(fontSize: 16,fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 25,
              ),
              Row(
                children: [
                  const Expanded(
                    child: Divider(
                        height: 20,
                        thickness: 1,
                        indent: 5,
                        endIndent: 5,
                        color: Color(
                          0xffDCDCDC,
                        )),
                  ),
                  InkWell(
                    onTap: () {
                      print("Sign In");
                    },
                    child: Text(
                      'Or Sign in with',
                      style: GoogleFonts.poppins(color: AppTheme.buttonColor),
                    ),
                  ),
                  const Expanded(
                    child: Divider(
                        height: 20,
                        thickness: 1,
                        indent: 5,
                        endIndent: 5,
                        color: Color(
                          0xffDCDCDC,
                        )),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {},
                    child: Container(
                      height: 58,
                      width: 58,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.black,
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.apple,
                          color: Colors.white,
                          size: 35,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  InkWell(
                    child: Container(
                      height: 58,
                      width: 58,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: const Color(0xffCACACA))),
                      child: Center(
                        child: Image.asset(
                          'assets/icons/google.png',
                          height: 27,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  InkWell(
                    child: Container(
                      height: 58,
                      width: 58,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color(0xff0B60A8)),
                      child: Center(
                        child: Image.asset(
                          'assets/icons/facebook.png',
                          height: 27,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
