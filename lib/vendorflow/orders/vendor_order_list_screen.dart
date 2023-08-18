import 'dart:convert';

import 'package:dirise/repository/repository.dart';
import 'package:dirise/utils/ApiConstant.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart' as intl;
import 'package:intl/intl.dart';
import '../../model/vendor_models/model_vendor_orders.dart';
import '../../widgets/common_colour.dart';
import '../../widgets/dimension_screen.dart';
import '../add_money_screen.dart';
import '../dashboard/sliver_bar.dart';

class VendorOrderList extends StatefulWidget {
  const VendorOrderList({Key? key}) : super(key: key);
  static var route = "/vendorOrderList";

  @override
  State<VendorOrderList> createState() => _VendorOrderListState();
}

class _VendorOrderListState extends State<VendorOrderList> {

  final Repositories repositories = Repositories();
  ModelVendorOrders modelVendorOrders = ModelVendorOrders();

  getOrdersList(){
    String url = "vendor-order?page=1";
    repositories.getApi(url: ApiUrls.baseUrl+url).then((value) {
      modelVendorOrders = ModelVendorOrders.fromJson(jsonDecode(value));
      setState(() {});
    });
  }

  final TextEditingController searchController = TextEditingController();
  RxBool isValue = false.obs;
  String? selectedStatus;
  String? selectedTime;
  String _statusController = "Filter";
  String _filterController = "Status";
  final List<String> optionMenu = ["vendor", "ffgsfgs"];

  final List<String> dropDownTimeList = ["This week", "Last week", "This month", "Last three month", "Custom"];
  final List<String> dropDownStatusList = ["Completed", "Pending"];

  final format = intl.DateFormat('dd-MM-yyyy');

  @override
  void initState() {
    super.initState();
    getOrdersList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff014E70),
      body: SafeArea(
        child: CustomScrollView(
          shrinkWrap: true,
          slivers: [
            SliverToBoxAdapter(
              child: Container(
                decoration: const BoxDecoration(
                    color: AppTheme.buttonColor,
                    image: DecorationImage(
                      image: AssetImage(
                        'assets/images/orderlitscontainer.png',
                      ),
                      fit: BoxFit.cover,
                    )),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: AddSize.padding16, vertical: AddSize.padding10),
                  child: SafeArea(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Get.back();
                              },
                              child: const Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                                size: 26,
                              ),
                            ),
                            // addWidth(20),
                            Text(
                              'Orders List',
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 1,
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 38,
                        ),
                        Container(
                            decoration: BoxDecoration(
                                color: AppTheme.buttonColor,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: Colors.white24)),
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: AddSize.padding16, vertical: AddSize.padding16),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '€450.00',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineSmall!
                                            .copyWith(fontWeight: FontWeight.w600, fontSize: 28, color: Colors.white),
                                      ),
                                      SizedBox(
                                        height: AddSize.size5,
                                      ),
                                      Text(
                                        "Your earning this month".tr,
                                        style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                                            fontWeight: FontWeight.w400, fontSize: AddSize.font14, color: Colors.white),
                                      ),
                                    ],
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      // controller.id.value=vendorOrderListController.model.value.data
                                      Get.toNamed(WithdrawMoney.route);
                                    },
                                    child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: AddSize.padding20, vertical: AddSize.padding12),
                                        decoration:
                                        BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
                                        child: Text(
                                          "Withdrawal".tr,
                                          style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                                              fontWeight: FontWeight.w600,
                                              fontSize: AddSize.font16,
                                              color: AppTheme.buttonColor),
                                        )),
                                  )
                                ],
                              ),
                            )),
                        SizedBox(
                          height: AddSize.size12,
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                height: 58,
                                decoration:
                                BoxDecoration(borderRadius: BorderRadius.circular(10.0), color: AppTheme.buttonColor),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: DropdownButtonFormField<String>(
                                        iconEnabledColor: Colors.white,
                                        iconDisabledColor: Colors.white,

                                        // value: _statusController,
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          focusedErrorBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(Radius.circular(8)),
                                              borderSide: BorderSide(color: Colors.white24)),
                                          errorBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(Radius.circular(8)),
                                              borderSide: BorderSide(color: Color(0xffE2E2E2))),
                                          focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(Radius.circular(8)),
                                              borderSide: BorderSide(color: Colors.white24)),
                                          disabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(Radius.circular(8)),
                                            borderSide: BorderSide(color: Colors.white24),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(Radius.circular(8)),
                                            borderSide: BorderSide(color: Colors.white24),
                                          ),
                                        ),
                                        items: ["vendor", "customer"]
                                            .map((label) => DropdownMenuItem(
                                          value: label,
                                          child: Text(
                                            label.toString(),
                                            style: GoogleFonts.poppins(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ))
                                            .toList(),
                                        // hint: Text('Rating',style: GoogleFonts.poppins(color: Colors.grey),),

                                        onChanged: (value) {
                                          setState(() {
                                            _statusController = value!;
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              //     child: Container(
                              //   decoration: BoxDecoration(
                              //       color: Colors.white,
                              //       borderRadius: BorderRadius.circular(6),
                              //       border: Border.all(color: Colors.white24)),
                              //   child: TextFormField(
                              //     style: GoogleFonts.poppins(
                              //       fontSize: 17,
                              //       color: AppTheme.buttonColor,
                              //     ),
                              //     decoration: InputDecoration(
                              //         border: const OutlineInputBorder(
                              //             borderSide: BorderSide.none),
                              //         contentPadding: EdgeInsets.symmetric(
                              //             horizontal: AddSize.padding20,
                              //             vertical: AddSize.padding10),
                              //         hintText: 'FiIter',
                              //         hintStyle: GoogleFonts.poppins(
                              //             fontSize: AddSize.font14,
                              //             color: const Color(0xFF676363),
                              //             fontWeight: FontWeight.w400)),
                              //     readOnly: true,
                              //     onTap: () {
                              //       // selectDate();
                              //     },
                              //     // controller: TextEditingController(
                              //     //     text: format.format(DateTime.parse('45/5'))),
                              //   ),
                              // )
                            ),
                            const SizedBox(
                              width: 18,
                            ),
                            Expanded(
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      height: 58,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10.0), color: AppTheme.buttonColor),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: DropdownButtonFormField<String>(
                                              iconEnabledColor: Colors.white,
                                              iconDisabledColor: Colors.white,
                                              // value: _filterController,
                                              decoration: const InputDecoration(
                                                border: InputBorder.none,
                                                focusedErrorBorder: OutlineInputBorder(
                                                    borderRadius: BorderRadius.all(Radius.circular(8)),
                                                    borderSide: BorderSide(color: Colors.white24)),
                                                errorBorder: OutlineInputBorder(
                                                    borderRadius: BorderRadius.all(Radius.circular(8)),
                                                    borderSide: BorderSide(color: Colors.white24)),
                                                focusedBorder: OutlineInputBorder(
                                                    borderRadius: BorderRadius.all(Radius.circular(8)),
                                                    borderSide: BorderSide(color: Colors.white24)),
                                                disabledBorder: OutlineInputBorder(
                                                  borderRadius: BorderRadius.all(Radius.circular(8)),
                                                  borderSide: BorderSide(color: Colors.white24),
                                                ),
                                                enabledBorder: OutlineInputBorder(
                                                    borderRadius: BorderRadius.all(Radius.circular(8)),
                                                    borderSide: BorderSide(color: Colors.white24)),
                                              ),
                                              items: ["vendor", "customer"]
                                                  .map((label) => DropdownMenuItem(
                                                value: label,
                                                child: Text(
                                                  label.toString(),
                                                  style: GoogleFonts.poppins(
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ))
                                                  .toList(),
                                              hint: const Text('Rating'),
                                              onChanged: (value) {
                                                setState(() {
                                                  _filterController = value!;
                                                });
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: AddSize.size12,
                        ),
                        Container(
                          height: 57,
                          decoration: BoxDecoration(
                              color: AppTheme.buttonColor,
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(color: Colors.white12)),
                          child: TextField(
                            // onTap: (){
                            //   vendorOrderListController.searchController.value=vendorOrderListController.model.value.data.orderList.length;
                            // },
                            maxLines: 1,
                            // controller:
                            // vendorOrderListController.searchController,
                            style: GoogleFonts.poppins(
                              fontSize: 17,
                              color: const Color(0xFF676363),
                            ),
                            textAlignVertical: TextAlignVertical.center,
                            textInputAction: TextInputAction.search,
                            onSubmitted: (value) {},
                            decoration: InputDecoration(
                                filled: true,
                                fillColor: AppTheme.buttonColor,
                                border: const OutlineInputBorder(
                                    borderSide: BorderSide.none, borderRadius: BorderRadius.all(Radius.circular(4))),
                                contentPadding:
                                EdgeInsets.symmetric(horizontal: AddSize.padding20, vertical: AddSize.padding10),
                                hintText: 'Search'.tr,
                                hintStyle: GoogleFonts.poppins(
                                    fontSize: AddSize.font16, color: Colors.white, fontWeight: FontWeight.w400)),
                          ),
                        ),
                        SizedBox(
                          height: AddSize.size12,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const LatestSalesAppBar(),
            if(modelVendorOrders.order != null)
            SliverList.builder(
                itemCount: modelVendorOrders.order!.data!.length,
                itemBuilder: (context, index) {
                  final order = modelVendorOrders.order!.data![index];
                  if (kDebugMode) {
                    print(jsonEncode(order));
                    print("SliverList....    $index");
                  }
                  return Container(
                    color: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      children: [
                        SizedBox(
                          height: AddSize.size5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 5,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "#${order.orderId.toString()}",
                                    style: GoogleFonts.poppins(
                                        color: const Color(0xFF454B5C),
                                        height: 1.5,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  if (DateTime.tryParse(order.updatedAt.toString()) != null)
                                    Text(
                                      DateFormat("HH:mm a - dd MMM, yyyy")
                                          .format(DateTime.tryParse(order.updatedAt.toString())!),
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 13,
                                          color: const Color(0xFF8C9BB2)),
                                    ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 6,
                            ),
                            Expanded(
                              flex: 3,
                              child: Text(
                                order.status.toString().capitalize!,
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w600, fontSize: 14, color: const Color(0xFFFFB26B)),
                              ),
                            ),
                            const SizedBox(
                              width: 6,
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(
                                "\$${order.totalPrice}",
                                textAlign: TextAlign.end,
                                style: GoogleFonts.poppins(
                                    height: 1.5,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                    color: const Color(0xFF454B5C)),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: AddSize.size5,
                        ),
                        const Divider(
                          color: Color(0xffEFEFEF),
                        ),
                      ],
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
