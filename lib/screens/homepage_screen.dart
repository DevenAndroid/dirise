import 'package:cached_network_image/cached_network_image.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:dirise/routers/my_routers.dart';
import 'package:dirise/widgets/common_colour.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../controller/trending_products_controller.dart';
import '../model/trending_products_modal.dart';
import '../repoistery/trending_product_repo.dart';
import 'Authors/authors_screen.dart';
import 'Authors/teacher_screen.dart';
import 'categores/add_bag_screen.dart';
import 'categores/categories_screen.dart';
import 'categores/single_categorie.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
final trendingProdCont=Get.put(TrendingProductsController());

  List categories = [
    "Libraries",
    "Authors",
    "Teachers",
    "Offline Furniture",
    "Schools & Nurseries"
  ];
@override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(150),
          child: Container(
            color: const Color(0xffEBF1F4),
            margin: const EdgeInsets.only(top: 5),
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 18),
                            child: Text(
                              'Driver order to',
                              style: GoogleFonts.poppins(fontSize: 18),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(left: 8.0),
                            child: CountryCodePicker(
                              padding: EdgeInsets.zero,
                              onChanged: print,
                              initialSelection: 'IT',
                              hideMainText: true,
                              showDropDownButton: true,
                              showCountryOnly: false,
                              showOnlyCountryWhenClosed: false,
                            ),
                          ),
                        ],
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 20, top: 7),
                        child: Image(
                            height: 23,
                            image: AssetImage(
                              'assets/images/diriselogo.png',
                            )),
                      ),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(right: 15, top: 10),
                        child: Container(
                          alignment: Alignment.center,
                          height: 40,
                          width: 60,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image(
                                height: 25,
                                image: AssetImage(
                                  'assets/icons/whishlist.png',
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                '0',
                                style: TextStyle(
                                    color: AppTheme.buttonColor, fontSize: 23),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: TextField(
                      maxLines: 1,
                      style: const TextStyle(fontSize: 17),
                      textAlign: TextAlign.center,
                      textInputAction: TextInputAction.search,
                      decoration: InputDecoration(
                          filled: true,
                          // prefixIcon:
                          //     Icon(Icons.search, color: Color(0xFFC33D18)),
                          prefixIcon: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Image.asset(
                              'assets/icons/search.png',
                              height: 5,
                            ),
                          ),
                          border: InputBorder.none,
                          enabledBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                              borderSide:
                                  BorderSide(color: AppTheme.buttonColor)),
                          disabledBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                              borderSide:
                                  BorderSide(color: AppTheme.buttonColor)),
                          focusedBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                              borderSide:
                                  BorderSide(color: AppTheme.buttonColor)),
                          fillColor: Colors.white,
                          contentPadding: const EdgeInsets.only(left: 13),
                          hintText: 'what are you looking for?',
                          hintStyle:
                              GoogleFonts.poppins(color: AppTheme.buttonColor)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        body:Obx((){
          return trendingProdCont.trendingModel.value.status==true?
            SingleChildScrollView(
              child: Column(children: [
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Image.asset(
                    'assets/images/storybooks.png',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                  child: Row(
                    children: [
                      Container(
                        height: 60,
                        width: size.width * .40,
                        decoration: const BoxDecoration(
                            color: Color(0xffF0F0F0),
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                bottomLeft: Radius.circular(10))),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 8),
                          child: Row(
                            children: [
                              Text(
                                'News & Trends',
                                style: GoogleFonts.poppins(
                                  color: AppTheme.buttonColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              const Image(
                                  height: 20,
                                  image: AssetImage('assets/icons/trends.png'))
                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: 60,
                        width: 170,
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: const Color(0xffF0F0F0),
                            ),
                            borderRadius: const BorderRadius.only(
                                bottomRight: Radius.circular(10),
                                topRight: Radius.circular(10))),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 15, left: 7),
                          child: InkWell(
                            onTap: () {
                              showModalBottomSheet(
                                  isScrollControlled: true,
                                  context: context,
                                  builder: (context) {
                                    return SizedBox(
                                      height: size.height * .7,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 30, right: 18, left: 18),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Image.asset(
                                                'assets/images/aritificial.png'),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            Text(
                                              "Artificial Intelligence Gains a Foot Hold In Writing",
                                              style: GoogleFonts.poppins(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                  color: AppTheme.buttonColor),
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            Text(
                                              "Artificial Intelligence (Al) is gaining a strong foothold in various niches, and blogging is no exception. By making use of the best Al writing tools, you can create a long-form affiliate blog post in 10 to 15 minutes (instead of spending hours writing it yourself) and generate traffic.",
                                              style: GoogleFonts.poppins(
                                                  fontSize: 14,
                                                  color: const Color(0xff484848)),
                                            ),
                                            const SizedBox(
                                              height: 40,
                                            ),
                                            Text(
                                              'Published: 06/06/2023',
                                              style: GoogleFonts.poppins(
                                                  fontSize: 15,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w500),
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  });
                            },
                            child: Text(
                              "Artificial Intelligence Gains  a Foot Hold In Writing",
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w500, fontSize: 13),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: categories.length + 1,
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      mainAxisExtent: size.height * .17,
                      crossAxisSpacing: 15),
                  itemBuilder: (BuildContext context, int index) {
                    if (index == categories.length) {
                      return Column(
                        children: [
                          InkWell(onTap:(){
                            Get.toNamed(CategoriesScreen.categoriesScreen);


                          },
                            child: Container(
                                height: 60,
                                width: 90,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: const Color(0xffF0F0F0)),
                                child: Padding(
                                  padding: const EdgeInsets.all(14),
                                  child: Container(
                                    height: 30,
                                    width: 30,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                            color: AppTheme.buttonColor, width: 1.2)),
                                    child: const Icon(
                                      Icons.arrow_forward,
                                      color: AppTheme.buttonColor,
                                    ),
                                  ),
                                )),
                          ),
                          // ignore: prefer_const_constructors
                          SizedBox(height: 10,),
                          Text(
                            'More',
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500,
                                fontSize: 15,
                                color: AppTheme.buttonColor),
                          )
                        ],
                      );
                    }
                    else {
                      return InkWell(
                        onTap: () {
                          if (index == 3) {
                            Get.toNamed(MyRouters.officeFurnitureScreen);
                          } else if (index == 0) {
                            Get.toNamed(SingleCategories.singleCategoriesScreen);
                          } else if (index == 1) {
                            Get.toNamed(AuthorsScreen.authorsScreen);
                          } else if (index == 2) {
                            Get.toNamed(TeacherScreen.teacherScreen);
                          } else if (index == 4) {
                            Get.toNamed(MyRouters.scoopsNursery);
                          }
                        },
                        child: Column(
                          children: [
                            Container(
                              height: 60,
                              width: 90,
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: const Color(0xffF0F0F0)),
                              child: Center(
                                child: Image.asset(
                                  height: 40,
                                  'assets/images/book.png',
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              categories[index],
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15,
                                  color: AppTheme.buttonColor),
                              textAlign: TextAlign.center,
                            )
                          ],
                        ),
                      );
                    }
                  },
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Trending Products',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                      Container(
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border:
                            Border.all(color: AppTheme.buttonColor, width: 1.2)),
                        child: const Icon(
                          Icons.arrow_forward,
                          color: AppTheme.buttonColor,
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  height: 250,
                  margin: const EdgeInsets.fromLTRB(15,20,15,0),
                  child: ListView.builder(
                      itemCount: trendingProdCont.trendingModel.value.product!.product!.length,
                      scrollDirection: Axis.horizontal,itemBuilder: (BuildContext context,int index){
                    return InkWell(onTap: (){
                      bottomSheet( trendingProdCont.trendingModel.value.product!.product![index]);
                    },
                      child: Container(
                        width: size.width*.5,
                        margin: EdgeInsets.only(right: 20),
                        child:Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CachedNetworkImage(
                              imageUrl: trendingProdCont.trendingModel.value.product!.product![index].featuredImage.toString(),
                              height: 100,
                              fit: BoxFit.cover,
                              errorWidget: (context,
                                  url, error) =>
                                  Image.asset(
                                      "assets/images/bag.png"),),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              trendingProdCont.trendingModel.value.product!.product![index].discountPercentage.toString(),
                              style: GoogleFonts.poppins(
                                  fontSize: 16, fontWeight: FontWeight.w500,color: Color(0xffC22E2E)),
                            ),
                            const SizedBox(
                              height: 7,
                            ),
                            Text(
                              trendingProdCont.trendingModel.value.product!.product![index].pname.toString(),
                              style: GoogleFonts.poppins(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(
                              height: 7,
                            ),
                            Text(
                              '${trendingProdCont.trendingModel.value.product!.product![index].inStock.toString()} pieces',
                              style: GoogleFonts.poppins(
                                  color: const Color(0xff858484), fontSize: 17),
                            ),
                            const SizedBox(
                              height: 7,
                            ),
                            Row(
                              children: [
                                Text(
                                  'KD ${trendingProdCont.trendingModel.value.product!.product![index].sPrice.toString()}',
                                  style: GoogleFonts.poppins(
                                      fontSize: 16, fontWeight: FontWeight.w500),
                                ),
                                const SizedBox(width: 15,),
                                Text(
                                  'KD ${trendingProdCont.trendingModel.value.product!.product![index].pPrice.toString()}',
                                  style: GoogleFonts.poppins(decoration: TextDecoration.lineThrough,color: const Color(0xff858484),
                                      fontSize: 16, fontWeight: FontWeight.w500),
                                ),
                              ],
                            )
                          ],
                        ) ,),
                    );
                  }),
                ),
                /*Container(
            margin: const EdgeInsets.all(20),
            height: size.height * .36,
            child: GridView.builder(
              itemCount: 5,
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                  mainAxisSpacing: 0,
                  ),
              itemBuilder: (BuildContext context, int index) {
                return Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        height: size.height * .2,
                        'assets/images/bag.png',
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Atrium Classic Backpack Accessory',
                        style: GoogleFonts.poppins(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        '1 piece',
                        style: GoogleFonts.poppins(
                            color: const Color(0xff858484), fontSize: 17),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        'KD 12.700',
                        style: GoogleFonts.poppins(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                );
              },
            ),
          ),*/
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Popular Products',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                      Container(
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border:
                            Border.all(color: AppTheme.buttonColor, width: 1.2)),
                        child: const Icon(
                          Icons.arrow_forward,
                          color: AppTheme.buttonColor,
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  height: size.height * .34,
                  child: GridView.builder(
                    itemCount: 2,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 100,
                        childAspectRatio: 0.1),
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset(
                            height: size.height * .2,
                            'assets/images/notebook.png',
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Atrium Classic Backpack Accessory',
                            style: GoogleFonts.poppins(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            '1 piece',
                            style: GoogleFonts.poppins(
                                color: const Color(0xff858484), fontSize: 17),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            'KD 12.700',
                            style: GoogleFonts.poppins(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          )
                        ],
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child:
                  Image(image: AssetImage('assets/images/collectionbooks.png')),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Shop By Author',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                      Container(
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border:
                            Border.all(color: AppTheme.buttonColor, width: 1.2)),
                        child: const Icon(
                          Icons.arrow_forward,
                          color: AppTheme.buttonColor,
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  height: 300,
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  child: GridView.builder(
                    itemCount: 2,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 200,
                        childAspectRatio: 0.1),
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset(
                            height: size.height * .19,
                            'assets/images/Soud Alsanousi.png',
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Soud Alsanousi',
                            style: GoogleFonts.poppins(
                                fontSize: 18, fontWeight: FontWeight.w600),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ])):const Center(child: CircularProgressIndicator());
        })
        );
  }
Future bottomSheet(ProductElement e){
  Size size = MediaQuery.of(context).size;
  return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      builder: (context) {
        return  SingleChildScrollView(
          child: SizedBox(
            width: size.width,
            height: size.height*.76,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(crossAxisAlignment:CrossAxisAlignment.start,
                    children: [
                      Align(alignment: Alignment.center,
                        child: CachedNetworkImage(
                          imageUrl: e.featuredImage.toString(),
                          height: 100,
                          fit: BoxFit.cover,
                          errorWidget: (context,
                              url, error) =>
                              Image.asset(
                                  "assets/images/bag.png"),),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Text(
                        e.discountPercentage.toString(),
                        style: GoogleFonts.poppins(

                            fontSize: 14, fontWeight: FontWeight.w500,color: const Color(0xffC22E2E)),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        e.pname.toString(),
                        style: GoogleFonts.poppins(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        '${e.inStock.toString()} pieces',
                        style: GoogleFonts.poppins(
                            color: const Color(0xff858484), fontSize: 17),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(mainAxisAlignment:MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                'KD ${e.sPrice.toString()}',
                                style: GoogleFonts.poppins(
                                    fontSize: 16, fontWeight: FontWeight.w500),
                              ),
                              const SizedBox(width: 15,),
                              Text(
                                'KD ${e.pPrice.toString()}',
                                style: GoogleFonts.poppins(decoration: TextDecoration.lineThrough,color: const Color(0xff858484),
                                    fontSize: 16, fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          Text(
                            'Add to list',
                            style: GoogleFonts.poppins(
                              shadows: [
                                const Shadow(
                                    color: Colors.black,
                                    offset: Offset(0, -4))
                              ],
                              color: Colors.transparent,
                              fontSize: 16, fontWeight: FontWeight.w500,decoration: TextDecoration.underline,),
                          )
                        ],
                      ),
                      const SizedBox(height: 20,),
                      Align(alignment: Alignment.center,
                        child: Text(
                          'Description',
                          style: GoogleFonts.poppins(
                            shadows: [
                              const Shadow(
                                  color: Colors.black,
                                  offset: Offset(0, -4))
                            ],
                            color: Colors.transparent,
                            fontSize: 18, fontWeight: FontWeight.w500,decoration: TextDecoration.underline,),
                        ),
                      ),
                      const SizedBox(height: 15,),
                      Text(Bidi.stripHtmlIfNeeded(e.longDescription.toString()),
                        style: GoogleFonts.poppins(
                          fontSize: 14, fontWeight: FontWeight.w400,),
                      ),
                      const SizedBox(height: 20,),
                    ],),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Row(children: [
                        CircleAvatar(radius: 18,backgroundColor:Color(0xffEAEAEA),
                          child:Center(child: Text("━",style: TextStyle(fontSize:16,fontWeight: FontWeight.w500,color: Colors.black),)) ,),
                        SizedBox(width: 10,),
                        Text("1",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 20),),
                        SizedBox(width: 10,),
                        CircleAvatar(radius: 18,backgroundColor:Color(0xffEAEAEA),
                          child:Center(child: Text("+",style: TextStyle(fontSize:20,fontWeight: FontWeight.w600,color: Colors.black),)) ,),

                      ],),
                      InkWell(onTap: (){
                        Get.offNamed(AddBagScreen.addBagScreen);
                      },

                        child: Container(decoration: BoxDecoration(color: const Color(0xff014E70),borderRadius: BorderRadius.circular(22)),
                          padding: const EdgeInsets.fromLTRB(20,9,20,9),

                          child: Text("Add to Bag",style: GoogleFonts.poppins(fontSize: 16,fontWeight: FontWeight.w500,color: Colors.white),),),
                      )
                    ],),
                ],
              ),
            ),
          ),
        );
      });
}
}
