import 'dart:convert';
import 'package:dirise/widgets/common_colour.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../model/common_modal.dart';
import '../../repoistery/repository.dart';
import '../../routers/my_routers.dart';
import '../../utils/ApiConstant.dart';
import '../../widgets/common_button.dart';
import '../../widgets/common_textfield.dart';
import 'otp_screen.dart';

class CreateAccountScreen extends StatefulWidget {
  static String route = "/CreateAccountScreen";
  const CreateAccountScreen({Key? key}) : super(key: key);

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  final formKey1 = GlobalKey<FormState>();

  // final TextEditingController _nameController = TextEditingController();
  RxBool hide = true.obs;
  RxBool hide1 = true.obs;
  final TextEditingController _mobileNumberController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final Repositories repositories = Repositories();
  bool showValidation = false;
  bool? _isValue = false;

  registerApi() {
    if (_isValue == false) return;
    Map<String, dynamic> map = {};
    map['email'] = _emailController.text.trim();
    // map['name'] = _nameController.text.trim();
    map['phone'] = _mobileNumberController.text.trim();
    map['password'] = _passwordController.text.trim();
    repositories.postApi(url: ApiUrls.signInUrl, context: context, mapData: map).then((value) {
      ModelCommonResponse response = ModelCommonResponse.fromJson(jsonDecode(value));
      showToast(response.message.toString());
      if (response.status == true) {
        Get.toNamed(OtpScreen.route, arguments: [_emailController.text, true,map]);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    // _nameController.dispose();
    _mobileNumberController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
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
              "Create Account",
              style: GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 22),
            ),
          ],
        ),
      ),
      body: Form(
        key: formKey1,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 15),
                  child: Image(height: 70, image: AssetImage('assets/images/diriselogo.png')),
                ),
                SizedBox(
                  height: size.height * .08,
                ),
                CommonTextfield(
                    controller: _emailController,
                    obSecure: false,
                    // hintText: 'Name',
                    hintText: 'Email',
                    validator: MultiValidator([
                      RequiredValidator(errorText: 'Email is required'),
                      EmailValidator(errorText: 'Please enter valid email address'),
                    ])),
                SizedBox(
                  height: size.height * .01,
                ),
                Obx(() {
                  return CommonTextfield(
                    controller: _passwordController,
                    hintText: 'Password',
                    obSecure: hide.value,
                    suffixIcon: IconButton(
                      onPressed: () {
                        hide.value = !hide.value;
                      },
                      icon: hide.value ? const Icon(Icons.visibility_off) : const Icon(Icons.visibility),
                    ),
                    validator: MultiValidator([
                      RequiredValidator(errorText: 'Password is required'),
                      MinLengthValidator(8, errorText: 'Password must be at least 8 digits long')
                    ]),
                  );
                }),
                SizedBox(
                  height: size.height * .01,
                ),
                Obx(() {
                  return CommonTextfield(
                    // controller: _passwordController,
                    // hintText: 'Password',
                    obSecure: hide1.value,
                    suffixIcon: IconButton(
                      onPressed: () {
                        hide1.value = !hide1.value;
                      },
                      icon: hide1.value ? const Icon(Icons.visibility_off) : const Icon(Icons.visibility),
                    ),
                    hintText: 'Confirm Password',
                    validator: (value) {
                      if (value!.trim().isEmpty) {
                        return "Please enter confirm password";
                      }
                      if (value.trim() != _passwordController.text.trim()) {
                        return "Confirm password is not matching";
                      }
                      return null;
                    },
                  );
                }),
                SizedBox(
                  height: size.height * .01,
                ),
                Row(
                  children: [
                    Transform.translate(
                      offset: const Offset(-6, 0),
                      child: Checkbox(
                          visualDensity: const VisualDensity(horizontal: -1, vertical: -3),
                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                          value: _isValue,
                          side: BorderSide(
                            color: showValidation == false ? AppTheme.buttonColor : Colors.red,
                          ),
                          onChanged: (bool? value) {
                            setState(() {
                              _isValue = value;
                            });
                          }),
                    ),
                    Expanded(
                      child: Text(
                        "Privacy policy",
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500, fontSize: 15, color: const Color(0xff808384)),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: size.height * .03,
                ),
                CustomOutlineButton(
                  title: "Create Account",
                  onPressed: () {
                    showValidation = true;
                    if (formKey1.currentState!.validate()) {
                      registerApi();
                    }
                    setState(() {});
                  },
                ),
                SizedBox(
                  height: size.height * .02,
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Already have an Account? ',
                        style: GoogleFonts.poppins(color: Colors.black),
                      ),
                      TextSpan(
                        text: 'Login',
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                            color: AppTheme.buttonColor,
                            decoration: TextDecoration.underline),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                          Get.back();
                          },
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
