import 'dart:io';
import 'package:dirise/utils/helper.dart';
import 'package:dirise/widgets/loading_animation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../controller/vendor_controllers/vendor_profile_controller.dart';
import '../../model/vendor_models/model_plan_list.dart';
import '../../model/vendor_models/model_vendor_details.dart';
import '../../repository/repository.dart';
import '../../utils/styles.dart';
import '../../widgets/common_colour.dart';
import '../../widgets/dimension_screen.dart';
import '../../widgets/vendor_common_textfield.dart';
import '../authenthication/image_widget.dart';
import '../authenthication/vendor_registration_screen.dart';

class VendorProfileScreen extends StatefulWidget {
  const VendorProfileScreen({super.key});
  static String route = "/VendorProfileScreen";

  @override
  State<VendorProfileScreen> createState() => _VendorProfileScreenState();
}

class _VendorProfileScreenState extends State<VendorProfileScreen> {
  final vendorProfileController = Get.put(VendorProfileController());
  PlanInfoData get planInfo => PlanInfoData();

  final _formKey = GlobalKey<FormState>();
  final GlobalKey categoryKey = GlobalKey();

  Rx<File> storeImage = File("").obs;
  Rx<File> businessImage = File("").obs;
  RxBool showValidation = false.obs;
  RxBool hideText = true.obs;
  final Repositories repositories = Repositories();

  /// Vendor 1 Fields and some are mandatory and present in all.
  final TextEditingController firstName = TextEditingController();
  final TextEditingController lastName = TextEditingController();
  final TextEditingController storeName = TextEditingController();
  final TextEditingController homeAddress = TextEditingController();
  final TextEditingController phoneNumber = TextEditingController();
  final TextEditingController emailAddress = TextEditingController();

  final TextEditingController optional1Plan1 = TextEditingController();
  final TextEditingController optional2Plan1 = TextEditingController();
  final TextEditingController optional3Plan1 = TextEditingController();

  final TextEditingController optional1Plan2 = TextEditingController();
  final TextEditingController optional2Plan2 = TextEditingController();
  final TextEditingController optional3Plan2 = TextEditingController();

  final TextEditingController optional1Plan3 = TextEditingController();
  final TextEditingController optional2Plan3 = TextEditingController();
  final TextEditingController optional3Plan3 = TextEditingController();

  /// Vendor 2 Fields and rest are from above
  final TextEditingController ceoName = TextEditingController();
  final TextEditingController partnerCount = TextEditingController();
  File paymentReceiptCertificate = File("");
  final GlobalKey paymentReceiptCertificateKey = GlobalKey();
  File optionalFile1 = File("");
  File optionalFile2 = File("");
  File optionalFile3 = File("");

  /// Vendor 3 Fields
  final TextEditingController companyName = TextEditingController();
  final TextEditingController workAddress = TextEditingController();
  final TextEditingController workEmail = TextEditingController();
  final TextEditingController businessNumber = TextEditingController();
  final TextEditingController taxNumber = TextEditingController();

  File memorandumAssociation = File("");
  final GlobalKey memorandumAssociationKey = GlobalKey();
  File commercialLicense = File("");
  final GlobalKey commercialLicenseKey = GlobalKey();
  File signatureApproval = File("");
  final GlobalKey signatureApprovalKey = GlobalKey();
  File ministryCommerce = File("");
  final GlobalKey ministryCommerceKey = GlobalKey();
  File originalCivilInformation = File("");
  final GlobalKey originalCivilInformationKey = GlobalKey();
  File companyBankAccount = File("");
  final GlobalKey companyBankAccountKey = GlobalKey();

  PlansType selectedPlan = PlansType.personal;

  bool checkValidation(bool bool1, bool2) {
    if (bool1 == true && bool2 == true) {
      return true;
    } else {
      return false;
    }
  }

  bool valuesLoaded = false;

  VendorUser get vendorInfo => vendorProfileController.model.user!;

  updateControllers(){
    if(valuesLoaded)return;
    if(vendorProfileController.model.user == null)return;
    selectedPlan = PlansType.values.firstWhere((element) => element.name.toString() == vendorInfo.vendorType.toString(),orElse: ()=> PlansType.personal);
    firstName.text = vendorInfo.firstName ?? "";
    lastName.text = vendorInfo.lastName ?? "";
    storeName.text = vendorInfo.storeName ?? "";
    homeAddress.text = vendorInfo.address ?? "";
    phoneNumber.text = vendorInfo.phone ?? "";
    emailAddress.text = vendorInfo.email ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF4F4F4),
      appBar: AppBar(
        title: Text('Vendor Profile',
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
      body: Obx(() {
        if(vendorProfileController.refreshInt.value > 0){}
        updateControllers();
        return vendorProfileController.apiLoaded
            ? RefreshIndicator(
          onRefresh: () async {
            await vendorProfileController.getVendorDetails();
          },
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Card(
                color: Colors.white,
                margin: const EdgeInsets.all(8),
                surfaceTintColor: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 18),
                  child: Column(
                    children: [
                      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        // planCard(),
                        if (selectedPlan == PlansType.advertisement) ...[
                          // 14.spaceY,
                          // First Name
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
                          // Last Name
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
                          // Store Name
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
                          // Home Address
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
                          14.spaceY,
                          //Phone Number
                          VendorCommonTextfield(
                              controller: phoneNumber,
                              key: phoneNumber.getKey,
                              hintText: "Phone Number",
                              keyboardType: TextInputType.phone,
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
                          // Email Address
                          VendorCommonTextfield(
                              controller: emailAddress,
                              keyboardType: TextInputType.emailAddress,
                              key: emailAddress.getKey,
                              hintText: "Email Address",
                              validator: (value) {
                                if (value!.trim().isEmpty) {
                                  return "Please enter email address";
                                }
                                if (value.trim().invalidEmail) {
                                  return "Please enter valid email address";
                                }
                                return null;
                              }),
                          14.spaceY,
                          //Optional1
                          VendorCommonTextfield(
                              controller: optional1Plan1,
                              key: optional1Plan1.getKey,
                              hintText: "Optional1",
                              validator: (value) {
                                // if (value!.trim().isEmpty) {
                                //   return "Please enter home address";
                                // }
                                return null;
                              }),
                          14.spaceY,
                          //Optional2
                          VendorCommonTextfield(
                              controller: optional2Plan1,
                              key: optional2Plan1.getKey,
                              hintText: "Optional2",
                              validator: (value) {
                                // if (value!.trim().isEmpty) {
                                //   return "Please enter home address";
                                // }
                                return null;
                              }),
                          14.spaceY,
                          //Optional3
                          VendorCommonTextfield(
                              controller: optional3Plan1,
                              key: optional3Plan1.getKey,
                              hintText: "Optional3",
                              validator: (value) {
                                // if (value!.trim().isEmpty) {
                                //   return "Please enter home address";
                                // }
                                return null;
                              }),
                        ],
                        if (selectedPlan == PlansType.personal) ...[
                          // 14.spaceY,
                          // First Name
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
                          // Last Name
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
                          // Store Name
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
                          // Ceo Name
                          VendorCommonTextfield(
                              controller: ceoName,
                              keyboardType: TextInputType.name,
                              key: ceoName.getKey,
                              hintText: "Ceo Name",
                              validator: (value) {
                                if (value!.trim().isEmpty) {
                                  return "Please enter ceo name";
                                }
                                return null;
                              }),
                          14.spaceY,
                          //#Partners
                          VendorCommonTextfield(
                              controller: partnerCount,
                              keyboardType: TextInputType.name,
                              key: partnerCount.getKey,
                              hintText: "#Partners",
                              validator: (value) {
                                if (value!.trim().isEmpty) {
                                  return "Please enter you partners";
                                }
                                return null;
                              }),
                          14.spaceY,
                          // Home Address
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
                          14.spaceY,
                          //Phone Number
                          VendorCommonTextfield(
                              controller: phoneNumber,
                              key: phoneNumber.getKey,
                              hintText: "Phone Number",
                              keyboardType: TextInputType.phone,
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
                          // Email Address
                          VendorCommonTextfield(
                              controller: emailAddress,
                              keyboardType: TextInputType.emailAddress,
                              key: emailAddress.getKey,
                              hintText: "Email Address",
                              validator: (value) {
                                if (value!.trim().isEmpty) {
                                  return "Please enter email address";
                                }
                                if (value.trim().invalidEmail) {
                                  return "Please enter valid email address";
                                }
                                return null;
                              }),
                          14.spaceY,
                          //Optional1
                          VendorCommonTextfield(
                              controller: optional1Plan2,
                              key: optional1Plan2.getKey,
                              hintText: "Optional1",
                              validator: (value) {
                                // if (value!.trim().isEmpty) {
                                //   return "Please enter home address";
                                // }
                                return null;
                              }),
                          14.spaceY,
                          //Optional2
                          VendorCommonTextfield(
                              controller: optional2Plan2,
                              key: optional2Plan2.getKey,
                              hintText: "Optional2",
                              validator: (value) {
                                // if (value!.trim().isEmpty) {
                                //   return "Please enter home address";
                                // }
                                return null;
                              }),
                          14.spaceY,
                          //Optional3
                          VendorCommonTextfield(
                              controller: optional3Plan2,
                              key: optional3Plan2.getKey,
                              hintText: "Optional3",
                              validator: (value) {
                                // if (value!.trim().isEmpty) {
                                //   return "Please enter home address";
                                // }
                                return null;
                              }),
                          ImageWidget(
                            key: paymentReceiptCertificateKey,
                            title: "Payment Receipt Certificate",
                            file: paymentReceiptCertificate,
                            validation: checkValidation(
                                showValidation.value,
                                paymentReceiptCertificate.path.isEmpty
                            ),
                            filePicked: (File g) {
                              paymentReceiptCertificate = g;
                            },
                          ),
                          ImageWidget(
                            title: "Optional",
                            file: optionalFile1,
                            validation: false,
                            filePicked: (File g) {
                              optionalFile1 = g;
                            },
                          ),
                        ],
                        if (selectedPlan == PlansType.company) ...[
                          // 14.spaceY,
                          // First Name
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
                          // Last Name
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
                          // Store Name
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
                          // Company Name
                          VendorCommonTextfield(
                              controller: companyName,
                              keyboardType: TextInputType.name,
                              key: companyName.getKey,
                              hintText: "Company Name",
                              validator: (value) {
                                if (value!.trim().isEmpty) {
                                  return "Please enter company name";
                                }
                                return null;
                              }),
                          14.spaceY,
                          // Work Address
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
                          // Business Number
                          VendorCommonTextfield(
                              controller: businessNumber,
                              key: businessNumber.getKey,
                              hintText: "Business Number",
                              validator: (value) {
                                if (value!.trim().isEmpty) {
                                  return "Please enter business number";
                                }
                                return null;
                              }),
                          14.spaceY,
                          // Email Address
                          VendorCommonTextfield(
                              controller: emailAddress,
                              keyboardType: TextInputType.emailAddress,
                              key: emailAddress.getKey,
                              hintText: "Email Address",
                              validator: (value) {
                                if (value!.trim().isEmpty) {
                                  return "Please enter email address";
                                }
                                if (value.trim().invalidEmail) {
                                  return "Please enter valid email address";
                                }
                                return null;
                              }),
                          14.spaceY,
                          // Work Email
                          VendorCommonTextfield(
                              controller: workEmail,
                              keyboardType: TextInputType.emailAddress,
                              key: workEmail.getKey,
                              hintText: "Work Email",
                              validator: (value) {
                                if (value!.trim().isEmpty) {
                                  return "Please enter work email";
                                }
                                if (value.trim().invalidEmail) {
                                  return "Please enter valid email address";
                                }
                                return null;
                              }),
                          14.spaceY,
                          // Work Email
                          VendorCommonTextfield(
                              controller: taxNumber,
                              key: taxNumber.getKey,
                              hintText: "Tax number* (outside Kuwait)",
                              validator: (value) {
                                return null;
                              }),

                          14.spaceY,
                          //Optional1
                          VendorCommonTextfield(
                              controller: optional1Plan3,
                              key: optional1Plan3.getKey,
                              hintText: "Optional1",
                              validator: (value) {
                                return null;
                              }),
                          14.spaceY,
                          //Optional2
                          VendorCommonTextfield(
                              controller: optional2Plan3,
                              key: optional2Plan3.getKey,
                              hintText: "Optional2",
                              validator: (value) {
                                return null;
                              }),
                          14.spaceY,
                          //Optional3
                          VendorCommonTextfield(
                              controller: optional3Plan3,
                              key: optional3Plan3.getKey,
                              hintText: "Optional3",
                              validator: (value) {
                                return null;
                              }),
                          // memorandumAssociation
                          // commercialLicense
                          // signatureApproval
                          // ministryCommerce
                          // originalCivilInformation
                          // companyBankAccount
                          ImageWidget(
                            key: memorandumAssociationKey,
                            title: "Memorandum of Association",
                            file: memorandumAssociation,
                            validation: checkValidation(showValidation.value,
                                memorandumAssociation.path.isEmpty),
                            filePicked: (File g) {
                              memorandumAssociation = g;
                            },
                          ),
                          ImageWidget(
                            title: "Commercial license",
                            file: commercialLicense,
                            key: commercialLicenseKey,
                            validation: checkValidation(showValidation.value,
                                commercialLicense.path.isEmpty),
                            filePicked: (File g) {
                              commercialLicense = g;
                            },
                          ),
                          ImageWidget(
                            title: "Signature approval",
                            file: signatureApproval,
                            key: signatureApprovalKey,
                            validation: checkValidation(showValidation.value,
                                signatureApproval.path.isEmpty),
                            filePicked: (File g) {
                              signatureApproval = g;
                            },
                          ),
                          ImageWidget(
                            title: "Extract from the Ministry of Commerce",
                            file: ministryCommerce,
                            key: ministryCommerceKey,
                            validation: checkValidation(showValidation.value,
                                ministryCommerce.path.isEmpty),
                            filePicked: (File g) {
                              ministryCommerce = g;
                            },
                          ),
                          ImageWidget(
                            title: "Original civil information",
                            file: originalCivilInformation,
                            key: originalCivilInformationKey,
                            validation: checkValidation(showValidation.value,
                                originalCivilInformation.path.isEmpty),
                            filePicked: (File g) {
                              originalCivilInformation = g;
                            },
                          ),
                          ImageWidget(
                            title: "Company bank account",
                            file: companyBankAccount,
                            key: companyBankAccountKey,
                            validation: checkValidation(showValidation.value,
                                companyBankAccount.path.isEmpty),
                            filePicked: (File g) {
                              companyBankAccount = g;
                            },
                          ),
                        ],
                        const SizedBox(height: 25,),
                        ElevatedButton(
                            onPressed: () {
                              // updateVendorProfile();
                            },
                            style: ElevatedButton.styleFrom(
                                minimumSize: const Size(double.maxFinite, 60),
                                backgroundColor: AppTheme.buttonColor,
                                elevation: 0,
                                shape: RoundedRectangleBorder(borderRadius:
                                BorderRadius.circular(AddSize.size10)),
                                textStyle: GoogleFonts.poppins(
                                    fontSize: AddSize.font20,
                                    fontWeight: FontWeight.w600
                                )
                            ),
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
        )
            : const LoadingAnimation();
      }),
    );
  }

  Card planCard() {
    return Card(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 14),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Text(
                  planInfo.businessType.toString().capitalize!,
                  style: titleStyle.copyWith(fontSize: 18),
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                            child: Text(
                              planInfo.title.toString().capitalize!,
                              style: titleStyle,
                            )),
                        Text(planInfo.amount.toString()),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: Text(
                              "Validity",
                              style: titleStyle,
                            )),
                        Text("${planInfo.label}"),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
