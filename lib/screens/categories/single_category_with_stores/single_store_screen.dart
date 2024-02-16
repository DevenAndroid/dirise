import 'dart:convert';
import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dirise/language/app_strings.dart';
import 'package:dirise/utils/helper.dart';
import 'package:dirise/utils/styles.dart';
import 'package:dirise/widgets/common_colour.dart';
import 'package:dirise/widgets/loading_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../model/model_category_stores.dart';
import '../../../model/model_store_products.dart';
import '../../../model/product_model/model_product_element.dart';
import '../../../model/social_links_model.dart';
import '../../../model/vendor_models/model_single_vendor.dart';
import '../../../repository/repository.dart';
import '../../../utils/api_constant.dart';
import '../../../widgets/cart_widget.dart';
import '../../app_bar/common_app_bar.dart';
import '../../check_out/add_bag_screen.dart';
import '../../product_details/product_widget.dart';

class SingleStoreScreen extends StatefulWidget {
  const SingleStoreScreen({super.key, required this.storeDetails,});
  final VendorStoreData storeDetails;

  @override
  State<SingleStoreScreen> createState() => _SingleStoreScreenState();
}

class _SingleStoreScreenState extends State<SingleStoreScreen> {
  final Repositories repositories = Repositories();
  int paginationPage = 1;
  VendorStoreData gg = VendorStoreData();
  SocialLinksModel ee = SocialLinksModel();
  ModelCategoryStores ss = ModelCategoryStores();
  SocialLinksModel get socialLinksData => ee;
  VendorStoreData get storeInfo => gg;
  ModelCategoryStores get allStoreInfo => ss;
  String get vendorId => widget.storeDetails.id.toString();
  String get vendorName => widget.storeDetails.storeName.toString();

 /* void onShare(code) async {
    final box = context.findRenderObject() as RenderBox?;
    await Share.share(code, subject: "link", sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size);
  }*/
  bool allLoaded = false;
  bool paginationLoading = false;

  ScrollController scrollController = ScrollController();

  ModelStoreProducts modelProductsList = ModelStoreProducts(data: null);

  Future getCategoryStores({required int page, String? search, bool? resetAll}) async {
    if (resetAll == true) {
      allLoaded = false;
      paginationLoading = false;
      paginationPage = 1;
      modelProductsList.data = null;
      page = 1;
    }
    if (allLoaded) return;
    if (paginationLoading) return;

    String url = "vendor_id=$vendorId";
    paginationLoading = true;

    await repositories.getApi(url: "${ApiUrls.vendorProductListUrl}$url").then((value) {
      paginationLoading = false;

      modelProductsList.data ??= [];
      final response = ModelStoreProducts.fromJson(jsonDecode(value));
      if (response.data != null && response.data!.isNotEmpty) {
        modelProductsList.data!.addAll(response.data!);
      } else {
        allLoaded = true;
      }
      setState(() {});
    });
  }
  _makingPhoneCall(call) async {
    var url = Uri.parse(call);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _instagramLink() async {
    var url = Uri.parse(socialLinksData.socialLinks!.instagram.toString());
    if (await canLaunchUrl(url)) {
      await launchUrl(url,mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }
  String productCount= '';
  String bannerString = '';
  String storeLogo = '';
  // String categoryName = Get.arguments;


  linkedinLink() async {
    var url = Uri.parse(allStoreInfo.socialLinks!.linkedin.toString());
    if (await canLaunchUrl(url)) {
      await launchUrl(url,mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }
  youTubeLink() async {
    var url = Uri.parse(allStoreInfo.socialLinks!.youtube.toString());
    if (await canLaunchUrl(url)) {
      await launchUrl(url,mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }
  facebookLink() async {
    var url = Uri.parse(allStoreInfo.socialLinks!.facebook.toString());
    if (await canLaunchUrl(url)) {
      await launchUrl(url,mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }
  getVendorInfo() {
    if (widget.storeDetails.storeName == null || true) {
      repositories.getApi(url: ApiUrls.getVendorInfoUrl + vendorId).then((value) {
        ModelSingleVendor response = ModelSingleVendor.fromJson(jsonDecode(value));
        productCount = response.productCount.toString();
        bannerString = response.user!.bannerProfileApp.toString();
        storeLogo = response.user!.storeLogoApp.toString();
        gg = VendorStoreData.fromJson(response.user!.toJson());
        ee = SocialLinksModel.fromJson(response.user!.toJson());
        ss = ModelCategoryStores.fromJson(response.user!.toJson());
        setState(() {});
      });
    }
  }
  @override
  void initState() {
    super.initState();
   // print('insta urll -------'+allStoreInfo.socialLinks!.instagram.toString());
    gg = widget.storeDetails;
    //ee = widget.socialLink;
    getVendorInfo();
    getCategoryStores(page: paginationPage);
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      scrollController.addListener(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: CommonAppBar(
          titleText: 'Authors',
          actions: [
            CartBagCard(isBlackTheme: true),
          ],
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await getCategoryStores(page: paginationPage, resetAll: true);
        },
        child: CustomScrollView(
          shrinkWrap: true,
          slivers: [
            if (gg.storeName != null && gg.email != null) ...[
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16).copyWith(top: 10),
                  child: Column(
                    children: [
                      SizedBox(
                          width: Get.width,
                          height: context.getSize.width * .5,
                          child: Hero(
                            tag: bannerString.toString(),
                            child: Material(
                              color: Colors.transparent,
                              surfaceTintColor: Colors.transparent,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: CachedNetworkImage(
                                  fit: BoxFit.cover,
                                  imageUrl: bannerString.toString(),
                                  errorWidget: (_, __, ___) => const Icon(Icons.error_outline),
                                ),
                              ),
                            ),
                          )),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16).copyWith(top: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 84,
                                width: 104,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: CachedNetworkImage(
                                    imageUrl: storeLogo.toString(),
                                    fit: BoxFit.cover,
                                    errorWidget: (_, __, ___) => const Icon(
                                      Icons.error_outline_outlined,
                                      color: Colors.red,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      storeInfo.storeName.toString().capitalize!,
                                      style: GoogleFonts.poppins(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 5, bottom: 5),
                                      child: Text(
                                        '${productCount.toString() ?? '0'} ${AppStrings.items.tr}'.toString(),
                                        maxLines: 1,
                                        style: GoogleFonts.poppins(
                                            color: const Color(0xFF014E70), fontSize: 14, fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      children: [
                                        GestureDetector(onTap: (){
                                         // onShare('instagram');
                                          //_instagramLink();
                                        },
                                          child: CircleAvatar(
                                              radius: 16,
                                              backgroundColor: const Color(0xFF014E70),
                                              child: SvgPicture.asset(
                                                'assets/svgs/insta_img.svg',
                                                width: 15,
                                                height: 15,
                                              )),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        GestureDetector(
                                          onTap: (){
                                           // onShare('linkedin');
                                            // linkedinLink();
                                          },
                                          child: CircleAvatar(
                                              radius: 16,
                                              backgroundColor: const Color(0xFF014E70),
                                              child: SvgPicture.asset(
                                                'assets/svgs/linkedin_img.svg',
                                                width: 15,
                                                height: 15,
                                              )),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        GestureDetector(
                                          onTap: (){
                                           // onShare('youtube');
                                            // youTubeLink();
                                          },
                                          child: CircleAvatar(
                                              radius: 16,
                                              backgroundColor: const Color(0xFF014E70),
                                              child: SvgPicture.asset(
                                                'assets/svgs/youtube_img.svg',
                                                width: 15,
                                                height: 15,
                                              )),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        GestureDetector(
                                          onTap: (){
                                          //  onShare('facebook');
                                            //facebookLink();
                                          },
                                          child: CircleAvatar(
                                              radius: 16,
                                              backgroundColor: const Color(0xFF014E70),
                                              child: SvgPicture.asset(
                                                'assets/svgs/facebook_img.svg',
                                                width: 15,
                                                height: 15,
                                              )),
                                        )
                                      ],
                                    )
                                    /* Text(
                                      storeInfo.description.toString(),
                                      style: GoogleFonts.poppins(
                                          color:  Colors.grey.shade800, fontSize: 14, fontWeight: FontWeight.w500),
                                    )*/
                                  ],
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 10,),
                          /*  if (storeInfo.description.toString().trim().isNotEmpty) ...[
                            const SizedBox(
                              height: 4,
                            ),
                            Text(
                              storeInfo.description.toString(),
                              style: normalStyle.copyWith(color: AppTheme.buttonColor),
                            )
                          ],*/
                          GestureDetector(
                            onTap: (){
                           //   if (allStoreInfo.socialLinks != null)
                              print('innsta url--------'+ socialLinksData.socialLinks!.instagram.toString(),);
                            },
                            child: Text(
                              'Brief'.tr,
                              style: GoogleFonts.poppins(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            storeInfo.description.toString(),
                            style: GoogleFonts.poppins(color: const Color(0xFF014E70), fontSize: 14, fontWeight: FontWeight.w500),
                          ),

                          if (storeInfo.email.toString().trim().isNotEmpty || storeInfo.storePhone.toString().trim().isNotEmpty) ...[
                            const SizedBox(
                              height: 12,
                            ),
                            Row(
                              children: [
                                if (storeInfo.email.toString().trim().isNotEmpty)
                                  Expanded(
                                    child: MaterialButton(
                                      onPressed: () async {
                                        await Clipboard.setData(ClipboardData(text: storeInfo.email.toString().trim()));
                                        final snackBar = SnackBar(
                                          content: Text(
                                            "Email copied".tr,
                                            style: normalStyle,
                                          ),
                                          action: SnackBarAction(
                                              label: "Send Mail".tr,
                                              onPressed: () {
                                                Helpers.launchEmail(email: storeInfo.email.toString().trim());
                                              }),
                                          backgroundColor: AppTheme.buttonColor,
                                        );
                                        if (!mounted) return;
                                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                      },
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                      child: Row(
                                        //  crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            "@",
                                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Expanded(
                                            child: Text(
                                              "${storeInfo.email}",
                                              style: normalStyle.copyWith(
                                                color: const Color(0xFF7D7D7D),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                if (storeInfo.storePhone.toString().trim().isNotEmpty)
                                  Expanded(
                                    child: MaterialButton(
                                      onPressed: () async {
                                        await Clipboard.setData(ClipboardData(text: storeInfo.storePhone.toString().trim()));
                                        final snackBar = SnackBar(
                                          content: Text(
                                            "Phone no. copied".tr,
                                            style: normalStyle,
                                          ),
                                          action: SnackBarAction(
                                              label: "Make Call".tr,
                                              onPressed: () {
                                                Helpers.makeCall(phoneNumber: storeInfo.storePhone.toString().trim());
                                              }),
                                          backgroundColor: AppTheme.buttonColor,
                                        );
                                        if (!mounted) return;
                                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                      },
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          SvgPicture.asset("assets/svgs/phone_call.svg"),
                                          Text(
                                            "+${storeInfo.storePhone}",
                                            style: normalStyle.copyWith(
                                              color: const Color(0xFF7D7D7D),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                            const SizedBox(height: 10,),
                            if (storeInfo.day != null || storeInfo.start  != null || storeInfo.end  != null)
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 17),
                              child: Row(
                                children: [
                                  GestureDetector(
                                    onTap: (){

                                    },
                                    child: SvgPicture.asset(
                                      'assets/svgs/watch_icon.svg',
                                      width: 20,
                                      height: 20,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(storeInfo.day.toString(),style: normalStyle.copyWith(
                                    color:  const Color(0xFF7D7D7D),
                                  ),),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  storeInfo.start != null ? Text('${storeInfo.start.toString()} - ${storeInfo.end.toString()}',style: normalStyle.copyWith(
                                    color:  const Color(0xFF7D7D7D),
                                  ),) : const SizedBox(),
                                ],
                              ),
                            )
                          ],
                        ],
                      ),
                    ),
                    const Divider(
                      thickness: 1,
                      color: Color(0xFFD9D9D9),
                    )
                  ],
                ),
              ),
            ],
            /*SliverAppBar(
              primary: false,
              pinned: true,
              backgroundColor: Colors.white,
              surfaceTintColor: Colors.white,
              leading: const SizedBox.shrink(),
              titleSpacing: 0,
              leadingWidth: 16,
              title: InkWell(
                onTap: () {},
                child: Container(
                  height: 36,
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xff014E70)),
                      color: const Color(0xffEBF1F4),
                      borderRadius: BorderRadius.circular(22)),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8, right: 10),
                        child: Text(
                          "${storeInfo.storeName.toString()} ${AppStrings.type}",
                          style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500, color: const Color(0xff014E70)),
                        ),
                      ),
                      const Icon(Icons.keyboard_arrow_down_outlined, color: Color(0xff014E70))
                    ],
                  ),
                ),
              ),
            ),*/
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 20,
              ),
            ),
            if (modelProductsList.data != null)
              modelProductsList.data!.isNotEmpty
                  ? SliverGrid.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 10, childAspectRatio: .74),
                      itemCount: modelProductsList.data!.length,
                      itemBuilder: (BuildContext context, int index) {
                        final item = modelProductsList.data![index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: ProductUI(
                            productElement: ProductElement.fromJson(item.toJson()),
                            onLiked: (value) {
                              // modelProductsList.data![index].inWishlist = value;
                            },
                          ),
                        );
                      },
                    )
                  : SliverToBoxAdapter(
                      child: Center(
                      child: Text(AppStrings.storeDontHaveAnyProduct),
                    ))
            else
              const SliverToBoxAdapter(child: LoadingAnimation()),
            // const SizedBox(
            //   height: 10,
            // ),
            // const Image(
            //   image: AssetImage('assets/images/collectionbooks.png'),
            // ),
          ],
        ),
      ),
    );
  }

  bottemSheet() {
    Size size = MediaQuery.of(context).size;
    return showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.white,
        builder: (context) {
          return SizedBox(
            width: size.width,
            height: size.height * .77,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 25.0),
                      child: Align(
                        alignment: Alignment.center,
                        child: Image.asset(
                          height: size.height * .2,
                          width: size.width * .7,
                          'assets/images/bag.png',
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Text(
                        AppStrings.fiftyOff.tr,
                        style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w500, color: const Color(0xffC22E2E)),
                      ),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Text(
                        'Ecstasy 165 days '.tr,
                        style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 16),
                      ),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Text(
                        '1 piece'.tr,
                        style: GoogleFonts.poppins(color: const Color(0xff858484), fontSize: 16),
                      ),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15, right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                'USD 6.350',
                                style: GoogleFonts.poppins(
                                    fontSize: 16, fontWeight: FontWeight.w500, color: const Color(0xff014E70)),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                'USD 12.700',
                                style: GoogleFonts.poppins(
                                    decoration: TextDecoration.lineThrough,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: const Color(0xff858484)),
                              ),
                            ],
                          ),
                          Text(
                            'Add to list'.tr,
                            style: GoogleFonts.poppins(
                              shadows: [const Shadow(color: Colors.black, offset: Offset(0, -4))],
                              color: Colors.transparent,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              decoration: TextDecoration.underline,
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Description'.tr,
                        style: GoogleFonts.poppins(
                          shadows: [const Shadow(color: Colors.black, offset: Offset(0, -4))],
                          color: Colors.transparent,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Text(
                        'to the rich father and the poor father; What the rich teach and the poor and middle class do not teach their children about to the Publisher s Synopsis: This book will shatter the myth that you need a big income to get rich... -Challenging'.tr,
                        style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w400, height: 1.7),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
                Card(
                  elevation: 10,
                  child: Container(
                    color: Colors.white,
                    width: size.width,
                    height: 60,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 18,
                                backgroundColor: const Color(0xffEAEAEA),
                                child: Center(
                                    child: Text(
                                  "━",
                                  style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black),
                                )),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                "1",
                                style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 20),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              CircleAvatar(
                                radius: 18,
                                backgroundColor: const Color(0xffEAEAEA),
                                child: Center(
                                    child: Text(
                                  "+",
                                  style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.black),
                                )),
                              ),
                            ],
                          ),
                          InkWell(
                            onTap: () {
                              Get.offNamed(BagsScreen.route);
                            },
                            child: Container(
                              decoration: BoxDecoration(color: const Color(0xff014E70), borderRadius: BorderRadius.circular(22)),
                              padding: const EdgeInsets.fromLTRB(20, 9, 20, 9),
                              child: Text(
                                "Add to Bag".tr,
                                style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
