import 'dart:convert';
import 'package:dirise/model/common_modal.dart';
import 'package:dirise/utils/helper.dart';
import 'package:dirise/widgets/loading_animation.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../controller/cart_controller.dart';
import '../../controller/profile_controller.dart';
import '../../model/model_address_list.dart';
import '../../utils/ApiConstant.dart';
import '../../widgets/common_textfield.dart';

class CheckOutScreen extends StatefulWidget {
  const CheckOutScreen({super.key});

  static var checkOutScreen = "/checkOutScreen";

  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  final cartController = Get.put(CartController());
  final profileController = Get.put(ProfileController());

  String couponApplied = "";
  String appliedCode = "";

  final TextEditingController couponController = TextEditingController();
  final TextEditingController deliveryInstructions = TextEditingController();

  AddressData selectedAddress = AddressData();
  final GlobalKey addressKey = GlobalKey();

  applyCouponCode() {
    if (couponController.text.trim().isEmpty) {
      showToast("Please enter coupon code");
      return;
    }
    cartController.refreshInt.value = -2;
    Map<String, dynamic> map = {};
    map["coupon_code"] = couponController.text.trim();
    map["total_price"] = cartController.cartModel.subtotal.toString();
    cartController.repositories.postApi(url: ApiUrls.applyCouponUrl, context: context, mapData: map).then((value) {
      ModelCommonResponse response = ModelCommonResponse.fromJson(jsonDecode(value));
      showToast(response.message);
      if (response.status == true) {
        couponApplied = jsonDecode(value)["discount"].toString();
        appliedCode = couponController.text.trim();
        couponController.clear();
        setState(() {});
      }
      cartController.updateUI();
    }).catchError((e) {
      cartController.updateUI();
    });
  }

  RxBool showValidation = false.obs;
  RxString deliveryOption = "".obs;
  RxString paymentOption = "".obs;

  bool get userLoggedIn => profileController.userLoggedIn;

  @override
  void initState() {
    super.initState();
    profileController.checkUserLoggedIn().then((value) {
      if (value == false) return;
      cartController.getAddress();
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xffF5F5F5),
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Color(0xff014E70), size: 20),
          onPressed: () => Navigator.of(context).pop(),
        ),
        titleSpacing: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Checkout",
              style: GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 22),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            addressPart(size),
            const SizedBox(
              height: 30,
            ),
            paymentMethod(size),
            Column(
              children: [
                Container(
                  decoration: const BoxDecoration(color: Colors.white),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 15,
                        ),
                        Text("Add delivery instructions",
                            style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 18)),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          style: GoogleFonts.poppins(),
                          controller: deliveryInstructions,
                          decoration: InputDecoration.collapsed(
                              hintText: "Add delivery instructions to help us with the delivery",
                              hintStyle: GoogleFonts.poppins(color: const Color(0xff949495), fontSize: 14)),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
            Column(
              children: [
                Container(
                  decoration: const BoxDecoration(color: Colors.white),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 15,
                        ),
                        Text("Have a coupon code?", style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 18)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Expanded(child: CommonTextfield(obSecure: false, hintText: 'Enter Code',)),
                            Expanded(
                              child: TextFormField(
                                  style: GoogleFonts.poppins(),
                                  controller: couponController,
                                  decoration: InputDecoration.collapsed(
                                    hintText: "Enter Code",
                                    hintStyle: GoogleFonts.poppins(color: const Color(0xff949495), fontSize: 14),
                                  )),
                            ),
                            Obx(() {
                              return cartController.refreshInt.value == -2
                                  ? const CupertinoActivityIndicator()
                                  : const SizedBox.shrink();
                            }),
                            const SizedBox(
                              width: 20,
                            ),
                            GestureDetector(
                              onTap: () {
                                applyCouponCode();
                              },
                              child: Container(
                                decoration:
                                    BoxDecoration(color: const Color(0xff014E70), borderRadius: BorderRadius.circular(22)),
                                padding: const EdgeInsets.fromLTRB(22, 9, 22, 9),
                                child: Text(
                                  "Apply",
                                  style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.white),
                                ),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Your Order", style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 18)),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Subtotal (${cartController.cartModel.totalQuantity} items)",
                          style: GoogleFonts.poppins(fontWeight: FontWeight.w400, color: const Color(0xff949495))),
                      Text("KWD ${cartController.cartModel.subtotal.toString()}",
                          style: GoogleFonts.poppins(fontWeight: FontWeight.w400, color: const Color(0xff949495))),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Obx(() {
                    if (cartController.refreshInt.value > 0) {}
                    return couponApplied.isNotEmpty
                        ? Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Coupon Applied: $appliedCode",
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w400, color: CupertinoColors.activeGreen)),
                                  Text("KWD $couponApplied",
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w400,
                                          color: CupertinoColors.activeGreen,
                                          decoration: TextDecoration.lineThrough,
                                          decorationColor: Colors.lightGreenAccent)),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                            ],
                          )
                        : const SizedBox.shrink();
                  }),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Total", style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 18)),
                      Text(
                          "KWD ${cartController.cartModel.total.toString().convertToNum! - (couponApplied.convertToNum ?? 0)}",
                          style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 18)),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: InkWell(
        onTap: () {
          showValidation.value = true;
          if (deliveryOption.value.isEmpty) {
            BuildContext? context1 = addressKey.currentContext;
            if (context1 != null) {
              Scrollable.ensureVisible(context1, duration: const Duration(milliseconds: 650));
            }
            showToast("Please select delivery options");
            return;
          }
          if (deliveryOption.value == "delivery" && selectedAddress.id == null) {
            BuildContext? context1 = addressKey.currentContext;
            if (context1 != null) {
              Scrollable.ensureVisible(context1, duration: const Duration(milliseconds: 650));
            }
            showToast("Select delivery address to complete order");
            return;
          }
          cartController.dialogOpened = false;
          cartController.placeOrder(
              context: context,
              currencyCode: "usd",
              deliveryOption: deliveryOption.value,
              subTotalPrice: cartController.cartModel.subtotal.toString(),
              totalPrice: cartController.cartModel.total.toString(),
              couponCode: couponApplied.isNotEmpty ? appliedCode : null,
              purchaseType: PurchaseType.cart,
              address: selectedAddress.toJson());
        },
        child: Container(
          decoration: const BoxDecoration(color: Color(0xff014E70)),
          height: 56,
          alignment: Alignment.bottomCenter,
          child: Align(
              alignment: Alignment.center,
              child: Text("Complete Payment",
                  style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 18, color: Colors.white))),
        ),
      ),
    );
  }

  Column paymentMethod(Size size) {
    return Column(
      children: [
        Container(
          decoration: const BoxDecoration(color: Colors.white),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 15),
                Text("Payment", style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 18)),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Container(
                      width: size.width * .3,
                      height: size.height * .08,
                      decoration: BoxDecoration(
                          border: Border.all(color: const Color(0xffAFB1B1)), borderRadius: BorderRadius.circular(12)),
                      alignment: Alignment.center,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/images/knet.png",
                            width: 50,
                            height: 55,
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Container(
                      width: size.width * .3,
                      height: size.height * .08,
                      decoration: BoxDecoration(
                          border: Border.all(color: const Color(0xffAFB1B1)), borderRadius: BorderRadius.circular(12)),
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.credit_card,
                            color: Color(0xffAFB1B1),
                          ),
                          Text("Credit Card", style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 12)),
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 30,
        ),
      ],
    );
  }

  Container addressPart(Size size) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Padding(
        key: addressKey,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Obx(() {
          if (cartController.refreshInt.value > 0) {}
          return cartController.addressLoaded || profileController.userLoggedIn == false
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                            child:
                                Text("Delivery to", style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 18))),
                        Radio<String>(
                            value: "delivery",
                            groupValue: deliveryOption.value,
                            visualDensity: VisualDensity.compact,
                            fillColor: deliveryOption.value.isEmpty && showValidation.value
                                ? MaterialStateProperty.all(Colors.red)
                                : null,
                            onChanged: (value) {
                              deliveryOption.value = value!;
                            })
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    if (deliveryOption.value == "delivery") ...[
                      Material(
                        child: InkWell(
                          onTap: () {
                            if (userLoggedIn) {
                              bottomSheetChangeAddress();
                            } else {
                              addAddressWithoutLogin(addressData: selectedAddress);
                            }
                          },
                          child: DottedBorder(
                            color: const Color(0xff014E70),
                            strokeWidth: 1.2,
                            dashPattern: const [6, 3, 0, 3],
                            child: Container(
                              // height: 50,
                              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                              width: size.width,
                              alignment: Alignment.center,
                              child: selectedAddress.id != null
                                  ? Text(selectedAddress.getShortAddress,
                                      style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 16))
                                  : Text("Select Address ",
                                      style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 16)),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      if (selectedAddress.id != null)
                        InkWell(
                            onTap: () {
                              if (userLoggedIn) {
                                bottomSheetChangeAddress();
                              } else {
                                addAddressWithoutLogin(addressData: selectedAddress);
                              }
                            },
                            child: Align(
                                alignment: Alignment.topRight,
                                child: Text("Change Address",
                                    style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500)))),
                    ],
                    Row(
                      children: [
                        Expanded(
                            child: Text("Pick Up", style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 18))),
                        Radio<String>(
                            value: "pickup",
                            groupValue: deliveryOption.value,
                            visualDensity: VisualDensity.compact,
                            fillColor: deliveryOption.value.isEmpty && showValidation.value
                                ? MaterialStateProperty.all(Colors.red)
                                : null,
                            onChanged: (value) {
                              deliveryOption.value = value!;
                            })
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                )
              : const LoadingAnimation();
        }),
      ),
    );
  }

  Future bottomSheet({required AddressData addressData}) {
    Size size = MediaQuery.of(context).size;
    final TextEditingController firstNameController = TextEditingController(text: addressData.firstName ?? "");
    final TextEditingController lastNameController = TextEditingController(text: addressData.lastName ?? "");
    final TextEditingController phoneController = TextEditingController(text: addressData.phone ?? "");
    final TextEditingController alternatePhoneController = TextEditingController(text: addressData.alternatePhone ?? "");
    final TextEditingController addressController = TextEditingController(text: addressData.address ?? "");
    final TextEditingController address2Controller = TextEditingController(text: addressData.address2 ?? "");
    final TextEditingController cityController = TextEditingController(text: addressData.city ?? "");
    final TextEditingController countryController = TextEditingController(text: addressData.country ?? "");
    final TextEditingController stateController = TextEditingController(text: addressData.state ?? "");
    final TextEditingController zipCodeController = TextEditingController(text: addressData.zipCode ?? "");
    final TextEditingController landmarkController = TextEditingController(text: addressData.landmark ?? "");
    final TextEditingController titleController = TextEditingController(text: addressData.type ?? "");

    final formKey = GlobalKey<FormState>();

    return showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.white,
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.all(20),
            child: SizedBox(
              width: size.width,
              height: size.height * .8,
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ...commonField(
                          textController: titleController,
                          title: "Title*",
                          hintText: "Title",
                          keyboardType: TextInputType.name,
                          validator: (value) {
                            if (value!.trim().isEmpty) {
                              return "Please enter address title";
                            }
                            return null;
                          }),
                      ...commonField(
                          textController: firstNameController,
                          title: "First Name*",
                          hintText: "First Name",
                          keyboardType: TextInputType.name,
                          validator: (value) {
                            if (value!.trim().isEmpty) {
                              return "Please enter first name";
                            }
                            return null;
                          }),
                      ...commonField(
                          textController: lastNameController,
                          title: "Last Name*",
                          hintText: "Last Name",
                          keyboardType: TextInputType.name,
                          validator: (value) {
                            if (value!.trim().isEmpty) {
                              return "Please enter Last name";
                            }
                            return null;
                          }),
                      ...commonField(
                          textController: phoneController,
                          title: "Phone*",
                          hintText: "Enter your phone number",
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value!.trim().isEmpty) {
                              return "Please enter phone number";
                            }
                            if (value.trim().length > 15) {
                              return "Please enter valid phone number";
                            }
                            if (value.trim().length < 8) {
                              return "Please enter valid phone number";
                            }
                            return null;
                          }),
                      ...commonField(
                          textController: alternatePhoneController,
                          title: "Alternate Phone*",
                          hintText: "Enter your alternate phone number",
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            // if(value!.trim().isEmpty){
                            //   return "Please enter phone number";
                            // }
                            // if(value.trim().length > 15){
                            //   return "Please enter valid phone number";
                            // }
                            // if(value.trim().length < 8){
                            //   return "Please enter valid phone number";
                            // }
                            return null;
                          }),
                      ...commonField(
                          textController: addressController,
                          title: "Address*",
                          hintText: "Enter your delivery address",
                          keyboardType: TextInputType.streetAddress,
                          validator: (value) {
                            if (value!.trim().isEmpty) {
                              return "Please enter delivery address";
                            }
                            return null;
                          }),
                      ...commonField(
                          textController: address2Controller,
                          title: "Address 2",
                          hintText: "Enter your delivery address",
                          keyboardType: TextInputType.streetAddress,
                          validator: (value) {
                            // if(value!.trim().isEmpty){
                            //   return "Please enter delivery address";
                            // }
                            return null;
                          }),
                      ...commonField(
                          textController: landmarkController,
                          title: "Landmark",
                          hintText: "Enter your nearby landmark",
                          keyboardType: TextInputType.streetAddress,
                          validator: (value) {
                            // if(value!.trim().isEmpty){
                            //   return "Please enter delivery address";
                            // }
                            return null;
                          }),
                      ...commonField(
                          textController: cityController,
                          title: "City*",
                          hintText: "Enter your city",
                          keyboardType: TextInputType.streetAddress,
                          validator: (value) {
                            if (value!.trim().isEmpty) {
                              return "Please enter City*";
                            }
                            return null;
                          }),
                      ...commonField(
                          textController: zipCodeController,
                          title: "Zip-Code*",
                          hintText: "Enter location Zip-Code",
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value!.trim().isEmpty) {
                              return "Please enter Zip-Code*";
                            }
                            return null;
                          }),
                      ...commonField(
                          textController: stateController,
                          title: "State*",
                          hintText: "Enter your state",
                          keyboardType: TextInputType.streetAddress,
                          validator: (value) {
                            if (value!.trim().isEmpty) {
                              return "Please enter state*";
                            }
                            return null;
                          }),
                      ...commonField(
                          textController: countryController,
                          title: "Country*",
                          hintText: "Enter your country",
                          keyboardType: TextInputType.streetAddress,
                          validator: (value) {
                            if (value!.trim().isEmpty) {
                              return "Please enter country*";
                            }
                            return null;
                          }),
                      const SizedBox(
                        height: 16,
                      ),
                      GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () {
                          if (formKey.currentState!.validate()) {
                            cartController.updateAddressApi(
                                context: context,
                                firstName: firstNameController.text.trim(),
                                title: titleController.text.trim(),
                                lastName: lastNameController.text.trim(),
                                state: stateController.text.trim(),
                                country: countryController.text.trim(),
                                city: cityController.text.trim(),
                                address2: address2Controller.text.trim(),
                                address: addressController.text.trim(),
                                alternatePhone: alternatePhoneController.text.trim(),
                                landmark: landmarkController.text.trim(),
                                phone: phoneController.text.trim(),
                                zipCode: zipCodeController.text.trim(),
                                id: addressData.id);
                          }
                        },
                        child: Container(
                          decoration: const BoxDecoration(color: Color(0xff014E70)),
                          height: 56,
                          alignment: Alignment.bottomCenter,
                          child: Align(
                              alignment: Alignment.center,
                              child: Text("Save",
                                  style:
                                      GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 19, color: Colors.white))),
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  List<Widget> commonField({
    required TextEditingController textController,
    required String title,
    required String hintText,
    required FormFieldValidator<String>? validator,
    required TextInputType keyboardType,
  }) {
    return [
      const SizedBox(
        height: 5,
      ),
      Text(
        title,
        style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 18, color: const Color(0xff585858)),
      ),
      const SizedBox(
        height: 8,
      ),
      CommonTextfield(
        controller: textController,
        obSecure: false,
        hintText: hintText,
        validator: validator,
        keyboardType: keyboardType,
      ),
    ];
  }

  Future bottomSheetChangeAddress() {
    Size size = MediaQuery.of(context).size;
    return showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.white,
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.all(20).copyWith(top: 10),
            child: SizedBox(
              width: size.width,
              height: size.height * .88,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 100,
                        height: 6,
                        decoration: BoxDecoration(color: Colors.grey.shade400, borderRadius: BorderRadius.circular(100)),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CommonTextfield(
                    onTap: () {
                      // bottomSheet();
                    },
                    obSecure: false,
                    hintText: '+ Add Address',
                  ),
                  Expanded(
                    child: Obx(() {
                      if (cartController.refreshInt.value > 0) {}
                      List<AddressData> shippingAddress = cartController.addressListModel.address!.shipping ?? [];

                      return CustomScrollView(
                        shrinkWrap: true,
                        slivers: [
                          SliverToBoxAdapter(
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "Shipping Address",
                                    style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 16),
                                  ),
                                ),
                                TextButton.icon(
                                    onPressed: () {
                                      bottomSheet(addressData: AddressData());
                                    },
                                    style: TextButton.styleFrom(padding: EdgeInsets.zero),
                                    icon: const Icon(
                                      Icons.add,
                                      size: 20,
                                    ),
                                    label: Text(
                                      "Add New",
                                      style: GoogleFonts.poppins(fontSize: 15),
                                    ))
                              ],
                            ),
                          ),
                          const SliverPadding(padding: EdgeInsets.only(top: 4)),
                          shippingAddress.isNotEmpty
                              ? SliverList(
                                  delegate: SliverChildBuilderDelegate(
                                  childCount: shippingAddress.length,
                                  (context, index) {
                                    final address = shippingAddress[index];
                                    return GestureDetector(
                                      behavior: HitTestBehavior.translucent,
                                      onTap: () {
                                        selectedAddress = address;
                                        Get.back();
                                        setState(() {});
                                      },
                                      child: Container(
                                        width: size.width,
                                        margin: const EdgeInsets.only(bottom: 15),
                                        padding: const EdgeInsets.all(15),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            border: Border.all(color: const Color(0xffDCDCDC))),
                                        child: IntrinsicHeight(
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              const Icon(Icons.location_on_rounded),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Expanded(
                                                child: Text(
                                                  address.getCompleteAddressInFormat,
                                                  style: GoogleFonts.poppins(
                                                      fontWeight: FontWeight.w500,
                                                      fontSize: 15,
                                                      color: const Color(0xff585858)),
                                                ),
                                              ),
                                              Column(
                                                children: [
                                                  Flexible(
                                                    child: IconButton(
                                                        onPressed: () {
                                                          cartController
                                                              .deleteAddress(
                                                            context: context,
                                                            id: address.id.toString(),
                                                          )
                                                              .then((value) {
                                                            if (value == true) {
                                                              cartController.addressListModel.address!.shipping!.removeWhere(
                                                                  (element) =>
                                                                      element.id.toString() == address.id.toString());
                                                              cartController.updateUI();
                                                            }
                                                          });
                                                        },
                                                        icon: const Icon(Icons.delete)),
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      bottomSheet(addressData: address);
                                                    },
                                                    child: Text(
                                                      'Edit',
                                                      style: GoogleFonts.poppins(
                                                          shadows: [
                                                            const Shadow(color: Color(0xff014E70), offset: Offset(0, -4))
                                                          ],
                                                          color: Colors.transparent,
                                                          fontSize: 16,
                                                          fontWeight: FontWeight.w500,
                                                          decoration: TextDecoration.underline,
                                                          decorationColor: const Color(0xff014E70)),
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ))
                              : SliverToBoxAdapter(
                                  child: Text(
                                    "No Shipping Address Added!",
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 16),
                                  ),
                                ),
                          SliverToBoxAdapter(
                            child: SizedBox(
                              height: MediaQuery.of(context).viewInsets.bottom,
                            ),
                          ),
                        ],
                      );
                    }),
                  ),
                ],
              ),
            ),
          );
        });
  }

  Future addAddressWithoutLogin({required AddressData addressData}) {
    Size size = MediaQuery.of(context).size;
    final TextEditingController firstNameController = TextEditingController(text: addressData.firstName ?? "");
    final TextEditingController emailController = TextEditingController(text: addressData.email ?? "");
    final TextEditingController lastNameController = TextEditingController(text: addressData.lastName ?? "");
    final TextEditingController phoneController = TextEditingController(text: addressData.phone ?? "");
    final TextEditingController alternatePhoneController = TextEditingController(text: addressData.alternatePhone ?? "");
    final TextEditingController addressController = TextEditingController(text: addressData.address ?? "");
    final TextEditingController address2Controller = TextEditingController(text: addressData.address2 ?? "");
    final TextEditingController cityController = TextEditingController(text: addressData.city ?? "");
    final TextEditingController countryController = TextEditingController(text: addressData.country ?? "");
    final TextEditingController stateController = TextEditingController(text: addressData.state ?? "");
    final TextEditingController zipCodeController = TextEditingController(text: addressData.zipCode ?? "");
    final TextEditingController landmarkController = TextEditingController(text: addressData.landmark ?? "");
    final TextEditingController titleController = TextEditingController(text: addressData.type ?? "");

    final formKey = GlobalKey<FormState>();

    return showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.white,
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.all(20),
            child: SizedBox(
              width: size.width,
              height: size.height * .8,
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ...commonField(
                          textController: titleController,
                          title: "Title*",
                          hintText: "Title",
                          keyboardType: TextInputType.name,
                          validator: (value) {
                            if (value!.trim().isEmpty) {
                              return "Please enter address title";
                            }
                            return null;
                          }),
                      ...commonField(
                          textController: emailController,
                          title: "Email Address*",
                          hintText: "Email Address",
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value!.trim().isEmpty) {
                              return "Please enter email address";
                            }
                            if (value.trim().isValidEmail) {
                              return "Please enter valid email address";
                            }
                            return null;
                          }),
                      ...commonField(
                          textController: firstNameController,
                          title: "First Name*",
                          hintText: "First Name",
                          keyboardType: TextInputType.name,
                          validator: (value) {
                            if (value!.trim().isEmpty) {
                              return "Please enter first name";
                            }
                            return null;
                          }),
                      ...commonField(
                          textController: lastNameController,
                          title: "Last Name*",
                          hintText: "Last Name",
                          keyboardType: TextInputType.name,
                          validator: (value) {
                            if (value!.trim().isEmpty) {
                              return "Please enter Last name";
                            }
                            return null;
                          }),
                      ...commonField(
                          textController: phoneController,
                          title: "Phone*",
                          hintText: "Enter your phone number",
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value!.trim().isEmpty) {
                              return "Please enter phone number";
                            }
                            if (value.trim().length > 15) {
                              return "Please enter valid phone number";
                            }
                            if (value.trim().length < 8) {
                              return "Please enter valid phone number";
                            }
                            return null;
                          }),
                      ...commonField(
                          textController: alternatePhoneController,
                          title: "Alternate Phone*",
                          hintText: "Enter your alternate phone number",
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            // if(value!.trim().isEmpty){
                            //   return "Please enter phone number";
                            // }
                            // if(value.trim().length > 15){
                            //   return "Please enter valid phone number";
                            // }
                            // if(value.trim().length < 8){
                            //   return "Please enter valid phone number";
                            // }
                            return null;
                          }),
                      ...commonField(
                          textController: addressController,
                          title: "Address*",
                          hintText: "Enter your delivery address",
                          keyboardType: TextInputType.streetAddress,
                          validator: (value) {
                            if (value!.trim().isEmpty) {
                              return "Please enter delivery address";
                            }
                            return null;
                          }),
                      ...commonField(
                          textController: address2Controller,
                          title: "Address 2",
                          hintText: "Enter your delivery address",
                          keyboardType: TextInputType.streetAddress,
                          validator: (value) {
                            // if(value!.trim().isEmpty){
                            //   return "Please enter delivery address";
                            // }
                            return null;
                          }),
                      ...commonField(
                          textController: landmarkController,
                          title: "Landmark",
                          hintText: "Enter your nearby landmark",
                          keyboardType: TextInputType.streetAddress,
                          validator: (value) {
                            // if(value!.trim().isEmpty){
                            //   return "Please enter delivery address";
                            // }
                            return null;
                          }),
                      ...commonField(
                          textController: cityController,
                          title: "City*",
                          hintText: "Enter your city",
                          keyboardType: TextInputType.streetAddress,
                          validator: (value) {
                            if (value!.trim().isEmpty) {
                              return "Please enter City*";
                            }
                            return null;
                          }),
                      ...commonField(
                          textController: zipCodeController,
                          title: "Zip-Code*",
                          hintText: "Enter location Zip-Code",
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value!.trim().isEmpty) {
                              return "Please enter Zip-Code*";
                            }
                            return null;
                          }),
                      ...commonField(
                          textController: stateController,
                          title: "State*",
                          hintText: "Enter your state",
                          keyboardType: TextInputType.streetAddress,
                          validator: (value) {
                            if (value!.trim().isEmpty) {
                              return "Please enter state*";
                            }
                            return null;
                          }),
                      ...commonField(
                          textController: countryController,
                          title: "Country*",
                          hintText: "Enter your country",
                          keyboardType: TextInputType.streetAddress,
                          validator: (value) {
                            if (value!.trim().isEmpty) {
                              return "Please enter country*";
                            }
                            return null;
                          }),
                      const SizedBox(
                        height: 16,
                      ),
                      GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () {
                          if (formKey.currentState!.validate()) {
                            selectedAddress = AddressData(
                              id: "",
                              type: titleController.text.trim(),
                              firstName: firstNameController.text.trim(),
                              lastName: lastNameController.text.trim(),
                              state: stateController.text.trim(),
                              country: countryController.text.trim(),
                              city: cityController.text.trim(),
                              address2: address2Controller.text.trim(),
                              address: addressController.text.trim(),
                              alternatePhone: alternatePhoneController.text.trim(),
                              landmark: landmarkController.text.trim(),
                              phone: phoneController.text.trim(),
                              zipCode: zipCodeController.text.trim(),
                              email: emailController.text.trim(),
                            );
                            setState(() {});
                            Get.back();
                            // cartController.updateAddressApi(
                            //     context: context,
                            //     firstName: firstNameController.text.trim(),
                            //     title: titleController.text.trim(),
                            //     lastName: lastNameController.text.trim(),
                            //     state: stateController.text.trim(),
                            //     country: countryController.text.trim(),
                            //     city: cityController.text.trim(),
                            //     address2: address2Controller.text.trim(),
                            //     address: addressController.text.trim(),
                            //     alternatePhone: alternatePhoneController.text.trim(),
                            //     landmark: landmarkController.text.trim(),
                            //     phone: phoneController.text.trim(),
                            //     zipCode: zipCodeController.text.trim(),
                            //     id: addressData.id);
                          }
                        },
                        child: Container(
                          decoration: const BoxDecoration(color: Color(0xff014E70)),
                          height: 56,
                          alignment: Alignment.bottomCenter,
                          child: Align(
                              alignment: Alignment.center,
                              child: Text("Save",
                                  style:
                                      GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 19, color: Colors.white))),
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
