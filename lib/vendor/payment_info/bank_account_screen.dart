import 'dart:convert';

import 'package:dirise/model/common_modal.dart';
import 'package:dirise/utils/api_constant.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../controller/vendor_controllers/bank_details_controller.dart';
import '../../repository/repository.dart';
import '../../widgets/common_button.dart';
import '../../widgets/common_colour.dart';
import '../../widgets/common_textfield.dart';
import '../../widgets/loading_animation.dart';

class BankDetailsScreen extends StatefulWidget {
  const BankDetailsScreen({Key? key}) : super(key: key);
  static var route = "/bankDetailsScreen";

  @override
  State<BankDetailsScreen> createState() => _BankDetailsScreenState();
}

class _BankDetailsScreenState extends State<BankDetailsScreen> {
  final controller = Get.put(BankDetailsController());

  final TextEditingController accountNumber = TextEditingController();
  final TextEditingController accountHolderName = TextEditingController();
  final TextEditingController bicSwiftCode = TextEditingController();
  String bankId = "";
  final formKey = GlobalKey<FormState>();

  updateBankDetails() {
    if (!formKey.currentState!.validate())return;
    final map = {
      'bank': bankId,
      'account_holder_name': accountHolderName.text.trim(),
      'account_no': accountNumber.text.trim(),
      'ifsc_code': bicSwiftCode.text.trim()
    };
    Repositories().postApi(url: ApiUrls.addAccountDetailsUrl,context: context,mapData: map).then((value) {
      ModelCommonResponse response = ModelCommonResponse.fromJson(jsonDecode(value));
      showToast(response.message.toString());
      Get.back();
    });
  }

  Future getData() async {
    await Future.wait([controller.getBankList(), controller.getBankDetails()]).then((value) {
      if (controller.modelBankInfo.data != null) {
        accountNumber.text = controller.modelBankInfo.data!.accountNo ?? "";
        accountHolderName.text = controller.modelBankInfo.data!.accountHolderName ?? "";
        bicSwiftCode.text = controller.modelBankInfo.data!.ifscCode ?? "";
        bankId = controller.modelBankInfo.data!.bank ?? "";
        if (controller.modelBankList.checkAll) {
          for (var element in controller.modelBankList.data!.banks!) {
            if (element.name!.toLowerCase() == controller.modelBankInfo.data!.bank!.toLowerCase()) {
              bankId = element.id.toString();
              break;
            }
          }
        }
      }
      setState(() {});
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
      body: controller.modelBankInfo.data != null && controller.modelBankList.data != null
          ? RefreshIndicator(
              onRefresh: () async {
                getData();
              },
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
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
                          decoration:
                              BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(11), boxShadow: [
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
                                value: bankId.isEmpty ? null : bankId,
                                style: const TextStyle(color: Colors.red),
                                decoration: const InputDecoration(
                                  hintText: "Please select bank",
                                  // labelText: "Please select bank",
                                  contentPadding: EdgeInsets.all(15),
                                  focusedErrorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(8)),
                                      borderSide: BorderSide(color: AppTheme.secondaryColor)),
                                  errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(8)),
                                      borderSide: BorderSide(color: AppTheme.secondaryColor)),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(8)),
                                      borderSide: BorderSide(color: AppTheme.secondaryColor)),
                                  disabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(8)),
                                    borderSide: BorderSide(color: AppTheme.secondaryColor),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(8)),
                                    borderSide: BorderSide(color: AppTheme.secondaryColor),
                                  ),
                                ),
                                icon: const Icon(Icons.keyboard_arrow_down),
                                items: controller.modelBankList.data!.banks!
                                    .map((e) => DropdownMenuItem(
                                          value: e.id.toString(),
                                          child: Text(
                                            e.name.toString(),
                                            style: GoogleFonts.poppins(
                                                fontSize: 13, fontWeight: FontWeight.w500, color: Colors.black),
                                          ),
                                        ))
                                    .toList(),
                                validator: (value) {
                                  if (bankId.isEmpty) {
                                    return "Please select bank";
                                  }
                                  return null;
                                },
                                onChanged: (newValue) {
                                  bankId = newValue!;
                                  if (kDebugMode) {
                                    print(bankId);
                                  }
                                  setState(() {});
                                },
                              ),
                              // addHeight(15),
                              const SizedBox(
                                height: 20,
                              ),
                              CommonTextField(
                                controller: accountNumber,
                                validator: (value) {
                                  if (value!.trim().isEmpty) {
                                    return "Please enter account number";
                                  }
                                  return null;
                                },
                                hintText: 'Account No.',
                                onTap: () {},
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              CommonTextField(
                                controller: accountHolderName,
                                validator: (value) {
                                  if (value!.trim().isEmpty) {
                                    return "Please enter account holder name";
                                  }
                                  return null;
                                },
                                hintText: 'Account Holder Name',
                                onTap: () {},
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              CommonTextField(
                                controller: bicSwiftCode,
                                validator: (value) {
                                  if (value!.trim().isEmpty) {
                                    return "Please enter IFSC code";
                                  }
                                  return null;
                                },
                                hintText: 'IFSC Code',
                                onTap: () {},
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              CustomOutlineButton(
                                onPressed: () {
                                  updateBankDetails();
                                },
                                title: "Add Account",
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          : const LoadingAnimation(),
    );
  }
}
