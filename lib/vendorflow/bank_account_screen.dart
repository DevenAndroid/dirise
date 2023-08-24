import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controller/vendor_controllers/bank_details_controller.dart';
import '../widgets/common_button.dart';
import '../widgets/common_textfield.dart';
import '../widgets/loading_animation.dart';

class BankDetailsScreen extends StatefulWidget {
  const BankDetailsScreen({Key? key}) : super(key: key);
  static var route = "/bankDetailsScreen";

  @override
  State<BankDetailsScreen> createState() => _BankDetailsScreenState();
}

class _BankDetailsScreenState extends State<BankDetailsScreen> {

  final controller = Get.put(BankDetailsController());

  String dropdownvalue = 'HDFC Bank';

  @override
  void initState() {
    super.initState();
    Future.wait([
    controller.getBankList(),
    controller.getBankDetails()]).then((value) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bank Details',
            style: GoogleFonts.poppins(
              fontSize: 17,
              fontWeight: FontWeight.w600,
              color: const Color(0xff423E5E),
            )),
        leading: GestureDetector(
          onTap: () {
            Get.back();
            // _scaffoldKey.currentState!.openDrawer();
          },
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Image.asset(
              'assets/icons/backicon.png',
              height: 20,
            ),
          ),
        ),
      ),
      body: controller.modelBankInfo.data != null && controller.modelBankList.data != null ?
      SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            // addHeight(50),
            Image.asset(
              'assets/images/bank_account.png',
              height: 151,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 13),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(11), boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF5F5F5F).withOpacity(0.2),
                    offset: const Offset(0.0, 0.5),
                    blurRadius: 5,
                  ),
                ]),
                child: Column(
                  children: [
                    DropdownButtonFormField<String?>(
                      isExpanded: true,
                      // padding: EdgeInsets.only(left: 15,right: 15),
                      icon: const Icon(Icons.keyboard_arrow_down),
                      items: controller.modelBankList.data!.banks!.map((e) =>
                          DropdownMenuItem(
                            value: e.id.toString(),
                            child: Padding(
                              padding: const EdgeInsets.all(17.0),
                              child: Text(
                                e.name.toString(),
                                style: GoogleFonts.raleway(
                                    fontSize: 13, fontWeight: FontWeight.w400, color: const Color(0xFF463C3E)),
                              ),
                            ),
                          )).toList(),
                      onChanged: (newValue) {
                        setState(() {
                          dropdownvalue = newValue!;
                        });
                      },
                    ),
                    // addHeight(15),
                    const SizedBox(
                      height: 20,
                    ),
                    CommonTextfield(
                      obSecure: true,
                      hintText: 'IBAN',
                      onTap: () {},
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    CommonTextfield(
                      hintText: 'Account Holder Name',
                      onTap: () {},
                      obSecure: true,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    CommonTextfield(
                      obSecure: true,
                      hintText: 'BIC/SWIFT code',
                      onTap: () {},
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomOutlineButton(
                      onPressed: () {},
                      title: "Add Account",
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ) :
      const LoadingAnimation(),
    );
  }
}
