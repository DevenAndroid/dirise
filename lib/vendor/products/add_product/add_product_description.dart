import 'package:dirise/utils/helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../controller/vendor_controllers/add_product_controller.dart';
import '../../../widgets/common_colour.dart';
import '../../../widgets/dimension_screen.dart';
import '../../../widgets/vendor_common_textfield.dart';

class AddProductDescriptionScreen extends StatefulWidget {
  const AddProductDescriptionScreen({super.key});

  @override
  State<AddProductDescriptionScreen> createState() => _AddProductDescriptionScreenState();
}

class _AddProductDescriptionScreenState extends State<AddProductDescriptionScreen> {
  final controller = Get.put(AddProductController());

  List<String> productTypes = [
    "Single Product",
    "Virtual Product",
    "Booking Product",
  ];

  @override
  void initState() {
    super.initState();
    controller.getProductCategoryLit();
  }

  @override
  Widget build(BuildContext context) {
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
                  iconDisabledColor: const Color(0xff97949A),
                  iconEnabledColor: const Color(0xff97949A),
                  value: controller.productType,
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
                    controller.productType = value;
                    controller.updateUI;
                  },
                ),
                18.spaceY,
                VendorCommonTextfield(
                    controller: controller.productNameController,
                    key: controller.productNameController.getKey,
                    hintText: "Enter Product Name",
                    validator: (value) {
                      if (value!.trim().isEmpty) {
                        return "Product name is required";
                      }
                      return null;
                    }),
                18.spaceY,
                VendorCommonTextfield(
                    controller: controller.skuController,
                    key: controller.skuController.getKey,
                    hintText: "Enter SKU",
                    validator: (value) {
                      if (value!.trim().isEmpty) {
                        return "SKU is required";
                      }
                      return null;
                    }),
                // 18.spaceY,
                // VendorCommonTextfield(
                //     controller: controller.priceController,
                //     key: controller.priceController.getKey,
                //     keyboardType: TextInputType.number,
                //     hintText: "Price",
                //     validator: (value) {
                //       if (value!.trim().isEmpty) {
                //         return "Price is required";
                //       }
                //       if ((num.tryParse(value.trim()) ?? 0) < 1) {
                //         return "Enter valid price";
                //       }
                //       return null;
                //     }),
                18.spaceY,
                VendorCommonTextfield(
                    controller: controller.purchasePriceController,
                    key: controller.purchasePriceController.getKey,
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
                    controller: controller.sellingPriceController,
                    key: controller.sellingPriceController.getKey,
                    keyboardType: TextInputType.number,
                    hintText: "Discounted Price",
                    validator: (value) {
                      if (value!.trim().isEmpty) {
                        return "Discounted price is required";
                      }
                      if ((num.tryParse(value.trim()) ?? 0) < 1) {
                        return "Enter valid discounted price";
                      }
                      return null;
                    }),
                18.spaceY,
                VendorCommonTextfield(
                    controller: controller.stockController,
                    key: controller.stockController.getKey,
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
                    controller: controller.returnDaysController,
                    key: controller.returnDaysController.getKey,
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
                  if (controller.refreshCategory.value > 0) {}
                  return DropdownButtonFormField<String>(
                    key: controller.categoryKey,
                    icon: controller.refreshCategory.value == -2
                        ? const CupertinoActivityIndicator()
                        : const Icon(Icons.keyboard_arrow_down),
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
                      hintText: "Category",
                      labelStyle: GoogleFonts.poppins(color: Colors.black),
                      labelText: "Category",
                      fillColor: const Color(0xffE2E2E2).withOpacity(.35),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 14),
                      enabledBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(color: AppTheme.secondaryColor),
                      ),
                    ),
                    value: controller.selectedCategory.isEmpty ? null : controller.selectedCategory,
                    validator: (gg) {
                      if (controller.selectedCategory.isEmpty) {
                        return "Please select product category";
                      }
                      return null;
                    },
                    items: controller.productCategory.data!
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
                      controller.selectedCategory = value;
                    },
                  );
                }),
                18.spaceY,
                VendorCommonTextfield(
                    controller: controller.shortDescriptionController,
                    key: controller.shortDescriptionController.getKey,
                    hintText: "Short Description",
                    validator: (value) {
                      if (value!.trim().isEmpty) {
                        return "Short description is required";
                      }
                      return null;
                    }),
                18.spaceY,
                VendorCommonTextfield(
                    controller: controller.longDescriptionController,
                    key: controller.longDescriptionController.getKey,
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
}
