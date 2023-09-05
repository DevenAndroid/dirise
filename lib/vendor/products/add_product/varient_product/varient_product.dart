import 'dart:developer';
import 'dart:io';
import 'package:dirise/utils/helper.dart';
import 'package:dirise/utils/styles.dart';
import 'package:dirise/widgets/loading_animation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trotter/trotter.dart';
import '../../../../controller/vendor_controllers/add_product_controller.dart';
import '../../../../model/vendor_models/model_attribute.dart';
import '../../../../model/vendor_models/model_varient.dart';
import '../../../../widgets/common_colour.dart';
import '../../../../widgets/vendor_common_textfield.dart';
import '../../../authenthication/image_widget.dart';

class ProductVarient extends StatefulWidget {
  const ProductVarient({super.key});

  @override
  State<ProductVarient> createState() => _ProductVarientState();
}

class _ProductVarientState extends State<ProductVarient> {
  final controller = Get.put(AddProductController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.attributeRefresh.value > 0) {}
      return controller.modelAttributes.data != null
          ? Card(
              margin: const EdgeInsets.symmetric(vertical: 18, horizontal: 4),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Product Variants",
                      style: titleStyle,
                    ),
                    10.spaceY,
                    DropdownButtonFormField<AttributeData>(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      isExpanded: true,
                      iconDisabledColor: const Color(0xff97949A),
                      iconEnabledColor: const Color(0xff97949A),
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          borderSide: BorderSide(color: AppTheme.secondaryColor),
                        ),
                        enabled: true,
                        filled: true,
                        hintText: "Select Variants",
                        labelStyle: GoogleFonts.poppins(color: Colors.black),
                        labelText: "Select Variants",
                        fillColor: const Color(0xffE2E2E2).withOpacity(.35),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 14),
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          borderSide: BorderSide(color: AppTheme.secondaryColor),
                        ),
                      ),
                      validator: (gg) {
                        if (controller.attributeList.isEmpty) {
                          return "Please select variants";
                        }
                        return null;
                      },
                      items: controller.modelAttributes.data!
                          .map((e) => DropdownMenuItem(value: e, child: Text(e.name.toString())))
                          .toList(),
                      onChanged: (value) {
                        if (value == null) return;
                        controller.attributeList.add(value);
                        controller.attributeList = controller.attributeList.toSet().toList();
                        setState(() {});
                      },
                    ),
                    10.spaceY,
                    Text(
                      "Product Variants",
                      style: titleStyle,
                    ),
                    5.spaceY,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: controller.attributeList
                          .map((e) => Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          e.name.toString().capitalize!,
                                          style: normalStyle,
                                        ),
                                      ),
                                      IconButton(onPressed: (){},
                                          visualDensity: VisualDensity.compact,
                                          icon: const Icon(Icons.clear))
                                    ],
                                  ),
                                  // SizedBox(
                                  //   height: ,
                                  // ),
                                  Wrap(
                                    spacing: 6,
                                    children: e.getAttrvalues!
                                        .map((e2) => FilterChip(
                                            label: Text(e2.attrValueName.toString().capitalize!),
                                            selected: e2.selectedVariant,
                                            onSelected: (va) {
                                              e2.selectedVariant = !e2.selectedVariant;
                                              setState(() {});
                                            }))
                                        .toList(),
                                  ),
                                ],
                              ))
                          .toList(),
                    ),
                    if (controller.attributeList
                        .map((e) => e.getAttrvalues!.map((e2) => e2.selectedVariant).toList().contains(true))
                        .toList()
                        .contains(true))
                      Padding(
                        padding: const EdgeInsets.only(top: 6),
                        child: ElevatedButton(
                            onPressed: () {
                              // List<GetAttrvalues> gg = [];
                              // List<AttributeData> attributeList = [];
                              //
                              // for (var element in controller.attributeList) {
                              //   AttributeData kk = AttributeData.fromJson(element.toJson());
                              //   kk.getAttrvalues = kk.getAttrvalues!.where((element) => !element.selectedVariant).toList();
                              //   attributeList.add(kk);
                              // }
                              // log(attributeList.map((e) =>
                              //     e.getAttrvalues!.map((e1) => e1.slug.toString()).toList()).toString());

                              combinations(
                                  controller.attributeList.map((e) => e.getAttrvalues!.where((element) => element.selectedVariant == true).toList()).toList()
                              ).forEach((element) {
                                log(element.map((e) => e.attrValueName).toList().toString());
                              });




                              // combinations(attributeList.map((e) => e.getAttrvalues!).toList()).map((e) => e.map((e1) => e1.slug.toString())).forEach((element) {

                              // });
                              // log(.toString());
                              // final bagOfItems = gg,
                              //     combos = Compounds(bagOfItems);
                              // for (final combo in combos()) {
                              //   print(combo.map((e) => "${e.slug}  ${e.aboveParentSlug}"));
                              // }
                              // log(gg.map((e) => e.toJson()).toString());
                              // log(gg.length.toString());
                              // for (var element in gg) {
                              //
                              // }


                              // controller.addMultipleItems
                            },
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                              backgroundColor: AppTheme.buttonColor,
                              surfaceTintColor: AppTheme.buttonColor,
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                    child: Text(
                                  "Create Variations",
                                  textAlign: TextAlign.center,
                                  style: titleStyle.copyWith(color: Colors.white),
                                )),
                              ],
                            )),
                      ),
                      Column(
                        children: controller.addMultipleItems
                            .map((e) => Column(
                                  children: [
                                    ImageWidget(
                                      title: "Variant Image",
                                      file: e.variantImages!,
                                      filePicked: (File gg) {
                                        e.variantImages = gg;
                                      },
                                      validation: true,
                                    ),
                                    2.spaceY,
                                    VendorCommonTextfield(
                                        controller: TextEditingController(text: e.variantSku),
                                        key: e.variantSkuKey,
                                        hintText: "Variant SKU",
                                        validator: (value) {
                                          if (value!.trim().isEmpty) {
                                            return "Variant sku is required";
                                          }
                                          return null;
                                        }),
                                    18.spaceY,
                                    VendorCommonTextfield(
                                        controller: TextEditingController(text: e.variantPrice),
                                        key: e.variantPriceKey,
                                        hintText: "Variant Price",
                                        validator: (value) {
                                          if (value!.trim().isEmpty) {
                                            return "Variant price is required";
                                          }
                                          return null;
                                        }),
                                    18.spaceY,
                                    VendorCommonTextfield(
                                        controller: TextEditingController(text: e.variantStock),
                                        key: e.variantStockKey,
                                        hintText: "Variant Stock",
                                        validator: (value) {
                                          if (value!.trim().isEmpty) {
                                            return "Variant stock is required";
                                          }
                                          return null;
                                        }),
                                  ],
                                ))
                            .toList(),
                      ),
                  ],
                ),
              ),
            )
          : const LoadingAnimation();
    });
  }
}
Iterable<List<T>> combinations<T>(
    List<List<T>> lists, [
      int index = 0,
      List<T>? prefix,
    ]) sync* {
  prefix ??= <T>[];

  if (lists.length == index) {
    yield prefix.toList();
  } else {
    for (final value in lists[index]) {
      yield* combinations(lists, index + 1, prefix..add(value));
      prefix.removeLast();
    }
  }
}
