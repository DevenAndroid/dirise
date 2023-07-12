import 'dart:io';

import 'package:dirise/routers/my_routers.dart';
import 'package:dirise/widgets/common_colour.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/helper.dart';
import '../widgets/common_textfield.dart';
import '../widgets/dimension_screen.dart';
import '../widgets/vendor_common_textfield.dart';

class VendorRegistrationScreen extends StatefulWidget {
  const VendorRegistrationScreen({Key? key}) : super(key: key);

   static var registrationScreen = "/registrationScreen";

  @override
  State<VendorRegistrationScreen> createState() => _VendorRegistrationScreenState();
}

class _VendorRegistrationScreenState extends State<VendorRegistrationScreen> {
  String chooseOptionType = "";
  String _ratingController = "vendor";
  final List<String> optionMenu = ["vendor", "ffgsfgs"];

  RxBool showValidation = false.obs;

  bool checkValidation(bool bool1, bool2) {
    if (bool1 == true && bool2 == true) {
      return true;
    } else {
      return false;
    }
  }

  @override
  void initState() {
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();
  double _value = 20;
  final TextEditingController cookNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController ppsController = TextEditingController();

  Rx<File> image1 = File("").obs;
  Rx<File> image2 = File("").obs;

  ScrollController _scrollController = ScrollController();

  scrollNavigation(double offset) {
    _scrollController.animateTo(offset, duration: const Duration(seconds: 1), curve: Curves.easeOutSine);
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xffF4F4F4),
      appBar: AppBar(
        backgroundColor: Color(0xffF4F4F4),
        surfaceTintColor: Colors.white,
        leading: GestureDetector(
          onTap: () {
            Get.back();
            // _scaffoldKey.currentState!.openDrawer();
          },
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Image.asset(
              'assets/icons/backicon.png',
              height: 20,
            ),
          ),
        ),
        title: Text(
          "Vendor Registration",
          style: GoogleFonts.raleway(fontSize: 18, fontWeight: FontWeight.w700, color: const Color(0xff303C5E)),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            color: Colors.white,
            surfaceTintColor: Colors.white,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: AddSize.padding16, vertical: AddSize.padding20),
              child: Column(
                children: [
                  Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    VendorCommonTextfield(
                        obSecure: true,
                        controller: cookNameController,
                        hintText: "Store Name",
                        validator: MultiValidator([RequiredValidator(errorText: 'Store name is required')])),
                    SizedBox(
                      height: height * .007,
                    ),
                    VendorCommonTextfield(
                        obSecure: true,
                        controller: phoneController,
                        hintText: "Phone Number",
                        validator: MultiValidator([RequiredValidator(errorText: 'Store name is required')])),
                    SizedBox(
                      height: height * .007,
                    ),
                    VendorCommonTextfield(
                        obSecure: true,
                        controller: addressController,
                        hintText: "Address",
                        validator: MultiValidator([RequiredValidator(errorText: 'Store name is required')])),
                    SizedBox(
                      height: height * .007,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Container(
                            height: 58,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0), color: Color(0xffE2E2E2).withOpacity(.4)),
                            child: Row(
                              children: [
                                Expanded(
                                  child: DropdownButtonFormField<String>(
                                    icon: Icon(Icons.keyboard_arrow_down),
                                    iconSize: 30,
                                    iconDisabledColor: Color(0xff97949A),
                                    iconEnabledColor: Color(0xff97949A),
                                    value: _ratingController,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      focusedErrorBorder: const OutlineInputBorder(
                                          borderRadius: BorderRadius.all(Radius.circular(8)),
                                          borderSide: BorderSide(color: AppTheme.secondaryColor)),
                                      errorBorder: const OutlineInputBorder(
                                          borderRadius: BorderRadius.all(Radius.circular(8)),
                                          borderSide: BorderSide(color: Color(0xffE2E2E2))),
                                      focusedBorder: const OutlineInputBorder(
                                          borderRadius: BorderRadius.all(Radius.circular(8)),
                                          borderSide: BorderSide(color: AppTheme.secondaryColor)),
                                      disabledBorder: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(8)),
                                        borderSide: BorderSide(color: AppTheme.secondaryColor),
                                      ),
                                      enabledBorder: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(8)),
                                        borderSide: BorderSide(color: AppTheme.secondaryColor),
                                      ),
                                    ),
                                    items: ["vendor", "customer"]
                                        .map((label) => DropdownMenuItem(
                                              child: Text(
                                                label.toString(),
                                                style: GoogleFonts.poppins(
                                                  color: Color(0xff463B57),
                                                ),
                                              ),
                                              value: label,
                                            ))
                                        .toList(),
                                    hint: Text('Rating'),
                                    onChanged: (value) {
                                      setState(() {
                                        _ratingController = value!;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height * .02,
                    ),
                    VendorCommonTextfield(
                        obSecure: true,
                        controller: ppsController,
                        hintText: "Business ID (number)",
                        validator: MultiValidator([RequiredValidator(errorText: 'Store name is required')])),
                    SizedBox(
                      height: height * .007,
                    ),
                    Text(
                      "Store Logo",
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500, color: const Color(0xff2F2F2F), fontSize: AddSize.font18),
                    ),
                    SizedBox(
                      height: height * .02,
                    ),
                    Obx(() {
                      return GestureDetector(
                        onTap: () {
                          NewHelper().addFilePicker().then((value) {
                            image1.value = value;
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: AddSize.padding16, vertical: AddSize.padding16),
                          width: AddSize.screenWidth,
                          height: height * .15,
                          decoration: BoxDecoration(
                              color: Color(0xffE2E2E2).withOpacity(.4),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: !checkValidation(showValidation.value, image1.value.path == "")
                                    ? Colors.grey.shade300
                                    : Colors.red,
                              )),
                          child: image1.value.path == ""
                              ? Column(
                                  children: [
                                    Text(
                                      "Upload",
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w300,
                                          color: const Color(0xff463B57),
                                          fontSize: AddSize.font16),
                                    ),
                                    SizedBox(
                                      height: AddSize.size10,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        NewHelper().addFilePicker().then((value) {
                                          image1.value = value;
                                        });
                                      },
                                      child: Center(
                                          child: Image(
                                              height: AddSize.size50,
                                              width: AddSize.size50,
                                              image: const AssetImage('assets/icons/camera_icon.png'))),
                                    ),
                                  ],
                                )
                              : Stack(
                                  children: [
                                    SizedBox(
                                        width: double.maxFinite,
                                        height: AddSize.size100,
                                        child: Image.file(image1.value)),
                                    Positioned(
                                      right: 0,
                                      top: 0,
                                      child: GestureDetector(
                                        onTap: () {
                                          NewHelper().addFilePicker().then((value) {
                                            image1.value = value;
                                          });
                                        },
                                        child: Container(
                                          height: AddSize.size30,
                                          width: AddSize.size30,
                                          decoration: BoxDecoration(
                                              border: Border.all(width: 1, color: Colors.black12),
                                              color: Colors.green,
                                              borderRadius: BorderRadius.circular(50)),
                                          child: const Center(
                                              child: Icon(
                                            Icons.edit,
                                            color: Colors.black45,
                                            size: 20,
                                          )),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                        ),
                      );
                    }),
                    SizedBox(
                      height: height * .02,
                    ),
                    Text(
                      "Business ID One Image ",
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500, color: const Color(0xff2F2F2F), fontSize: AddSize.font18),
                    ),
                    SizedBox(
                      height: height * .02,
                    ),
                    Obx(() {
                      return GestureDetector(
                        onTap: () {
                          NewHelper().addFilePicker().then((value) {
                            image2.value = value;
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: AddSize.padding16, vertical: AddSize.padding16),
                          width: AddSize.screenWidth,
                          height: height * .15,
                          decoration: BoxDecoration(
                              color: Color(0xffE2E2E2).withOpacity(.4),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: !checkValidation(showValidation.value, image1.value.path == "")
                                    ? Colors.grey.shade300
                                    : Colors.red,
                              )),
                          child: image2.value.path == ""
                              ? Column(
                                  children: [
                                    Text(
                                      "Image",
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w300,
                                          color: const Color(0xff463B57),
                                          fontSize: AddSize.font16),
                                    ),
                                    SizedBox(
                                      height: AddSize.size10,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        NewHelper().addFilePicker().then((value) {
                                          image2.value = value;
                                        });
                                      },
                                      child: Center(
                                          child: Image(
                                              height: AddSize.size50,
                                              width: AddSize.size50,
                                              image: const AssetImage('assets/icons/camera_icon.png'))),
                                    ),
                                  ],
                                )
                              : Stack(
                                  children: [
                                    SizedBox(
                                        width: double.maxFinite,
                                        height: AddSize.size100,
                                        child: Image.file(image2.value)),
                                    Positioned(
                                      right: 0,
                                      top: 0,
                                      child: GestureDetector(
                                        onTap: () {
                                          NewHelper().addFilePicker().then((value) {
                                            image2.value = value;
                                          });
                                        },
                                        child: Container(
                                          height: AddSize.size30,
                                          width: AddSize.size30,
                                          decoration: BoxDecoration(
                                              border: Border.all(width: 1, color: Colors.black12),
                                              color: Colors.green,
                                              borderRadius: BorderRadius.circular(50)),
                                          child: const Center(
                                              child: Icon(
                                            Icons.edit,
                                            color: Colors.black45,
                                            size: 20,
                                          )),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                        ),
                      );
                    }),
                    SizedBox(
                      height: height * .02,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          Get.toNamed(MyRouters.thankUScreen);
                        },
                        style: ElevatedButton.styleFrom(
                            minimumSize: const Size(double.maxFinite, 60),
                            backgroundColor: AppTheme.buttonColor,
                            elevation: 0,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AddSize.size10)),
                            textStyle: TextStyle(fontSize: AddSize.font20, fontWeight: FontWeight.w600)),
                        child: Text(
                          "Submit",
                          style: Theme.of(context)
                              .textTheme
                              .headline5!
                              .copyWith(color: Colors.white, fontWeight: FontWeight.w500, fontSize: AddSize.font18),
                        )),
                  ]),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
