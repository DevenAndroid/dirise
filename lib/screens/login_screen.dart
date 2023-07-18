import 'dart:convert';
import 'dart:io';
import 'package:dirise/routers/my_routers.dart';
import 'package:dirise/utils/ApiConstant.dart';
import 'package:dirise/widgets/common_colour.dart';
import 'package:dirise/widgets/common_textfield.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../model/login_model.dart';
import '../repoistery/repository.dart';
import '../widgets/common_button.dart';
import '../bottomavbar.dart';

class LoginScreen extends StatefulWidget {
  static String route = "/LoginScreen";

  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final loginFormKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final Repositories repositories = Repositories();
  RxBool hide = true.obs;

  //final controller = Get.put(CustomNavigationBarController());

  // signInWithGoogle(context) async {
  //   await GoogleSignIn().signOut();
  //   final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
  //
  //   final GoogleSignInAuthentication googleAuth =
  //   await googleUser!.authentication;
  //
  //   final credential = GoogleAuthProvider.credential(
  //     idToken: googleAuth.idToken,
  //     accessToken: googleAuth.accessToken,
  //   );
  //
  //   socialLoginApi(
  //       context: context, token: googleAuth.accessToken, type: "google");
  //
  //   await FirebaseAuth.instance.signInWithCredential(credential).then((value) {
  //     log(value.toString());
  //   });
  // }
  // socialLoginApi({token, type, context}) {
  //   socialLogin(token, type, context).then((value) async {
  //     LoginModel user = LoginModel();
  //
  //     user.message = value['data']['token'];
  //
  //     if (user.message != null) {
  //       showToast("Logged in successfully");
  //       SharedPreferences pref = await SharedPreferences.getInstance();
  //       pref.setString('user', jsonEncode(user));
  //       log("User Token :: ${pref.getString("user")}");
  //       controller.getUser();
  //       Get.offAllNamed(MyRouters.bottomNavBar);
  //     } else {
  //       showToast(value['message']);
  //     }
  //   });
  // }

  loginUserApi() {
    if (loginFormKey.currentState!.validate()) {
      Map<String, dynamic> map = {};
      map['email'] = emailController.text.trim();
      map['password'] = passwordController.text.trim();
      repositories.postApi(url: ApiUrls.loginUrl, context: context, mapData: map).then((value) async {
        LoginModal response = LoginModal.fromJson(jsonDecode(value));
        repositories.saveLoginDetails(jsonEncode(response));
        showToast(response.message.toString());
        if(response.status == true) {
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
                Obx(() {
                  return CommonTextfield(
                    controller: passwordController,
                    obSecure: hide.value,
                    suffixIcon: IconButton(
                      onPressed: (){
                        hide.value = !hide.value;
                      },
                      icon: hide.value ? const Icon(Icons.visibility) : const Icon(Icons.close),
                    ),
                    hintText: 'Password',
                    validator: MultiValidator([
                      RequiredValidator(errorText: 'Password is required'),
                    ]),
                  );
                }),
                const SizedBox(
                  height: 35,
                ),
                CustomOutlineButton(
                  title: "Sign In",
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
                        Get.toNamed(MyRouters.forgetPassword);
                      },
                      child: Text(
                        'Forgot Password',
                        style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500,color: AppTheme.buttonColor),
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
                            border: Border.all(color: const Color(0xffCACACA), width: 2)),
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
                        decoration:
                            BoxDecoration(borderRadius: BorderRadius.circular(10), color: const Color(0xff0B60A8)),
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
                SizedBox(height: size.height*.07,),
                RichText(
                  text: TextSpan(

                    children: [
                      TextSpan(
                        text: 'Already have an Account? ',
                        style: GoogleFonts.poppins(color: Colors.black),
                      ),
                      TextSpan(text: 'Sign Up',style: GoogleFonts.poppins(fontWeight: FontWeight.w600,color: AppTheme.buttonColor,decoration: TextDecoration.underline),

                          recognizer: TapGestureRecognizer()..onTap = () {
                        Get.toNamed(MyRouters.createAccScreen);

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
