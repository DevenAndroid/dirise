import 'dart:convert';
import 'package:dirise/repository/repository.dart';
import 'package:dirise/screens/app_bar/common_app_bar.dart';
import 'package:dirise/utils/api_constant.dart';
import 'package:dirise/utils/helper.dart';
import 'package:dirise/utils/styles.dart';
import 'package:dirise/vendor/profile/vendor_profile_screen.dart';
import 'package:dirise/widgets/common_colour.dart';
import 'package:dirise/widgets/loading_animation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../model/vendor_models/model_plan_list.dart';
import '../authenthication/vendor_registration_screen.dart';

class EditVendorPlan extends StatefulWidget {
  const EditVendorPlan({super.key, required this.selectedPlanId});
  final String selectedPlanId;

  @override
  State<EditVendorPlan> createState() => _EditVendorPlanState();
}

class _EditVendorPlanState extends State<EditVendorPlan> with SingleTickerProviderStateMixin {
  final Repositories repositories = Repositories();
  ModelPlansList? modelPlansList;

  getPlansList() {
    repositories.getApi(url: ApiUrls.vendorPlanUrl).then((value) {
      modelPlansList = ModelPlansList.fromJson(jsonDecode(value));
      modelPlansList!.allPlans.asMap().entries.forEach((element) {
        for (var element1 in element.value!) {
          if(widget.selectedPlanId == element1.id.toString()){
            selectedPlan = element1;
            tabController.animateTo(element.key);
            setState(() {});
            break;
          }
        }
      });
      setState(() {});
    });
  }

  late TabController tabController;

  PlanInfoData? selectedPlan;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3,vsync: this);
    getPlansList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        titleText: 'Plans',
        bottom: modelPlansList != null
            ? PreferredSize(
          preferredSize: Size(context.getSize.width, kToolbarHeight + 50),
          child: TabBar(
            controller: tabController,
            isScrollable: true,
            tabs: modelPlansList!.allPlans
                .map((e) => Tab(
              child: Text(
                e!.first.businessType.toString().capitalize!,
                // style: titleStyle,
              ),
            ))
                .toList(),
            unselectedLabelStyle: titleStyle.copyWith(fontWeight: FontWeight.w400),
            labelStyle: titleStyle,
          ),
        )
            : null,
      ),
      backgroundColor: Colors.grey.shade100,
      body: modelPlansList != null
          ? TabBarView(
        controller: tabController,
        children: modelPlansList!.allPlans
            .map((e) => SingleChildScrollView(
            child: Card(
              margin: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 24),
                    child: Text(
                      e!.first.businessType.toString().capitalize!,
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600, fontSize: 20, color: AppTheme.buttonColor),
                    ),
                  ),
                  const Divider(
                    color: Color(0xFFC2ECEC),
                    height: 0,
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Text(
                          'PLANS',
                          style: GoogleFonts.poppins(
                            color: const Color(0xFF111727),
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: e
                              .asMap()
                              .entries
                              .map((e1) => GestureDetector(
                            onTap: () {
                              selectedPlan = e1.value;
                              setState(() {});
                            },
                            behavior: HitTestBehavior.translucent,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Radio<PlanInfoData?>(
                                        value: e1.value,
                                        groupValue: selectedPlan,
                                        visualDensity:
                                        const VisualDensity(horizontal: -4, vertical: -2),
                                        onChanged: (value) {
                                          selectedPlan = value;
                                          if (selectedPlan == null) return;
                                          setState(() {});
                                        }),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Expanded(
                                        flex: 3,
                                        child: Text(
                                          e1.value.label.toString().capitalize!,
                                          style: titleStyle,
                                        )),
                                    Expanded(flex: 2, child: Text("${e1.value.amount} ${e1.value.currency}",style: titleStyle.copyWith(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14
                                    ),)),
                                  ],
                                ),
                              ],
                            ),
                          ))
                              .toList(),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )))
            .toList(),
      )
          : const LoadingAnimation(),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20).copyWith(bottom: 25),
        child: ElevatedButton(
          onPressed: (){
            if(selectedPlan == null){
              showToast("Please select any plan");
              return;
            }
            Get.to(() => VendorProfileScreen(
              planId: selectedPlan!.id.toString(),
              selectedPlan: PlansType.values.firstWhere((element) => element.name.toLowerCase() == selectedPlan!.businessType.toString(),orElse: ()=> PlansType.personal),
            ));
          },
          style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.buttonColor,
              surfaceTintColor: AppTheme.buttonColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4)
              )
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Text("Update",style: titleStyle.copyWith(color: Colors.white),),
          ),
        ),
      ),
    );
  }
}
