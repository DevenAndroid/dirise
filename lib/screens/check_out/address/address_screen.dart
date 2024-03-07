import 'package:dirise/utils/helper.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../controller/cart_controller.dart';
import '../../../controller/profile_controller.dart';
import '../../../model/customer_profile/model_city_list.dart';
import '../../../model/customer_profile/model_country_list.dart';
import '../../../model/customer_profile/model_state_list.dart';
import '../../../model/model_address_list.dart';
import '../../../utils/api_constant.dart';
import '../../../widgets/common_colour.dart';
import '../../../widgets/common_textfield.dart';
import '../../../widgets/loading_animation.dart';
import '../../my_account_screens/editprofile_screen.dart';
import 'edit_address.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({super.key});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  final cartController = Get.put(CartController());
  final profileController = Get.put(ProfileController());

  bool get userLoggedIn => profileController.userLoggedIn;
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Padding(
          // key: addressKey,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Obx(() {
            if (cartController.refreshInt.value > 0) {}
            return cartController.addressLoaded || profileController.userLoggedIn == false
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Row(
                      //   children: [
                      //     Expanded(
                      //         child: Text("Delivery to",
                      //             style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 18))),
                      //     // Radio<String>(
                      //     //     value: "delivery",
                      //     //     groupValue: cartController.deliveryOption1.value,
                      //     //     visualDensity: VisualDensity.compact,
                      //     //     fillColor: cartController.deliveryOption1.value.isEmpty && cartController.showValidation.value
                      //     //         ? MaterialStateProperty.all(Colors.red)
                      //     //         : null,
                      //     //     onChanged: (value) {
                      //     //       cartController.deliveryOption1.value = value!;
                      //     //     })
                      //
                      //     Radio<String>(
                      //       value: "delivery",
                      //       groupValue: cartController.deliveryOption1.value.isNotEmpty
                      //           ? cartController.deliveryOption1.value
                      //           : "delivery",
                      //
                      //       visualDensity: VisualDensity.compact,
                      //       // fillColor: cartController.deliveryOption1.value.isEmpty &&
                      //       //     cartController.showValidation.value
                      //       //     ? MaterialStateProperty.all(Colors.red)
                      //       //     : null,
                      //       onChanged: (value) {
                      //         cartController.deliveryOption1.value = value!;
                      //       },
                      //     )
                      //
                      //   ],
                      // ),

                      const SizedBox(
                        height: 20,
                      ),
                      // if (cartController.deliveryOption1.value == "delivery") ...[
                      //   Material(
                      //     child: InkWell(
                      //       onTap: () {
                      //         if (userLoggedIn) {
                      //           bottomSheetChangeAddress();
                      //         } else {
                      //           addAddressWithoutLogin(addressData: cartController.selectedAddress);
                      //         }
                      //       },
                      //       child: DottedBorder(
                      //         color: const Color(0xff014E70),
                      //         strokeWidth: 1.2,
                      //         dashPattern: const [6, 3, 0, 3],
                      //         child: Container(
                      //           // height: 50,
                      //           padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                      //           width: context.getSize.width,
                      //           alignment: Alignment.center,
                      //           child: cartController.selectedAddress.id != null
                      //               ? Text(cartController.selectedAddress.getShortAddress,
                      //                   style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 16))
                      //               : Text("Select Address ",
                      //                   style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 16)),
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      //   const SizedBox(
                      //     height: 5,
                      //   ),
                      //   if (cartController.selectedAddress.id != null)
                      //     InkWell(
                      //         onTap: () {
                      //           if (userLoggedIn) {
                      //             bottomSheetChangeAddress();
                      //           } else {
                      //             addAddressWithoutLogin(addressData: cartController.selectedAddress);
                      //           }
                      //         },
                      //         child: Align(
                      //             alignment: Alignment.topRight,
                      //             child: Text("Change Address",
                      //                 style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500)))),
                      // ],




                      // Row(
                      //   children: [
                      //     Expanded(
                      //         child: Text("Pick Up", style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 18))),
                      //     Radio<String>(
                      //         value: "pickup",
                      //         groupValue: cartController.deliveryOption1.value,
                      //         visualDensity: VisualDensity.compact,
                      //         fillColor: cartController.deliveryOption1.value.isEmpty && cartController.showValidation.value
                      //             ? MaterialStateProperty.all(Colors.red)
                      //             : null,
                      //         onChanged: (value) {
                      //           cartController.deliveryOption1.value = value!;
                      //         })
                      //   ],
                      // ),
                      Material(
                        child: InkWell(
                          onTap: () {
                            if (userLoggedIn) {
                              bottomSheetChangeAddress();
                            } else {
                              addAddressWithoutLogin(addressData: cartController.selectedAddress);
                            }
                          },
                          child: DottedBorder(
                            color: const Color(0xff014E70),
                            strokeWidth: 1.2,
                            dashPattern: const [6, 3, 0, 3],
                            child: Container(
                              // height: 50,
                              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                              width: context.getSize.width,
                              alignment: Alignment.center,
                              child: cartController.selectedAddress.id != null
                                  ? Text(cartController.selectedAddress.getShortAddress,
                                  style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 16))
                                  : Text("Choose Address ",
                                  style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 16)),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      if (cartController.selectedAddress.id != null)
                        InkWell(
                            onTap: () {
                              if (userLoggedIn) {
                                bottomSheetChangeAddress();
                              } else {
                                addAddressWithoutLogin(addressData: cartController.selectedAddress);
                              }
                            },
                            child: Align(
                                alignment: Alignment.topRight,
                                child: Text("Change Address",
                                    style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500)))),

                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  )
                : const LoadingAnimation();
          }),
        ),
      ),
    );
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
                            if (value.trim().invalidEmail) {
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
                      const SizedBox(
                        height: 16,
                      ),
                      GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () {
                          if (formKey.currentState!.validate()) {
                            cartController.selectedAddress = AddressData(
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

  Future bottomSheetChangeAddress() {
    Size size = MediaQuery.of(context).size;
    cartController.getAddress();
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
                  CommonTextField(
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
                                        cartController.selectedAddress = address;
                                        cartController.countryName.value = address.country.toString();
                                        print('onTap is....${cartController.countryName.value}');
                                        if(cartController.isDelivery.value == true){
                                          cartController.addressDeliFirstName.text = cartController.selectedAddress.getFirstName;
                                          cartController.addressDeliLastName.text = cartController.selectedAddress.getLastName;
                                          cartController.addressDeliEmail.text = cartController.selectedAddress.getEmail;
                                          cartController.addressDeliPhone.text = cartController.selectedAddress.getPhone;
                                          cartController.addressDeliAlternate.text = cartController.selectedAddress.getAlternate;
                                          cartController.addressDeliAddress.text = cartController.selectedAddress.getAddress;
                                          cartController.addressDeliZipCode.text = cartController.selectedAddress.getZipCode;
                                          cartController.addressCountryController.text = cartController.selectedAddress.getCountry;
                                          cartController.addressStateController.text = cartController.selectedAddress.getState;
                                          cartController.addressCityController.text = cartController.selectedAddress.getCity;
                                        }
                                        print('codeee isss${cartController.countryName.toString()}');
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

  Future bottomSheet({required AddressData addressData}) {

    return showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.white,
        builder: (context12) {
          return EditAddressSheet(addressData: addressData,);
        });
  }
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
      style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 16, color: const Color(0xff585858)),
    ),
    const SizedBox(
      height: 8,
    ),
    CommonTextField(
      controller: textController,
      obSecure: false,
      hintText: hintText,
      validator: validator,
      keyboardType: keyboardType,
    ),
  ];
}
