import 'package:dirise/routers/my_routers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;
import '../widgets/common_colour.dart';
import '../widgets/dimension_screen.dart';

class VendorOrderList extends StatefulWidget {
  const VendorOrderList({Key? key}) : super(key: key);
  static var vendorOrderList = "/vendorOrderList";

  @override
  State<VendorOrderList> createState() => _VendorOrderListState();
}

class _VendorOrderListState extends State<VendorOrderList> {
  final TextEditingController searchController = TextEditingController();
  RxBool isValue = false.obs;
  String? selectedStatus;
  String? selectedTime;

  final List<String> dropDownTimeList = [
    "This week",
    "Last week",
    "This month",
    "Last three month",
    "Custom"
  ];
  final List<String> dropDownStatusList = ["Completed", "Pending"];

  final format = intl.DateFormat('dd-MM-yyyy');

  // void selectDate() async {
  //   final DateTime? pickedDate = await showDatePicker(
  //     context: context,
  //     initialDate: DateTime.parse(vendorOrderListController.selectedDate.value),
  //     firstDate: DateTime(1900),
  //     lastDate: DateTime.now(),
  //   );
  //   if (pickedDate != null) {
  //     vendorOrderListController.selectedDate.value = pickedDate.toString();
  //     setState(() {});
  //   }
  // }

  // void selectDate1() async {
  //   final DateTime? pickedDate = await showDatePicker(
  //     context: context,
  //     initialDate: DateTime.parse(vendorOrderListController.selectedDate.value),
  //     firstDate: DateTime(1900),
  //     lastDate: DateTime.now(),
  //   );
  //   if (pickedDate != null) {
  //     vendorOrderListController.selectedDate.value = pickedDate.toString();
  //     controller.getMyOrderDetails();
  //     setState(() {});
  //   }
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   vendorOrderListController.filter.value = "";
  //   vendorOrderListController.vendorOrderListData();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Column(
              children: [
                Container(
                  width: AddSize.screenWidth * 1,
                  decoration: const BoxDecoration(
                      color: AppTheme.buttonColor,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20)),
                      image: DecorationImage(

                        image: AssetImage('assets/icons/shortcontainer.png'),
                        fit: BoxFit.fill,
                      )),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: AddSize.padding16,
                        vertical: AddSize.padding10),
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
                              const Text(
                                'Orders List',
                                style: TextStyle(
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
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(color: Colors.white24)),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: AddSize.padding16,
                                    vertical: AddSize.padding16),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '€450.00',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline5!
                                              .copyWith(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 28,
                                                  color:
                                                      const Color(0xFF676363)),
                                        ),
                                        SizedBox(
                                          height: AddSize.size5,
                                        ),
                                        Text(
                                          "Your earning this month".tr,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline5!
                                              .copyWith(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: AddSize.font14,
                                                  color:
                                                      const Color(0xFF676363)),
                                        ),
                                      ],
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        // controller.id.value=vendorOrderListController.model.value.data
                                        Get.toNamed(MyRouters.addMoneyScreen);
                                      },
                                      child: Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: AddSize.padding16,
                                              vertical: AddSize.padding10),
                                          decoration: BoxDecoration(
                                              color: AppTheme.primaryColor,
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Text(
                                            "Withdrawal".tr,
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline5!
                                                .copyWith(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: AddSize.font14,
                                                    color: Colors.white),
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
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(6),
                                    border: Border.all(color: Colors.white24)),
                                child: TextFormField(
                                  style: const TextStyle(
                                    fontSize: 17,
                                    color: AppTheme.buttonColor,
                                  ),
                                  decoration: InputDecoration(
                                      border: const OutlineInputBorder(
                                          borderSide: BorderSide.none),
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: AddSize.padding20,
                                          vertical: AddSize.padding10),
                                      hintText: 'FiIter',
                                      hintStyle: TextStyle(
                                          fontSize: AddSize.font14,
                                          color: const Color(0xFF676363),
                                          fontWeight: FontWeight.w400)),
                                  readOnly: true,
                                  onTap: () {
                                    // selectDate();
                                  },
                                  // controller: TextEditingController(
                                  //     text: format.format(DateTime.parse('45/5'))),
                                ),
                              )),
                              const SizedBox(
                                width: 18,
                              ),
                              Expanded(
                                child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(6),
                                        border:
                                            Border.all(color: Colors.white24)),
                                    child: TextFormField(
                                      style: const TextStyle(
                                        fontSize: 17,
                                        color: AppTheme.buttonColor,
                                      ),
                                      decoration: InputDecoration(
                                          border: const OutlineInputBorder(
                                              borderSide: BorderSide.none),
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: AddSize.padding20,
                                              vertical: AddSize.padding10),
                                          hintText: 'Status',
                                          hintStyle: TextStyle(
                                              fontSize: AddSize.font14,
                                              color: const Color(0xFF676363),
                                              fontWeight: FontWeight.w400)),
                                      onTap: () {
                                        // selectDate1();
                                      },
                                      readOnly: true,
                                      //   controller: TextEditingController(
                                      //       // text: format.format(DateTime.parse(
                                      //       //     vendorOrderListController
                                      //       //         .selectedDate1
                                      //       //         .value ==
                                      //       //         ""
                                      //       //         ? DateTime.now().toString()
                                      //       //         : vendorOrderListController
                                      //       //         .selectedDate1.value))),
                                      //     text: 'Date',
                                      // ),
                                    )),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: AddSize.size12,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.white10,
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(color: Colors.white)),
                            child: TextField(
                              // onTap: (){
                              //   vendorOrderListController.searchController.value=vendorOrderListController.model.value.data.orderList.length;
                              // },
                              maxLines: 1,
                              // controller:
                              // vendorOrderListController.searchController,
                              style: const TextStyle(
                                fontSize: 17,
                                color: Color(0xFF676363),
                              ),
                              textAlignVertical: TextAlignVertical.center,
                              textInputAction: TextInputAction.search,
                              onSubmitted: (value) {},
                              decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: const OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(4))),
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: AddSize.padding20,
                                      vertical: AddSize.padding10),
                                  hintText: 'Search'.tr,
                                  hintStyle: TextStyle(
                                      fontSize: AddSize.font14,
                                      color: const Color(0xFF676363),
                                      fontWeight: FontWeight.w400)),
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
                Container(
                  decoration: const BoxDecoration(
                      // color: AppTheme.backgroundcolor,
                      ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: AddSize.padding16, vertical: 25),
                    child: Column(children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Latest Sales".tr,
                            style: Theme.of(context)
                                .textTheme
                                .headline5!
                                .copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xFF454B5C),
                                    fontSize: AddSize.font16),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Order No.".tr,
                            style: Theme.of(context)
                                .textTheme
                                .headline5!
                                .copyWith(
                                    height: 1.5,
                                    fontWeight: FontWeight.w600,
                                    fontSize: AddSize.font12,
                                    color: const Color(0xFF04666E)),
                          ),
                          Text(
                            "                Status".tr,
                            style: Theme.of(context)
                                .textTheme
                                .headline5!
                                .copyWith(
                                    height: 1.5,
                                    fontWeight: FontWeight.w600,
                                    fontSize: AddSize.font12,
                                    color: const Color(0xFF04666E)),
                          ),
                          Text(
                            "Earning".tr,
                            style: Theme.of(context)
                                .textTheme
                                .headline5!
                                .copyWith(
                                    height: 1.5,
                                    fontWeight: FontWeight.w600,
                                    fontSize: AddSize.font12,
                                    color: const Color(0xFF04666E)),
                          )
                        ],
                      ),
                      const Divider(
                        thickness: 1,
                      ),
                      ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: 4,
                        padding: EdgeInsets.zero,
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            onTap: () {
                              // Get.toNamed(OrderDetailsScreen.orderDetailsScreen);
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // addHeight(5),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '#1234',
                                          // '# ${vendorOrderListController.model.value.data!.orderList![index].id.toString()}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline5!
                                              .copyWith(
                                                  height: 1.5,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: AddSize.font14,
                                                  color:
                                                      const Color(0xFF454B5C)),
                                        ),
                                        Text(
                                          '2 June, 2021 - 11:57PM',
                                          // vendorOrderListController
                                          //     .model
                                          //     .value
                                          //     .data!
                                          //     .orderList![index]
                                          //     .date
                                          //     .toString(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline5!
                                              .copyWith(
                                                  height: 1.5,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 11,
                                                  color:
                                                      const Color(0xFF8C9BB2)),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      'Processing',
                                      // vendorOrderListController
                                      //     .model
                                      //     .value
                                      //     .data!
                                      //     .orderList![index]
                                      //     .status
                                      //     .toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline5!
                                          .copyWith(
                                              height: 1.5,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 12,
                                              color: const Color(0xFFFFB26B)),
                                    ),
                                    Text(
                                      // "₹ ${vendorOrderListController.model.value.data!.orderList![index].amount.toString()}",
                                      '€45.00',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline5!
                                          .copyWith(
                                              height: 1.5,
                                              fontWeight: FontWeight.w500,
                                              fontSize: AddSize.font14,
                                              color: Colors.black),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: AddSize.size5,
                                ),
                                index != 3 ? Divider() : SizedBox()
                              ],
                            ),
                          );
                        },
                      )
                    ]),
                  ),
                ),
              ],
            )));
  }
}
