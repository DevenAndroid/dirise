import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dirise/routers/my_routers.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;

import '../model/common_modal.dart';
import '../utils/ApiConstant.dart';
import '../utils/helper.dart';
import '../widgets/common_button.dart';
import '../widgets/common_textfield.dart';
import 'login_screen.dart';

class NewPassword extends StatefulWidget {
  const NewPassword({Key? key}) : super(key: key);

  @override
  State<NewPassword> createState() => _NewPasswordState();
}

class _NewPasswordState extends State<NewPassword> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  String email = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    email = Get.arguments[0];
  }

  Future<CommonModel> changePasswordRepo({password, email, context}) async {
    OverlayEntry loader = Helpers.overlayLoader(context);
    Overlay.of(context).insert(loader);
    var map = <String, dynamic>{};
    map['password'] = password;
    map['email'] = email;
    var header = {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.acceptHeader: "application/json",
    };
    final response = await http.post(Uri.parse(ApiUrls.changePasswordUrl), body: jsonEncode(map), headers: header);
    if (response.statusCode == 200 || response.statusCode == 400) {
      log(response.body);
      Helpers.hideLoader(loader);
      return CommonModel.fromJson(jsonDecode(response.body));
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
        body: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Padding(
                padding: const EdgeInsets.only(left: 13, right: 13),
                child: Column(children: [
                  const SizedBox(
                    height: 35,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 50),
                    child: Image(height: 80, image: AssetImage('assets/images/diriselogo.png')),
                  ),
                  SizedBox(
                    height: size.height * .08,
                  ),
                  CommonTextfield(
                    controller: passwordController,
                    obSecure: false,
                    hintText: 'New Password',
                    validator: MultiValidator([
                      RequiredValidator(errorText: "password in required"),
                      MinLengthValidator(8, errorText: "password must be 8 digits long")
                    ]),
                  ),
                  SizedBox(
                    height: size.height * .01,
                  ),
                  CommonTextfield(
                    controller: newPasswordController,
                    obSecure: false,
                    hintText: 'Confirm New Password',
                    validator: (value) {
                      if (value!.trim().isEmpty) {
                        return 'Conform password is required ';
                      } else if (value!.trim() != passwordController.text.trim()) {
                        return 'Conform password not matching';
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(
                    height: size.height * .03,
                  ),
                  CustomOutlineButton(
                    title: "Continue",
                    onPressed: () {
                      print(email);
                      if (formKey.currentState!.validate()) {
                        changePasswordRepo(password: passwordController.text, email: email, context: context)
                            .then((value) {
                          if (value.status == true) {
                            showToast(value.message.toString());
                            Get.offNamed(LoginScreen.route);
                          } else {
                            showToast(value.message.toString());
                          }
                        });
                      }
                    },
                  ),
                ])),
          ),
        ));
  }
}
