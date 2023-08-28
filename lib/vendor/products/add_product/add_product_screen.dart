import 'package:dirise/widgets/common_colour.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../controller/vendor_controllers/add_product_controller.dart';
import '../../../utils/helper.dart';
import '../../../widgets/dimension_screen.dart';
import '../../../widgets/loading_animation.dart';
import 'add_product_description.dart';
import 'bookable_screens/bookable_ui.dart';
import 'product_gallery_images.dart';
import 'vertual_product_and_image.dart';

class AddProductScreen extends StatefulWidget {
  static String route = "/AddProductScreen";

  const AddProductScreen({Key? key}) : super(key: key);

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final controller = Get.put(AddProductController());

  @override
  void initState() {
    super.initState();
    controller.getProductDetails();
  }

  @override
  void dispose() {
    super.dispose();
    controller.disposeControllers();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
            controller.productId.isEmpty ? "Add Product" : "Edit Product",
            style: GoogleFonts.raleway(fontSize: 18, fontWeight: FontWeight.w700, color: const Color(0xff303C5E)),
          ),
        ),
        body: Obx(() {
          if (controller.refreshInt.value > 0) {}
          return controller.apiLoaded
              ? RefreshIndicator(
                  onRefresh: () async => await controller.getProductCategoryLit(),
                  child: SingleChildScrollView(
                      child: Form(
                    key: controller.formKey,
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(children: [
                          const AddProductDescriptionScreen(),
                          16.spaceY,
                          if (controller.productType == "Booking Product") const BookableUI(),
                          const AddProductImageAndVirtualFile(),
                          16.spaceY,
                          const ProductGalleryImages(),
                          16.spaceY,
                          ElevatedButton(
                              onPressed: () {
                                controller.addProduct(context: context);
                              },
                              style: ElevatedButton.styleFrom(
                                  minimumSize: const Size(double.maxFinite, 60),
                                  backgroundColor: AppTheme.buttonColor,
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AddSize.size10)),
                                  textStyle: GoogleFonts.poppins(fontSize: AddSize.font20, fontWeight: FontWeight.w600)),
                              child: Text(
                                controller.productId.isEmpty ? "Create" : "Update",
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall!
                                    .copyWith(color: Colors.white, fontWeight: FontWeight.w500, fontSize: AddSize.font18),
                              )),
                          10.spaceY,
                        ])),
                  )),
                )
              : const LoadingAnimation();
        }));
  }
}
