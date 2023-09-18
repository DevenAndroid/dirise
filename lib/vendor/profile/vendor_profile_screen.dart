import 'dart:convert';
import 'dart:io';
import 'package:dirise/utils/helper.dart';
import 'package:dirise/widgets/loading_animation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../controller/vendor_controllers/vendor_profile_controller.dart';
import '../../model/bank_details/model_bank_list.dart';
import '../../model/common_modal.dart';
import '../../model/vendor_models/model_payment_method.dart';
import '../../model/vendor_models/model_plan_list.dart';
import '../../model/vendor_models/model_vendor_details.dart';
import '../../model/vendor_models/model_vendor_registration.dart';
import '../../repository/repository.dart';
import '../../utils/ApiConstant.dart';
import '../../utils/notification_service.dart';
import '../../utils/styles.dart';
import '../../widgets/common_colour.dart';
import '../../widgets/dimension_screen.dart';
import '../../widgets/vendor_common_textfield.dart';
import '../authenthication/image_widget.dart';
import '../authenthication/payment_screen.dart';
import '../authenthication/thanku_screen.dart';
import '../authenthication/vendor_registration_screen.dart';

class VendorProfileScreen extends StatefulWidget {
  const VendorProfileScreen({super.key, this.selectedPlan, this.planId});

  final PlansType? selectedPlan;
  final String? planId;
  static String route = "/VendorProfileScreen";

  @override
  State<VendorProfileScreen> createState() => _VendorProfileScreenState();
}

class _VendorProfileScreenState extends State<VendorProfileScreen> {
  String get planId => widget.planId!;

  final vendorProfileController = Get.put(VendorProfileController());

  PlanInfoData get planInfo => PlanInfoData();

  ModelPaymentMethods? methods;
  String paymentMethod = "";

  getPaymentGateWays() {
    if (methods != null) return;
    repositories.getApi(url: ApiUrls.paymentMethodsUrl).then((value) {
      methods = ModelPaymentMethods.fromJson(jsonDecode(value));
      setState(() {});
    });
  }

  getPaymentUrl() {
    if (paymentMethod.isEmpty) {
      showToast("Please select payment method");
      return;
    }
    repositories.postApi(url: ApiUrls.createPaymentUrl, context: context, mapData: {
      'plan_id': planId,
      'callback_url': 'https://dirise.eoxyslive.com/home/$navigationBackUrl',
      'payment_method': paymentMethod,
    }).then((value) {
      ModelCommonResponse modelCommonResponse = ModelCommonResponse.fromJson(jsonDecode(value));
      if (modelCommonResponse.uRL != null) {
        Get.to(() => VendorPaymentScreen(
              paymentUrl: modelCommonResponse.uRL,
            ));
      }
    });
  }

  final _formKey = GlobalKey<FormState>();
  final GlobalKey categoryKey = GlobalKey();

  Rx<File> storeImage = File("").obs;
  Rx<File> businessImage = File("").obs;
  RxBool showValidation = false.obs;
  RxBool hideText = true.obs;
  final Repositories repositories = Repositories();

  ModelBankList? modelBankList;
  String bankId = "";

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


  final TextEditingController accountNumber = TextEditingController();
  final TextEditingController ibnNumber = TextEditingController();
  final TextEditingController accountHolderName = TextEditingController();


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

  updateControllers() {
    if (valuesLoaded) return;
    if (widget.selectedPlan != null) {
      getPaymentGateWays();
    }
    if (vendorProfileController.model.user == null) return;
    if (widget.selectedPlan == null) {
      selectedPlan = PlansType.values.firstWhere(
          (element) => element.name.toString() == vendorInfo.vendorType.toString(),
          orElse: () => PlansType.personal);
    } else {
      selectedPlan = widget.selectedPlan!;
    }
    firstName.text = vendorInfo.firstName ?? "";
    lastName.text = vendorInfo.lastName ?? "";
    storeName.text = vendorInfo.storeName ?? "";
    homeAddress.text = vendorInfo.address ?? "";
    phoneNumber.text = vendorInfo.phone ?? "";
    emailAddress.text = vendorInfo.email ?? "";
    if (vendorInfo.vendorProfile != null) {
      businessNumber.text = vendorInfo.vendorProfile!.business_number ?? "";
      homeAddress.text = vendorInfo.vendorProfile!.home_address ?? "";
      bankId = vendorInfo.vendorProfile!.bank_name ?? "";
      accountNumber.text = vendorInfo.vendorProfile!.account_number ?? "";
      ibnNumber.text = vendorInfo.vendorProfile!.ibn_number ?? "";
      accountHolderName.text = vendorInfo.vendorProfile!.account_holder_name ?? "";
      ceoName.text = (vendorInfo.vendorProfile!.ceoName ?? "").toString();
      partnerCount.text = (vendorInfo.vendorProfile!.partners ?? "").toString();
      paymentReceiptCertificate = File((vendorInfo.vendorProfile!.paymentCertificate ?? "").toString());
      companyName.text = (vendorInfo.vendorProfile!.companyName ?? "").toString();
      workAddress.text = (vendorInfo.vendorProfile!.workAddress ?? "").toString();
      workEmail.text = (vendorInfo.vendorProfile!.workEmail ?? "").toString();
      // businessNumber.text = (vendorInfo.vendorProfile. ?? "").toString();
      taxNumber.text = (vendorInfo.vendorProfile!.taxNumber ?? "").toString();
      memorandumAssociation = File((vendorInfo.vendorProfile!.memorandumOfAssociation ?? "").toString());
      commercialLicense = File((vendorInfo.vendorProfile!.commercialLicense ?? "").toString());
      signatureApproval = File((vendorInfo.vendorProfile!.signatureApproval ?? "").toString());
      ministryCommerce = File((vendorInfo.vendorProfile!.ministyOfCommerce ?? "").toString());
      originalCivilInformation = File((vendorInfo.vendorProfile!.originalCivilInformation ?? "").toString());
      companyBankAccount = File((vendorInfo.vendorProfile!.companyBankAccount ?? "").toString());
    }
    valuesLoaded = true;
  }

  bool get planUpdate => widget.selectedPlan != null;

  void updateProfile() {
    if (showValidation.value == false) {
      showValidation.value = true;
      setState(() {});
    }

    /// Validations
    if (!_formKey.currentState!.validate()) {
      if (selectedPlan == PlansType.advertisement) {
        // First Name
        if (firstName.checkEmpty) return;
        // Last Name
        if (lastName.checkEmpty) return;
        // Store Name
        if (storeName.checkEmpty) return;
        // Home Adress
        if (homeAddress.checkEmpty) return;
        // Phone Number
        if (phoneNumber.checkBothWithPhone) return;
        // Email
        if (emailAddress.checkBothWithEmail) return;
        // Optional
        // Optional
        // Optional
      }
      if (selectedPlan == PlansType.personal) {
        // First Name
        if (firstName.checkEmpty) return;
        // Last Name
        if (lastName.checkEmpty) return;
        // Store Name
        if (storeName.checkEmpty) return;
        // Home Adress
        if (homeAddress.checkEmpty) return;
        // Phone Number
        if (ceoName.checkEmpty) return;
        // Email
        if (partnerCount.checkEmpty) return;
        // Phone Number
        if (phoneNumber.checkBothWithPhone) return;
        // Phone Number
        if (emailAddress.checkBothWithEmail) return;
        // accountNumber
        if (bankId.isEmpty){
          accountNumber.getKey.currentContext!.navigate;
          return;
        }
        // accountNumber
        if (accountNumber.checkEmpty) return;
        // ibnNumber
        if (ibnNumber.checkEmpty) return;
        // accountHolderName
        if (accountHolderName.checkEmpty) return;
      }
      if (selectedPlan == PlansType.company) {
        // First Name
        if (firstName.checkEmpty) return;
        // Last Name
        if (lastName.checkEmpty) return;
        // Store Name
        if (storeName.checkEmpty) return;
        // Company Name
        if (companyName.checkEmpty) return;
        // Work Adress
        if (workAddress.checkEmpty) return;
        // Business number
        if (businessNumber.checkEmpty) return;
        // Email
        if (emailAddress.checkBothWithEmail) return;
        // Work Email
        if (workEmail.checkBothWithEmail) return;

        // accountNumber
        if (bankId.isEmpty){
          accountNumber.getKey.currentContext!.navigate;
          return;
        }
        // accountNumber
        if (accountNumber.checkEmpty) return;
        // ibnNumber
        if (ibnNumber.checkEmpty) return;
        // accountHolderName
        if (accountHolderName.checkEmpty) return;
      }
      return;
    }
    if (selectedPlan == PlansType.personal) {
      // Payment receipt certificate
      if (paymentReceiptCertificate.path.isEmpty) {
        showToast("Please Select Payment Receipt Certificate");
        paymentReceiptCertificateKey.currentContext!.navigate;
        return;
      }
    }
    if (selectedPlan == PlansType.company) {
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

    if (planUpdate && paymentMethod.isEmpty) {
      showToast("Please select payment method");
      return;
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
    if (selectedPlan == PlansType.advertisement) {
      map = {
        'first_name': firstName.text.trim(),
        'last_name': lastName.text.trim(),
        'email': emailAddress.text.trim(),
        'phone': phoneNumber.text.trim(),
        'store_name': storeName.text.trim(),
        'home_address': homeAddress.text.trim(),
      };
    }
    if (selectedPlan == PlansType.personal) {

      // 'account_number': '96969696969696',
      // 'work_address': 'adfadfda',
      // 'business_number': '969',
      // 'ibn_number': 'KOM9696',
      // 'label1': 'optional',
      // 'account_holder_name': '',
      // 'bank_name': ''
      map = {
        'partners': partnerCount.text.trim(),
        'first_name': firstName.text.trim(),
        'ceo_name': ceoName.text.trim(),
        'last_name': lastName.text.trim(),
        'email': emailAddress.text.trim(),
        'phone': phoneNumber.text.trim(),
        'store_name': storeName.text.trim(),
        'home_address': homeAddress.text.trim(),


        'account_number': accountNumber.text.trim(),
        'ibn_number': ibnNumber.text.trim(),
        'account_holder_name': accountHolderName.text.trim(),
        'bank_name': bankId,
      };
    }
    if (selectedPlan == PlansType.company) {
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

        'account_number': accountNumber.text.trim(),
        'ibn_number': ibnNumber.text.trim(),
        'account_holder_name': accountHolderName.text.trim(),
        'bank_name': bankId,
        'tax_number': taxNumber.text.trim(),
      };
    }

    map["vendor_type"] = selectedPlan.name;

    /// Files upload map
    Map<String, File> images = {};

    if (selectedPlan == PlansType.personal) {
      images["payment_certificate"] = paymentReceiptCertificate;
    }

    if (selectedPlan == PlansType.company) {
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
            url: ApiUrls.editVendorDetailsUrl,
            onProgress: (int bytes, int totalBytes) {
              NotificationService().showNotificationWithProgress(
                  title: "Uploading Documents",
                  body: "Uploading Documents are in progress",
                  payload: "payload",
                  maxProgress: 100,
                  progress: ((bytes / totalBytes) * 100).toInt(),
                  progressId: 770);
            })
        .then((value) {
      NotificationService().hideAllNotifications();
      ModelVendorRegistrationResponse response = ModelVendorRegistrationResponse.fromJson(jsonDecode(value));
      showToast(response.message.toString());
      if (response.status == true) {
        if (!planUpdate) {
          Get.back();
        } else {
          getPaymentUrl();
        }
      }
    }).catchError((e) {
      NotificationService().hideAllNotifications();
    });
  }

  RxInt bankListValue = 0.obs;

  Future getBankList() async {
    await repositories.getApi(url: ApiUrls.bankListUrl).then((value) {
      modelBankList = ModelBankList.fromJson(jsonDecode(value));
      bankListValue.value = DateTime.now().millisecondsSinceEpoch;
    });
  }

  @override
  void initState() {
    super.initState();
    getBankList();
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
        if (vendorProfileController.refreshInt.value > 0) {}
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
                                ...bankDetails(),
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
                                  validation:
                                      checkValidation(showValidation.value, paymentReceiptCertificate.path.isEmpty),
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
                                    keyboardType: TextInputType.number,
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
                                ...bankDetails(),

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
                                  validation:
                                      checkValidation(showValidation.value, originalCivilInformation.path.isEmpty),
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
                              const SizedBox(
                                height: 10,
                              ),
                              if (methods != null && methods!.data != null)
                                DropdownButtonFormField(
                                    decoration: InputDecoration(
                                      border: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(8)),
                                        borderSide: BorderSide(color: AppTheme.secondaryColor),
                                      ),
                                      enabled: true,
                                      filled: true,
                                      hintText: "Select Payment Method",
                                      labelStyle: GoogleFonts.poppins(color: Colors.black),
                                      labelText: "Select Payment Method",
                                      fillColor: const Color(0xffE2E2E2).withOpacity(.35),
                                      contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 14),
                                      enabledBorder: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(8)),
                                        borderSide: BorderSide(color: AppTheme.secondaryColor),
                                      ),
                                    ),
                                    validator: (value) {
                                      if (paymentMethod.isEmpty) {
                                        return "Please select payment method";
                                      }
                                      return null;
                                    },
                                    isExpanded: true,
                                    items: methods!.data!
                                        .map((e) => DropdownMenuItem(
                                            value: e.paymentMethodId.toString(),
                                            child: Row(
                                              children: [
                                                Expanded(child: Text(e.paymentMethodEn.toString())),
                                                SizedBox(
                                                    width: 35, height: 35, child: Image.network(e.imageUrl.toString()))
                                              ],
                                            )))
                                        .toList(),
                                    onChanged: (value) {
                                      if (value == null) return;
                                      paymentMethod = value;
                                    }),
                              const SizedBox(
                                height: 25,
                              ),
                              ElevatedButton(
                                  onPressed: () {
                                    updateProfile();
                                  },
                                  style: ElevatedButton.styleFrom(
                                      minimumSize: const Size(double.maxFinite, 60),
                                      backgroundColor: AppTheme.buttonColor,
                                      elevation: 0,
                                      shape:
                                          RoundedRectangleBorder(borderRadius: BorderRadius.circular(AddSize.size10)),
                                      textStyle:
                                          GoogleFonts.poppins(fontSize: AddSize.font20, fontWeight: FontWeight.w600)),
                                  child: Text(
                                    "Submit",
                                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                                        color: Colors.white, fontWeight: FontWeight.w500, fontSize: AddSize.font18),
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

  bool get bankLoaded => modelBankList != null && modelBankList!.data != null && modelBankList!.data!.banks != null;
  bool errorResolved = false;
  resolveError(){
    if(errorResolved)return;
    if(bankId.isEmpty)return;
    if(bankLoaded){
      int temp = modelBankList!.data!.banks!.indexWhere((element) => element.id.toString() == bankId);
      if(temp == -1){
        bankId = "";
      }
      errorResolved = true;
    }
  }

  List<Widget> bankDetails() {
    return [
      14.spaceY,
      //Bank List
      Obx(() {
        if (bankListValue.value > 0) {}
        resolveError();
        return DropdownButtonFormField<String?>(
          isExpanded: true,
          value: bankLoaded ? bankId.isNotEmpty ? bankId : null : null,
          style: const TextStyle(color: Colors.red),
          decoration: InputDecoration(
            hintText: "Please select bank",
            labelText: "Please select bank",
            filled: true,
            fillColor: const Color(0xffE2E2E2).withOpacity(.35),
            labelStyle: GoogleFonts.poppins(
              color: Colors.black,
              fontSize: 14,
            ),
            contentPadding: const EdgeInsets.all(15),
            focusedErrorBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                borderSide: BorderSide(color: AppTheme.secondaryColor)),
            errorBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                borderSide: BorderSide(color: AppTheme.secondaryColor)),
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
          icon: const Icon(Icons.keyboard_arrow_down),
          items: bankLoaded
              ? modelBankList!.data!.banks!
                  .map((e) => DropdownMenuItem(
                        value: e.id.toString(),
                        child: Text(
                          e.name.toString(),
                          style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w500, color: Colors.black),
                        ),
                      ))
                  .toList()
              : [],
          validator: (value) {
            if (bankId.isEmpty) {
              return "Please select bank";
            }
            return null;
          },
          onChanged: (newValue) {
            if(newValue == null)return;
            bankId = newValue;
            setState(() {});
          },
        );
      }),
      14.spaceY,
      //accountNumber
      VendorCommonTextfield(
          controller: accountNumber,
          key: accountNumber.getKey,
          hintText: "Account Number",
          validator: (value) {
            if (value!.trim().isEmpty) {
              return "Please enter account number";
            }
            return null;
          }),
      14.spaceY,
      //ibnNumber
      VendorCommonTextfield(
          controller: ibnNumber,
          key: ibnNumber.getKey,
          hintText: "IBM Number",
          validator: (value) {
            if (value!.trim().isEmpty) {
              return "Please enter IBM number";
            }
            return null;
          }),
      14.spaceY,
      //accountHolderName
      VendorCommonTextfield(
          controller: accountHolderName,
          key: accountHolderName.getKey,
          hintText: "Account Holder Name",
          validator: (value) {
            if (value!.trim().isEmpty) {
              return "Please enter account holder name";
            }
            return null;
          }),
    ];
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
