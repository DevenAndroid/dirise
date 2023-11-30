import 'dart:convert';
import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dirise/utils/helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../controller/cart_controller.dart';
import '../../model/common_modal.dart';
import '../../model/model_single_product.dart';
import '../../model/order_models/model_direct_order_details.dart';
import '../../model/product_model/model_product_element.dart';
import '../../repository/repository.dart';
import '../../utils/api_constant.dart';
import '../../utils/styles.dart';
import '../../widgets/common_colour.dart';
import '../../widgets/loading_animation.dart';
import '../check_out/direct_check_out.dart';

class SingleProductDetails extends StatefulWidget {
  const SingleProductDetails({super.key, required this.productDetails});

  final ProductElement productDetails;

  @override
  State<SingleProductDetails> createState() => _SingleProductDetailsState();
}

class _SingleProductDetailsState extends State<SingleProductDetails> {
  final Repositories repositories = Repositories();
  ProductElement productElement = ProductElement();

  ProductElement get productDetails => productElement;
  ModelSingleProduct modelSingleProduct = ModelSingleProduct();

  bool get isBookingProduct => productElement.productType == "booking";

  bool get isVirtualProduct => productElement.productType == "virtual_product";
  bool get isVariantType => productElement.productType == "variants";

  bool get isVirtualProductAudio => productElement.virtualProductType == "voice";
  bool get canBuyProduct => productElement.addToCart == true;
  String dropdownvalue1 = 'red';
  String dropdownvalue2 = 'l';
  var items1 = [
    'red',
    'black',
    'white',
  ];
  var items2 = [
    'l',
    'M',
  ];

  String selectedSlot = "";
  final TextEditingController selectedDate = TextEditingController();
  DateTime selectedDateTime = DateTime.now();
  final formKey = GlobalKey<FormState>();

  final DateFormat dateFormat = DateFormat("yyyy-MM-dd");
  final GlobalKey slotKey = GlobalKey();

  bool showValidation = false;

  bool validateSlots() {
    if (showValidation == false) {
      showValidation = true;
      setState(() {});
    }
    if (!formKey.currentState!.validate()) {
      selectedDate.checkEmpty;
      return false;
    }
    if (isBookingProduct) {
      if (modelSingleProduct.product == null) {
        showToast("Please wait loading available slots");
        return false;
      }
      if (modelSingleProduct.product!.serviceTimeSloat == null) {
        showToast("Slots are not available");
        return false;
      }
      if (selectedSlot.isEmpty) {
        slotKey.currentContext!.navigate;
        showToast("Please select slot");
        return false;
      }
      return true;
    }
    if(isVariantType){
      if(selectedVariant == null){
        showToast("Please select Variation");
        return false;
      }
    }
    return true;
  }

  pickDate(
      {required Function(DateTime gg) onPick, DateTime? initialDate, DateTime? firstDate, DateTime? lastDate}) async {
    DateTime lastD = lastDate ?? DateTime(2101);
    DateTime initialD = initialDate ?? firstDate ?? DateTime.now();

    if (lastD.isBefore(firstDate ?? DateTime.now())) {
      lastD = firstDate ?? DateTime.now();
    }

    if (initialD.isAfter(lastD)) {
      initialD = lastD;
    }

    if (initialD.isBefore(firstDate ?? DateTime.now())) {
      initialD = firstDate ?? DateTime.now();
    }

    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: initialD,
        firstDate: firstDate ?? DateTime.now(),
        lastDate: lastD,
        initialEntryMode: DatePickerEntryMode.calendarOnly);
    if (pickedDate == null) return;
    onPick(pickedDate);
    // updateValues();
  }

  Map<String, dynamic> get getMap {
    Map<String, dynamic> map = {};
    map["product_id"] = productDetails.id.toString();
    map["quantity"] = productQuantity.value.toString();
    if (isBookingProduct) {
      map["start_date"] = selectedDate.text.trim();
      map["time_sloat"] = selectedSlot.split("--").first;
      map["sloat_end_time"] = selectedSlot.split("--").last;
    }
    if(isVariantType){
      map["variation"] = selectedVariant!.id.toString();
    }
    return map;
  }

  getProductDetails() {
    repositories.postApi(url: ApiUrls.singleProductUrl, mapData: {"id": productDetails.id.toString()}).then((value) {
      modelSingleProduct = ModelSingleProduct.fromJson(jsonDecode(value));
      if (modelSingleProduct.product != null) {
        log("modelSingleProduct.product!.toJson().....      ${modelSingleProduct.product!.toJson()}");
        productElement = modelSingleProduct.product!;
        imagesList.addAll(modelSingleProduct.product!.galleryImage ?? []);
        imagesList = imagesList.toSet().toList();
        for (var element in productElement.variants!) {
          imagesList.add(element.image.toString());
        }
      }
      setState(() {});
    });
  }

  addToCartProduct() {
    if (!validateSlots()) return;
    repositories.postApi(url: ApiUrls.addToCartUrl, mapData: getMap, context: context).then((value) {
      ModelCommonResponse response = ModelCommonResponse.fromJson(jsonDecode(value));
      showToast(response.message.toString());
      if (response.status == true) {
        Get.back();
        cartController.getCart();
      }
    });
  }

  directBuyProduct() {
    if (!validateSlots()) return;
    repositories.postApi(url: ApiUrls.buyNowDetailsUrl, mapData: getMap, context: context).then((value) {
      ModelDirectOrderResponse response = ModelDirectOrderResponse.fromJson(jsonDecode(value));
      showToast(response.message.toString());
      if (response.status == true) {
        response.quantity = productQuantity.value;
        if (kDebugMode) {
          print(response.quantity);
        }
        Get.toNamed(DirectCheckOutScreen.route, arguments: response);
      }
    });
  }

  List<String> imagesList = [];
  RxInt currentIndex = 0.obs;
  Variants? selectedVariant;

  @override
  void initState() {
    super.initState();
    productElement = widget.productDetails;
    imagesList.add(productDetails.featuredImage.toString());
    imagesList.addAll(productDetails.galleryImage ?? []);
    getProductDetails();
  }

  RxInt productQuantity = 1.obs;
  final cartController = Get.put(CartController());

  bool get checkLoaded => productDetails.pName != null && productDetails.sPrice != null;

  CarouselController carouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      child: checkLoaded
          ? Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(20).copyWith(bottom: 10).copyWith(top: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 5,
                          width: context.getSize.width * .22,
                          decoration:
                              BoxDecoration(color: Colors.grey.shade400, borderRadius: BorderRadius.circular(100)),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    Flexible(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CarouselSlider(
                              options: CarouselOptions(
                                  height: 180.0,
                                  viewportFraction: .8,
                                  onPageChanged: (daf, sda) {
                                    currentIndex.value = daf;
                                  }),
                              carouselController: carouselController,
                              items: imagesList.map((i) {
                                return Builder(
                                  builder: (BuildContext context) {
                                    return CachedNetworkImage(
                                      imageUrl: i,
                                      height: 180,
                                      fit: BoxFit.cover,
                                      errorWidget: (context, url, error) => Icon(
                                        Icons.error_outline_rounded,
                                        color: Theme.of(context).colorScheme.error,
                                      ),
                                    );
                                  },
                                );
                              }).toList(),
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: Obx(() {
                                return AnimatedSmoothIndicator(
                                  activeIndex: currentIndex.value,
                                  count: imagesList.length,
                                  effect: WormEffect(
                                      dotWidth: 10,
                                      dotColor: Colors.grey.shade200,
                                      dotHeight: 10,
                                      activeDotColor: AppTheme.buttonColor),
                                );
                              }),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Expanded(
                                    child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${productDetails.discountPercentage} ${'%'} Off",
                                      style: GoogleFonts.poppins(
                                          fontSize: 14, fontWeight: FontWeight.w500, color: const Color(0xffC22E2E)),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      productDetails.pName.toString().capitalize!,
                                      style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      '${productDetails.inStock.toString()} pieces',
                                      style: GoogleFonts.poppins(color: const Color(0xff858484), fontSize: 17),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          'USD ${productDetails.sPrice.toString()}',
                                          style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500),
                                        ),
                                        const SizedBox(
                                          width: 12,
                                        ),
                                        Expanded(
                                          child: Text(
                                            'USD ${productDetails.pPrice.toString()}',
                                            style: GoogleFonts.poppins(
                                                decoration: TextDecoration.lineThrough,
                                                color: const Color(0xff858484),
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                )),
                                if (isVirtualProduct)
                                  if (isVirtualProductAudio)
                                    SizedBox(
                                        width: 40,
                                        height: 40,
                                        child: SvgPicture.asset(
                                          "assets/svgs/audio.svg",
                                          color: Colors.red,
                                        ))
                                  else
                                    SizedBox(width: 40, height: 40, child: SvgPicture.asset("assets/svgs/pdf.svg"))
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            if(isVariantType)
                              ...[
                                Text(
                                  'Variants',
                                  style: normalStyle,
                                ),
                                if(modelSingleProduct.product != null && modelSingleProduct.product!.variants != null)
                                  DropdownButtonFormField(
                                    value: selectedVariant,
                                    isExpanded: true,
                                    icon: const Icon(Icons.keyboard_arrow_down),
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      enabled: true,
                                      enabledBorder: InputBorder.none,
                                      fillColor: Colors.grey.shade100,
                                      filled: true,
                                      hintText: "Select Variant",
                                      hintStyle: normalStyle
                                    ),
                                    validator: (value){
                                      if(selectedVariant == null){
                                        return "Please select variation";
                                      }
                                      return null;
                                    },
                                    items: modelSingleProduct.product!.variants!.map((e) =>
                                        DropdownMenuItem(
                                            value: e,
                                            child: Row(
                                              children: [
                                                Expanded(child: Text(e.comb.toString().capitalize!)),
                                                Text("\$${e.price}"),
                                                const SizedBox(width: 4,)
                                              ],
                                            ))).toList(),
                                    onChanged: (newValue) {
                                      if(newValue == null)return;
                                        selectedVariant = newValue;
                                      carouselController.animateToPage(imagesList.indexWhere((element) => element.toString() == selectedVariant!.image.toString()));
                                      setState(() {});
                                    },
                                  ),
                              ],
                            const SizedBox(
                              height: 20,
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: Text(
                                'Description'.tr,
                                style: GoogleFonts.poppins(
                                  shadows: [const Shadow(color: Colors.black, offset: Offset(0, -4))],
                                  color: Colors.transparent,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Text(
                              Bidi.stripHtmlIfNeeded(productDetails.longDescription.toString()),
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            if (isBookingProduct)
                              if (modelSingleProduct.product != null &&
                                  modelSingleProduct.product!.serviceTimeSloat != null) ...[
                                Text(
                                  "Select Date".tr,
                                  style: normalStyle,
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                TextFormField(
                                  onTap: () {
                                    pickDate(
                                        onPick: (DateTime gg) {
                                          if (dateFormat
                                              .parse((modelSingleProduct.product!.productAvailability!.fromDate ??
                                                      modelSingleProduct.product!.productAvailability!.toDate)
                                                  .toString())
                                              .isAfter(gg)) {
                                            showToast("This date is not available".tr);
                                            return;
                                          }
                                          selectedDate.text = dateFormat.format(gg);
                                          selectedDateTime = gg;
                                        },
                                        initialDate: selectedDateTime,
                                        firstDate: DateTime.now(),
                                        lastDate: dateFormat.parse(
                                            (modelSingleProduct.product!.productAvailability!.toDate ??
                                                    modelSingleProduct.product!.productAvailability!.fromDate)
                                                .toString()));
                                  },
                                  autovalidateMode: AutovalidateMode.onUserInteraction,
                                  validator: (value) {
                                    if (value!.trim().isEmpty) {
                                      return "Please select date".tr;
                                    }
                                    return null;
                                  },
                                  readOnly: true,
                                  controller: selectedDate,
                                  key: selectedDate.getKey,
                                  decoration: InputDecoration(
                                    border: const OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                                    enabled: true,
                                    suffixIcon: Icon(
                                      CupertinoIcons.calendar,
                                      color: Colors.grey.shade800,
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                                    enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                                    hintText: "Select Date".tr,
                                  ),
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                Text(
                                  "Available Slot".tr,
                                  style: normalStyle,
                                ),
                                Wrap(
                                  key: slotKey,
                                  spacing: 14,
                                  children: modelSingleProduct.product!.serviceTimeSloat!
                                      .map((e) => FilterChip(
                                          label: Text(
                                              "${e.timeSloat.toString().convertToFormatTime} - ${e.timeSloatEnd.toString().convertToFormatTime}"),
                                          side: BorderSide(
                                            color: showValidation && selectedSlot.isEmpty
                                                ? Theme.of(context).colorScheme.error
                                                : Colors.grey,
                                          ),
                                          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
                                          selected: selectedSlot == "${e.timeSloat}--${e.timeSloatEnd}",
                                          onSelected: (value) {
                                            selectedSlot = "${e.timeSloat}--${e.timeSloatEnd}";
                                            setState(() {});
                                          }))
                                      .toList(),
                                ),
                                if (showValidation && selectedSlot.isEmpty)
                                  Text(
                                    "Please select available slots".tr,
                                    style:
                                        normalStyle.copyWith(color: Theme.of(context).colorScheme.error, fontSize: 13),
                                  ),
                                const SizedBox(
                                  height: 16,
                                ),
                              ] else
                                const LoadingAnimation()
                          ],
                        ),
                      ),
                    ),
                    if(canBuyProduct)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  if (productQuantity.value > 1) {
                                    productQuantity.value--;
                                  }
                                },
                                child: CircleAvatar(
                                  radius: 18,
                                  backgroundColor: const Color(0xffEAEAEA),
                                  child: Center(
                                      child: Text(
                                    "━",
                                    style: GoogleFonts.poppins(
                                        fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black),
                                  )),
                                ),
                              ),
                               SizedBox(
                                width: size.width*.015,
                              ),
                              Obx(() {
                                return Text(
                                  productQuantity.value.toString(),
                                  style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 18),
                                );
                              }),
                              SizedBox(
                                width: size.width*.015,
                              ),
                              GestureDetector(
                                onTap: () {
                                  if ((productDetails.inStock.toString().convertToNum ?? 0) > productQuantity.value) {
                                    productQuantity.value++;
                                  } else {
                                    showToast("Cannot add more".tr);
                                  }
                                },
                                child: CircleAvatar(
                                  radius: 18,
                                  backgroundColor: const Color(0xffEAEAEA),
                                  child: Center(
                                      child: Text(
                                    "+",
                                    style: GoogleFonts.poppins(
                                        fontSize: 20, fontWeight: FontWeight.w600, color: Colors.black),
                                  )),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              directBuyProduct();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppTheme.buttonColor,
                              surfaceTintColor: AppTheme.buttonColor,
                            ),
                            child: FittedBox(
                              child: Text(
                                "Buy Now".tr,
                                style:
                                    GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              addToCartProduct();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppTheme.buttonColor,
                              surfaceTintColor: AppTheme.buttonColor,
                            ),
                            child: FittedBox(
                              child: Text(
                                "Add to Bag".tr,
                                style:
                                    GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          : const LoadingAnimation(),
    );
  }
}
