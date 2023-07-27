import 'package:cached_network_image/cached_network_image.dart';
import 'package:dirise/screens/categores/single_categorie.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../controller/home_controller.dart';
import '../../widgets/common_app_bar.dart';
import '../Authors/authors_screen.dart';
import '../Authors/teacher_screen.dart';
import '../e-book/ebookcategory_screen.dart';
import '../officefurniture_sceen/officefurniture_screen.dart';
import '../public_speaker_screen/single_public_speaker_screen.dart';
import '../schoolnursery_screen.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});
  static var categoriesScreen = "/categoriesScreen";

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  final homeController = Get.put(TrendingProductsController());
  List categories = [
    "Libraries",
    "Author",
    "Teacher",
    "Office Furniture",
    "Electronics",
    "Schools & Nurseries",
    "Club & Camps",
    "E-Book",
    "Public Speaker",
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: CommonAppBar(
          titleText: 'Categories',

        ),
      ),
      body: Obx(() {
        return homeController.categoryModal.value.status == true
            ? SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Padding(
                    padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 5,
                        ),
                        const ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            
                            child: Image(image: AssetImage('assets/images/storybooks.png'))),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          "What are you  looking for ... we back you !",
                          style: GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 18),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          child: GridView.builder(
                            shrinkWrap: true,
                            padding: const EdgeInsets.only(bottom: 25),
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: categories.length,
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2, crossAxisSpacing: 15, mainAxisSpacing: 10, mainAxisExtent: 80),
                            itemBuilder: (BuildContext context, int index) {
                              return InkWell(
                                onTap: () {
                                  if (index == 0) {
                                     Get.toNamed(SingleCategories.singleCategoriesScreen);
                                  } else if (index == 1) {
                                    Get.toNamed(AuthorsScreen.authorsScreen);
                                  } else if (index == 2) {
                                    Get.toNamed(TeacherScreen.teacherScreen);
                                  } else if (index == 3) {
                                    Get.toNamed(OfficeFurnitureScreen.route);
                                  } else if (index == 5) {
                                    Get.toNamed(SchoolNurseryScreen.route);
                                  } else if (index == 7) {
                                    Get.toNamed(EBookCategoryScreen.route);
                                  }
                                  else if (index == 8) {
                                    Get.toNamed(PublicSpeakerCategoryScreen.route);
                                  }
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: const Color(0xffEBF1F4).withOpacity(.5)),
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            CachedNetworkImage(
                                              imageUrl: homeController.categoryModal.value.data![index].categoryImage.toString(),

                                              height: 50,
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Expanded(
                                              child: Text(
                                                homeController.categoryModal.value.data![index].title.toString(),
                                                style: GoogleFonts.poppins(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                    color: const Color(0xff014E70)),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),

                        /* Text("Other",style: GoogleFonts.poppins(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 22),),
                  const SizedBox(height: 20,),
                  SizedBox(
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 4,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          mainAxisExtent: 80
                      ),
                      itemBuilder: (BuildContext context, int index){
                        return InkWell(onTap: (){
                          Get.toNamed(SingleCategories.singleCategoriesScreen);

                        },
                          child: Container(
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: const Color(0xffEBF1F4).withOpacity(.5)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(mainAxisAlignment:MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'assets/images/book.png',
                                      height: 50,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      'Libraries',
                                      style: GoogleFonts.poppins(
                                          fontSize: 14, fontWeight: FontWeight.w500,color: const Color(0xff014E70)),
                                    ),
                                  ],)

                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),*/
                        const SizedBox(height: 50,),
                      ],
                    )),
              )
            : const Center(
                child: CircularProgressIndicator(
                  color: Colors.grey,
                ),
              );
      }),
    );
  }
}
