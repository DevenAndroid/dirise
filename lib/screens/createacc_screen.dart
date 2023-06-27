import 'package:country_code_picker/country_code_picker.dart';
import 'package:dirise/widgets/common_colour.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/common_button.dart';
import '../widgets/common_textfield.dart';

class CreateAcc extends StatefulWidget {
  const CreateAcc({Key? key}) : super(key: key);

  @override
  State<CreateAcc> createState() => _CreateAccState();
}

class _CreateAccState extends State<CreateAcc> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(left: 13, right: 13),
        child: Column(
          children: [
            const SizedBox(
              height: 35,
            ),
            Row(
              children: [
                InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Image.asset(height: 30, 'assets/icons/arrowback.png'),
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  'Create Account',
                  style: GoogleFonts.poppins(
                      fontSize: 19, fontWeight: FontWeight.w600),
                )
              ],
            ),
            const Padding(
              padding: EdgeInsets.only(top: 20),
              child: Image(
                  height: 170, image: AssetImage('assets/images/logo.png')),
            ),
            SizedBox(
              height: size.height * .03,
            ),
            CommonTextfield(obSecure: false, hintText: 'Name'),
            SizedBox(
              height: size.height * .01,
            ),
            CommonTextfield(obSecure: false, hintText: 'Email'),
            SizedBox(
              height: size.height * .01,
            ),
            CommonTextfield(obSecure: false, hintText: 'Password'),
            SizedBox(
              height: size.height * .01,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 51,
                  child: Expanded(
                    flex: 1,
                    child: Container(
                      width: 80,
                      decoration: BoxDecoration(
                          border: Border.all(color: AppTheme.secondaryColor),
                          borderRadius: BorderRadius.circular(8)),
                      child: const Center(
                        child: CountryCodePicker(
                          onChanged: print,
                          initialSelection: 'IT',
                          favorite: [' +39', 'FR'],
                          showCountryOnly: false,
                          showOnlyCountryWhenClosed: false,
                          alignLeft: false,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Flexible(
                    flex: 5,
                    child: CommonTextfield(
                        obSecure: false, hintText: '987-654-3210')),
              ],
            ),
            SizedBox(
              height: size.height * .03,
            ),
            CustomOutlineButton(
              title: "Create Account",
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
