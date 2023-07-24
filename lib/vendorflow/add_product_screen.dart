import 'dart:io';
import 'package:dirise/widgets/common_colour.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import '../utils/helper.dart';
import '../widgets/dimension_screen.dart';
import '../widgets/vendor_common_textfield.dart';

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
  File pdfFile = File("");
  File voiceFile = File("");
  List<File> galleryImages = [];

  showImagePickerSheet({
    required Function(File image) gotImage,
  }) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: const Text(
          'Select Image',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: AppTheme.primaryColor),
        ),
        // message: const Text('Message'),
        cancelButton: CupertinoActionSheetAction(
          child: const Text('Cancel'),
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pop("Cancel");
          },
        ),
        actions: <CupertinoActionSheetAction>[
          CupertinoActionSheetAction(
            child: const Text('Gallery'),
            onPressed: () {
              // pickImage(
              //     ImageSource.gallery);
              NewHelper().addImagePicker(imageSource: ImageSource.gallery).then((value) {
                if (value == null) return;
                gotImage(value);
                Get.back();
              });
            },
          ),
          CupertinoActionSheetAction(
            child: const Text('Camera'),
            onPressed: () {
              NewHelper().addImagePicker(imageSource: ImageSource.camera).then((value) {
                if (value == null) return;
                gotImage(value);
                Get.back();
              });
            },
          ),
        ],
      ),
    );
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
        body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            physics: const BouncingScrollPhysics(),
            child: Form(
              key: formKey,
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(children: [
                    Card(
                        color: Colors.white,
                        surfaceTintColor: Colors.white,
                        child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: AddSize.padding16, vertical: AddSize.padding20),
                            child: Column(children: [
                              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                productImageWidget(context, height),
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
                                    }
                                    ),
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
                                          validator:
                                              MultiValidator([RequiredValidator(errorText: 'Price is required')])),
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
                                    contentPadding: const EdgeInsets.symmetric(horizontal: 15,vertical: 14),
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
                                          validator:
                                              MultiValidator([RequiredValidator(errorText: 'Min Qty is required')])),
                                    ),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    Expanded(
                                      child: VendorCommonTextfield(
                                          obSecure: true,
                                          controller: maxQuantityController,
                                          hintText: "Max Qty",
                                          validator:
                                              MultiValidator([RequiredValidator(errorText: 'Max Qty is required')])),
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
                                    validator:
                                        MultiValidator([RequiredValidator(errorText: 'Description is required')])),
                              ])
                            ]))),
                    const SizedBox(
                      height: 15,
                    ),
                    Card(
                        color: Colors.white,
                        surfaceTintColor: Colors.white,
                        child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: AddSize.padding16, vertical: AddSize.padding20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Upload PDF And Voice",
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w500,
                                      color: const Color(0xff2F2F2F),
                                      fontSize: AddSize.font18),
                                ),
                                SizedBox(
                                  height: height * .02,
                                ),
                                DottedBorder(
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
                                    child: Column(
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
                                SizedBox(
                                  height: height * .02,
                                ),
                                DottedBorder(
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
                                    child: Column(
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
                                )
                              ],
                            ))),
                    SizedBox(
                      height: height * .02,
                    ),
                    Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.2,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade300,
                              offset: const Offset(
                                .1,
                                .1,
                              ),
                              blurRadius: 20.0,
                              spreadRadius: 1.0,
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(16, 11, 20, 0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Image Gallery',
                                    style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: const Color(0xFF000000),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      showModalBottomSheet(
                                          context: context,
                                          isScrollControlled: true,
                                          enableDrag: false,
                                          backgroundColor: Colors.transparent,
                                          elevation: 0,
                                          builder: (context) {
                                            return Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                SizedBox(
                                                  height: AddSize.size20,
                                                ),
                                                Container(
                                                  width: double.maxFinite,
                                                  decoration: const BoxDecoration(
                                                    color: Colors.white,
                                                  ),
                                                  child: Padding(
                                                    padding: EdgeInsets.symmetric(
                                                        horizontal: AddSize.padding16, vertical: AddSize.padding16),
                                                    child: Column(
                                                      children: [
                                                        InkWell(
                                                          onTap: () {
                                                            NewHelper()
                                                                .addImagePicker(imageSource: ImageSource.camera)
                                                                .then((value) {
                                                              // for (var i = 0; i < imageList.length; i++) {
                                                              //   if (imageList[i].path == "") {
                                                              //     imageList[i] = value!;
                                                              //     Get.back();
                                                              //     break;
                                                              //   }
                                                              // }
                                                            });
                                                          },
                                                          child: Text(
                                                            "Take picture",
                                                            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                                                                color: AppTheme.buttonColor,
                                                                fontWeight: FontWeight.w500,
                                                                fontSize: AddSize.font16),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: AddSize.size12,
                                                        ),
                                                        const Divider(),
                                                        SizedBox(
                                                          height: AddSize.size12,
                                                        ),
                                                        InkWell(
                                                          onTap: () {
                                                            NewHelper().addFilePickerList().then((value) {
                                                              if (value != null) {
                                                                // for (var item in value) {
                                                                //   if (imageList.length < 6) {
                                                                //     imageList.add(item);
                                                                //   }
                                                                // }
                                                              }
                                                            });
                                                          },
                                                          child: Text(
                                                            "Choose From Gallery",
                                                            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                                                                color: AppTheme.buttonColor,
                                                                fontWeight: FontWeight.w500,
                                                                fontSize: AddSize.font16),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: AddSize.size12,
                                                        ),
                                                        ElevatedButton(
                                                            onPressed: () {
                                                              // Get.toNamed(MyRouters.thankUScreen);
                                                            },
                                                            style: ElevatedButton.styleFrom(
                                                                minimumSize: const Size(double.maxFinite, 60),
                                                                backgroundColor: AppTheme.buttonColor,
                                                                elevation: 0,
                                                                shape: RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(AddSize.size10)),
                                                                textStyle: TextStyle(
                                                                    fontSize: AddSize.font20,
                                                                    fontWeight: FontWeight.w600)),
                                                            child: Text(
                                                              "Submit",
                                                              style: Theme.of(context)
                                                                  .textTheme
                                                                  .headlineSmall!
                                                                  .copyWith(
                                                                      color: Colors.white,
                                                                      fontWeight: FontWeight.w500,
                                                                      fontSize: AddSize.font18),
                                                            )),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            );
                                          });
                                    },
                                    child: Text(
                                      'Choose From Gallery',
                                      style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        color: AppTheme.buttonColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 100,
                              child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                physics: const BouncingScrollPhysics(),
                                itemCount: 0,
                                itemBuilder: (context, index) {
                                  return Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Stack(
                                          children: [
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: AddSize.padding16, vertical: AddSize.padding16),
                                              width: 80,
                                              decoration: BoxDecoration(
                                                color: Colors.grey.shade50,
                                                borderRadius: BorderRadius.circular(15),
                                              ),
                                              // child: Image.file(
                                              //   imageList[index],
                                              //   width: 40,
                                              // ),
                                            ),
                                            const Positioned(
                                                right: 5,
                                                top: 5,
                                                child: Image(
                                                  height: 13,
                                                  image: AssetImage('assets/icons/delete.png'),
                                                ))
                                          ],
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),
                          ],
                        )),
                    SizedBox(
                      height: height * .02,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {}
                          // Get.toNamed(MyRouters.orderListScreen);
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
            )));
  }

  GestureDetector productImageWidget(BuildContext context, double height) {
    return GestureDetector(
      onTap: () {
        showImagePickerSheet(gotImage: (File gg) {
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
