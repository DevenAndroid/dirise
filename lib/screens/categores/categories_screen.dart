
import 'package:dirise/screens/categores/single_categorie.dart';
import 'package:dirise/widgets/common_colour.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});
  static var categoriesScreen = "/categoriesScreen";

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar:AppBar(
        elevation: 0,
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
        leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios, color: Color(0xff014E70),size: 20),
        onPressed: () => Navigator.of(context).pop(),

      ),
       title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Categories",style: GoogleFonts.poppins(color: Colors.black,fontWeight: FontWeight.w600,fontSize: 22),),
          Container(
            alignment: Alignment.center,
            height: 40,
            width: 60,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Color(0xff014E70)
            ),
            child: const Row(mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.shopping_bag_outlined,color: Colors.white,),
                SizedBox(width: 3,),
                Text(("0"),style: TextStyle(color: Colors.white,fontSize: 22),)
              ],),
          ),
        ],
      ),),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Padding(
            padding: const EdgeInsets.all(15.0),
            child:  Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 10,),
            const Image(image: AssetImage('assets/images/storybooks.png')),
                const SizedBox(height: 20,),
                Text("What are you  looking for ... we back you !",style: GoogleFonts.poppins(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 18),),
                const SizedBox(height: 20,),
          SizedBox(
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 5,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                mainAxisExtent: 90
              ),
              itemBuilder: (BuildContext context, int index){
                return InkWell(onTap: (){
                  Get.toNamed(SingleCategories.singleCategoriesScreen);
                },
                  child: Container(
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Color(0xffF0F0F0)),
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
                            width:10,
                          ),
                          Text(
                            'Libraries',
                            style: GoogleFonts.poppins(
                                fontSize: 14, fontWeight: FontWeight.w500),
                          ),
                        ],)

                      ],
                    ),
                  ),
                );
              },
            ),
          ),

                Align(alignment: Alignment.topLeft,
                    child: Text("Other",style: GoogleFonts.poppins(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 22),)),
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
                        mainAxisExtent: 90
                    ),
                    itemBuilder: (BuildContext context, int index){
                      return InkWell(onTap: (){
                        Get.toNamed(SingleCategories.singleCategoriesScreen);
                      },
                        child: Container(
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Color(0xffF0F0F0)),
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
                                        fontSize: 14, fontWeight: FontWeight.w500),
                                  ),
                                ],)

                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),






              ],
            )

        ),
      ),
    );
  }
}
