import 'dart:convert';
import 'dart:io';
import 'package:dirise/widgets/common_colour.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../model/vendor_models/model_vendor_registration.dart';
import '../../model/vendor_models/vendor_category_model.dart';
import '../../repository/repository.dart';
import '../../utils/ApiConstant.dart';
import '../../utils/helper.dart';
import '../../widgets/dimension_screen.dart';
import '../../widgets/vendor_common_textfield.dart';
import 'image_widget.dart';

class VendorRegistrationScreen extends StatefulWidget {
  const VendorRegistrationScreen({Key? key}) : super(key: key);

  static var registrationScreen = "/registrationScreen";

  @override
  State<VendorRegistrationScreen> createState() => _VendorRegistrationScreenState();
}

class _VendorRegistrationScreenState extends State<VendorRegistrationScreen> {
  final Repositories repositories = Repositories();
  ModelVendorCategory modelVendorCategory = ModelVendorCategory(usphone: []);

  final _formKey = GlobalKey<FormState>();
  final GlobalKey categoryKey = GlobalKey();

  List<String> vendorType = ["Advertising", "Personal/ home business", "Company"];
  String storeType = "Advertising";
  RxBool showValidation = false.obs;
  RxBool hideText = true.obs;
  Map<String, VendorCategoriesData> allSelectedCategory = {};
  Rx<RxStatus> vendorCategoryStatus = RxStatus.empty().obs;

  Rx<File> storeImage = File("").obs;
  Rx<File> businessImage = File("").obs;

  /// Vendor 1 Fields and some are mandatory and present in all.
  final TextEditingController firstName = TextEditingController();
  final TextEditingController lastName = TextEditingController();
  final TextEditingController storeName = TextEditingController();
  final TextEditingController homeAddress = TextEditingController();
  final TextEditingController phoneNumber = TextEditingController();
  final TextEditingController emailAddress = TextEditingController();
  final TextEditingController optionalController1 = TextEditingController();
  final TextEditingController optionalController2 = TextEditingController();
  final TextEditingController optionalController3 = TextEditingController();

  /// Vendor 2 Fields and rest are from above
  final TextEditingController ceoName = TextEditingController();
  final TextEditingController partnerCount = TextEditingController();
  File paymentReceiptCertificate = File("");

  /// Vendor 3 Fields
  final TextEditingController companyName = TextEditingController();
  final TextEditingController workAddress = TextEditingController();
  final TextEditingController workEmail = TextEditingController();
  final TextEditingController businessNumber = TextEditingController();
  final TextEditingController taxNumber = TextEditingController();
  File memorandumAssociation = File("");
  File commercialLicense = File("");
  File signatureApproval = File("");
  File ministryCommerce = File("");
  File originalCivilInformation = File("");
  File companyBankAccount = File("");

  void vendorRegistration() {
    if(showValidation.value== false){
      showValidation.value = true;
      setState(() {});
    }
    if (!_formKey.currentState!.validate()) {
      return;
    }
    if (storeImage.value.path.isEmpty) {
      showToast("Please select store logo");
      return;
    }
    if (businessImage.value.path.isEmpty) {
      showToast("Please select business id image");
      return;
    }
    Map<String, String> map = {};
    map["category_id"] = allSelectedCategory.entries.map((e) => e.key).toList().join(",");

    Map<String, File> images = {};
    images["store_logo"] = storeImage.value;
    images["store_image"] = businessImage.value;

    repositories
        .multiPartApi(
            mapData: map,
            images: images,
            context: context,
            url: ApiUrls.vendorRegistrationUrl,
            onProgress: (int bytes, int totalBytes) {
              // print((bytes/totalBytes).toStringAsFixed(2));
            })
        .then((value) {
      ModelVendorRegistrationResponse response = ModelVendorRegistrationResponse.fromJson(jsonDecode(value));
      showToast(response.message.toString());
      if (response.status == true && response.otp != null) {
        // Get.to(() => const VendorOTPVerification(), arguments: [textControllers["email"]!.text.trim()]);
      }
    });
  }

  void getVendorCategories() {
    vendorCategoryStatus.value = RxStatus.loading();
    repositories.getApi(url: ApiUrls.vendorCategoryListUrl).then((value) {
      modelVendorCategory = ModelVendorCategory.fromJson(jsonDecode(value));
      vendorCategoryStatus.value = RxStatus.success();
    }).catchError((e) {
      vendorCategoryStatus.value = RxStatus.error();
      throw Exception(e);
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
    // textControllers.forEach((key, value) {
    //   value.dispose();
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF4F4F4),
      appBar: AppBar(
        title: Text('Vendor Registration',
            style: GoogleFonts.poppins(
              fontSize: 17,
              fontWeight: FontWeight.w600,
              color: const Color(0xff423E5E),
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
                    DropdownButtonFormField<String>(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      iconSize: 30,
                      iconDisabledColor: const Color(0xff97949A),
                      iconEnabledColor: const Color(0xff97949A),
                      value: storeType,
                      style: GoogleFonts.poppins(color: Colors.black, fontSize: 16),
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
                      items: vendorType.map((e) => DropdownMenuItem(value: e, child: Text(e.toString()))).toList(),
                      hint: const Text('Category'),
                      onChanged: (value) {
                        if (value == null) return;
                        storeType = value;
                        setState(() {});
                      },
                    ),

                    14.spaceY,
                    VendorCommonTextfield(
                        controller: firstName,
                        key: firstName.getKey,
                        hintText: "First Name",
                        validator: (value) {
                          if (value!.trim().isEmpty) {
                            return "Please enter first name";
                          }
                          return null;
                        }),
                    14.spaceY,
                    VendorCommonTextfield(
                        controller: lastName,
                        key: lastName.getKey,
                        hintText: "Last Name",
                        validator: (value) {
                          if (value!.trim().isEmpty) {
                            return "Please enter last name";
                          }
                          return null;
                        }),

                    14.spaceY,
                    VendorCommonTextfield(
                        controller: storeName,
                        key: storeName.getKey,
                        hintText: "Store Name",
                        validator: (value) {
                          if (value!.trim().isEmpty) {
                            return "Please enter store name";
                          }
                          return null;
                        }),
                    14.spaceY,
                    VendorCommonTextfield(
                        controller: phoneNumber,
                        key: phoneNumber.getKey,
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
                        controller: emailAddress,
                        keyboardType: TextInputType.emailAddress,
                        key: emailAddress.getKey,
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
                    VendorCommonTextfield(
                        controller: homeAddress,
                        keyboardType: TextInputType.streetAddress,
                        key: homeAddress.getKey,
                        hintText: "Home Address",
                        validator: (value) {
                          if (value!.trim().isEmpty) {
                            return "Please enter home address";
                          }
                          return null;
                        }),

                    /// Optional Fields
                    14.spaceY,
                    VendorCommonTextfield(
                        controller: optionalController1,
                        keyboardType: TextInputType.streetAddress,
                        key: optionalController1.getKey,
                        hintText: "Optional1",
                        validator: (value) {
                          // if (value!.trim().isEmpty) {
                          //   return "Please enter home address";
                          // }
                          return null;
                        }),
                    14.spaceY,
                    VendorCommonTextfield(
                        controller: optionalController2,
                        keyboardType: TextInputType.streetAddress,
                        key: optionalController2.getKey,
                        hintText: "Optional2",
                        validator: (value) {
                          // if (value!.trim().isEmpty) {
                          //   return "Please enter home address";
                          // }
                          return null;
                        }),
                    14.spaceY,
                    VendorCommonTextfield(
                        controller: optionalController3,
                        keyboardType: TextInputType.streetAddress,
                        key: optionalController3.getKey,
                        hintText: "Optional3",
                        validator: (value) {
                          // if (value!.trim().isEmpty) {
                          //   return "Please enter home address";
                          // }
                          return null;
                        }),
                    14.spaceY,

                    if (storeType == "Personal/ home business") ...[
                      VendorCommonTextfield(
                          controller: ceoName,
                          keyboardType: TextInputType.streetAddress,
                          key: ceoName.getKey,
                          hintText: "Ceo Name",
                          validator: (value) {
                            if (value!.trim().isEmpty) {
                              return "Please enter ceo name";
                            }
                            return null;
                          }),
                      14.spaceY,
                      VendorCommonTextfield(
                          controller: partnerCount,
                          keyboardType: TextInputType.streetAddress,
                          key: partnerCount.getKey,
                          hintText: "#Partners",
                          validator: (value) {
                            if (value!.trim().isEmpty) {
                              return "Please enter you partners";
                            }
                            return null;
                          }),
                      14.spaceY,
                    ],

                    if (storeType == "Company") ...[
                      VendorCommonTextfield(
                          controller: companyName,
                          keyboardType: TextInputType.streetAddress,
                          key: companyName.getKey,
                          hintText: "Company Name",
                          validator: (value) {
                            if (value!.trim().isEmpty) {
                              return "Please enter company name";
                            }
                            return null;
                          }),
                      14.spaceY,
                      VendorCommonTextfield(
                          controller: workAddress,
                          keyboardType: TextInputType.streetAddress,
                          key: workAddress.getKey,
                          hintText: "Work Address",
                          validator: (value) {
                            if (value!.trim().isEmpty) {
                              return "Please enter work address";
                            }
                            return null;
                          }),
                      14.spaceY,
                      VendorCommonTextfield(
                          controller: businessNumber,
                          keyboardType: TextInputType.streetAddress,
                          key: businessNumber.getKey,
                          hintText: "Business Number",
                          validator: (value) {
                            if (value!.trim().isEmpty) {
                              return "Please enter business number";
                            }
                            return null;
                          }),
                      14.spaceY,
                      VendorCommonTextfield(
                          controller: workEmail,
                          keyboardType: TextInputType.streetAddress,
                          key: workEmail.getKey,
                          hintText: "Work Email",
                          validator: (value) {
                            if (value!.trim().isEmpty) {
                              return "Please enter work email";
                            }
                            return null;
                          }),
                      14.spaceY,
                      VendorCommonTextfield(
                          controller: taxNumber,
                          keyboardType: TextInputType.streetAddress,
                          key: taxNumber.getKey,
                          hintText: "Tax number * (outside Kuwait)",
                          validator: (value) {
                            if (value!.trim().isEmpty) {
                              return "Please enter work email";
                            }
                            return null;
                          }),
                      14.spaceY,
                    ],

                    Obx(() {
                      if (kDebugMode) {
                        print(modelVendorCategory.usphone!
                            .map((e) => DropdownMenuItem(value: e, child: Text(e.name.toString().capitalize!)))
                            .toList());
                      }
                      return DropdownButtonFormField<VendorCategoriesData>(
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
                        style: GoogleFonts.poppins(color: Colors.black, fontSize: 16),
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
                          if (value == null) return;
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
                      children: allSelectedCategory.entries
                          .map((e) => Chip(
                              label: Text(e.value.name.toString().capitalize!),
                              labelPadding: const EdgeInsets.only(right: 4, left: 2),
                              onDeleted: () {
                                allSelectedCategory.remove(e.key);
                                setState(() {});
                              }))
                          .toList(),
                    ),
                    14.spaceY,

                    if (storeType == "Personal/ home business")
                      ImageWidget(
                        title: "Payment Receipt Certificate",
                        file: paymentReceiptCertificate,
                        validation: checkValidation(showValidation.value, paymentReceiptCertificate.path.isEmpty),
                        filePicked: (File g) {
                          paymentReceiptCertificate = g;
                        },
                      ),
                    if (storeType == "Company") ...[
                      // memorandumAssociation
                      // commercialLicense
                      // signatureApproval
                      // ministryCommerce
                      // originalCivilInformation
                      // companyBankAccount
                      ImageWidget(
                        title: "Memorandum of Association",
                        file: memorandumAssociation,
                        validation: checkValidation(showValidation.value, memorandumAssociation.path.isEmpty),
                        filePicked: (File g) {
                          memorandumAssociation = g;
                        },
                      ),
                      ImageWidget(
                        title: "Commercial license",
                        file: commercialLicense,
                        validation: checkValidation(showValidation.value, commercialLicense.path.isEmpty),
                        filePicked: (File g) {
                          commercialLicense = g;
                        },
                      ),
                      ImageWidget(
                        title: "Signature approval",
                        file: signatureApproval,
                        validation: checkValidation(showValidation.value, signatureApproval.path.isEmpty),
                        filePicked: (File g) {
                          signatureApproval = g;
                        },
                      ),
                      ImageWidget(
                        title: "Extract from the Ministry of Commerce",
                        file: ministryCommerce,
                        validation: checkValidation(showValidation.value, ministryCommerce.path.isEmpty),
                        filePicked: (File g) {
                          ministryCommerce = g;
                        },
                      ),
                      ImageWidget(
                        title: "Original civil information",
                        file: originalCivilInformation,
                        validation: checkValidation(showValidation.value, originalCivilInformation.path.isEmpty),
                        filePicked: (File g) {
                          originalCivilInformation = g;
                        },
                      ),
                      ImageWidget(
                        title: "Company bank account",
                        file: companyBankAccount,
                        validation: checkValidation(showValidation.value, companyBankAccount.path.isEmpty),
                        filePicked: (File g) {
                          companyBankAccount = g;
                        },
                      ),
                    ],

                    ElevatedButton(
                        onPressed: () {
                          vendorRegistration();
                        },
                        style: ElevatedButton.styleFrom(
                            minimumSize: const Size(double.maxFinite, 60),
                            backgroundColor: AppTheme.buttonColor,
                            elevation: 0,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AddSize.size10)),
                            textStyle: GoogleFonts.poppins(fontSize: AddSize.font20, fontWeight: FontWeight.w600)),
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
