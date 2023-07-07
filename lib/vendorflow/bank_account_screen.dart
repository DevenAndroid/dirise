import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/common_button.dart';
import '../widgets/common_textfield.dart';


class BankDetailsScreen extends StatefulWidget {
  const BankDetailsScreen({Key? key}) : super(key: key);
  static var bankDetailsScreen = "/bankDetailsScreen";

  @override
  State<BankDetailsScreen> createState() => _BankDetailsScreenState();
}

class _BankDetailsScreenState extends State<BankDetailsScreen> {


  String dropdownvalue = 'HDFC Bank';

  // List of items in our dropdown menu
  var items = [
    'HDFC Bank',
    'SBI Bank',
    'ICICI Bank',
    'PNB Bank',
    'IDFC Bank',
  ];
  // final TextEditingController bankAccountNumber = TextEditingController();
  // final TextEditingController accountHolderName = TextEditingController();
  // final TextEditingController iFSCCode = TextEditingController();
  RxString selectedCAt = "".obs;
  final _formKey = GlobalKey<FormState>();
  final List<String> dropDownList = ["HDFC Bank", "SBI Bank", "PNB Bank"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Bank Details',style: TextStyle(
      fontSize: 17,
      fontWeight: FontWeight.w600,
          color: Color(0xff423E5E),
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
      ),),
      // appBar: backAppBar(title: 'Bank Details', context: context),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            SizedBox(height: 30,),
            // addHeight(50),
            Image.asset('assets/images/bank_account.png',height: 151,),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 50,horizontal: 13),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 15),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(11),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xFF5F5F5F).withOpacity(0.2),
                        offset: Offset(0.0, 0.5),
                        blurRadius: 5,),]
                ),
                child: Column(
                  children: [
                    Container(
                      height: 50,
                      width: Get.width,
                      decoration: BoxDecoration(
                        border: Border.all(color: Color(0xFFE2E2E2),width: 1),
                        borderRadius: BorderRadius.circular(6),color: Color(0xFFF9F9F9),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 16.0),
                          child: DropdownButton(
                            value: dropdownvalue,
                            isExpanded: true,
                            // padding: EdgeInsets.only(left: 15,right: 15),
                            icon: const Icon(Icons.keyboard_arrow_down),
                            items: items.map((String items) {
                              return DropdownMenuItem(
                                value: items,
                                child: Padding(
                                  padding: const EdgeInsets.all(17.0),
                                  child: Text(items,
                                    style: GoogleFonts.raleway(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xFF463C3E)
                                    )
                                    ,),
                                ),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                dropdownvalue = newValue!;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                    // addHeight(15),
                    SizedBox(height: 20,),
                    CommonTextfield(

                      obSecure: true,
                      hintText: 'IBAN',
                      onTap: (){},
                    ),
                    SizedBox(height: 15,),
                    CommonTextfield(
                      hintText: 'Account Holder Name',
                      onTap: (){}, obSecure: true,
                    ),
                SizedBox(height: 15,),
                    CommonTextfield(
                      obSecure: true,
                      hintText: 'BIC/SWIFT code',
                      onTap: (){},
                    ),
                    SizedBox(height: 20,),
                    CustomOutlineButton(
                      onPressed: () {
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
    );
  }
}
