import 'dart:convert';

import 'package:dirise/language/app_strings.dart';
import 'package:dirise/widgets/common_button.dart';
import 'package:dirise/widgets/common_colour.dart';
import 'package:dirise/widgets/customsize.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import '../../model/aboutus_model.dart';
import '../../repository/repository.dart';
import '../../utils/api_constant.dart';
import '../../widgets/common_textfield.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({Key? key}) : super(key: key);
  static String route = "/contactUsScreen";

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  // Rx<AboutUsmodel> aboutusModal = AboutUsmodel().obs;
  // Future aboutUsData() async {
  //   Map<String, dynamic> map = {};
  //   map["id"] = 12;
  //   repositories.postApi(url: ApiUrls.aboutUsUrl, mapData: map).then((value) {
  //     aboutusModal.value = AboutUsmodel.fromJson(jsonDecode(value));
  //   });
  // }
  //
  // final Repositories repositories = Repositories();
  //
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   aboutUsData();
  // }

   TextEditingController nameController = TextEditingController();
   TextEditingController emailController = TextEditingController();
   TextEditingController phoneController = TextEditingController();
   TextEditingController companyController = TextEditingController();
   TextEditingController messageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(60),
            child: SafeArea(
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios, color: Color(0xff014E70), size: 20),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  Text(
                    AppStrings.contactUs,
                    style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600),
                  )
                ],
              ),
            )),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: Get.width,
                padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 25),
                decoration: BoxDecoration(color: Colors.white, boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF5F5F5F).withOpacity(0.4),
                    offset: const Offset(0.0, 0.5),
                    blurRadius: 2,
                  ),
                ]),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('Drop us a Line',
                    style: GoogleFonts.poppins(
                      color: AppTheme.buttonColor,
                      fontSize: 15,
                      fontWeight: FontWeight.w400
                    ),
                    ),
                    addHeight(5),
                    Text('Get in touch with us',
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.w600
                    ),
                    ),
                    addHeight(20),
                    CommonTextField(
                      hintText: 'Your Name',
                      controller: nameController,
                    ),
                    addHeight(7),
                    CommonTextField(
                      hintText: 'Your Email',
                      controller: nameController,
                    ),
                    addHeight(7),
                    CommonTextField(
                      hintText: 'Phone Number',
                      controller: nameController,
                    ),
                    addHeight(7),
                    CommonTextField(
                      hintText: 'Company',
                      controller: nameController,
                    ),
                    addHeight(7),
                    CommonTextField(
                      hintText: 'Message',
                      controller: nameController,
                      isMulti: true,
                    ),
                    addHeight(10),
                    Container(
                       width: Get.width/2.5,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: AppTheme.buttonColor
                        ),
                      child: Center(
                        child: Text('Send Message',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(color: const Color(0xFFFFFFFF), fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                      ),
                        )
                  ],
                ),
              ),
              addHeight(40),
              Container(
                width: Get.width,
                padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 25),
                decoration: BoxDecoration(color: AppTheme.buttonColor, boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF5F5F5F).withOpacity(0.4),
                    offset: const Offset(0.0, 0.5),
                    blurRadius: 2,
                  ),
                ]),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconColumnRowWidget(
                      iconData: 'assets/icons/phone_icon.svg',
                      title: 'Phone Number',
                      subtitle: '+44 7459 860569',
                    ),
                    addHeight(30),
                    IconColumnRowWidget(
                      iconData: 'assets/icons/Icon ionic-ios-mail.svg',
                      title: 'Support email',
                      subtitle: 'support@dirise.com',
                    ),
                    addHeight(30),
                    IconColumnRowWidget(
                      iconData: 'assets/images/address.svg',
                      title: 'Office Address',
                      subtitle: 'Lorem ipsum dolor sit amet adipiscing elit, sed do.',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}


class IconColumnRowWidget extends StatelessWidget {
  final String iconData;
  final String title;
  final String subtitle;

  IconColumnRowWidget({required this.iconData, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Container with Icon
        Container(
          width: 50,
          padding: const EdgeInsets.all(8.0),
          decoration: const BoxDecoration(
            color: Colors.white
          ),
          child: SvgPicture.asset(
            iconData,
            width: 30,
            height: 30,
            color: AppTheme.buttonColor,
          ),
        ),
        addWidth(20),
        // Column
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w400
                ),
              ),
              addHeight(2),
              Text(
                subtitle,
                style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w500
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
