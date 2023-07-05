import 'dart:developer';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:dirise/widgets/common_colour.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import '../repoistery/common_repo.dart';
import '../routers/my_routers.dart';
import '../utils/ApiConstant.dart';
import '../widgets/common_button.dart';
import '../widgets/common_textfield.dart';

class CreateAcc extends StatefulWidget {
  const CreateAcc({Key? key}) : super(key: key);

  @override
  State<CreateAcc> createState() => _CreateAccState();
}

class _CreateAccState extends State<CreateAcc> {
  final formKey1 = GlobalKey<FormState>();

  // Rx<CommonModel>model<CommonModel>;

  TextEditingController nameController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  registerApi() {

      registerRepo(
           name: nameController.text,
           email: emailController.text,
        phone: mobileNumberController.text,
        password: passwordController.text,
              )
          .then((value) {
        log(value.message.toString());
        if (value.status == true) {

           Get.toNamed(MyRouters.otpScreen,arguments: [emailController.text]);
        }else{
          showToast(value.message.toString());

        }
        showToast(value.message.toString());
      });

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
          icon: const Icon(Icons.arrow_back_ios,
              color: Color(0xff014E70), size: 20),
          onPressed: () => Navigator.of(context).pop(),
        ),
        titleSpacing: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Create Account",
              style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 22),
            ),
          ],
        ),
      ),
      body: Form(key:formKey1 ,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 15),
                  child: Image(
                      height: 70,
                      image: AssetImage('assets/images/diriselogo.png')),
                ),
                SizedBox(
                  height: size.height * .08,
                ),
                CommonTextfield(
                    controller: nameController,
                    obSecure: false,
                    hintText: 'Name',
                  validator: MultiValidator([
                    RequiredValidator(errorText: 'name is required'),
                  ])),
                SizedBox(
                  height: size.height * .01,
                ),
                CommonTextfield(
                    controller: emailController,
                    obSecure: false,
                    hintText: 'Email',
                  validator: MultiValidator([
                    RequiredValidator(errorText: 'email is required'),
                  ]),),
                SizedBox(
                  height: size.height * .01,
                ),
                CommonTextfield(
                    controller: passwordController,
                    obSecure: false,
                    hintText: 'Password',
                  validator: MultiValidator([
                    RequiredValidator(errorText: 'password is required'),
                    MinLengthValidator(8,
                        errorText:
                        'Password must be at least 8 digits long')

                  ]),),
                SizedBox(
                  height: size.height * .01,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 56,

                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: AppTheme.secondaryColor),
                            borderRadius: BorderRadius.circular(8)),
                        child: const Center(
                          child: CountryCodePicker(
                            onChanged: print,
                            initialSelection: 'IT',
                            favorite: [' +39', 'FR'],
                            showCountryOnly: false,
                            showOnlyCountryWhenClosed: false,
                            alignLeft: false,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(
                      width: 15,
                    ),
                    Flexible(
                        flex: 3,
                        child: CommonTextfield(
                            controller: mobileNumberController,
                            obSecure: false,

                            hintText: '987-654-3210',
                          keyboardType: TextInputType.phone,
                          validator: MultiValidator([
                            RequiredValidator(errorText: 'phone no is required'),
                            MinLengthValidator(10,
                                errorText:
                                'phone no must be at least 10 digits long')
                          ]),)),
                  ],
                ),
                SizedBox(
                  height: size.height * .03,
                ),
                CustomOutlineButton(
                  title: "Create Account",
                  onPressed: () {
                    if(formKey1.currentState!.validate()){
                      registerApi();
                    }


                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
