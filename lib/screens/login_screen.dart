import 'dart:convert';
import 'package:dirise/routers/my_routers.dart';
import 'package:dirise/widgets/common_colour.dart';
import 'package:dirise/widgets/common_textfield.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:shared_preferences/shared_preferences.dart';
import '../controller/customnavigationbar_controller.dart';
import '../repoistery/login_repo.dart';
import '../widgets/common_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final loginFormKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  //final controller = Get.put(CustomNavigationBarController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: loginFormKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 100),
                  child: Image(
                      height: 70,
                      image: AssetImage(
                        'assets/images/diriselogo.png',
                      )),
                ),
                SizedBox(
                  height: size.height * .1,
                ),
                CommonTextfield(
                  controller: emailController,
                  obSecure: false,
                  hintText: 'Email or Phone number',
                  validator: (value) {
                    if (emailController.text.isEmpty) {
                      return "Please enter your email";
                    } else if (emailController.text.contains('+') || emailController.text.contains(' ')) {
                      return "Email is invalid";
                    } else if (RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(emailController.text)) {
                      return null;
                    } else {
                      return 'Please type a valid email address';
                    }
                  },
                ),
                SizedBox(
                  height: size.height * .01,
                ),
                CommonTextfield(
                  controller: passwordController,
                  obSecure: false,
                  hintText: 'Password',
                  validator: MultiValidator([
                    RequiredValidator(errorText: 'password is required'),
                  ]),
                ),
                const SizedBox(
                  height: 35,
                ),
                CustomOutlineButton(
                  title: "Sign In",
                  onPressed: () {
                    Get.offAllNamed(MyRouters.bottomNavBar);
                    if (loginFormKey.currentState!.validate()) {
                      loginRepo(emailController.text, passwordController.text,
                              context)
                          .then((value) async {
                        if (value.status == true) {
                          Get.offAllNamed(MyRouters.bottomNavBar);
                          SharedPreferences pref =
                              await SharedPreferences.getInstance();
                          pref.setString('user', jsonEncode(value));
                          if (kDebugMode) {
                            print("User Token :: ${pref.getString("user")}");
                          }
                          //controller.getUser();

                        }
                      });
                    }
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
                        style: GoogleFonts.poppins(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Get.toNamed(MyRouters.createAccScreen);
                      },
                      child: Text(
                        'Sign Up',
                        style: GoogleFonts.poppins(
                            fontSize: 16, fontWeight: FontWeight.w500),
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
                      onTap: () {},
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
                        height: 62,
                        width: 62,
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
                        height: 62,
                        width: 62,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                color: const Color(0xffCACACA), width: 2)),
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
                        height: 62,
                        width: 62,
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
      ),
    );
  }
}
