import 'dart:io';
import 'package:collection/collection.dart';
import 'package:dirise/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import '../../widgets/common_colour.dart';

class ProductGalleryImages extends StatefulWidget {
  final Function(List<File> images) galleryImages;
  final List<File> images;
  final bool showValidation;
  const ProductGalleryImages({super.key, required this.galleryImages, required this.images, required this.showValidation});

  @override
  State<ProductGalleryImages> createState() => _ProductGalleryImagesState();
}

class _ProductGalleryImagesState extends State<ProductGalleryImages> {

  List<File> images = [];

  @override
  void initState() {
    super.initState();
    images = widget.images;
  }

  updateImages(){
    widget.galleryImages(images);
    setState(() {});
  }

  showImagesBottomSheet(){
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
              20.spaceY,
              Container(
                width: double.maxFinite,
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 16),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: MaterialButton(
                              onPressed: () {
                                Get.back();
                                NewHelper().addImagePicker(imageSource: ImageSource.camera,).then((value) {
                                  if(value == null)return;
                                  if(images.length < 5){
                                    images.add(value);
                                    updateImages();
                                  }
                                });
                              },
                              height: 58,
                              elevation: 0,
                              color: Colors.white,
                              child: Text(
                                "Take picture",
                                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                                    color: AppTheme.buttonColor,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Divider(
                        height: 8,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: MaterialButton(
                              onPressed: () {
                                Get.back();
                                NewHelper()
                                    .multiImagePicker()
                                    .then((value) {
                                  if(value == null)return;
                                  for (var element in value) {
                                    if(images.length < 5){
                                      images.add(element);
                                    } else {
                                      break;
                                    }
                                  }
                                  updateImages();
                                });
                              },
                              height: 58,
                              elevation: 0,
                              color: Colors.white,
                              child: Text(
                                "Choose From Gallery",
                                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                                    color: AppTheme.buttonColor,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            // Get.toNamed(thankUScreen);
                          },
                          style: ElevatedButton.styleFrom(
                              minimumSize: const Size(double.maxFinite, 60),
                              backgroundColor: AppTheme.buttonColor,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.circular(10)),
                              textStyle: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600)),
                          child: Text(
                            "Submit",
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall!
                                .copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 18),
                          )),
                    ],
                  ),
                ),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 4, 0, 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Row(
                        children: [
                          Flexible(
                            child: Text(
                              'Image Gallery',
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF000000),
                              ),
                            ),
                          ),
                          if(widget.showValidation && images.isEmpty)
                            Padding(
                              padding: const EdgeInsets.only(left: 5,top: 2),
                              child: Icon(Icons.error_outline_rounded,color: Theme.of(context).colorScheme.error,size: 21,),
                            ),
                        ],
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        showImagesBottomSheet();
                      },

                      child: Text(
                        'Choose From Gallery ${images.isNotEmpty ? "${images.length}/5" : ""}',
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
              if(images.isNotEmpty)
              ...[
                SizedBox(
                  height: 125,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.only(left: 20),
                    child: Row(
                      children: images.mapIndexed((i,e)=> Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: GestureDetector(
                            onTap: (){
                              NewHelper.showImagePickerSheet(
                                  gotImage: (value){
                                    images[i] = value;
                                    updateImages();
                                  },
                                  context: context,
                                  removeOption: true,
                                  removeImage: (fg){
                                    images.removeAt(i);
                                    updateImages();
                                  }
                              );
                            },
                            child: Image.file(e)),
                      )).toList(),
                    ),
                  ),
                ),
                const SizedBox(height: 12,),
              ],
            ],
          )),
    );
  }
}
