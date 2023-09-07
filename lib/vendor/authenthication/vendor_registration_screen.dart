import 'dart:convert';
import 'dart:io';
import 'package:dirise/screens/app_bar/common_app_bar.dart';
import 'package:dirise/utils/notification_service.dart';
import 'package:dirise/widgets/common_colour.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../model/vendor_models/model_plan_list.dart';
import '../../model/vendor_models/model_vendor_registration.dart';
import '../../model/vendor_models/vendor_category_model.dart';
import '../../repository/repository.dart';
import '../../utils/ApiConstant.dart';
import '../../utils/helper.dart';
import '../../utils/styles.dart';
import '../../widgets/dimension_screen.dart';
import '../../widgets/vendor_common_textfield.dart';
import 'image_widget.dart';
import 'verify_vendor_otp.dart';

enum PlansType { advertisement, company, personal }

class VendorRegistrationScreen extends StatefulWidget {
  const VendorRegistrationScreen({Key? key, required this.selectedPlan, required this.modelPlansList})
      : super(key: key);
  final PlanInfoData selectedPlan;
  final ModelPlansList modelPlansList;

  @override
  State<VendorRegistrationScreen> createState() => _VendorRegistrationScreenState();
}

class _VendorRegistrationScreenState extends State<VendorRegistrationScreen> {
  PlanInfoData get planInfo => widget.selectedPlan;

  final Repositories repositories = Repositories();
  ModelVendorCategory modelVendorCategory = ModelVendorCategory(usphone: []);

  final _formKey = GlobalKey<FormState>();
  final GlobalKey categoryKey = GlobalKey();
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



  void vendorRegistration() {
    if (showValidation.value == false) {
      showValidation.value = true;
      setState(() {});
    }

    /// Validations
    if (!_formKey.currentState!.validate()) {
      if(selectedPlan == PlansType.advertisement){
        // First Name
        if(firstName.checkEmpty)return;
        // Last Name
        if(lastName.checkEmpty)return;
        // Store Name
        if(storeName.checkEmpty)return;
        // Home Adress
        if(homeAddress.checkEmpty)return;
        // Phone Number
        if(phoneNumber.checkBothWithPhone)return;
        // Email
        if(emailAddress.checkBothWithEmail)return;
        // Optional
        // Optional
        // Optional
      }
      if(selectedPlan == PlansType.personal){
        // First Name
        if(firstName.checkEmpty)return;
        // Last Name
        if(lastName.checkEmpty)return;
        // Store Name
        if(storeName.checkEmpty)return;
        // Home Adress
        if(homeAddress.checkEmpty)return;
        // Phone Number
        if(ceoName.checkEmpty)return;
        // Email
        if(partnerCount.checkEmpty)return;
        // Phone Number
        if(phoneNumber.checkBothWithPhone)return;
        // Phone Number
        if(emailAddress.checkBothWithEmail)return;
      }
      if(selectedPlan == PlansType.company){
        // First Name
        if(firstName.checkEmpty)return;
        // Last Name
        if(lastName.checkEmpty)return;
        // Store Name
        if(storeName.checkEmpty)return;
        // Company Name
        if(companyName.checkEmpty)return;
        // Work Adress
        if(workAddress.checkEmpty)return;
        // Business number
        if(businessNumber.checkEmpty)return;
        // Email
        if(emailAddress.checkBothWithEmail)return;
        // Work Email
        if(workEmail.checkBothWithEmail)return;
      }
      return;
    }
    if(selectedPlan == PlansType.personal){
      // Payment receipt certificate
      if (paymentReceiptCertificate.path.isEmpty) {
        showToast("Please Select Payment Receipt Certificate");
        paymentReceiptCertificateKey.currentContext!.navigate;
        return;
      }
    }
    if(selectedPlan == PlansType.company){

      // Memorandum of Association
      if (memorandumAssociation.path.isEmpty) {
        showToast("Please Select Memorandum of Association");
        memorandumAssociationKey.currentContext!.navigate;
        return;
      }

      // Commercial license
      if (commercialLicense.path.isEmpty) {
        showToast("Please Select Commercial license");
        commercialLicenseKey.currentContext!.navigate;
        return;
      }

      // Signature approval
      if (signatureApproval.path.isEmpty) {
        showToast("Please Select Signature approval");
        signatureApprovalKey.currentContext!.navigate;
        return;
      }

      // Extract from the Ministry of Commerce
      if (ministryCommerce.path.isEmpty) {
        showToast("Please Select Extract from the Ministry of Commerce");
        ministryCommerceKey.currentContext!.navigate;
        return;
      }

      // Original civil information
      if (originalCivilInformation.path.isEmpty) {
        showToast("Please Select Original civil information");
        originalCivilInformationKey.currentContext!.navigate;
        return;
      }

      // Company bank account
      if (companyBankAccount.path.isEmpty) {
        showToast("Please Select Company bank account");
        companyBankAccountKey.currentContext!.navigate;
        return;
      }
    }



    /// Map Data
    /*{
  'first_name': 'karan',
  'last_name': 'Junwal',
  'email': 'karanjunwal143@yopmail.com',
  'phone': '8599612592',
  'password': '12345678',
  'store_name': 'halak',
  'store_url': 'www.abc.com',
  'category_id': '3',
  'store_address': 'Jaipur',
  'store_business_id': '1',
  'store_about_us': 'checking out',
  'store_about_me': 'damn serious',
  'vendor_type': 'company',
  'owner_name': 'Rishi',
  'ceo_name': 'dsfsdfs',
  'home_address': 'Amer Road',
  'partners': '6',
  'company_name': 'webluci',
  'work_email': 'luci@yopmail.com',
  'tax_number': '',
  'label1': 'optional',
  'label2': 'optional',
  'label3': 'optional',
  'work_address': 'adfadfda'
}*/

    Map<String, String> map = {};
    if(selectedPlan == PlansType.advertisement){
      map = {
        'first_name': firstName.text.trim(),
        'last_name': lastName.text.trim(),
        'email': emailAddress.text.trim(),
        'phone': phoneNumber.text.trim(),
        'store_name': storeName.text.trim(),
        'home_address': homeAddress.text.trim(),
      };
    }
    if(selectedPlan == PlansType.personal){
      map = {
        'partners': partnerCount.text.trim(),
        'first_name': firstName.text.trim(),
        'ceo_name': ceoName.text.trim(),
        'last_name': lastName.text.trim(),
        'email': emailAddress.text.trim(),
        'phone': phoneNumber.text.trim(),
        'store_name': storeName.text.trim(),
        'home_address': homeAddress.text.trim(),
      };
    }
    if(selectedPlan == PlansType.company){
      // Business number
      map = {
        'first_name': firstName.text.trim(),
        'last_name': lastName.text.trim(),
        'email': emailAddress.text.trim(),
        'store_name': storeName.text.trim(),
        'company_name': companyName.text.trim(),
        'work_address': workAddress.text.trim(),
        'work_email': workEmail.text.trim(),
        'business_number': businessNumber.text.trim(),
      };
    }

    map["vendor_type"] = selectedPlan.name;





    /// Files upload map
    Map<String, File> images = {};

    if(selectedPlan == PlansType.personal){
      images["payment_certificate"] = paymentReceiptCertificate;
    }

    if(selectedPlan == PlansType.company){
      // Memorandum of Association  ✅
      // Commercial license ✅
      // Signature approval ✅
      // Extract from the Ministry of Commerce ✅
      // Original civil information ✅
      // Company bank account ✅
      images["memorandum_of_association"] = memorandumAssociation;
      images["commercial_license"] = commercialLicense;
      images["signature_approval"] = signatureApproval;
      images["ministy_of_commerce"] = ministryCommerce;
      images["original_civil_information"] = originalCivilInformation;
      images["company_bank_account"] = companyBankAccount;
    }
    repositories
        .multiPartApi(
            mapData: map,
            images: images,
            context: context,
            url: ApiUrls.vendorRegistrationUrl,
            onProgress: (int bytes, int totalBytes) {
              NotificationService().showNotificationWithProgress(
                  title: "Uploading Documents", body: "Uploading Documents are in progress", payload: "payload",
                  maxProgress: 100, progress: ((bytes/ totalBytes) * 100).toInt(), progressId: 770);
            })
        .then((value) {
      NotificationService().hideAllNotifications();
      ModelVendorRegistrationResponse response = ModelVendorRegistrationResponse.fromJson(jsonDecode(value));
      showToast(response.message.toString());
      if (response.status == true && response.otp != null) {
        Get.to(() => const VendorOTPVerification(), arguments: [emailAddress.text.trim(),planInfo]);
      }
    }).catchError((e){
      NotificationService().hideAllNotifications();
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

    selectedPlan = PlansType.values.firstWhere(
        (element) => element.name.toLowerCase() == widget.selectedPlan.businessType.toString(),
        orElse: () => PlansType.personal);
    // vendorType= getVendorType;
    // storeType = widget.selectedPlan.businessType.toString();
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
      appBar: const CommonAppBar(
        titleText: "Vendor Registration",
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
                    planCard(),

                    if (selectedPlan == PlansType.advertisement) ...[
                      14.spaceY,
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
                      14.spaceY,
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
                        validation: checkValidation(showValidation.value, paymentReceiptCertificate.path.isEmpty),
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
                      14.spaceY,
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
                            if (value!.trim().isEmpty) {
                              return "Please enter work email";
                            }
                            if (value.trim().invalidEmail) {
                              return "Please enter valid email address";
                            }
                            return null;
                          }),

                      14.spaceY,
                      //Optional1
                      VendorCommonTextfield(
                          controller: optional1Plan3,
                          key: optional1Plan3.getKey,
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
                          controller: optional2Plan3,
                          key: optional2Plan3.getKey,
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
                          controller: optional3Plan3,
                          key: optional3Plan3.getKey,
                          hintText: "Optional3",
                          validator: (value) {
                            // if (value!.trim().isEmpty) {
                            //   return "Please enter home address";
                            // }
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
                        validation: checkValidation(showValidation.value, memorandumAssociation.path.isEmpty),
                        filePicked: (File g) {
                          memorandumAssociation = g;
                        },
                      ),
                      ImageWidget(
                        title: "Commercial license",
                        file: commercialLicense,
                        key: commercialLicenseKey,
                        validation: checkValidation(showValidation.value, commercialLicense.path.isEmpty),
                        filePicked: (File g) {
                          commercialLicense = g;
                        },
                      ),
                      ImageWidget(
                        title: "Signature approval",
                        file: signatureApproval,
                        key: signatureApprovalKey,
                        validation: checkValidation(showValidation.value, signatureApproval.path.isEmpty),
                        filePicked: (File g) {
                          signatureApproval = g;
                        },
                      ),
                      ImageWidget(
                        title: "Extract from the Ministry of Commerce",
                        file: ministryCommerce,
                        key: ministryCommerceKey,
                        validation: checkValidation(showValidation.value, ministryCommerce.path.isEmpty),
                        filePicked: (File g) {
                          ministryCommerce = g;
                        },
                      ),
                      ImageWidget(
                        title: "Original civil information",
                        file: originalCivilInformation,
                        key: originalCivilInformationKey,
                        validation: checkValidation(showValidation.value, originalCivilInformation.path.isEmpty),
                        filePicked: (File g) {
                          originalCivilInformation = g;
                        },
                      ),
                      ImageWidget(
                        title: "Company bank account",
                        file: companyBankAccount,
                        key: companyBankAccountKey,
                        validation: checkValidation(showValidation.value, companyBankAccount.path.isEmpty),
                        filePicked: (File g) {
                          companyBankAccount = g;
                        },
                      ),
                    ],
                    const SizedBox(height: 25,),
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
