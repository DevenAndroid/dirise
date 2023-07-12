import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

// import 'package:image_picker/image_picker.dart';

import '../model/profile_model.dart';
import '../utils/helper.dart';
import '../widgets/common_colour.dart';
import '../widgets/common_textfield.dart';
import '../widgets/dimension_screen.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Rx<profileModel> getProfile = profileModel().obs;
  RxList<File> imageList = <File>[].obs;
  File image = File("");

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemporary = File(image.path);
      setState(() {
        this.image = imageTemporary;
      });
    } on PlatformException catch (e) {
      print('Field to pick img : $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
                                  imageUrl: getProfile.value.user!.profileImage.toString(),
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
                CommonTextfield(obSecure: false, hintText: 'Williams jones',    controller: nameController,),
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
                CommonTextfield(obSecure: false, hintText: 'williamsjones@gmail.com',    controller: emailController,),
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
                CommonTextfield(obSecure: false, hintText: '+91 987-654-3210',    controller: mobileController,),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Address',
                  style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 10,
                ),
                CommonTextfield(obSecure: false, hintText: 'Riverside Building, County hall,',controller: addressController),
                SizedBox(
                  height: size.height * .3,
                ),
                SizedBox(
                  width: double.infinity,
                  height: size.height * .07,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.buttonColor,
                        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                        textStyle: const TextStyle(
                          fontWeight: FontWeight.bold,
                        )),
                    onPressed: () {},
                    child: Text(
                      'Save',
                      style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white),
                    ),
                  ),
                ),
              ]),
            ),
          ),
        ));
  }
}
