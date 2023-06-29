import 'package:flutter/material.dart';


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
              const SizedBox(
                height: 35,
              ),

              const Padding(
                padding: EdgeInsets.only(top: 50),
                child: Image(
                    height: 80, image: AssetImage('assets/images/diriselogo.png')),
              ),
              SizedBox(
                height: size.height * .08,
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
