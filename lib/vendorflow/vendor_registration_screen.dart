import 'dart:convert';
import 'dart:io';
import 'package:dirise/model/common_modal.dart';
import 'package:dirise/repoistery/repository.dart';
import 'package:dirise/widgets/common_colour.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../model/vendor_models/model_vendor_registration.dart';
import '../model/vendor_models/vendor_category_model.dart';
import '../utils/ApiConstant.dart';
import '../utils/helper.dart';
import '../widgets/dimension_screen.dart';
import '../widgets/vendor_common_textfield.dart';
import 'verify_vendor_otp.dart';

class VendorRegistrationScreen extends StatefulWidget {
  const VendorRegistrationScreen({Key? key}) : super(key: key);

  static var registrationScreen = "/registrationScreen";

  @override
  State<VendorRegistrationScreen> createState() => _VendorRegistrationScreenState();
}

class _VendorRegistrationScreenState extends State<VendorRegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final GlobalKey categoryKey = GlobalKey();

  Map<String, TextEditingController> textControllers = {
    "store_name": TextEditingController(),
    "phone": TextEditingController(),
    "email": TextEditingController(),
    "password": TextEditingController(),
    "store_address": TextEditingController(),
    "store_business_id": TextEditingController(),
    "store_about_us": TextEditingController(),
    "store_about_me": TextEditingController(),
  };

  Rx<File> storeImage = File("").obs;
  Rx<File> businessImage = File("").obs;
  RxBool showValidation = false.obs;
  RxBool hideText = true.obs;
  final Repositories repositories = Repositories();
  Rx<RxStatus> vendorCategoryStatus = RxStatus.empty().obs;
  ModelVendorCategory modelVendorCategory = ModelVendorCategory(usphone: []);
  // Usphone? selectedCategory;
  Map<String, Usphone> allSelectedCategory = {};

  void vendorRegistration() {
    showValidation.value = true;
    if (!_formKey.currentState!.validate()) {
      bool inTextFound = false;
      for (var element in textControllers.entries) {
        if (element.value.text.trim().isEmpty) {
          inTextFound = true;
          Scrollable.ensureVisible(element.value.getKey.currentContext!,
              alignment: .25, duration: const Duration(milliseconds: 600));
          break;
        }
      }

      if (!inTextFound) {
        Scrollable.ensureVisible(categoryKey.currentContext!,
            alignment: .25, duration: const Duration(milliseconds: 600));
      }
      return;
    }
    if(storeImage.value.path.isEmpty){
      showToast("Please select store logo");
      return;
    }
    if(businessImage.value.path.isEmpty){
      showToast("Please select business id image");
      return;
    }
    Map<String, String> map = textControllers.map((key, value) => MapEntry(key, value.text.trim()));
    map["VenderCategory"] = allSelectedCategory.entries.map((e) => e.key).toList().join(",");

    Map<String, File> images = {};
    images["store_logo"] = storeImage.value;
    images["store_image"] = businessImage.value;

    repositories.multiPartApi(
        mapData: map,
        images: images,
        context: context,
        url: ApiUrls.vendorRegistrationUrl,
      onProgress: (int bytes, int totalBytes){
          // print((bytes/totalBytes).toStringAsFixed(2));
      }
    ).then((value) {
      ModelVendorRegistrationResponse response = ModelVendorRegistrationResponse.fromJson(jsonDecode(value));
      showToast(response.message.toString());
      if(response.status == true && response.otp != null) {
        Get.to(() => const VendorOTPVerification(), arguments: [textControllers["email"]!.text.trim()]);
      }
    });
  }

  void getVendorCategories() {
    vendorCategoryStatus.value = RxStatus.loading();
    repositories.postApi(url: ApiUrls.vendorCategoryListUrl).then((value) {
      modelVendorCategory = ModelVendorCategory.fromJson(jsonDecode(value));
      vendorCategoryStatus.value = RxStatus.success();
    }).catchError((e) {
      vendorCategoryStatus.value = RxStatus.error();
    });
  }

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
    getVendorCategories();
  }

  @override
  void dispose() {
    super.dispose();
    textControllers.forEach((key, value) {
      value.dispose();
    });
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
                        controller: textControllers["store_name"],
                        key: textControllers["store_name"]!.getKey,
                        hintText: "Store Name",
                        validator: (value) {
                          if (value!.trim().isEmpty) {
                            return "Please enter store name";
                          }
                          return null;
                        }),
                    14.spaceY,
                    VendorCommonTextfield(
                        //obSecure: true,
                        controller: textControllers["phone"],
                        key: textControllers["phone"]!.getKey,
                        hintText: "Phone Number",
                        keyboardType: TextInputType.name,
                        validator: (value) {
                          if (value!.trim().isEmpty) {
                            return "Please enter store phone number";
                          }
                          if (value.trim().length < 10) {
                            return "Please enter valid store phone number";
                          }
                          return null;
                        }),
                    14.spaceY,
                    VendorCommonTextfield(
                        //obSecure: true,
                        controller: textControllers["email"],
                        keyboardType: TextInputType.emailAddress,
                        key: textControllers["email"]!.getKey,
                        hintText: "Store Email Address",
                        validator: (value) {
                          if (value!.trim().isEmpty) {
                            return "Please enter store email address";
                          }
                          if (value.trim().isValidEmail) {
                            return "Please enter valid email address";
                          }
                          return null;
                        }),
                    14.spaceY,
                    Obx(() {
                      return VendorCommonTextfield(
                          //obSecure: true,
                          obSecure: hideText.value,
                          controller: textControllers["password"],
                          key: textControllers["password"]!.getKey,
                          hintText: "Set Store Password",
                          suffixIcon: IconButton(
                            onPressed: () {
                              hideText.value = !hideText.value;
                            },
                            icon: Icon(hideText.value ? Icons.visibility_off_rounded : Icons.visibility),
                          ),
                          validator: (value) {
                            if (value!.trim().isEmpty) {
                              return "Password is required";
                            }
                            if (value.trim().length < 8) {
                              return "Password required minimum 8 characters";
                            }
                            return null;
                          });
                    }),
                    14.spaceY,
                    VendorCommonTextfield(
                        controller: textControllers["store_address"],
                        keyboardType: TextInputType.streetAddress,
                        key: textControllers["store_address"]!.getKey,
                        hintText: "Address",
                        validator: (value) {
                          if (value!.trim().isEmpty) {
                            return "Please enter store address";
                          }
                          return null;
                        }),
                    14.spaceY,
                    VendorCommonTextfield(
                        //obSecure: true,
                        controller: textControllers["store_business_id"],
                        keyboardType: TextInputType.number,
                        key: textControllers["store_business_id"]!.getKey,
                        hintText: "Business ID (number)",
                        validator: (value) {
                          if (value!.trim().isEmpty) {
                            return "Please enter Business ID (number)";
                          }
                          return null;
                        }),
                    14.spaceY,
                    Obx(() {
                      return DropdownButtonFormField<Usphone>(
                        key: categoryKey,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        icon: vendorCategoryStatus.value.isLoading
                            ? const CupertinoActivityIndicator()
                            : vendorCategoryStatus.value.isError
                                ? IconButton(
                                    onPressed: () => getVendorCategories(),
                                    padding: EdgeInsets.zero,
                                    visualDensity: VisualDensity.compact,
                                    icon: const Icon(
                                      Icons.refresh,
                                      color: Colors.black,
                                    ))
                                : const Icon(Icons.keyboard_arrow_down_rounded),
                        iconSize: 30,
                        iconDisabledColor: const Color(0xff97949A),
                        iconEnabledColor: const Color(0xff97949A),
                        value: null,
                        style: const TextStyle(color: Colors.black, fontSize: 16),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          filled: true,
                          fillColor: const Color(0xffE2E2E2).withOpacity(.35),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10).copyWith(right: 8),
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
                        items: modelVendorCategory.usphone!
                            .map((e) => DropdownMenuItem(value: e, child: Text(e.name.toString().capitalize!)))
                            .toList(),
                        hint: const Text('Category'),
                        onChanged: (value) {
                          // selectedCategory = value;
                          if(value ==null)return;
                          allSelectedCategory[value.id.toString()] = value;
                          setState(() {});
                        },
                        validator: (value) {
                          if (allSelectedCategory.isEmpty) {
                            return "Please select Category";
                          }
                          return null;
                        },
                      );
                    }),
                    5.spaceY,
                    Wrap(
                      runSpacing: 0,
                      spacing: 8,
                      children: allSelectedCategory.entries.map((e) => Chip(
                          label: Text(e.value.name.toString().capitalize!),
                          labelPadding: const EdgeInsets.only(right: 4,left: 2),
                          onDeleted: (){
                            allSelectedCategory.remove(e.key);
                            setState(() {});
                          })).toList(),
                    ),
                    14.spaceY,
                    VendorCommonTextfield(
                        //obSecure: true,
                        controller: textControllers["store_about_us"],
                        key: textControllers["store_about_us"]!.getKey,
                        hintText: "Tell us about the store....",
                        isMulti: true,
                        validator: (value) {
                          if (value!.trim().isEmpty) {
                            return "Store description is required";
                          }
                          return null;
                        }),
                    14.spaceY,
                    VendorCommonTextfield(
                        //obSecure: true,
                        controller: textControllers["store_about_me"],
                        key: textControllers["store_about_me"]!.getKey,
                        hintText: "Tell us about you.",
                        isMulti: true,
                        validator: (value) {
                          if (value!.trim().isEmpty) {
                            return "Please tell us about yourself";
                          }
                          return null;
                        }),
                    14.spaceY,
                    Text(
                      "Store Logo",
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500, color: const Color(0xff2F2F2F), fontSize: AddSize.font18),
                    ),
                    14.spaceY,
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
                              : Image.file(storeImage.value),
                        ),
                      );
                    }),
                    14.spaceY,
                    Text(
                      "Business ID One Image ",
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500, color: const Color(0xff2F2F2F), fontSize: AddSize.font18),
                    ),
                    14.spaceY,
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
                              : Image.file(businessImage.value),
                        ),
                      );
                    }),
                    14.spaceY,
                    ElevatedButton(
                        onPressed: () {
                          vendorRegistration();
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
