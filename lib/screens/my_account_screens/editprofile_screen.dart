import 'dart:convert';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dirise/model/common_modal.dart';
import 'package:dirise/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import '../../controller/profile_controller.dart';
import '../../repository/repository.dart';
import '../../utils/ApiConstant.dart';
import '../../widgets/common_colour.dart';
import '../../widgets/common_textfield.dart';

class EditProfileScreen extends StatefulWidget {
  static String route = "/EditProfileScreen";
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final profileController = Get.put(ProfileController());
  final Repositories repositories = Repositories();
  File image = File("");
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  // final TextEditingController addressController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future pickImage() async {
    try {
      final image1 = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image1 == null) return;
      setState(() {
        image = File(image1.path);
      });
    } on PlatformException {
      return;
    }
  }

  updateProfile() {
    if (_formKey.currentState!.validate()) {
      Map map = <String, String>{};
      map['name'] = nameController.text.trim();
      map['email'] = emailController.text.trim();
      map['phone'] = phoneController.text.trim();
      map['password'] = passwordController.text.trim();

      repositories
          .multiPartApi(mapData: map, images: {"profile": image}, url: ApiUrls.updateProfile, context: context,onProgress: (gg,kk){})
          .then((value) {
        ModelCommonResponse response = ModelCommonResponse.fromJson(jsonDecode(value));
        showToast(response.message.toString());
        if (response.status == true) {
          profileController.getDataProfile();
          Get.back();
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();
    nameController.text = profileController.model.user!.name.toString();
    emailController.text = profileController.model.user!.email.toString();
    phoneController.text = profileController.model.user!.phone.toString();
    // addressController.text = profileController.model.user!.address.toString();
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    // addressController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit profile',
          style: GoogleFonts.poppins(color: Colors.white, fontSize: 20),
        ),
        centerTitle: true,
        backgroundColor: AppTheme.buttonColor,
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Form(
            key: _formKey,
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: AppTheme.primaryColor)),
                child: Center(
                  child: InkWell(
                    onTap: () => pickImage(),
                    child: image.path != ""
                        ? ClipOval(
                            child: Image.file(
                              image,
                              width: 120,
                              height: 120,
                              fit: BoxFit.cover,
                            ),
                          )
                        : Container(
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(100)),
                              color: AppTheme.primaryColor,
                            ),
                            child: ClipOval(
                              child: CachedNetworkImage(
                                width: 120,
                                height: 120,
                                fit: BoxFit.cover,
                                imageUrl: profileController.model.user!.profileImage.toString(),
                                placeholder: (context, url) => const SizedBox(),
                                errorWidget: (context, url, error) => const SizedBox(),
                              ),
                            ),
                          ),
                  ),
                ),
              ),
              Text(
                'Name',
                style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 10,
              ),
              CommonTextfield(
                obSecure: false,
                hintText: 'Enter Name',
                controller: nameController,
                validator: (v){
                  if(v!.trim().isEmpty){
                    return "Please enter your name";
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Email',
                style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 10,
              ),
              CommonTextfield(
                obSecure: false,
                hintText: 'example@gmail.com',
                readOnly: true,
                controller: emailController,
                validator: (v){
                  if(v!.trim().isEmpty){
                    return "Please enter your email address";
                  }
                  if(v.trim().isValidEmail){
                    return "Please enter valid email address";
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Mobile number',
                style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 10,
              ),
              CommonTextfield(
                obSecure: false,
                hintText: 'Enter Phone Number',
                controller: phoneController,
                validator: (v){
                  if(v!.trim().isEmpty){
                    return "Please enter phone number";
                  }
                  if(v.trim().length < 10){
                    return "Please enter valid phone number";
                  }
                  return null;
                },
              ),
            ]),
          ),
        ),
      ),
      bottomNavigationBar: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14).copyWith(bottom: 12),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.buttonColor,
                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                textStyle: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                )),
            onPressed: () {
              updateProfile();
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                'Save',
                style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
