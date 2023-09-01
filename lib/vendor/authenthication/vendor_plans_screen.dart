import 'dart:convert';
import 'package:dirise/repository/repository.dart';
import 'package:dirise/screens/app_bar/common_app_bar.dart';
import 'package:dirise/utils/ApiConstant.dart';
import 'package:dirise/utils/styles.dart';
import 'package:dirise/widgets/loading_animation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../model/vendor_models/model_plan_list.dart';
import 'vendor_registration_screen.dart';

class VendorPlansScreen extends StatefulWidget {
  const VendorPlansScreen({super.key});

  @override
  State<VendorPlansScreen> createState() => _VendorPlansScreenState();
}

class _VendorPlansScreenState extends State<VendorPlansScreen> {
  final Repositories repositories = Repositories();
  ModelPlansList? modelPlansList;

  getPlansList() {
    repositories.getApi(url: ApiUrls.vendorPlanUrl).then((value) {
      modelPlansList = ModelPlansList.fromJson(jsonDecode(value));
      setState(() {});
    });
  }

  PlanInfoData? selectedPlan;

  @override
  void initState() {
    super.initState();
    getPlansList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CommonAppBar(
        titleText: 'Available Plans',
      ),
      body: modelPlansList != null
          ? SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: modelPlansList!.allPlans
                    .map((e) => Card(
                          margin: const EdgeInsets.only(bottom: 20),
                          child: Column(
                            children: e!
                                .asMap()
                                .entries
                                .map((e1) => Padding(
                                      padding: const EdgeInsets.only(bottom: 14),
                                      child: GestureDetector(
                                        onTap: () {
                                          selectedPlan = e1.value;
                                          Get.to(()=> VendorRegistrationScreen(
                                            selectedPlan: selectedPlan!,
                                            modelPlansList: modelPlansList!,
                                          ));
                                          setState(() {});
                                        },
                                        behavior: HitTestBehavior.translucent,
                                        child: Padding(
                                          padding: const EdgeInsets.all(15.0),
                                          child: Column(
                                            children: [
                                              if (e1.key == 0)
                                                Text(
                                                  e1.value.businessType.toString().capitalize!,
                                                  style: titleStyle.copyWith(fontSize: 18),
                                                ),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: Column(
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Expanded(
                                                                child: Text(
                                                              e1.value.title.toString().capitalize!,
                                                              style: titleStyle,
                                                            )),
                                                            Text(e1.value.amount.toString()),
                                                          ],
                                                        ),
                                                        const SizedBox(
                                                          height: 5,
                                                        ),
                                                        Row(
                                                          children: [
                                                            Expanded(
                                                                child: Text(
                                                              "Validity",
                                                              style: titleStyle,
                                                            )),
                                                            Text("${e1.value.label}"),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Radio<PlanInfoData?>(
                                                      value: e1.value,
                                                      groupValue: selectedPlan,
                                                      onChanged: (value) {
                                                        selectedPlan = value;
                                                        if(selectedPlan == null)return;
                                                        Get.to(()=> VendorRegistrationScreen(
                                                          selectedPlan: selectedPlan!,
                                                          modelPlansList: modelPlansList!,
                                                        ));
                                                        setState(() {});
                                                      })
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ))
                                .toList(),
                          ),
                        ))
                    .toList(),
              ),
            )
          : const LoadingAnimation(),
    );
  }
}
