import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../model/common_modal.dart';
import '../../model/vendor_models/model_add_product_category.dart';
import '../../model/vendor_models/model_vendor_product_details.dart';
import '../../repository/repository.dart';
import '../../utils/ApiConstant.dart';
import '../../utils/helper.dart';
import 'products_controller.dart';

class AddProductController extends GetxController{

  ModelAddProductCategory productCategory = ModelAddProductCategory(data: []);
  RxInt refreshCategory = 0.obs;

  Future getProductCategoryLit() async {
    refreshCategory.value = -2;
    await repositories.postApi(url: ApiUrls.productCategoryListUrl,showResponse: false,showMap: false).then((value) {
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
  // final TextEditingController priceController = TextEditingController();
  final TextEditingController regularPriceController = TextEditingController();
  final TextEditingController sellingPriceController = TextEditingController();
  final TextEditingController stockController = TextEditingController();
  final TextEditingController shortDescriptionController = TextEditingController();
  final TextEditingController longDescriptionController = TextEditingController();
  final TextEditingController returnDaysController = TextEditingController();

  RxString productFileType = "".obs;
  File productImage = File("");
  RxInt virtualRefreshInt = 0.obs;
  File pdfFile = File("");
  File voiceFile = File("");
  List<File> galleryImages = [];
  String selectedCategory = "";
  String productType = "Single Product";
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

  updateControllers(){
    if(productDetails.product == null)return;
    ModelVendorProductDetailsData item = productDetails.product!;
    /// Description Part
    if(item.productType == "virtual_product"){
      productType = "Virtual Product";
    }
    if(item.productType == "booking"){
      productType = "Booking Product";
      serviceTimeSloat = item.serviceTimeSloat ?? [];
    }
    productNameController.text = item.pname.toString();
    skuController.text = item.prodectSku.toString();
    regularPriceController.text = (item.regularPrice ?? "").toString();
    sellingPriceController.text = item.sPrice.toString();
    stockController.text = item.inStock.toString();
    shortDescriptionController.text = item.shortDescription.toString();
    longDescriptionController.text = item.longDescription.toString();
    returnDaysController.text = item.returnDays.toString();
    updateCategory();
    galleryImages.clear();
    for (var element in item.galleryImage!) {
      galleryImages.add(File(element));
    }
    productImage = File((item.featuredImage ?? "").toString());

    /// Virtual Part
    if(productType == "Virtual Product"){
      if(item.virtualProductFileType == "pdf"){
        productFileType.value = "pdf";
        pdfFile = File(item.virtualProductFile.toString());
      } else {
        productFileType.value = "voice";
        voiceFile = File(item.virtualProductFile.toString());
      }
      // productFileType
    }

    /// Booking Part
    if(productType == "Booking Product") {
      // 1. First Booking Type
      if (item.bookingProductType.toString() == "") {
        bookingType.value = "";
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


  updateStartDateTime(){
    try {
      selectedStartDateTime = DateFormat("yyyy-MM-dd").parse(productDetails.product!.productAvailability!.fromDate.toString());
      startDate.text = DateFormat("dd-MMM-yyyy").format(selectedStartDateTime!);
    } catch(e){
      throw Exception(e);
    }
  }

  updateEndDateTime(){
    try {
      selectedEndDateTIme = DateFormat("yyyy-MM-dd").parse(productDetails.product!.productAvailability!.toDate.toString());
      endDate.text = DateFormat("dd-MMM-yyyy").format(selectedEndDateTIme!);
    } catch(e){
      throw Exception(e);
    }
  }

  updateCategory(){
    if(productDetails.product != null && productCategory.data != null && productCategory.data!.isNotEmpty){
      if(productCategory.data!.map((e) => e.id.toString()).contains(productDetails.product!.catId.toString())){
        selectedCategory = productDetails.product!.catId.toString();
        refreshCategory.value = DateTime.now().millisecondsSinceEpoch;
      }
    }
  }


  addProduct({required BuildContext context}) {
    if (showValidations == false) {
      showValidations = true;
      updateUI;
    }
    List<String> timeslots = [];
    if(slots.isNotEmpty){
      timeslots = slots.entries
          .where((element) => element.value == true)
          .map((e) => "${timeFormatWithoutAMPM.format(e.key.keys.first)},${timeFormatWithoutAMPM.format(e.key.values.first)}")
          .toList();
    }
    if (!formKey.currentState!.validate()) {
      if (productNameController.checkEmpty) return;
      if (skuController.checkEmpty) return;
      // if (priceController.checkBoth) return;
      if (regularPriceController.checkBoth) return;
      if (sellingPriceController.checkBoth) return;
      if (stockController.checkBoth) return;
      if (returnDaysController.checkBoth) return;
      if (selectedCategory.isEmpty) {
        if (categoryKey.currentContext != null) {
          Scrollable.ensureVisible(categoryKey.currentContext!, alignment: .25, duration: const Duration(milliseconds: 600));
          return;
        }
      }
      if (shortDescriptionController.checkEmpty) return;
      if (longDescriptionController.checkEmpty) return;

      if(productType == "Booking Product"){
        if(startTime.checkEmpty) return;
        if(endTime.checkEmpty) return;
        if(serviceDuration.checkEmpty) return;
        if(startDate.checkEmpty) return;

        if(selectedEndDateTIme == null && dateType.value == "range"){
          if(serviceDuration.checkEmpty) return;
        }
      }

      return;
    }

    if(productType == "Booking Product"){
      if(timeslots.isEmpty){
        showToast("Please select slot");
        slotKey.currentContext!.navigate;
        return;
      }
      if(selectedStartDateTime == null){
        showToast("Please select product availability");
        productAvailabilityKey.currentContext!.navigate;
      }
      if(selectedEndDateTIme == null && dateType.value == "range"){
        showToast("Please select product availability");
        productAvailabilityKey.currentContext!.navigate;
      }
    }

    if (galleryImages.isEmpty) return showToast("Please select product gallery images");
    if (productImage.path.isEmpty) return showToast("Please select product images");

    // return;
    Map<String, String> map = {};
    // single,variants,booking,virtual_product
    map["product_type"] = productType.replaceAll("Product", "").trim().toLowerCase();

    if(productType.replaceAll("Product", "").trim().toLowerCase() == "virtual"){
      // "virtual_product"
      map["product_type"] = "virtual_product";
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

    map["product_name"] = productNameController.text.trim();
    // map["prodect_price"] = priceController.text.trim();
    map["sku"] = skuController.text.trim();
    map["regular_price"] = regularPriceController.text.trim();
    map["selling_price"] = sellingPriceController.text.trim();
    map["stock"] = stockController.text.trim();
    map["return_days"] = returnDaysController.text.trim();
    map["category_id"] = selectedCategory;
    map["short_description"] = shortDescriptionController.text.trim();
    map["long_description"] = longDescriptionController.text.trim();

    Map<String, File> imageMap = {};
    if (productType == "Virtual Product") {
      imageMap["virtual_product_file"] = productFileType.value == "pdf" ? pdfFile : voiceFile;
    }
    imageMap["featured_image"] = productImage;
    galleryImages.asMap().forEach((key, value) {
      imageMap["gallery_image[$key]"] = value;
    });

    log(map.toString());
    log(imageMap.toString());

    repositories
        .multiPartApi(
        mapData: map,
        images: imageMap,
        url: ApiUrls.addVendorProductUrl,
        context: context,
        onProgress: (int bytes, int totalBytes) {

        })
        .then((value) {
      ModelCommonResponse response = ModelCommonResponse.fromJson(jsonDecode(value));
      showToast(response.message.toString());
      if (response.status == true) {
        Get.back();
        productListController.getProductList();
      }
    });
  }

  Future getProductDetails() async {
    if(Get.arguments != null) {
      productId = Get.arguments;
    }
    if(productId.isEmpty){
      apiLoaded = true;
    }
    else {
      await repositories.getApi(url: ApiUrls.getProductDetailsUrl + productId).then((value) {
        productDetails = ModelVendorProductDetails.fromJson(jsonDecode(value));
        apiLoaded = true;
        updateControllers();
        updateUI;
      }).catchError((e){
        throw Exception(e);
      });
    }
  }

  void get updateUI => refreshInt.value = DateTime.now().millisecondsSinceEpoch;

  Future<File?> pickAudioFile() async {
    await NewHelper()
        .addFilePicker(
      allowedExtensions: audioType,
    )
        .then((value) {
      return value;
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

  disposeControllers(){
    startTime.dispose();
    endTime.dispose();
    serviceDuration.dispose();
    startDate.dispose();
    endDate.dispose();
    productNameController.dispose();
    skuController.dispose();
    // priceController.dispose();
    regularPriceController.dispose();
    sellingPriceController.dispose();
    stockController.dispose();
    shortDescriptionController.dispose();
    longDescriptionController.dispose();
    returnDaysController.dispose();
  }

}
