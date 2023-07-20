import 'dart:io';
import 'package:dirise/routers/my_routers.dart';
import 'package:dirise/widgets/common_colour.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/helper.dart';
import '../widgets/dimension_screen.dart';
import '../widgets/vendor_common_textfield.dart';

class VendorRegistrationScreen extends StatefulWidget {
  const VendorRegistrationScreen({Key? key}) : super(key: key);

  static var registrationScreen = "/registrationScreen";

  @override
  State<VendorRegistrationScreen> createState() => _VendorRegistrationScreenState();
}

class _VendorRegistrationScreenState extends State<VendorRegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  // Define this in TextEditingController Class
  // GlobalKey getKey = GlobalKey();
  //

  final TextEditingController storeNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController ppsController = TextEditingController();

  Rx<File> storeImage = File("").obs;
  Rx<File> businessImage = File("").obs;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF4F4F4),
      appBar: AppBar(
        title: const Text('Vendor Registration',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w600,
              color: Color(0xff423E5E),
            )),
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        leading: GestureDetector(
          onTap: () {
            Get.back();
            // _scaffoldKey.currentState!.openDrawer();
          },
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Image.asset(
              'assets/icons/backicon.png',
              height: 20,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Card(
            color: Colors.white,
            margin: const EdgeInsets.all(8),
            surfaceTintColor: Colors.white,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: AddSize.padding20),
              child: Column(
                children: [
                  Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    VendorCommonTextfield(
                        controller: storeNameController,
                        key: storeNameController.getKey,
                        hintText: "Store Name",
                        validator: (value) {
                          if (value!.trim().isEmpty) {
                            return "Please enter store name";
                          }
                          return null;
                        }),
                    5.spaceY,
                    VendorCommonTextfield(
                        obSecure: true,
                        controller: phoneController,
                        key: phoneController.getKey,
                        hintText: "Phone Number",
                        validator: (value) {
                          if (value!.trim().isEmpty) {
                            return "Please enter store phone number";
                          }
                          if (value.trim().length < 10) {
                            return "Please enter valid store phone number";
                          }
                          return null;
                        }),
                    5.spaceY,
                    VendorCommonTextfield(
                        obSecure: true,
                        controller: addressController,
                        key: addressController.getKey,
                        hintText: "Address",
                        validator: (value) {
                          if (value!.trim().isEmpty) {
                            return "Please enter store address";
                          }
                          return null;
                        }),
                    5.spaceY,
                    DropdownButtonFormField<String>(
                      icon: const Icon(Icons.keyboard_arrow_down),
                      iconSize: 30,
                      iconDisabledColor: const Color(0xff97949A),
                      iconEnabledColor: const Color(0xff97949A),
                      value: null,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        filled: true,
                        fillColor: const Color(0xffE2E2E2).withOpacity(.35),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
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
                                value: label,
                                child: Text(
                                  label.toString(),
                                  style: GoogleFonts.poppins(
                                    color: const Color(0xff463B57),
                                  ),
                                ),
                              ))
                          .toList(),
                      hint: const Text('Category'),
                      onChanged: (value) {},
                      validator: (value) {
                        if (value == null) {
                          return "Please select Category";
                        }
                        return null;
                      },
                    ),
                    10.spaceY,
                    VendorCommonTextfield(
                        obSecure: true,
                        controller: ppsController,
                        hintText: "Business ID (number)",
                        validator: (value) {
                          if (value!.trim().isEmpty) {
                            return "Please enter Business ID (number)";
                          }
                          return null;
                        }),
                    5.spaceY,
                    Text(
                      "Store Logo",
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500, color: const Color(0xff2F2F2F), fontSize: AddSize.font18),
                    ),
                    5.spaceY,
                    Obx(() {
                      return GestureDetector(
                        onTap: () {
                          NewHelper().addFilePicker().then((value) {
                            storeImage.value = value;
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: AddSize.padding16, vertical: AddSize.padding16),
                          width: AddSize.screenWidth,
                          height: context.getSize.width * .38,
                          decoration: BoxDecoration(
                              color: const Color(0xffE2E2E2).withOpacity(.4),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: !checkValidation(showValidation.value, storeImage.value.path == "")
                                    ? Colors.grey.shade300
                                    : Colors.red,
                              )),
                          child: storeImage.value.path == ""
                              ? Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Select Store Logo",
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w500,
                                          color: showValidation.value && storeImage.value.path.isEmpty
                                              ? Theme.of(context).colorScheme.error
                                              : const Color(0xff463B57),
                                          fontSize: AddSize.font16),
                                    ),
                                    SizedBox(
                                      height: AddSize.size10,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: showValidation.value && storeImage.value.path.isEmpty
                                                ? Theme.of(context).colorScheme.error
                                                : Colors.grey,
                                            width: 1.8,
                                          )),
                                      padding: const EdgeInsets.all(6),
                                      child: Icon(
                                        CupertinoIcons.photo_camera,
                                        size: 20,
                                        color: showValidation.value && storeImage.value.path.isEmpty
                                            ? Theme.of(context).colorScheme.error
                                            : Colors.grey,
                                      ),
                                    )
                                  ],
                                )
                              : SizedBox(
                                  width: double.maxFinite,
                                  height: AddSize.size100,
                                  child: Image.file(storeImage.value)),
                        ),
                      );
                    }),
                    12.spaceY,
                    Text(
                      "Business ID One Image ",
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500, color: const Color(0xff2F2F2F), fontSize: AddSize.font18),
                    ),
                    5.spaceY,
                    Obx(() {
                      return GestureDetector(
                        onTap: () {
                          NewHelper().addFilePicker().then((value) {
                            businessImage.value = value;
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: AddSize.padding16, vertical: AddSize.padding16),
                          width: AddSize.screenWidth,
                          height: context.width * .38,
                          decoration: BoxDecoration(
                              color: const Color(0xffE2E2E2).withOpacity(.4),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: !checkValidation(showValidation.value, businessImage.value.path == "")
                                    ? Colors.grey.shade300
                                    : Colors.red,
                              )),
                          child: businessImage.value.path == ""
                              ? Column(
                                  children: [
                                    Text(
                                      "Select Business ID Image",
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w500,
                                          color: showValidation.value && businessImage.value.path.isEmpty
                                              ? Theme.of(context).colorScheme.error
                                              : const Color(0xff463B57),
                                          fontSize: AddSize.font16),
                                    ),
                                    SizedBox(
                                      height: AddSize.size10,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: showValidation.value && businessImage.value.path.isEmpty
                                                ? Theme.of(context).colorScheme.error
                                                : Colors.grey,
                                            width: 1.8,
                                          )),
                                      padding: const EdgeInsets.all(6),
                                      child: Icon(
                                        CupertinoIcons.photo_camera,
                                        size: 20,
                                        color: showValidation.value && businessImage.value.path.isEmpty
                                            ? Theme.of(context).colorScheme.error
                                            : Colors.grey,
                                      ),
                                    )
                                  ],
                                )
                              : Stack(
                                  children: [
                                    SizedBox(
                                        width: double.maxFinite,
                                        height: AddSize.size100,
                                        child: Image.file(businessImage.value)),
                                    Positioned(
                                      right: 0,
                                      top: 0,
                                      child: GestureDetector(
                                        onTap: () {
                                          NewHelper().addFilePicker().then((value) {
                                            businessImage.value = value;
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
                    12.spaceY,
                    ElevatedButton(
                        onPressed: () {
                          showValidation.value = true;
                          if (!_formKey.currentState!.validate()) {
                            if (storeNameController.text.trim().isEmpty) {
                              Scrollable.ensureVisible(storeNameController.getKey.currentContext!,
                                  alignment: .5,
                                  duration: const Duration(milliseconds: 600));
                              return;
                            }
                            if (phoneController.text.trim().isEmpty) {
                              Scrollable.ensureVisible(phoneController.getKey.currentContext!,
                                  alignment: .5,
                                  duration: const Duration(milliseconds: 600));
                              return;
                            }
                            if (addressController.text.trim().isEmpty) {
                              Scrollable.ensureVisible(addressController.getKey.currentContext!,
                                  alignment: .5,
                                  duration: const Duration(milliseconds: 600));
                              return;
                            }
                            return;
                          }
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
                              .headlineSmall!
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
