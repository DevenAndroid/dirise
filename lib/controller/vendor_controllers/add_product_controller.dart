import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../model/common_modal.dart';
import '../../model/vendor_models/model_add_product_category.dart';
import '../../model/vendor_models/model_attribute.dart';
import '../../model/vendor_models/model_varient.dart';
import '../../model/vendor_models/model_vendor_product_details.dart';
import '../../repository/repository.dart';
import '../../utils/ApiConstant.dart';
import '../../utils/helper.dart';
import '../../utils/notification_service.dart';
import '../../vendor/products/add_product/varient_product/varient_product.dart';
import 'products_controller.dart';

class AddProductController extends GetxController {
  // Gram Kilogram Pound

  List<String> gg = [
    "Gram",
    "Kilogram",
    "Pound",
  ];

  String productDurationValue = "";
  String productDurationTypeValue = "";

  List<String> productDuration = [];

  List<String> productDurationType = [
    "None",
    "Hours",
    "Days",
    "Months"
  ];

  ModelAddProductCategory productCategory = ModelAddProductCategory(data: []);
  RxInt refreshCategory = 0.obs;

  getProductAttributes() {
    repositories.getApi(url: ApiUrls.getAttributeUrl).then((value) {
      modelAttributes = ModelAttributes.fromJson(jsonDecode(value));
      updateVariants();
      attributeRefresh.value = DateTime.now().millisecondsSinceEpoch;
    });
  }

  Future getProductCategoryLit() async {
    refreshCategory.value = -2;
    await repositories.postApi(url: ApiUrls.productCategoryListUrl, showResponse: false, showMap: false).then((value) {
      productCategory = ModelAddProductCategory.fromJson(jsonDecode(value));
      updateCategory();
      refreshCategory.value = DateTime.now().millisecondsSinceEpoch;
    });
  }

  final Repositories repositories = Repositories();
  final productListController = Get.put(ProductsController());

  RxInt refreshInt = 0.obs;
  bool apiLoaded = false;
  String productId = "";

  final GlobalKey slotKey = GlobalKey();
  final GlobalKey categoryKey = GlobalKey();
  final GlobalKey productAvailabilityKey = GlobalKey();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController startTime = TextEditingController();
  final TextEditingController endTime = TextEditingController();
  final TextEditingController serviceDuration = TextEditingController();
  final TextEditingController startDate = TextEditingController();
  final TextEditingController endDate = TextEditingController();
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController skuController = TextEditingController();
  final TextEditingController purchasePriceController = TextEditingController();
  final TextEditingController sellingPriceController = TextEditingController();
  final TextEditingController stockController = TextEditingController();
  final TextEditingController shortDescriptionController = TextEditingController();
  final TextEditingController longDescriptionController = TextEditingController();
  final TextEditingController returnDaysController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  // final TextEditingController weightUnitController = TextEditingController();
  String weightUnit = "";
  final GlobalKey weightUnitKey = GlobalKey();

  RxString productFileType = "".obs;
  File productImage = File("");
  RxInt virtualRefreshInt = 0.obs;
  File pdfFile = File("");
  File voiceFile = File("");
  List<File> galleryImages = [];
  String selectedCategory = "";
  String productType = "Simple Product";
  bool showValidations = false;
  DateTime? selectedStartDateTime;
  DateTime? selectedEndDateTIme;
  Map<Map<DateTime, DateTime>, bool> slots = {};

  RxString bookingType = "Virtual".obs;
  RxString dateType = "date".obs;
  final DateFormat timeFormatWithoutAMPM = DateFormat("hh:mm");

  ModelVendorProductDetails productDetails = ModelVendorProductDetails();
  List<ServiceTimeSloat> serviceTimeSloat = [];
  bool resetSlots = false;

  // For Variation
  ModelAttributes modelAttributes = ModelAttributes();
  RxInt attributeRefresh = 0.obs;
  RxInt variation = 0.obs;
  List<AttributeData> attributeList = [];
  final GlobalKey attributeListKey = GlobalKey();
  final GlobalKey attributeEmptyListKey = GlobalKey();
  final GlobalKey createAttributeButton = GlobalKey();
  List<AddMultipleItems> addMultipleItems = [];

  filterClearAttributes(){
    addMultipleItems.removeWhere((element) => !element.live);
    variation.value = DateTime.now().millisecondsSinceEpoch;
  }

  bool valuesAssigned = false;

  updateVariants(){
    if (productDetails.product == null) return;
    if(valuesAssigned)return;
    ModelVendorProductDetailsData item = productDetails.product!;
    if(productId.isNotEmpty && item.productType == "variants"){
      productType = "Variants Product";
    }
    if (modelAttributes.data != null && modelAttributes.data!.isNotEmpty) {

      for (var element in item.variantData!) {

        Map<String, GetAttrvalues> kk = {};
        for (var i in element.variantValue.entries) {
          if(modelAttributes.attributeMap[i.value.toString()] != null) {
            kk[i.key] = modelAttributes.attributeMap[i.value.toString()]!;
          }
        }

        addMultipleItems.add(AddMultipleItems.fromServer(
            attr: kk,
            filePath: element.variantImages.toString(),
            variantSkuLive: element.variantSku.toString(),
            variantPriceLive: element.variantPrice.toString(),
            variantStockLive: element.variantStock.toString()));
      }
      valuesAssigned = true;

      // for (var element in addMultipleItems) {
      //   for (var element1 in modelAttributes.data!) {
      //     if(element.attributes != null && element.attributes![element1.slug.toString()] != null){
      //       attributeList.add(element1);
      //     }
      //   }
      // }
      // attributeList = attributeList.toSet().toList();
      variation.value = DateTime.now().millisecondsSinceEpoch;

    }

  }

  updateControllers() {
    if (productDetails.product == null) return;
    ModelVendorProductDetailsData item = productDetails.product!;

    /// Description Part
    if (item.productType == "virtual_product") {
      productType = "Virtual Product";
    }
    updateVariants();

    if (item.productType == "booking") {
      productType = "Booking Product";
      serviceTimeSloat = item.serviceTimeSloat ?? [];
    }
    productNameController.text = item.pName.toString();
    weightController.text = (item.weight ?? "").toString();
    weightUnit = (item.weightUnit ?? "").toString();
    if(!gg.contains(weightUnit)){
      gg.add(weightUnit);
    }
    skuController.text = item.skuId.toString();
    purchasePriceController.text = (item.pPrice ?? "").toString();
    sellingPriceController.text = item.sPrice.toString();
    stockController.text = item.inStock.toString();
    shortDescriptionController.text = item.shortDescription.toString();
    longDescriptionController.text = item.longDescription.toString();
    returnDaysController.text = item.returnDays.toString();
    productDurationValue = (item.time ?? "").toString();
    productDurationTypeValue = (item.time_period ?? "").toString();
    updateCategory();
    galleryImages.clear();
    for (var element in item.galleryImage!) {
      galleryImages.add(File(element));
    }
    productImage = File((item.featuredImage ?? "").toString());

    /// Virtual Part
    if (productType == "Virtual Product") {
      if (item.virtualProductFileType == "pdf") {
        productFileType.value = "pdf";
        pdfFile = File(item.virtualProductFile.toString());
      } else {
        productFileType.value = "voice";
        voiceFile = File(item.virtualProductFile.toString());
      }
      // productFileType
    }

    /// Booking Part
    if (productType == "Booking Product") {
      // 1. First Booking Type
      if (item.bookingProductType.toString() == "Personal") {
        bookingType.value = "Personal";
      } else {
        bookingType = "Virtual".obs;
      }

      // 2. Product Availability
      if (item.productAvailability != null) {
        dateType.value = (item.productAvailability!.type ?? "date").toString();
        updateStartDateTime();
        updateEndDateTime();
      }
    }
    updateUI;
  }

  updateStartDateTime() {
    try {
      selectedStartDateTime =
          DateFormat("yyyy-MM-dd").parse(productDetails.product!.productAvailability!.fromDate.toString());
      startDate.text = DateFormat("dd-MMM-yyyy").format(selectedStartDateTime!);
    } catch (e) {
      throw Exception(e);
    }
  }

  updateEndDateTime() {
    try {
      selectedEndDateTIme =
          DateFormat("yyyy-MM-dd").parse(productDetails.product!.productAvailability!.toDate.toString());
      endDate.text = DateFormat("dd-MMM-yyyy").format(selectedEndDateTIme!);
    } catch (e) {
      throw Exception(e);
    }
  }

  updateCategory() {
    if (productDetails.product != null && productCategory.data != null && productCategory.data!.isNotEmpty) {
      if (productCategory.data!.map((e) => e.id.toString()).contains(productDetails.product!.catId.toString())) {
        selectedCategory = productDetails.product!.catId.toString();
        refreshCategory.value = DateTime.now().millisecondsSinceEpoch;
      }
    }
  }

  String convertToTime(String gg) {
    return "${gg.split(":")[0]}:${gg.split(":")[1]}";
  }

  deleteProduct(BuildContext context){
    repositories.postApi(url: ApiUrls.deleteProductUrl,
    context: context,
    mapData: {
      'product_id': productId.toString(),
    }
    ).then((value) {
      ModelCommonResponse modelCommonResponse = ModelCommonResponse.fromJson(jsonDecode(value));
      showToast(modelCommonResponse.message.toString());
      if(modelCommonResponse.status == true){
        productListController.getProductList();
        Get.back();
        Get.back();
      }
    });
  }

  addProduct({required BuildContext context}) {
    if (showValidations == false) {
      showValidations = true;
      updateUI;
    }
    List<String> timeslots = [];
    if (productId.isNotEmpty && serviceTimeSloat.isNotEmpty && resetSlots == false) {
      timeslots = serviceTimeSloat
          .map((e) => "${convertToTime(e.timeSloat.toString())},${convertToTime(e.timeSloatEnd.toString())}")
          .toList();
    } else if (slots.isNotEmpty) {
      timeslots = slots.entries
          .where((element) => element.value == true)
          .map((e) =>
              "${timeFormatWithoutAMPM.format(e.key.keys.first)},${timeFormatWithoutAMPM.format(e.key.values.first)}")
          .toList();
    }

    /// Form Validation
    if (!formKey.currentState!.validate()) {
      if (productNameController.checkEmpty) return;
      if (skuController.checkEmpty) return;
      if (purchasePriceController.checkBothWithNum) return;
      if (sellingPriceController.checkBothWithNum) return;
      if (stockController.checkBothWithNum) return;
      if (returnDaysController.checkBothWithNum) return;
      if (weightController.checkBothWithNum) return;
      if (weightUnit.isEmpty) {
        if (weightUnitKey.currentContext != null) {
          Scrollable.ensureVisible(weightUnitKey.currentContext!,
              alignment: .25, duration: const Duration(milliseconds: 600));
          return;
        }
      }
      if (selectedCategory.isEmpty) {
        if (categoryKey.currentContext != null) {
          Scrollable.ensureVisible(categoryKey.currentContext!,
              alignment: .25, duration: const Duration(milliseconds: 600));
          return;
        }
      }
      if (shortDescriptionController.checkEmpty) return;
      if (longDescriptionController.checkEmpty) return;

      if (productType == "Variants Product") {
        if (attributeList.isEmpty) {
          attributeListKey.currentContext!.navigate;
          return;
        }
        for (var element in addMultipleItems) {
          if(element.variantImages.path.isEmpty){
            element.variantImageKey.currentContext!.navigate;
            showToast("Select Variant Image",center: true);
            return;
          }
          if (element.variantSku.checkEmpty) return;
          if (element.variantPrice.checkBothWithNum) return;
          if (element.variantStock.checkBothWithNum) return;
        }
      }

      if (productType == "Booking Product") {
        if (startTime.checkEmpty) return;
        if (endTime.checkEmpty) return;
        if (serviceDuration.checkEmpty) return;
        if (startDate.checkEmpty) return;
        if (selectedEndDateTIme == null && dateType.value == "range") {
          if (serviceDuration.checkEmpty) return;
        }
      }

      categoryKey.currentContext!.navigate;
      return;
    }

    /// Other Validation
    if (productType == "Variants Product") {
      // print("testing...    ${}")
      if (!attributeList
          .map((e) => e.getAttrvalues!.map((e2) => e2.selectedVariant).toList().contains(true))
          .toList()
          .contains(true) && addMultipleItems.isEmpty) {
        showToast("Please select at least 1 variant",gravity: ToastGravity.CENTER);
        attributeEmptyListKey.currentContext!.navigate;
        return;
      }
      if(attributeList
          .map((e) => e.getAttrvalues!.map((e2) => e2.selectedVariant).toList().contains(true))
          .toList()
          .contains(true) && addMultipleItems.isEmpty){
        createAttributeButton.currentContext!.navigate.then((value) {
          filterClearAttributes();
          combinations(
              attributeList.map((e) => e.getAttrvalues!.where((element) => element.selectedVariant == true).toList()).toList()
          ).forEach((element) {
            log(element.map((e) => e.aboveParentSlug).toList().toString());
            Map<String, GetAttrvalues> tempMap = {};
            for (var element1 in element) {
              tempMap[element1.aboveParentSlug] = element1;
            }
            addMultipleItems.add(AddMultipleItems(
                attributes: tempMap,
            ));
          });
          Future.delayed(const Duration(milliseconds: 200)).then((value) {
            showToast("Fill available fields properly.",gravity: ToastGravity.CENTER);
          });
          variation.value = DateTime.now().millisecondsSinceEpoch;
        });
        return;
      }
      for (var element in addMultipleItems) {
        if(element.variantImages.path.isEmpty){
          element.variantImageKey.currentContext!.navigate;
          showToast("Select Variant Image",center: true);
          return;
        }
        if (element.variantSku.checkEmpty) return;
        if (element.variantPrice.checkBothWithNum) return;
        if (element.variantStock.checkBothWithNum) return;
      }
    }

    if (productType == "Booking Product") {
      if (timeslots.isEmpty) {
        showToast("Please select slot");
        slotKey.currentContext!.navigate;
        return;
      }
      if (selectedStartDateTime == null) {
        showToast("Please select product availability");
        productAvailabilityKey.currentContext!.navigate;
      }
      if (selectedEndDateTIme == null && dateType.value == "range") {
        showToast("Please select product availability");
        productAvailabilityKey.currentContext!.navigate;
      }
    }

    if (galleryImages.isEmpty) {
      return showToast("Please select product gallery images");
    }
    if (productImage.path.isEmpty) {
      return showToast("Please select product images");
    }



    // return;
    Map<String, String> map = {};
    // single,variants,booking,virtual_product
    map["product_type"] = productType.replaceAll("Product", "").replaceAll("Simple", "single").trim().toLowerCase();
    map["weight"] = weightController.text.trim();
    map["weight_unit"] = weightUnit;

    if(productDurationValue.isNotEmpty && productDurationValue != "none") {
      map["time"] = productDurationValue;
    }
    if(productDurationTypeValue.isNotEmpty && productDurationTypeValue != "none") {
      map["time_period"] = productDurationTypeValue;
    }

    if (productType.replaceAll("Product", "").trim().toLowerCase() == "virtual") {
      // "virtual_product"
      map["product_type"] = "virtual_product";
      map["virtual_product_type"] = productFileType.value == "pdf" ? "digital_reader" : "voice";
    }

    if (productType == "Booking Product") {
      final DateFormat dateFormat = DateFormat("yyyy-MM-dd");

      map["group[0]"] = dateType.value;
      map["booking_product_type"] = bookingType.value;
      if (dateType.value == "date") {
        map["single_date[0]"] = dateFormat.format(selectedStartDateTime!);
      } else {
        map["from_date[0]"] = dateFormat.format(selectedStartDateTime!);
        map["to_date[0]"] = dateFormat.format(selectedEndDateTIme!);
      }
      timeslots.asMap().entries.forEach((element) {
        map["sloat[${element.key}]"] = element.value;
      });
    }

    if (productType == "Variants Product") {
      addMultipleItems.asMap().entries.forEach((element) {
        map["variant_sku[${element.key}]"] = element.value.variantSku.text.trim();
        map["variant_price[${element.key}]"] = element.value.variantPrice.text.trim();
        map["variant_stock[${element.key}]"] = element.value.variantStock.text.trim();
        Map<String, String> kk = {};
        for (var element11 in element.value.attributes!.entries) {
          kk[element11.key] = element11.value.id.toString();
        }
        map["variant_value[${element.key}]"] = jsonEncode(kk);
      });
    }

    map["product_name"] = productNameController.text.trim();
    map["sku_id"] = skuController.text.trim();
    map["purchase_price"] = purchasePriceController.text.trim();
    map["selling_price"] = sellingPriceController.text.trim();
    map["stock"] = stockController.text.trim();
    map["return_days"] = returnDaysController.text.trim();
    map["category_id"] = selectedCategory;
    map["short_description"] = shortDescriptionController.text.trim();
    map["long_description"] = longDescriptionController.text.trim();
    if (productId.isNotEmpty) {
      map["id"] = productId;
    }

    Map<String, File> imageMap = {};
    if (productType == "Virtual Product") {
      imageMap["virtual_product_file"] = productFileType.value == "pdf" ? pdfFile : voiceFile;
    }
    imageMap["featured_image"] = productImage;

    if (productType == "Variants Product") {
      addMultipleItems.asMap().entries.forEach((element) {
        if(element.value.variantImages.path.checkHTTP.isEmpty) {
          imageMap["variant_images[${element.key}]"] = element.value.variantImages;
        } else {
          map["variant_images[${element.key}]"] = element.value.variantImages.path;
        }
      });

    }

    galleryImages.asMap().forEach((key, value) {
      imageMap["gallery_image[$key]"] = value;
    });

    map["galleryTempData"] = galleryImages
        .where((element) => element.path.checkHTTP.isNotEmpty)
        .map((e) => e.path.checkHTTP)
        .toList()
        .join(",");

    imageMap.removeWhere((key, value) => value.path.checkHTTP.isNotEmpty);
    map.removeWhere((key, value) => value.isEmpty);
    log(map.toString());
    log(imageMap.toString());
    // if(productId.isNotEmpty)return;
    // return;
    repositories
        .multiPartApi(
            mapData: map,
            images: imageMap,
            url: ApiUrls.addVendorProductUrl,
            context: context,
            onProgress: (int bytes, int totalBytes) {
              NotificationService().showNotificationWithProgress(
                  title: "Uploading Images",
                  body: "Uploading Images are in progress",
                  payload: "payload",
                  maxProgress: 100,
                  progress: ((bytes / totalBytes) * 100).toInt(),
                  progressId: 770
              );
            })
        .then((value) {
      NotificationService().hideAllNotifications();
      ModelCommonResponse response = ModelCommonResponse.fromJson(jsonDecode(value));
      showToast(response.message.toString());
      if (response.status == true) {
        Get.back();
        productListController.getProductList();
      }
    }).catchError((e) {
      NotificationService().hideAllNotifications();
    });
  }

  Future getProductDetails() async {
    if (Get.arguments != null) {
      productId = Get.arguments;
    }
    if (productId.isEmpty) {
      apiLoaded = true;
    } else {
      await repositories.getApi(url: ApiUrls.getProductDetailsUrl + productId).then((value) {
        productDetails = ModelVendorProductDetails.fromJson(jsonDecode(value));
        apiLoaded = true;
        updateControllers();
        updateUI;
      }).catchError((e) {
        throw Exception(e);
      });
    }
  }

  void get updateUI => refreshInt.value = DateTime.now().millisecondsSinceEpoch;

  pickAudioFile() async {
    await NewHelper()
        .addFilePicker(
      allowedExtensions: audioType,
    )
        .then((value) {
      if (value == null) return;
      voiceFile = value;
      virtualRefreshInt.value = DateTime.now().millisecondsSinceEpoch;
    });
    return null;
  }

  Future pickPDFFile() async {
    await NewHelper().addFilePicker(
      allowedExtensions: ["pdf"],
    ).then((value) {
      if (value == null) return;
      pdfFile = value;
      virtualRefreshInt.value = DateTime.now().millisecondsSinceEpoch;
    });
  }

  @override
  void onInit() {
    super.onInit();
    productDuration.clear();
    productDuration.add("none");
    for(var i = 0; i < 100; i++){
      productDuration.add((i+1).toString());
    }
  }


}
