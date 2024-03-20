import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dirise/language/app_strings.dart';
import 'package:dirise/screens/product_details/product_widget.dart';
import 'package:dirise/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../controller/home_controller.dart';
import '../../model/get_star_vendor_Model.dart';
import '../../model/model_category_stores.dart';
import '../../repository/repository.dart';
import '../../utils/api_constant.dart';
import '../../widgets/common_colour.dart';
import '../categories/single_category_with_stores/single_store_screen.dart';

class StarOfMonthScreen extends StatefulWidget {
  const StarOfMonthScreen({super.key});

  @override
  State<StarOfMonthScreen> createState() => _StarOfMonthScreenState();
}

class _StarOfMonthScreenState extends State<StarOfMonthScreen> {

  Rx<GetStarVendorModel> getStarVendorModel = GetStarVendorModel().obs;

  Future getNewsTrendData() async {
    repositories.getApi(url: ApiUrls.starVendorUrl).then((value) {
      getStarVendorModel.value = GetStarVendorModel.fromJson(jsonDecode(value));
      print(getStarVendorModel.value.toString());
    });
  }

  final Repositories repositories = Repositories();

  @override
  void initState() {
    super.initState();
    getNewsTrendData();
  }
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return getStarVendorModel.value.data != null
          ? Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20).copyWith(bottom: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                getStarVendorModel.value.data!.isNotEmpty ?
                Text(
                  'Stars Of The Month'.tr,
                  style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w500),
                ) : const SizedBox.shrink(),
                10.spaceX,
                SvgPicture.asset('assets/svgs/star_xmas.svg',height: 25,)
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            height: 230,
            margin: const EdgeInsets.symmetric(horizontal: 15),
            child: ListView.builder(
              itemCount: getStarVendorModel.value.data!.length,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: (){
                    Get.to(()=> SingleStoreScreen(
                      storeDetails: VendorStoreData(id: getStarVendorModel.value.data![index].ofTheMonth!.id.toString()),
                    ));
                  },
                  child: Container(
                      width: context.getSize.width * .5,
                      margin: const EdgeInsets.only(right: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if(getStarVendorModel.value.data![index].ofTheMonth!= null)
                            Flexible(
                              child: CachedNetworkImage(
                                  imageUrl: getStarVendorModel.value.data![index].ofTheMonth!.profileImage.toString(),
                                  fit: BoxFit.cover,
                                  errorWidget: (_, __, ___) =>
                                      Image.asset(
                                          'assets/images/new_logo.png'
                                      )
                              ),
                            ),
                          if(getStarVendorModel.value.data![index].ofTheMonth!= null)
                          const SizedBox(
                            height: 10,
                          ),
                          if(getStarVendorModel.value.data![index].ofTheMonth!= null)
                          Text(
                            getStarVendorModel.value.data![index].name.toString(),
                            style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600),
                          ),
                        ],
                      )),
                );
              },
            ),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      )
          : const SizedBox.shrink();
    });
  }

}
