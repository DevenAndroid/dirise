import 'dart:io';

import 'package:dirise/utils/helper.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:open_filex/open_filex.dart';

import '../../../controller/vendor_controllers/add_product_controller.dart';
import '../../../widgets/dimension_screen.dart';

class AddProductImageAndVirtualFile extends StatefulWidget {
  const AddProductImageAndVirtualFile({super.key});

  @override
  State<AddProductImageAndVirtualFile> createState() => _AddProductImageAndVirtualFileState();
}

class _AddProductImageAndVirtualFileState extends State<AddProductImageAndVirtualFile> {

  final controller = Get.put(AddProductController());

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery
        .of(context)
        .size
        .height;
    return Card(
        color: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 3,
        child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(() {
                  if(controller.refreshInt.value > 0){}
                  return Row(
                    children: [
                      Flexible(
                        child: Text(
                          "Upload Image",
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500, color: const Color(0xff2F2F2F), fontSize: 18),
                        ),
                      ),
                      if (controller.showValidations && controller.productImage.path.isEmpty)
                        Padding(
                          padding: const EdgeInsets.only(left: 5, top: 2),
                          child: Icon(
                            Icons.error_outline_rounded,
                            color: Theme
                                .of(context)
                                .colorScheme
                                .error,
                            size: 21,
                          ),
                        ),
                    ],
                  );
                }),
                6.spaceY,
                productImageWidget(context, height),
                Obx(() {
                  if (controller.refreshInt.value > 0) {}
                  if(controller.virtualRefreshInt.value > 0){}
                  return controller.productType == "Virtual Product" ?
                  Column(
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
                                if (controller.showValidations && controller.pdfFile.path.isEmpty)
                                  Padding(
                                    padding: const EdgeInsets.only(left: 5, top: 1),
                                    child: Icon(
                                      Icons.error_outline_rounded,
                                      color: Theme
                                          .of(context)
                                          .colorScheme
                                          .error,
                                      size: 22,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          Checkbox(
                              value: controller.productFileType.value == "pdf",
                              onChanged: (value) {
                                if (value == true) {
                                  controller.productFileType.value = "pdf";
                                } else {
                                  controller.productFileType.value = "";
                                }
                              })
                        ],
                      ),
                      6.spaceY,
                      if (controller.productFileType.value == "pdf") ...[
                        GestureDetector(
                          onTap: () {
                            controller.pickPDFFile().then((value) {
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
                              padding:
                              EdgeInsets.symmetric(horizontal: AddSize.padding16, vertical: AddSize.padding16),
                              width: AddSize.screenWidth,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade50,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: controller.pdfFile.path.isNotEmpty
                                  ? Column(
                                children: [
                                  Center(
                                    child: Text(
                                      controller.pdfFile.path
                                          .split("/")
                                          .last,
                                      style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 16),
                                    ),
                                  ),
                                  // TextButton(
                                  //     onPressed: () {
                                  //       OpenFilex.open(controller.pdfFile.path);
                                  //     },
                                  //     child: const Text("View"))
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
                                if (controller.showValidations && controller.pdfFile.path.isEmpty)
                                  Padding(
                                    padding: const EdgeInsets.only(left: 5, top: 1),
                                    child: Icon(
                                      Icons.error_outline_rounded,
                                      color: Theme
                                          .of(context)
                                          .colorScheme
                                          .error,
                                      size: 22,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          Checkbox(
                              value: controller.productFileType.value == "voice",
                              onChanged: (value) {
                                if (value == true) {
                                  controller.productFileType.value = "voice";
                                } else {
                                  controller.productFileType.value = "";
                                }
                              })
                        ],
                      ),
                      if (controller.productFileType.value == "voice") ...[
                        4.spaceY,
                        GestureDetector(
                          onTap: () {
                            controller.pickAudioFile();
                          },
                          child: DottedBorder(
                            radius: const Radius.circular(10),
                            borderType: BorderType.RRect,
                            dashPattern: const [3, 5],
                            color: Colors.grey.shade500,
                            strokeWidth: 1,
                            child: Container(
                              padding:
                              EdgeInsets.symmetric(horizontal: AddSize.padding16, vertical: AddSize.padding16),
                              width: AddSize.screenWidth,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade50,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: controller.voiceFile.path.isNotEmpty
                                  ? Column(
                                children: [
                                  Center(
                                    child: Text(
                                      controller.voiceFile.path
                                          .split("/")
                                          .last,
                                      style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 16),
                                    ),
                                  ),
                                  // TextButton(
                                  //     onPressed: () {
                                  //       OpenFilex.open(controller.voiceFile.path);
                                  //     },
                                  //     child: const Text("View"))
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
                  ) : const SizedBox.shrink();
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
              controller.productImage = gg;
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
          child: controller.productImage.path.isNotEmpty
              ? Container(
            constraints: BoxConstraints(minHeight: 0, maxHeight: context.getSize.width * .36),
            child: Image.file(controller.productImage,
            errorBuilder: (_,__,___)=> Image.network(controller.productImage.path,
            errorBuilder: (_,__,___)=> const SizedBox.shrink(),),),
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