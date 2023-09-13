import 'package:dirise/language/app_strings.dart';
import 'package:dirise/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/vendor_controllers/vendor_profile_controller.dart';

class PlanWidget extends StatefulWidget {
  const PlanWidget({super.key});

  @override
  State<PlanWidget> createState() => _PlanWidgetState();
}

class _PlanWidgetState extends State<PlanWidget> {
  final vendorProfileController = Get.put(VendorProfileController());

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Obx(() {
        if (vendorProfileController.refreshInt.value > 0) {}
        return vendorProfileController.model.user != null
            ? Card(
                margin: const EdgeInsets.only(top: 10),
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Theme(
                    data: ThemeData(useMaterial3: true, dividerColor: Colors.transparent),
                    child: ExpansionTile(
                      textColor: const Color(0xFF393A3C),
                      initiallyExpanded: true,
                      iconColor: Colors.grey,
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Active Plan"),
                          Text(
                            vendorProfileController.model.user!.vendorType.toString().capitalize!,
                            style: titleStyle,
                          ),
                        ],
                      ),
                      expandedCrossAxisAlignment: CrossAxisAlignment.start,
                      expandedAlignment: Alignment.centerLeft,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (vendorProfileController.model.user!.planStartDate != null) ...[
                                const Text("Plan Start Date"),
                                Text(
                                  vendorProfileController.model.user!.planStartDate.toString().capitalize!,
                                  style: titleStyle,
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                              ],
                              if (vendorProfileController.model.user!.planExpireDate != null) ...[
                                const Text("Plan Expiry Date"),
                                Text(
                                  vendorProfileController.model.user!.planExpireDate.toString().capitalize!,
                                  style: titleStyle,
                                ),
                                const SizedBox(
                                  height: 14,
                                ),
                              ],
                              if (vendorProfileController.model.user!.planStartDate == null &&
                                  vendorProfileController.model.user!.planExpireDate == null)
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 8),
                                  child: Text(
                                    "Plan Info Not Available",
                                    style: normalStyle,
                                  ),
                                ),
                              Row(
                                children: [
                                  Expanded(
                                    child: OutlinedButton(
                                        onPressed: () {},
                                        style: OutlinedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(5),
                                          ),
                                          side: const BorderSide(color: Color(0xffECB403)),
                                          surfaceTintColor: Colors.white,
                                          elevation: 2,
                                          shadowColor: const Color(0xffECB403),
                                          backgroundColor: Colors.white,
                                        ),
                                        child: FittedBox(
                                          child: Text(
                                            AppStrings.renewPlan,
                                            style: titleStyle.copyWith(color: const Color(0xffECB403), fontSize: 18),
                                          ),
                                        )),
                                  ),
                                  const SizedBox(
                                    width: 16,
                                  ),
                                  Expanded(
                                    child: OutlinedButton(
                                        onPressed: () {},
                                        style: OutlinedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(5),
                                          ),
                                          side: const BorderSide(color: Color(0xff13BFA6)),
                                          surfaceTintColor: Colors.white,
                                          elevation: 2,
                                          shadowColor: const Color(0xff13BFA6),
                                          backgroundColor: Colors.white,
                                        ),
                                        child: FittedBox(
                                          child: Text(
                                            AppStrings.upgradePlan,
                                            style: titleStyle.copyWith(color: const Color(0xff13BFA6), fontSize: 18),
                                          ),
                                        )),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
            : const SizedBox.shrink();
      }),
    );
  }
}
