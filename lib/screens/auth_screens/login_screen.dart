import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dirise/language/app_strings.dart';
import 'package:dirise/widgets/common_colour.dart';
import 'package:dirise/widgets/common_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../controller/profile_controller.dart';
import '../../model/login_model.dart';
import '../../model/social_login_model.dart';
import '../../repository/repository.dart';
import '../../repository/social_login.dart';
import '../../routers/my_routers.dart';
import '../../utils/api_constant.dart';
import '../../widgets/common_button.dart';
import '../../bottomavbar.dart';
import 'createacc_screen.dart';
import 'forgetpass_screen.dart';

class LoginScreen extends StatefulWidget {
  static String route = "/LoginScreen";

  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final loginFormKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final Repositories repositories = Repositories();
  final profileController = Get.put(ProfileController());
  RxBool hide = true.obs;
  String? token = "";
  loginUserApi()  async {
    String? token1 = await FirebaseMessaging.instance.getAPNSToken();
    String? token = await FirebaseMessaging.instance.getToken();
    if (loginFormKey.currentState!.validate()) {
// if(Platform.isIOS){
//   String? token = await FirebaseMessaging.instance.getAPNSToken();
// }
// if(Platform.isAndroid){
//   String? token = await FirebaseMessaging.instance.getAPNSToken();
// }


      Map<String, dynamic> map = {};
      map['email'] = emailController.text.trim();
      map['password'] = passwordController.text.trim();
      map['fcm_token'] = Platform.isAndroid?token:token1;
      repositories.postApi(url: ApiUrls.loginUrl, context: context, mapData: map).then((value) async {
        LoginModal response = LoginModal.fromJson(jsonDecode(value));
        repositories.saveLoginDetails(jsonEncode(response));
        showToast(response.message.toString());
        if (response.status == true) {
          Get.offAllNamed(BottomNavbar.route);
        }
      });
    }
  }

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
                CommonTextField(
                  controller: emailController,
                  obSecure: false,
                  hintText: AppStrings.phoneNumber.tr,
                  validator: (value) {
                    if (value!.trim().isEmpty) {
                      return "Please enter your email".tr;
                    } else if (value.trim().contains('+') || value.trim().contains(' ')) {
                      return "Email is invalid";
                    } else if (RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(value.trim())) {
                      return null;
                    } else {
                      return 'Please type a valid email address'.tr;
                    }
                  },
                ),
                SizedBox(
                  height: size.height * .01,
                ),
                Obx(() {
                  return CommonTextField(
                    controller: passwordController,
                    obSecure: hide.value,
                    suffixIcon: IconButton(
                      onPressed: () {
                        hide.value = !hide.value;
                      },
                      icon: hide.value ? const Icon(Icons.visibility_off) : const Icon(Icons.visibility),
                    ),
                    hintText: AppStrings.password.tr,
                    validator: (value) {
                      if (value!.trim().isEmpty) return AppStrings.passwordRequired.tr;
                      return null;
                    },
                  );
                }),
                const SizedBox(
                  height: 35,
                ),
                CustomOutlineButton(
                  title: AppStrings.signIn.tr,
                  onPressed: () {
                    loginUserApi();
                  },
                ),
                SizedBox(
                  height: size.height * .02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () {
                        Get.toNamed(ForgetPasswordScreen.route);
                      },
                      child: Text(
                        AppStrings.forgotPassword.tr,
                        style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500, color: AppTheme.buttonColor),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 25,
                ),
                // Row(
                //   children: [
                //     const Expanded(
                //       child: Divider(
                //           height: 20,
                //           thickness: 1,
                //           indent: 5,
                //           endIndent: 5,
                //           color: Color(
                //             0xffDCDCDC,
                //           )),
                //     ),
                //     InkWell(
                //       onTap: () {},
                //       child: Text(
                //         AppStrings.signInWith.tr,
                //         style: GoogleFonts.poppins(color: AppTheme.buttonColor),
                //       ),
                //     ),
                //     const Expanded(
                //       child: Divider(
                //           height: 20,
                //           thickness: 1,
                //           indent: 5,
                //           endIndent: 5,
                //           color: Color(
                //             0xffDCDCDC,
                //           )),
                //     ),
                //   ],
                // ),
                // const SizedBox(
                //   height: 30,
                // ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     if(Platform.isIOS)
                //     InkWell(
                //       onTap: () {},
                //       child: Container(
                //         height: 62,
                //         width: 62,
                //         decoration: BoxDecoration(
                //           borderRadius: BorderRadius.circular(10),
                //           color: Colors.black,
                //         ),
                //         child: const Center(
                //           child: Icon(
                //             Icons.apple,
                //             color: Colors.white,
                //             size: 35,
                //           ),
                //         ),
                //       ),
                //     ),
                //     const SizedBox(
                //       width: 20,
                //     ),
                //     InkWell(
                //       onTap: (){
                //         signInWithGoogle();
                //       },
                //       child: Container(
                //         height: 62,
                //         width: 62,
                //         decoration: BoxDecoration(
                //             borderRadius: BorderRadius.circular(10),
                //             border: Border.all(color: const Color(0xffCACACA), width: 2)),
                //         child: Center(
                //           child: Image.asset(
                //             'assets/icons/google.png',
                //             height: 27,
                //           ),
                //         ),
                //       ),
                //     ),
                //     // const SizedBox(
                //     //   width: 20,
                //     // ),
                //     // InkWell(
                //     //   child: Container(
                //     //     height: 62,
                //     //     width: 62,
                //     //     decoration:
                //     //         BoxDecoration(borderRadius: BorderRadius.circular(10), color: const Color(0xff0B60A8)),
                //     //     child: Center(
                //     //       child: Image.asset(
                //     //         'assets/icons/facebook.png',
                //     //         height: 27,
                //     //       ),
                //     //     ),
                //     //   ),
                //     // ),
                //   ],
                // ),
                SizedBox(
                  height: size.height * .07,
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text:  AppStrings.noAccount.tr,
                        style: GoogleFonts.poppins(color: Colors.black),
                      ),
                      TextSpan(
                        text: AppStrings.signUp.tr,
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600, color: AppTheme.buttonColor, decoration: TextDecoration.underline),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Get.toNamed(CreateAccountScreen.route);
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
  signInWithGoogle() async {
    await GoogleSignIn().signOut();
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;
    final credential = GoogleAuthProvider.credential(
      idToken: googleAuth.idToken,
      accessToken: googleAuth.accessToken,
    );
    print("Token---------${googleAuth.accessToken}");
    final value = await FirebaseAuth.instance.signInWithCredential(credential);
    log('tokkeeeem${value.credential!.accessToken!}');
    Map<String, dynamic> map = {};
    map['provider'] =  "google";
    map['access_token'] = value.credential!.accessToken!;
    repositories.postApi(url: ApiUrls.socialLoginUrl, context: context, mapData: map).then((value) async {
      LoginModal response = LoginModal.fromJson(jsonDecode(value));
      repositories.saveLoginDetails(jsonEncode(response));
      if (response.status == true) {
        showToast(response.message.toString());
        profileController.userLoggedIn = true;
        Get.offAllNamed(BottomNavbar.route);
      } else {
        showToast(response.message.toString());
      }
    });
    // socialLogin(provider: "google", token: value.credential!.accessToken!, context: context).then((value) async {
    //   if (value.status == true) {
    //     SharedPreferences pref = await SharedPreferences.getInstance();
    //     pref.setString('login_user', jsonEncode(value));
    //     showToast(value.message);
    //     Get.offAllNamed(BottomNavbar.route);
    //   } else {
    //     showToast(value.message);
    //   }
    // });
  }
}
