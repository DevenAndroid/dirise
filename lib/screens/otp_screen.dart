import 'package:dirise/routers/my_routers.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';

import '../widgets/common_colour.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({Key? key}) : super(key: key);

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  TextEditingController otpController = TextEditingController();

  @override
  final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
        fontSize: 22,
        color: Color.fromRGBO(30, 60, 87, 1),
      ),
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
        color: Colors.grey.shade300,
        width: 4.0,
      ))));

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: SingleChildScrollView(
          child: SizedBox(
              height: size.height,
              width: size.width,
              child: Stack(children: [
                Container(
                  height: size.height,
                  width: size.width,
                  decoration: const BoxDecoration(color: AppTheme.buttonColor),
                  padding: EdgeInsets.symmetric(
                      horizontal: size.width * .02, vertical: size.height * .06),
                  child: Column(
                    children: [
                      Image.asset(
                          height: size.height * .15, 'assets/images/otplogo.png'),
                      const SizedBox(
                        height: 13,
                      ),
                      Text(
                        'OTP Verification',
                        style: GoogleFonts.poppins(
                            fontSize: 23,
                            fontWeight: FontWeight.w700,
                            color: Colors.white),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        'Enter the OTP Send to Your Email',
                        style: GoogleFonts.poppins(
                            fontSize: 16, color: Colors.white),
                      )
                    ],
                  ),
                ),
                Positioned(
                    top: size.height * .40,
                    right: 0,
                    left: 0,
                    bottom: 0,
                    child: Container(
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(100))),
                      child: Padding(
                        padding:
                            const EdgeInsets.only(top: 60, left: 10, right: 10),
                        child: Column(
                          children: [
                            Pinput(
                              controller: otpController,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              keyboardType: TextInputType.number,
                              length: 4,
                              defaultPinTheme: defaultPinTheme,
                            ),
                            SizedBox(
                              height: size.height * .05,
                            ),
                            Text(
                              "Didn't you receive the OTP?",
                              style: GoogleFonts.poppins(
                                  color: const Color(0xff3D4260), fontSize: 17),
                            ),
                            SizedBox(
                              height: size.height * .03,
                            ),
                            Text(
                              ' Resend OTP',
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w600,
                                  color: const Color(0xff578AE8), fontSize: 16),
                            ),
                            SizedBox(
                              height: size.height * .2,
                            ),
                            SizedBox(
                              width: double.infinity,
                              height: size.height*.075,
                              child: ElevatedButton(


                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: AppTheme.buttonColor,
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(Radius.circular(10))),

                                      textStyle: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      )), onPressed: () {
                                    Get.toNamed(MyRouters.newPasswordScreen);

                              }, child: Text('Verify OTP',style: GoogleFonts.poppins(
                                fontSize: 18,fontWeight: FontWeight.w600,color: Colors.white
                              ),),

                              ),
                            ),
                          ],
                        ),
                      ),
                    ))
              ])),
        ));
  }
}
