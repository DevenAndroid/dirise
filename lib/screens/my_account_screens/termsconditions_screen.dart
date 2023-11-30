import 'dart:convert';

import 'package:dirise/language/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';

import 'package:google_fonts/google_fonts.dart';

import '../../model/aboutus_model.dart';
import '../../repository/repository.dart';
import '../../utils/api_constant.dart';

class TermConditionScreen extends StatefulWidget {
  static String route = "/TermConditionScreen";
  const TermConditionScreen({Key? key}) : super(key: key);

  @override
  State<TermConditionScreen> createState() => _TermConditionScreenState();
}

class _TermConditionScreenState extends State<TermConditionScreen> {
  Rx<AboutUsmodel> aboutusModal = AboutUsmodel().obs;
  Future aboutUsData() async {
    Map<String, dynamic> map = {};
    map["id"] = 9;
    repositories.postApi(url: ApiUrls.aboutUsUrl, mapData: map).then((value) {
      aboutusModal.value = AboutUsmodel.fromJson(jsonDecode(value));
    });
  }

  final Repositories repositories = Repositories();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    aboutUsData();
  }

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
                   AppStrings.termsCondition.tr,
                    style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600),
                  )
                ],
              ),
            )),
        body: Obx(() {
          return aboutusModal.value.status == true
              ? SingleChildScrollView(
                  child: Html(data: aboutusModal.value.data!.content!),
                )
              : const Center(
                  child: CircularProgressIndicator(
                  color: Colors.grey,
                ));
        }));
  }
}
