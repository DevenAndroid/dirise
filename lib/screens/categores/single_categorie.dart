
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';


import '../../widgets/common_app_bar.dart';
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
    List<CheckBoxListTileModel> data1 =
    CheckBoxListTileModel.getList();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar:const PreferredSize(
        preferredSize: Size.fromHeight(60),
        child:CommonAppBar(titleText: 'Libraries',) ,
      ),
      body: SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: Padding(
          padding: const EdgeInsets.fromLTRB(15,1,15,15),
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
                            Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 27,top: 15,bottom: 10),
                                child: Text(
                                  "Library Type",
                                  style:
                                  GoogleFonts.poppins(fontSize: 20,fontWeight: FontWeight.w600),
                                ),
                              ),
                              Obx(() {return
                                Column(
                                  children: List.generate(
                                      data1.length,
                                          (index) => Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Theme(
                                            data: ThemeData(unselectedWidgetColor: const Color(0xff014E70)),
                                            child: CheckboxListTile(
                                              controlAffinity:
                                              ListTileControlAffinity.leading,
                                              dense: true,
                                              visualDensity:VisualDensity.compact,
                                              activeColor: const Color(0xff014E70),

                                              value: data1[index].isCheck!.value,
                                              onChanged: ( value) {
                                                setState(() {
                                                  data1[index].isCheck!.value=value!;
                                                });
                                              },
                                              title: Row(
                                                children: [
                                                  Text(
                                                    data1[index].title.toString(),
                                                    style: GoogleFonts.poppins(
                                                      fontWeight: FontWeight.w500,
                                                      color: Colors.black,
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                  const SizedBox(width: 10,),
                                                  Text(
                                                    data1[index].number.toString(),
                                                    style: GoogleFonts.poppins(
                                                      fontWeight: FontWeight.w500,
                                                      color: const Color(0xffADADAD),
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                  ),
                                );}),
                            ],),
                            Align(alignment: Alignment.bottomCenter,

                              child: Column(
                                children: [
                                  Container(
                                    alignment: Alignment.center,
                                    height: 47,
                                    width:MediaQuery.of(context).size.width *.87,
                                    decoration: const BoxDecoration(
                                    color: Color(0xff014E70)
                                  ),
                                  child: Text(
                                    "Apply",
                                    style:
                                    GoogleFonts.poppins(fontSize: 18,fontWeight: FontWeight.w500,color: Colors.white),
                                  ),),
                                  const SizedBox(height: 20,),
                                  Container(
                                    alignment: Alignment.center,
                                    margin: const EdgeInsets.only(bottom: 10),
                                    height: 47,
                                    width:MediaQuery.of(context).size.width *.87,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: const Color(0xff014E70))
                                    ),
                                    child: Text(
                                      "Clear All",
                                      style:
                                      GoogleFonts.poppins(fontSize: 18,fontWeight: FontWeight.w500,color: const Color(0xff014E70)),
                                    ),),
                                ],
                              ),
                            ),
                          ],
                        );
                      });
                },
                child: Container(
                  height: 36,
                  padding: const EdgeInsets.fromLTRB(10,0,10,0),
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: const Color(0xff014E70)),
                      color: const Color(0xffEBF1F4),
                      borderRadius: BorderRadius.circular(22)),
                  child: Row(mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8,right: 10),
                        child: Text(
                          "Library Type",
                          style:
                          GoogleFonts.poppins(fontSize: 14,fontWeight: FontWeight.w500,color: const Color(0xff014E70)),
                        ),
                      ),
                      const Icon(Icons.keyboard_arrow_down_outlined,color:Color(0xff014E70))
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
                          margin: const EdgeInsets.only(bottom: 10,),
                          decoration: BoxDecoration(
                              border: Border.all(color: const Color(0xffDCDCDC)),
                              borderRadius:
                              BorderRadius.circular(10)),
                          child:  Padding(
                            padding: const EdgeInsets.fromLTRB(8,10,15,8),
                            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                              const Image(image: AssetImage('assets/images/singleCategories.png'),height: 85,),
                              const SizedBox(width: 4,),
                              Expanded(
                                child: Column(crossAxisAlignment:CrossAxisAlignment.start,mainAxisAlignment:MainAxisAlignment.start,children: [
                                  Text(("General Library"),style: GoogleFonts.poppins(color: Colors.black,fontSize: 18,fontWeight: FontWeight.w500),),
                                  Padding(
                                    padding: const EdgeInsets.only(top:5,bottom: 5),
                                    child: Text(("Books, Stationary and Electronics"),style: GoogleFonts.poppins(color: Colors.grey.withOpacity(.7),fontSize: 12,fontWeight: FontWeight.w500),),
                                  ),
                                  Text(("1457 items"),style: GoogleFonts.poppins(color: const Color(0xff014E70),fontSize: 18,fontWeight: FontWeight.w500),)
                                ],),
                              )
                            ],),
                          )
                        ));
                  })

            ],
          )

      ),
    ),);
  }
}



class CheckBoxListTileModel {
  String title;
  dynamic number;
  RxBool? isCheck;

  CheckBoxListTileModel({
    required this.title,
    required this.number,
    required this.isCheck,
  });
  static List<CheckBoxListTileModel> getList() {
    return <CheckBoxListTileModel>[
      CheckBoxListTileModel(
        title: "General Bookstore",
        number: "1",
        isCheck: true.obs,
      ),
      CheckBoxListTileModel(
        title: "Commercial Bookstore",
        number: "4",
        isCheck: false.obs,
      ),
      CheckBoxListTileModel(
        title: "Speciality Bookstore",
        number: "6",
        isCheck: false.obs,
      ),
      CheckBoxListTileModel(
        title: "Dasman Complex",
        number: "3",
        isCheck: false.obs,
      ),
    ];
  }
}