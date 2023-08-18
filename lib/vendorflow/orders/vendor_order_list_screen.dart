import 'dart:convert';
import 'package:dirise/repository/repository.dart';
import 'package:dirise/utils/ApiConstant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../model/vendor_models/model_vendor_orders.dart';
import '../../widgets/common_colour.dart';
import '../../widgets/dimension_screen.dart';
import '../add_money_screen.dart';
import '../dashboard/sliver_bar.dart';
import 'order_tile.dart';

class VendorOrderList extends StatefulWidget {
  const VendorOrderList({Key? key}) : super(key: key);
  static var route = "/vendorOrderList";

  @override
  State<VendorOrderList> createState() => _VendorOrderListState();
}

class _VendorOrderListState extends State<VendorOrderList> {

  final Repositories repositories = Repositories();
  ModelVendorOrders modelVendorOrders = ModelVendorOrders();

  getOrdersList() {
    String url = "vendor-order?page=1";
    repositories.getApi(url: ApiUrls.baseUrl + url).then((value) {
      modelVendorOrders = ModelVendorOrders.fromJson(jsonDecode(value));
      setState(() {});
    });
  }

  final TextEditingController searchController = TextEditingController();
  RxBool isValue = false.obs;

  @override
  void initState() {
    super.initState();
    getOrdersList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: [
                Color(0xff014E70),
                Colors.white,
                Colors.white,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              tileMode: TileMode.clamp,
              stops: [.06, .061, 1])),
      child: Scaffold(
        backgroundColor: Colors.transparent,
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
                    padding: EdgeInsets.symmetric(
                        vertical: AddSize.padding10),
                    child: Column(
                      children: [
                        Row(
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            IconButton(
                              onPressed: () {
                                Get.back();
                              },
                              icon: Icon(
                                Icons.adaptive.arrow_back,
                                color: Colors.white,
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
                          height: 10,
                        ),
                        Container(
                            decoration: BoxDecoration(
                                color: Colors.white.withOpacity(.1),
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(color: Colors.white24),
                            ),
                            margin: const EdgeInsets.symmetric(horizontal: 16),
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
                                            .headlineSmall!
                                            .copyWith(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 28,
                                                color: Colors.white),
                                      ),
                                      SizedBox(
                                        height: AddSize.size5,
                                      ),
                                      Text(
                                        "Your earning this month".tr,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineSmall!
                                            .copyWith(
                                                fontWeight: FontWeight.w400,
                                                fontSize: AddSize.font14,
                                                color: Colors.white),
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
                                            horizontal: AddSize.padding20,
                                            vertical: AddSize.padding12),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Text(
                                          "Withdrawal".tr,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headlineSmall!
                                              .copyWith(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: AddSize.font16,
                                                  color:
                                                      AppTheme.buttonColor),
                                        )),
                                  )
                                ],
                              ),
                            )),
                        const SizedBox(
                          height: 16,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
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
                                fillColor: Colors.white.withOpacity(.1),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white.withOpacity(.2)),
                                    borderRadius:
                                        const BorderRadius.all(Radius.circular(6))),
                                enabled: true,
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white.withOpacity(.2)),
                                    borderRadius:
                                    const BorderRadius.all(Radius.circular(6))),
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: AddSize.padding20,
                                    vertical: AddSize.padding10),
                                hintText: 'Search'.tr,
                                hintStyle: GoogleFonts.poppins(
                                    fontSize: AddSize.font16,
                                    color: Colors.white,
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
              const LatestSalesAppBar(),
              if (modelVendorOrders.order != null)
                SliverList.builder(
                    itemCount: modelVendorOrders.order!.data!.length,
                    itemBuilder: (context, index) {
                      final order = modelVendorOrders.order!.data![index];
                      return OrderTile(
                        order: order,
                      );
                    }),
            ],
          ),
        ),
      ),
    );
  }
}
