import 'dart:io';
import 'package:dirise/widgets/common_colour.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:open_filex/open_filex.dart';
import '../utils/helper.dart';
import '../widgets/dimension_screen.dart';
import '../widgets/vendor_common_textfield.dart';
import 'add_product_screens/product_gallery_images.dart';

class AddProductScreen extends StatefulWidget {
  static String route = "/AddProductScreen";

  const AddProductScreen({Key? key}) : super(key: key);

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  File productImage = File("");
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController skuController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController minQuantityController = TextEditingController();
  final TextEditingController maxQuantityController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  String productType = "Simple Product";
  File pdfFile = File("");
  File voiceFile = File("");
  List<File> galleryImages = [];

  List<String> productTypes = [
    "Simple Product",
    "Virtual Product",
    "Bookable Product",
  ];

  RxString productFileType = "".obs;

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
  Widget build(BuildContext context) {
    var height = MediaQuery
        .of(context)
        .size
        .height;
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
        body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            physics: const BouncingScrollPhysics(),
            child: Form(
              key: formKey,
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(children: [
                    productDescriptionUI(height),
                    const SizedBox(
                      height: 15,
                    ),
                    productTypeFile(height),
                    SizedBox(
                      height: height * .02,
                    ),
                    ProductGalleryImages(
                      images: galleryImages,
                      galleryImages: (List<File> gg) {
                        galleryImages = gg;
                      },
                    ),
                    SizedBox(
                      height: height * .02,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {}
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
                          style: Theme
                              .of(context)
                              .textTheme
                              .headlineSmall!
                              .copyWith(color: Colors.white, fontWeight: FontWeight.w500, fontSize: AddSize.font18),
                        )),
                  ])),
            )));
  }

  Card productDescriptionUI(double height) {
    return Card(
        color: Colors.white,
        surfaceTintColor: Colors.white,
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
                      .map((label) =>
                      DropdownMenuItem(
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
                SizedBox(
                  height: height * .02,
                ),
                VendorCommonTextfield(
                    obSecure: true,
                    controller: productNameController,
                    hintText: "Enter Product Name",
                    validator: (value) {
                      if (value!.trim().isEmpty) {
                        return "Product name is required";
                      }
                      return null;
                    }),
                SizedBox(
                  height: height * .007,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: VendorCommonTextfield(
                          obSecure: true,
                          controller: skuController,
                          hintText: "SKU",
                          validator: MultiValidator([RequiredValidator(errorText: 'SKU is required')])),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: VendorCommonTextfield(
                          obSecure: true,
                          controller: priceController,
                          hintText: "Price",
                          validator: MultiValidator([RequiredValidator(errorText: 'Price is required')])),
                    ),
                  ],
                ),
                SizedBox(
                  height: height * .007,
                ),
                DropdownButtonFormField<String>(
                  icon: const Icon(Icons.keyboard_arrow_down),
                  // iconSize: 30,
                  iconDisabledColor: const Color(0xff97949A),
                  iconEnabledColor: const Color(0xff97949A),
                  // value: _ratingController,
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
                  items: ["vendor", "customer"]
                      .map((label) =>
                      DropdownMenuItem(
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
                    setState(() {
                      // _ratingController = value!;
                    });
                  },
                ),
                SizedBox(
                  height: height * .02,
                ),
                Row(
                  children: [
                    Expanded(
                      child: VendorCommonTextfield(
                          obSecure: true,
                          controller: minQuantityController,
                          hintText: "Min Qty",
                          validator: MultiValidator([RequiredValidator(errorText: 'Min Qty is required')])),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: VendorCommonTextfield(
                          obSecure: true,
                          controller: maxQuantityController,
                          hintText: "Max Qty",
                          validator: MultiValidator([RequiredValidator(errorText: 'Max Qty is required')])),
                    ),
                  ],
                ),
                SizedBox(
                  height: height * .02,
                ),
                VendorCommonTextfield(
                    obSecure: true,
                    controller: descriptionController,
                    hintText: "Description",
                    validator: MultiValidator([RequiredValidator(errorText: 'Description is required')])),
              ])
            ])));
  }

  Card productTypeFile(double height) {
    return Card(
        color: Colors.white,
        surfaceTintColor: Colors.white,
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: AddSize.padding16, vertical: AddSize.padding20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Upload Image",
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500,
                      color: const Color(0xff2F2F2F),
                      fontSize: 18),
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
                              child: Text(
                                "Upload PDF",
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w500,
                                    color: const Color(0xff2F2F2F),
                                    fontSize: 18),
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
                                padding: EdgeInsets.symmetric(
                                    horizontal: AddSize.padding16, vertical: AddSize.padding16),
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
                                        pdfFile.path
                                            .split("/")
                                            .last,
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
                              child: Text(
                                "Upload Voice",
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w500,
                                    color: const Color(0xff2F2F2F),
                                    fontSize: 18),
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
                                padding: EdgeInsets.symmetric(
                                    horizontal: AddSize.padding16, vertical: AddSize.padding16),
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
                                        pdfFile.path
                                            .split("/")
                                            .last,
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
            )
        )
    );
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
