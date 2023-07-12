import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:dirise/routers/my_routers.dart';
import 'package:dirise/widgets/common_colour.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../model/common_modal.dart';
import '../utils/ApiConstant.dart';
import '../utils/helper.dart';
import '../widgets/common_button.dart';
import '../widgets/common_textfield.dart';
import 'otp_screen.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final emailController = TextEditingController();

  Future<ModelCommonResponse> forgotPasswordRepo({email, context}) async {
    OverlayEntry loader = Helpers.overlayLoader(context);
    Overlay.of(context).insert(loader);
    var map = <String, dynamic>{};
    map['email'] = email;
    var header = {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.acceptHeader: "application/json",
    };
    final response = await http.post(Uri.parse(ApiUrls.forgotPasswordUrl), body: jsonEncode(map), headers: header);
    if (response.statusCode == 200 || response.statusCode == 400) {
      log(response.body);
      Helpers.hideLoader(loader);
      return ModelCommonResponse.fromJson(jsonDecode(response.body));
    } else {
      Helpers.hideLoader(loader);
      throw Exception(response.body);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Color(0xff014E70), size: 20),
            onPressed: () => Navigator.of(context).pop(),
          ),
          titleSpacing: 0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Forgot Password",
                style: GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 22),
              ),
            ],
          ),
        ),
        body: Padding(
            padding: const EdgeInsets.only(left: 13, right: 13),
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8, top: 10),
                child: Text(
                  'Enter the email address associated with your account',
                  style: GoogleFonts.poppins(color: AppTheme.buttonColor, fontSize: 18),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: size.height * .05,
              ),
              CommonTextfield(controller: emailController, obSecure: false, hintText: 'Email'),
              SizedBox(
                height: size.height * .03,
              ),
              CustomOutlineButton(
                title: "Send Otp",
                onPressed: () {
                  forgotPasswordRepo(email: emailController.text, context: context).then((value) {
                    if (value.status == true) {
                      showToast(value.message.toString());
                      Get.toNamed(OtpScreen.route, arguments: [emailController.text, false]);
                    } else {
                      showToast(value.message.toString());
                    }
                  });
                },
              ),
            ])));
  }
}
