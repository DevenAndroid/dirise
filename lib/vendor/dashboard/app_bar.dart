import 'package:dirise/utils/helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../controller/vendor_controllers/vendor_profile_controller.dart';
import '../../controller/vendor_controllers/vendor_store_timing.dart';
import '../../model/vendor_models/model_store_availability.dart';
import '../../widgets/common_colour.dart';
import '../../widgets/dimension_screen.dart';
import '../profile/vendor_profile_screen.dart';
import 'store_open_time_screen.dart';

class AppBarScreen extends StatefulWidget implements PreferredSizeWidget {
  const AppBarScreen({super.key});

  @override
  State<AppBarScreen> createState() => _AppBarScreenState();

  @override
  Size get preferredSize => const Size(double.maxFinite, 80);
}

class _AppBarScreenState extends State<AppBarScreen> {
  final vendorProfileController = Get.put(VendorProfileController());
  final vendorStoreTimingController = Get.put(VendorStoreTimingController());

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Image.asset(
                  'assets/icons/backicon.png',
                  height: 25,
                ),
              ),
            ),
          ],
        ),
      ),
      toolbarHeight: 100,
      backgroundColor: Colors.transparent,
      elevation: 0,
      titleSpacing: 0,
      title: Obx(() {
        if (vendorProfileController.refreshInt.value > 0) {}
        return vendorProfileController.apiLoaded
            ? Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Hi, ${vendorProfileController.model.user!
                  .name
                  .toString()
                  .checkNullable}",
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600, fontSize: AddSize.font22, color: const Color(0xff292F45)),
            ),
            Row(
              children: [
                Flexible(
                  child: Text(
                    "Store Time :",
                    style:
                    GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 15, color: const Color(0xff737A8A)),
                  ),
                ),
                Expanded(
                  child: Obx(() {
                    if(vendorStoreTimingController.refreshInt.value > 0){}
                    print("fffff....    ${DateFormat("EEEE").format(DateTime.now()).toLowerCase()}");
                    return Text(
                      vendorStoreTimingController.modelStoreAvailability.data != null ?
                      "${vendorStoreTimingController.modelStoreAvailability.data!.firstWhere((element) =>
                      element.weekDay.toString().toLowerCase() == DateFormat("EEEE").format(DateTime.now()).toLowerCase(),
                          orElse: () =>
                              TimeData(
                                  startTime: ""
                              )).startTime.toString().normalTime} to ${(vendorStoreTimingController.modelStoreAvailability.data!.firstWhere((
                          element) =>
                      element.weekDay.toString().toLowerCase() == DateFormat("EEEE").format(DateTime.now()).toLowerCase(),
                          orElse: () =>
                              TimeData(
                                  startTime: ""
                              )).endTime ?? "").toString().normalTime}" : "",
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w400, fontSize: 16, color: AppTheme.buttonColor),
                    );
                  }),
                ),
                IconButton(
                  onPressed: () {
                    Get.toNamed(SetTimeScreen.setTimeScreen);
                  },
                  padding: EdgeInsets.zero,
                  visualDensity: VisualDensity.compact,
                  icon: const Icon(
                    Icons.edit,
                    color: AppTheme.buttonColor,
                    size: 15,
                  ),
                ),
              ],
            )
          ],
        )
            : const SizedBox();
      }),
      actions: [
        GestureDetector(
          onTap: () {
            Get.toNamed(VendorProfileScreen.route);
          },
          child: Obx(() {
            // log(vendorController.model.data!.storeBusinessId.toString());
            if (vendorProfileController.refreshInt.value > 0) {}
            return vendorProfileController.apiLoaded
                ? Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 16.0, top: 8),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(1000),
                    child: Container(
                        height: 45,
                        width: 45,
                        clipBehavior: Clip.antiAlias,
                        // margin: EdgeInsets.all(1),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          // color: Colors.brown
                        ),
                        child: Image.network(
                          vendorProfileController.model.user!.storeImage.toString(),
                          errorBuilder: (_, __, ___) =>
                              Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(1000),
                                      border: Border.all(color: Colors.grey)),
                                  child: Icon(
                                    Icons.person_2_rounded,
                                    color: Colors.grey.shade700,
                                  )),
                        )),
                  ),
                ),
                Positioned(
                    top: 9,
                    child: Column(children: [
                      Image.asset(
                        'assets/icons/active.png',
                        height: 12,
                      ),
                    ]))
              ],
            )
                : const Padding(
              padding: EdgeInsets.only(right: 14),
              child: Center(
                child: CupertinoActivityIndicator(),
              ),
            );
          }),
        )
      ],
    );
  }
}
