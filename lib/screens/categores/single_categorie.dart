
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../widgets/common_colour.dart';

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
    bool? status=false;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
      physics: AlwaysScrollableScrollPhysics(),
      child: Padding(
          padding: const EdgeInsets.all(15.0),
          child:  Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 35,),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(children: [
                    InkWell(onTap: (){
                      Get.back();
                    },child: Icon(Icons.arrow_back_ios)),
                    const SizedBox(width: 20,),
                    Text("Categories",style: GoogleFonts.poppins(color: Colors.black,fontWeight: FontWeight.w600,fontSize: 22),),
                  ],),
                  Container(
                    alignment: Alignment.center,
                    height: 40,
                    width: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color(0xff014E70)
                    ),
                    child: const Row(mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.shopping_bag_outlined,color: Colors.white,),
                        Text(("0"),style: TextStyle(color: Colors.white,fontSize: 20),)
                      ],),
                  ),
                ],),
              const SizedBox(height: 20,),
              const Image(image: AssetImage('assets/images/storybooks.png')),
              const SizedBox(height: 20,),
              InkWell(
                onTap: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return  Column(
                          mainAxisAlignment:
                          MainAxisAlignment.start,
                          children: [
                            Text(
                              "Library Type",
                              style:
                              GoogleFonts.poppins(fontSize: 14),
                            ),
                            Column(
                              children: List.generate(
                                  data.length,
                                      (index) => Column(
                                    children: [
                                      CheckboxListTile(
                                        controlAffinity:
                                        ListTileControlAffinity.leading,
                                        dense: false,
                                        value: status,
                                        onChanged: (bool? value) {
                                          setState(() {
                                           status=value;
                                          });
                                        },
                                        activeColor: AppTheme.primaryColor,
                                        title: Text(
                                          data[index],
                                          style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14,
                                              color: const Color(0xff545454)
                                                  .withOpacity(.7)),
                                        ),
                                      ),
                                      const Padding(
                                        padding:
                                        EdgeInsets.fromLTRB(20, 0, 20, 0),
                                        child: Divider(
                                          thickness: .4,
                                        ),
                                      )
                                    ],
                                  )
                              ),
                            ),
                          ],
                        );
                      });
                },
                child: IgnorePointer(
                    ignoring: true,
                    child: Container(
                      height: 47,
                      width: MediaQuery.of(context).size.width * .4,
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: const Color(0xffD9D9D9)),
                          color: Color(0xffEBF1F4),
                          borderRadius: BorderRadius.circular(12)),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 8,right: 10),
                            child: Text(
                              "Library Type",
                              style:
                              GoogleFonts.poppins(fontSize: 14),
                            ),
                          ),
                          const Icon(Icons.keyboard_arrow_down_outlined)
                        ],
                      ),
                    )),
              ),

              ListView.builder(
                  shrinkWrap: true,
                  itemCount: 3,
                  scrollDirection: Axis.vertical,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                        onTap: () {
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
                                Text(("General Library"),style: GoogleFonts.poppins(color: Colors.black,fontSize: 20),),
                                Text(("Books, Stationary and Electronics"),style: GoogleFonts.poppins(color: Colors.grey,fontSize: 16),),
                                Text(("1457 items"),style: GoogleFonts.poppins(color: Color(0xff014E70),fontSize: 20),)
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
