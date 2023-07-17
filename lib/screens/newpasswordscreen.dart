import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../model/common_modal.dart';
import '../utils/ApiConstant.dart';
import '../utils/helper.dart';
import '../widgets/common_button.dart';
import '../widgets/common_textfield.dart';
import '../bottomavbar.dart';
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
  RxBool hide1 = true.obs;
  RxBool hide2 = true.obs;
  @override
  void initState() {
    super.initState();
    email = Get.arguments[0];
  }

  Future<ModelCommonResponse> changePasswordRepo({password, email, context}) async {
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
                  Obx(() {
                    return CommonTextfield(
                      controller: passwordController,
                      obSecure: hide1.value,
                      suffixIcon: IconButton(
                        onPressed: (){
                          hide1.value = !hide1.value;
                        },
                        icon: hide1.value ? const Icon(Icons.visibility) : const Icon(Icons.close),
                      ),
                      hintText: 'New Password',
                      validator: MultiValidator([
                        RequiredValidator(errorText: "Password in required"),
                        MinLengthValidator(8, errorText: "Password must be 8 digits long")
                      ]),
                    );
                  }),
                  SizedBox(
                    height: size.height * .01,
                  ),
                  Obx(() {
                    return CommonTextfield(
                    controller: newPasswordController,
                    obSecure: hide2.value,
                    suffixIcon: IconButton(
                      onPressed: (){
                        hide2.value = !hide2.value;
                      },
                      icon: hide2.value ? const Icon(Icons.visibility) : const Icon(Icons.close),
                    ),
                    hintText: 'Confirm New Password',
                    validator: (value) {
                      if (value!.trim().isEmpty) {
                        return 'Conform password is required ';
                      } else if (value.trim() != passwordController.text.trim()) {
                        return 'Conform password not matching';
                      } else {
                        return null;
                      }
                    },
                    );
                  }),
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
                            Get.offNamed(BottomNavbar.route);
                            Get.toNamed(LoginScreen.route);
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
