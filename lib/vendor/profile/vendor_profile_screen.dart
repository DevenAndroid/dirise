import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dirise/utils/helper.dart';
import 'package:dirise/widgets/loading_animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../controller/vendor_controllers/vendor_profile_controller.dart';
import '../../model/vendor_models/model_vendor_details.dart';
import '../../model/vendor_models/model_vendor_registration.dart';
import '../../model/vendor_models/vendor_category_model.dart';
import '../../repository/repository.dart';
import '../../utils/ApiConstant.dart';
import '../../widgets/common_colour.dart';
import '../../widgets/dimension_screen.dart';
import '../../widgets/vendor_common_textfield.dart';

class VendorProfileScreen extends StatefulWidget {
  const VendorProfileScreen({super.key});
  static String route = "/VendorProfileScreen";

  @override
  State<VendorProfileScreen> createState() => _VendorProfileScreenState();
}

class _VendorProfileScreenState extends State<VendorProfileScreen> {
  final vendorProfileController = Get.put(VendorProfileController());

  final _formKey = GlobalKey<FormState>();
  final GlobalKey categoryKey = GlobalKey();

  Map<String, TextEditingController> textControllers = {
    "store_name": TextEditingController(),
    "phone": TextEditingController(),
    "email": TextEditingController(),
    "store_address": TextEditingController(),
    "store_phone": TextEditingController(),
    "store_business_id": TextEditingController(),
    "store_about_us": TextEditingController(),
    "store_about_me": TextEditingController(),
  };

  Rx<File> storeImage = File("").obs;
  Rx<File> businessImage = File("").obs;
  RxBool showValidation = false.obs;
  RxBool hideText = true.obs;
  bool allLoaded = false;
  final Repositories repositories = Repositories();
  Rx<RxStatus> vendorCategoryStatus = RxStatus.empty().obs;
  ModelVendorCategory modelVendorCategory = ModelVendorCategory(usphone: []);
  // Map<String, VendorCategoriesData> allSelectedCategory = {};

  updateParameters() {
    VendorUser? user = vendorProfileController.model.user;
    if (user == null) return;
    if (modelVendorCategory.usphone!.isEmpty) return;

    log("updating values.........11          ${user.toJson()}");
    textControllers["store_name"]!.text = user.storeName.toString().checkNullable;
    textControllers["phone"]!.text = user.phone.toString().checkNullable;
    textControllers["email"]!.text = user.email.toString().checkNullable;
    textControllers["store_address"]!.text = user.storeAddress.toString().checkNullable;
    textControllers["store_business_id"]!.text = user.storeBusinessId.toString().checkNullable;
    textControllers["store_about_us"]!.text = user.storeAboutUs.toString().checkNullable;
    textControllers["store_about_me"]!.text = user.storeAboutMe.toString().checkNullable;
    textControllers["store_phone"]!.text = user.storePhone.toString().checkNullable;
    storeImage.value = File(user.storeLogo.toString().checkNullable);
    businessImage.value = File(user.storeImage.toString().checkNullable);
    allLoaded = true;
    // for (var element in user.venderCategory!) {
    //   allSelectedCategory[element.id.toString()] = VendorCategoriesData.fromJson(element.toJson());
    // }
    // allSelectedCategory
    setState(() {});
  }

  void updateVendorProfile() {
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
        Scrollable.ensureVisible(categoryKey.currentContext!, alignment: .25, duration: const Duration(milliseconds: 600));
      }
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
    Map<String, String> map = textControllers.map((key, value) => MapEntry(key, value.text.trim()));
    // map["category_id"] = allSelectedCategory.entries.map((e) => e.key).toList().join(",");

    Map<String, File> images = {};
    if (storeImage.value.path.checkHTTP.isEmpty) {
      images["store_logo"] = storeImage.value;
    }
    if (businessImage.value.path.checkHTTP.isEmpty) {
      images["store_image"] = businessImage.value;
    }

    repositories
        .multiPartApi(
            mapData: map,
            images: images,
            context: context,
            url: ApiUrls.editVendorDetailsUrl,
            onProgress: (int bytes, int totalBytes) {
              // print((bytes/totalBytes).toStringAsFixed(2));
            })
        .then((value) {
      ModelVendorRegistrationResponse response = ModelVendorRegistrationResponse.fromJson(jsonDecode(value));
      showToast(response.message.toString());
      if (response.status == true) {
        vendorProfileController.getVendorDetails();
        Get.back();
      }
    });
  }

  void getVendorCategories() {
    vendorCategoryStatus.value = RxStatus.loading();
    repositories.getApi(url: ApiUrls.vendorCategoryListUrl).then((value) {
      modelVendorCategory = ModelVendorCategory.fromJson(jsonDecode(value));
      vendorCategoryStatus.value = RxStatus.success();
      updateParameters();
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
    if (vendorProfileController.apiLoaded == false) {
      vendorProfileController.getVendorDetails().then((value) {
        updateParameters();
      });
    } else {
      updateParameters();
    }
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
      body: allLoaded
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


                            ElevatedButton(
                                onPressed: () {
                                  updateVendorProfile();
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
            )
          : const LoadingAnimation(),
    );
  }
}
