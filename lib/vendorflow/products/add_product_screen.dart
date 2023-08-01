import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dirise/model/common_modal.dart';
import 'package:dirise/widgets/common_colour.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:open_filex/open_filex.dart';
import '../../controller/vendor_controllers/products_controller.dart';
import '../../model/vendor_models/model_add_product_category.dart';
import '../../repository/repository.dart';
import '../../utils/ApiConstant.dart';
import '../../utils/helper.dart';
import '../../widgets/dimension_screen.dart';
import '../../widgets/vendor_common_textfield.dart';
import 'bookable_ui.dart';
import 'product_gallery_images.dart';

class AddProductScreen extends StatefulWidget {
  static String route = "/AddProductScreen";

  const AddProductScreen({Key? key}) : super(key: key);

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final controller = Get.put(ProductsController());
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey categoryKey = GlobalKey();
  final Repositories repositories = Repositories();
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController skuController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController purchasePriceController = TextEditingController();
  final TextEditingController sellingPriceController = TextEditingController();
  final TextEditingController stockController = TextEditingController();
  final TextEditingController shortDescriptionController = TextEditingController();
  final TextEditingController longDescriptionController = TextEditingController();
  final TextEditingController returnDaysController = TextEditingController();

  File productImage = File("");
  File pdfFile = File("");
  File voiceFile = File("");
  List<File> galleryImages = [];
  String selectedCategory = "";
  String productType = "Single Product";
  bool showValidations = false;

  ModelAddProductCategory productCategory = ModelAddProductCategory(data: []);
  RxInt refreshInt = 0.obs;

  String bookingType = "";
  String dateType = "";
  DateTime? selectedStartDateTime;
  DateTime? selectedEndDateTIme;
  List<String> slots = [];

  List<String> productTypes = [
    "Single Product",
    "Virtual Product",
    "Booking Product",
  ];

  RxString productFileType = "".obs;

  scrollToError(BuildContext? context1) {
    if (context1 == null) return;
    Scrollable.ensureVisible(context1, alignment: .25, duration: const Duration(milliseconds: 600));
  }

  addProduct() {
    if (showValidations == false) {
      showValidations = true;
      setState(() {});
    }
    if (!formKey.currentState!.validate()) {
      if (productNameController.checkEmpty) return;
      if (skuController.checkEmpty) return;
      if (priceController.checkBoth) return;
      if (purchasePriceController.checkBoth) return;
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
        if(controller.startTime.checkEmpty) return;
        if(controller.endTime.checkEmpty) return;
        if(controller.serviceDuration.checkEmpty) return;
        if(controller.startDate.checkEmpty) return;

        if(selectedEndDateTIme == null && dateType == "range"){
          if(controller.serviceDuration.checkEmpty) return;
        }
      }

      return;
    }

    if(productType == "Booking Product"){
      if(slots.isEmpty){
        showToast("Please select slot");
        controller.slotKey.currentContext!.navigate;
        return;
      }
      if(selectedStartDateTime == null){
        showToast("Please select product availability");
        controller.productAvailabilityKey.currentContext!.navigate;
      }
      if(selectedEndDateTIme == null && dateType == "range"){
        showToast("Please select product availability");
        controller.productAvailabilityKey.currentContext!.navigate;
      }
    }

    if (galleryImages.isEmpty) return showToast("Please select product gallery images");
    if (productImage.path.isEmpty) return showToast("Please select product images");

    // return;
    Map<String, String> map = {};
    // single,variants,booking,virtual_product
    map["product_type"] = productType.replaceAll("Product", "").trim().toLowerCase();
    if (productType == "Booking Product") {
      final DateFormat dateFormat = DateFormat("yyyy-MM-dd");

      map["group[0]"] = dateType;
      map["booking_product_type"] = bookingType;
      if (dateType == "date") {
        map["single_date[0]"] = dateFormat.format(selectedStartDateTime!);
      } else {
        map["from_date[0]"] = dateFormat.format(selectedStartDateTime!);
        map["to_date[0]"] = dateFormat.format(selectedEndDateTIme!);
      }
      slots.asMap().entries.forEach((element) {
        map["sloat[${element.key}]"] = element.value;
      });
    }

    map["product_name"] = productNameController.text.trim();
    map["prodect_price"] = priceController.text.trim();
    map["sku"] = skuController.text.trim();
    map["purchase_price"] = purchasePriceController.text.trim();
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

    // repositories
    //     .multiPartApi(
    //         mapData: map,
    //         images: imageMap,
    //         url: ApiUrls.addVendorProductUrl,
    //         context: context,
    //         onProgress: (int bytes, int totalBytes) {})
    //     .then((value) {
    //   ModelCommonResponse response = ModelCommonResponse.fromJson(jsonDecode(value));
    //   showToast(response.message.toString());
    //   if (response.status == true) {
    //     Get.back();
    //   }
    // });
  }

  Future getProductCategoryLit() async {
    refreshInt.value = -2;
    await repositories.postApi(url: ApiUrls.productCategoryListUrl).then((value) {
      productCategory = ModelAddProductCategory.fromJson(jsonDecode(value));
      refreshInt.value = DateTime.now().millisecondsSinceEpoch;
    });
  }

  pickPDFFile() {
    NewHelper().addFilePicker(
      allowedExtensions: ["pdf"],
    ).then((value) {
      if (value == null) return;
      pdfFile = value;
      setState(() {});
    });
  }

  pickAudioFile() {
    const audioType = [
      "mpeg",
      "ogg",
      "wav",
      "webm",
      "x-aac",
      "x-midi",
      "x-wav",
      "midi",
      "mp4",
      "aac",
      "vnd.wave",
      "vnd.rn-realaudio",
      "3gpp",
      "3gpp2",
      "x-flac",
      "x-m4a",
    ];
    NewHelper()
        .addFilePicker(
      allowedExtensions: audioType,
    )
        .then((value) {
      if (value == null) return;
      voiceFile = value;
      setState(() {});
    });
  }

  @override
  void initState() {
    super.initState();
    getProductCategoryLit();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xffF4F4F4),
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
                // height: 21,
              ),
            ),
          ),
          title: Text(
            "Add Product",
            style: GoogleFonts.raleway(fontSize: 18, fontWeight: FontWeight.w700, color: const Color(0xff303C5E)),
          ),
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            await getProductCategoryLit();
          },
          child: SingleChildScrollView(
              child: Form(
            key: formKey,
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(children: [
                  productDescriptionUI(height),
                  15.spaceY,
                  if (productType == "Booking Product")
                    BookableUI(
                      onChange: (String bookingType1, String dateType1, DateTime? selectedStartDateTime1,
                          DateTime? selectedEndDateTIme1, List<String> slots1) {
                         bookingType = bookingType1;
                         dateType = dateType1;
                        selectedStartDateTime = selectedStartDateTime1;
                        selectedEndDateTIme = selectedEndDateTIme1;
                        slots = slots1;
                      },
                    ),
                  productTypeFile(height),
                  15.spaceY,
                  ProductGalleryImages(
                    images: galleryImages,
                    galleryImages: (List<File> gg) {
                      galleryImages = gg;
                    },
                    showValidation: showValidations,
                  ),
                  SizedBox(
                    height: height * .02,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        addProduct();
                        // Get.toNamed(orderListScreen);
                      },
                      style: ElevatedButton.styleFrom(
                          minimumSize: const Size(double.maxFinite, 60),
                          backgroundColor: AppTheme.buttonColor,
                          elevation: 0,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AddSize.size10)),
                          textStyle: TextStyle(fontSize: AddSize.font20, fontWeight: FontWeight.w600)),
                      child: Text(
                        "Upload",
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall!
                            .copyWith(color: Colors.white, fontWeight: FontWeight.w500, fontSize: AddSize.font18),
                      )),
                ])),
          )),
        ));
  }

  Card productDescriptionUI(double height) {
    return Card(
        color: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 3,
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: AddSize.padding16, vertical: AddSize.padding20),
            child: Column(children: [
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                DropdownButtonFormField<String>(
                  icon: const Icon(Icons.keyboard_arrow_down),
                  // iconSize: 30,
                  iconDisabledColor: const Color(0xff97949A),
                  iconEnabledColor: const Color(0xff97949A),
                  value: productType,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    filled: true,
                    fillColor: const Color(0xffE2E2E2).withOpacity(.35),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 14),
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
                  items: productTypes
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
                  hint: const Text('Rating'),
                  onChanged: (value) {
                    if (value == null) return;
                    productType = value;
                    setState(() {});
                  },
                ),
                18.spaceY,
                VendorCommonTextfield(
                    //obSecure: true,
                    controller: productNameController,
                    key: productNameController.getKey,
                    hintText: "Enter Product Name",
                    validator: (value) {
                      if (value!.trim().isEmpty) {
                        return "Product name is required";
                      }
                      return null;
                    }),
                18.spaceY,
                VendorCommonTextfield(
                    //obSecure: true,
                    controller: skuController,
                    key: skuController.getKey,
                    hintText: "Enter SKU",
                    validator: (value) {
                      if (value!.trim().isEmpty) {
                        return "SKU is required";
                      }
                      return null;
                    }),
                18.spaceY,
                VendorCommonTextfield(
                    //obSecure: true,
                    controller: priceController,
                    key: priceController.getKey,
                    keyboardType: TextInputType.number,
                    hintText: "Price",
                    validator: (value) {
                      if (value!.trim().isEmpty) {
                        return "Price is required";
                      }
                      if ((num.tryParse(value.trim()) ?? 0) < 1) {
                        return "Enter valid price";
                      }
                      return null;
                    }),
                18.spaceY,
                VendorCommonTextfield(
                    //obSecure: true,
                    controller: purchasePriceController,
                    key: purchasePriceController.getKey,
                    keyboardType: TextInputType.number,
                    hintText: "Purchase Price",
                    validator: (value) {
                      if (value!.trim().isEmpty) {
                        return "Purchase price is required";
                      }
                      if ((num.tryParse(value.trim()) ?? 0) < 1) {
                        return "Enter valid purchased price";
                      }
                      return null;
                    }),
                18.spaceY,
                VendorCommonTextfield(
                    //obSecure: true,
                    controller: sellingPriceController,
                    key: sellingPriceController.getKey,
                    keyboardType: TextInputType.number,
                    hintText: "Selling Price",
                    validator: (value) {
                      if (value!.trim().isEmpty) {
                        return "Selling price is required";
                      }
                      if ((num.tryParse(value.trim()) ?? 0) < 1) {
                        return "Enter valid selling price";
                      }
                      return null;
                    }),
                18.spaceY,
                VendorCommonTextfield(
                    //obSecure: true,
                    controller: stockController,
                    key: stockController.getKey,
                    keyboardType: TextInputType.number,
                    hintText: "Stock Quantity",
                    validator: (value) {
                      if (value!.trim().isEmpty) {
                        return "Stock quantity is required";
                      }
                      if ((num.tryParse(value.trim()) ?? 0) < 1) {
                        return "Enter valid stock quantity";
                      }
                      return null;
                    }),
                18.spaceY,
                VendorCommonTextfield(
                    //obSecure: true,
                    controller: returnDaysController,
                    key: returnDaysController.getKey,
                    keyboardType: TextInputType.number,
                    hintText: "Return Days",
                    validator: (value) {
                      if (value!.trim().isEmpty) {
                        return "Return days is required";
                      }
                      if ((num.tryParse(value.trim()) ?? 0) < 1) {
                        return "Enter valid return days";
                      }
                      return null;
                    }),
                18.spaceY,
                Obx(() {
                  if (refreshInt.value > 0) {}
                  return DropdownButtonFormField<String>(
                    key: categoryKey,
                    icon:
                        refreshInt.value == -2 ? const CupertinoActivityIndicator() : const Icon(Icons.keyboard_arrow_down),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    isExpanded: true,
                    iconDisabledColor: const Color(0xff97949A),
                    iconEnabledColor: const Color(0xff97949A),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      filled: true,
                      hintText: "Category",
                      labelStyle: const TextStyle(color: Colors.black),
                      labelText: "Category",
                      fillColor: const Color(0xffE2E2E2).withOpacity(.35),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 14),
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
                    validator: (gg) {
                      if (selectedCategory.isEmpty) {
                        return "Please select product category";
                      }
                      return null;
                    },
                    items: productCategory.data!
                        .map((label) => DropdownMenuItem(
                              value: label.id.toString(),
                              child: Text(
                                label.title.toString(),
                                style: GoogleFonts.poppins(
                                  color: const Color(0xff463B57),
                                ),
                              ),
                            ))
                        .toList(),
                    onChanged: (value) {
                      if (value == null) return;
                      selectedCategory = value;
                    },
                  );
                }),
                18.spaceY,
                VendorCommonTextfield(
                    //obSecure: true,
                    controller: shortDescriptionController,
                    key: shortDescriptionController.getKey,
                    hintText: "Short Description",
                    validator: (value) {
                      if (value!.trim().isEmpty) {
                        return "Short description is required";
                      }
                      return null;
                    }),
                18.spaceY,
                VendorCommonTextfield(
                    //obSecure: true,
                    controller: longDescriptionController,
                    key: longDescriptionController.getKey,
                    maxLength: 5000,
                    isMulti: true,
                    hintText: "Long Description",
                    validator: (value) {
                      if (value!.trim().isEmpty) {
                        return "Long description is required";
                      }
                      return null;
                    }),
              ])
            ])));
  }

  Card productTypeFile(double height) {
    return Card(
        color: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 3,
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: AddSize.padding16, vertical: AddSize.padding20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        "Upload Image",
                        style:
                            GoogleFonts.poppins(fontWeight: FontWeight.w500, color: const Color(0xff2F2F2F), fontSize: 18),
                      ),
                    ),
                    if (showValidations && productImage.path.isEmpty)
                      Padding(
                        padding: const EdgeInsets.only(left: 5, top: 2),
                        child: Icon(
                          Icons.error_outline_rounded,
                          color: Theme.of(context).colorScheme.error,
                          size: 21,
                        ),
                      ),
                  ],
                ),
                6.spaceY,
                productImageWidget(context, height),
                if (productType == "Virtual Product")
                  Obx(() {
                    return Column(
                      children: [
                        6.spaceY,
                        Row(
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  Flexible(
                                    child: Text(
                                      "Upload PDF",
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w500, color: const Color(0xff2F2F2F), fontSize: 18),
                                    ),
                                  ),
                                  if (showValidations && pdfFile.path.isEmpty)
                                    Padding(
                                      padding: const EdgeInsets.only(left: 5, top: 1),
                                      child: Icon(
                                        Icons.error_outline_rounded,
                                        color: Theme.of(context).colorScheme.error,
                                        size: 22,
                                      ),
                                    ),
                                ],
                              ),
                            ),
                            Checkbox(
                                value: productFileType.value == "pdf",
                                onChanged: (value) {
                                  if (value == true) {
                                    productFileType.value = "pdf";
                                  } else {
                                    productFileType.value = "";
                                  }
                                })
                          ],
                        ),
                        6.spaceY,
                        if (productFileType.value == "pdf") ...[
                          GestureDetector(
                            onTap: () {
                              pickPDFFile();
                            },
                            child: DottedBorder(
                              radius: const Radius.circular(10),
                              borderType: BorderType.RRect,
                              dashPattern: const [3, 5],
                              color: Colors.grey.shade500,
                              strokeWidth: 1,
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: AddSize.padding16, vertical: AddSize.padding16),
                                width: AddSize.screenWidth,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade50,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: pdfFile.path.isNotEmpty
                                    ? Column(
                                        children: [
                                          Center(
                                            child: Text(
                                              pdfFile.path.split("/").last,
                                              style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                                            ),
                                          ),
                                          TextButton(
                                              onPressed: () {
                                                OpenFilex.open(pdfFile.path);
                                              },
                                              child: const Text("Open"))
                                        ],
                                      )
                                    : Column(
                                        children: [
                                          const Image(
                                            height: 30,
                                            image: AssetImage(
                                              'assets/icons/pdfdownload.png',
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          Text(
                                            "Upload PDF File",
                                            style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.w300,
                                                color: const Color(0xff463B57),
                                                fontSize: AddSize.font16),
                                          ),
                                          SizedBox(
                                            height: height * .01,
                                          ),
                                        ],
                                      ),
                              ),
                            ),
                          ),
                          4.spaceY,
                        ],
                        Row(
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  Flexible(
                                    child: Text(
                                      "Upload Voice",
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w500, color: const Color(0xff2F2F2F), fontSize: 18),
                                    ),
                                  ),
                                  if (showValidations && pdfFile.path.isEmpty)
                                    Padding(
                                      padding: const EdgeInsets.only(left: 5, top: 1),
                                      child: Icon(
                                        Icons.error_outline_rounded,
                                        color: Theme.of(context).colorScheme.error,
                                        size: 22,
                                      ),
                                    ),
                                ],
                              ),
                            ),
                            Checkbox(
                                value: productFileType.value == "voice",
                                onChanged: (value) {
                                  if (value == true) {
                                    productFileType.value = "voice";
                                  } else {
                                    productFileType.value = "";
                                  }
                                })
                          ],
                        ),
                        if (productFileType.value == "voice") ...[
                          4.spaceY,
                          GestureDetector(
                            onTap: () {
                              pickAudioFile();
                            },
                            child: DottedBorder(
                              radius: const Radius.circular(10),
                              borderType: BorderType.RRect,
                              dashPattern: const [3, 5],
                              color: Colors.grey.shade500,
                              strokeWidth: 1,
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: AddSize.padding16, vertical: AddSize.padding16),
                                width: AddSize.screenWidth,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade50,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: voiceFile.path.isNotEmpty
                                    ? Column(
                                        children: [
                                          Center(
                                            child: Text(
                                              pdfFile.path.split("/").last,
                                              style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                                            ),
                                          ),
                                          TextButton(
                                              onPressed: () {
                                                OpenFilex.open(voiceFile.path);
                                              },
                                              child: const Text("Open"))
                                        ],
                                      )
                                    : Column(
                                        children: [
                                          const Image(
                                            height: 30,
                                            image: AssetImage(
                                              'assets/icons/pdfdownload.png',
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          Text(
                                            "Upload Voice",
                                            style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.w300,
                                                color: const Color(0xff463B57),
                                                fontSize: AddSize.font16),
                                          ),
                                          SizedBox(
                                            height: height * .01,
                                          ),
                                        ],
                                      ),
                              ),
                            ),
                          )
                        ],
                      ],
                    );
                  }),
              ],
            )));
  }

  GestureDetector productImageWidget(BuildContext context, double height) {
    return GestureDetector(
      onTap: () {
        NewHelper.showImagePickerSheet(
            context: context,
            gotImage: (File gg) {
              productImage = gg;
              setState(() {});
            });
      },
      child: DottedBorder(
        radius: const Radius.circular(10),
        borderType: BorderType.RRect,
        dashPattern: const [3, 5],
        color: Colors.grey.shade500,
        strokeWidth: 1,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: AddSize.padding16, vertical: AddSize.padding16),
          width: AddSize.screenWidth,
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(10),
          ),
          child: productImage.path.isNotEmpty
              ? Container(
                  constraints: BoxConstraints(minHeight: 0, maxHeight: context.getSize.width * .36),
                  child: Image.file(productImage),
                )
              : Column(
                  children: [
                    const Image(
                      height: 30,
                      image: AssetImage(
                        'assets/icons/pdfdownload.png',
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      "Upload Product image",
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w300, color: const Color(0xff463B57), fontSize: AddSize.font14),
                    ),
                    SizedBox(
                      height: height * .01,
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
