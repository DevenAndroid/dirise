
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../widgets/common_colour.dart';
import 'general_library.dart';

class SingleCategories extends StatefulWidget {
  const SingleCategories({super.key});
  static var singleCategoriesScreen = "/SingleCategoriesScreen";

  @override
  State<SingleCategories> createState() => _SingleCategoriesState();
}

class _SingleCategoriesState extends State<SingleCategories> {
  @override
  Widget build(BuildContext context) {
    List data= ["General Bookstore","Commercial Bookstore","Speciality Bookstore","Dasman Complex"];
    RxBool? status=false.obs;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar:AppBar(backgroundColor: Colors.white,surfaceTintColor: Colors.white, elevation: 0,leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios, color: Color(0xff014E70),size: 20),
        onPressed: () => Navigator.of(context).pop(),
      ),title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Libraries",style: GoogleFonts.poppins(color: Colors.black,fontWeight: FontWeight.w600,fontSize: 22),),
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10,),
              const Image(image: AssetImage('assets/images/storybooks.png')),
              const SizedBox(height: 20,),
              InkWell(
                onTap: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return  Column(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 26,top: 15),
                              child: Text(
                                "Library Type",
                                style:
                                GoogleFonts.poppins(fontSize: 20,fontWeight: FontWeight.w600),
                              ),
                            ),
                            Obx(() {return
                        Column(
                        children: List.generate(
                        data.length,
                        (index) => Column(
                          mainAxisSize: MainAxisSize.min,
                        children: [
                        CheckboxListTile(
                        controlAffinity:
                        ListTileControlAffinity.leading,
                          activeColor: Color(0xff014E70),
                        value: status.value,
                        onChanged: ( value) {
                        setState(() {
                        status.value=value!;
                        });
                        },
                        title: Text(
                        data[index],
                        style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                        fontSize: 16,
                        ),
                        ),
                        ),
                        ],
                        )
                        ),
                        );}),

                            Align(alignment: Alignment.bottomCenter,
                              child: Column(
                                children: [
                                  Container(
                                    alignment: Alignment.center,
                                    height: 45,
                                    width:MediaQuery.of(context).size.width *.9,
                                    decoration: const BoxDecoration(
                                    color: Color(0xff014E70)
                                  ),
                                  child: Text(
                                    "Apply",
                                    style:
                                    GoogleFonts.poppins(fontSize: 18,fontWeight: FontWeight.w500,color: Colors.white),
                                  ),),
                                  SizedBox(height: 20,),
                                  Container(
                                    alignment: Alignment.center,
                                    height: 45,
                                    width:MediaQuery.of(context).size.width *.9,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey)
                                    ),
                                    child: Text(
                                      "Clear All",
                                      style:
                                      GoogleFonts.poppins(fontSize: 18,fontWeight: FontWeight.w500,color: Color(0xff014E70)),
                                    ),),
                                ],
                              ),
                            ),
                            SizedBox(height: 5,)

                          ],
                        );
                      });
                },
                child: Container(
                  height: 47,
                  padding: const EdgeInsets.fromLTRB(10,0,10,0),
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: const Color(0xff014E70)),
                      color: Color(0xffEBF1F4),
                      borderRadius: BorderRadius.circular(22)),
                  child: Row(mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8,right: 10),
                        child: Text(
                          "Library Type",
                          style:
                          GoogleFonts.poppins(fontSize: 14,fontWeight: FontWeight.w500,color: Color(0xff014E70)),
                        ),
                      ),
                      const Icon(Icons.keyboard_arrow_down_outlined)
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20,),
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: 3,
                  scrollDirection: Axis.vertical,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                        onTap: () {
                          Get.toNamed(GeneralLibrary.generalLibrary);
                        },
                        child: Container(
                          margin: EdgeInsets.only(bottom: 10,),
                          decoration: BoxDecoration(
                              border: Border.all(color: Color(0xffDCDCDC)),
                              borderRadius:
                              BorderRadius.circular(10)),
                          child:  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                            const Padding(
                              padding: EdgeInsets.fromLTRB(8,8,15,8),
                              child: Image(image: AssetImage('assets/images/singleCategories.png'),height: 85,),
                            ),
                            Expanded(
                              child: Column(crossAxisAlignment:CrossAxisAlignment.start,children: [
                                Text(("General Library"),style: GoogleFonts.poppins(color: Colors.black,fontSize: 18,fontWeight: FontWeight.w500),),
                                Text(("Books, Stationary and Electronics"),style: GoogleFonts.poppins(color: Colors.grey.withOpacity(.7),fontSize: 14,fontWeight: FontWeight.w500),),
                                Text(("1457 items"),style: GoogleFonts.poppins(color: const Color(0xff014E70),fontSize: 18,fontWeight: FontWeight.w500),)
                              ],),
                            )
                          ],)
                        ));
                  })

            ],
          )

      ),
    ),);
  }
}
