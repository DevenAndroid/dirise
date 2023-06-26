import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/common_button.dart';
import '../widgets/common_textfield.dart';

class NewPassword extends StatefulWidget {
  const NewPassword({Key? key}) : super(key: key);

  @override
  State<NewPassword> createState() => _NewPasswordState();
}

class _NewPasswordState extends State<NewPassword> {
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

              Padding(
                padding: EdgeInsets.only(top: 20),
                child: Image(
                    height: 170, image: AssetImage('assets/images/logo.png')),
              ),
              SizedBox(
                height: size.height * .03,
              ),
              CommonTextfield(obSecure: false, hintText: 'New Password'),
              SizedBox(
                height: size.height * .01,
              ),
              CommonTextfield(obSecure: false, hintText: 'Confirm New Password'),
              SizedBox(
                height: size.height * .03,
              ),
              CustomOutlineButton(
                title: "Continue",
                onPressed: () {},
              ),
            ])));
  }
}
