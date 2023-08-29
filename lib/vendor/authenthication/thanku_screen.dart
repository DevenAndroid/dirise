import 'package:dirise/widgets/common_colour.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../widgets/dimension_screen.dart';
import '../dashboard/dashboard_screen.dart';

class ThankYouVendorScreen extends StatefulWidget {
  const ThankYouVendorScreen({Key? key}) : super(key: key);
  static var route = "/thankYouVendorScreen";
  @override
  State<ThankYouVendorScreen> createState() => _ThankYouVendorScreenState();
}

class _ThankYouVendorScreenState extends State<ThankYouVendorScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        body: SingleChildScrollView(
            child: Padding(
          padding: EdgeInsets.symmetric(horizontal: AddSize.padding16, vertical: AddSize.padding16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: AddSize.size45,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Image(
                  height: AddSize.size300,
                  width: double.maxFinite,
                  image: const AssetImage('assets/images/thanku.png'),
                  fit: BoxFit.contain,
                  opacity: const AlwaysStoppedAnimation(.80),
                ),
              ),
              const SizedBox(
                height: 60,
              ),
              Text(
                "Your Account Has Been Successfully Created".tr,
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall!
                    .copyWith(fontWeight: FontWeight.w500, fontSize: 30, color: const Color(0xff262F33)),
              ),
              SizedBox(
                height: AddSize.size15,
              ),
              // Text(
              //   "Admin will verify and update you by\ncall or email".tr,
              //   textAlign: TextAlign.center,
              //   style: Theme.of(context)
              //       .textTheme
              //       .headlineSmall!
              //       .copyWith(fontWeight: FontWeight.w300, fontSize: AddSize.font18, color: const Color(0xff596774)),
              // ),
              SizedBox(
                height: AddSize.size10,
              ),
            ],
          ),
        )),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.symmetric(horizontal: AddSize.padding16, vertical: AddSize.size40),
          child: ElevatedButton(
              onPressed: () {
                Get.off(() => const VendorDashBoardScreen());
              },
              style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.maxFinite, 60),
                  backgroundColor: AppTheme.buttonColor,
                  elevation: 0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AddSize.size10)),
                  textStyle: GoogleFonts.poppins(fontSize: AddSize.font20, fontWeight: FontWeight.w600)),
              child: Text(
                "Continue".tr,
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall!
                    .copyWith(color: Colors.white, fontWeight: FontWeight.w500, fontSize: AddSize.font22),
              )),
        ),
      ),
    );
  }
}