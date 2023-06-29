
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'add_bag_screen.dart';

class GeneralLibrary extends StatefulWidget {
  const GeneralLibrary({super.key});
  static var generalLibrary = "/generalLibrary";

  @override
  State<GeneralLibrary> createState() => _GeneralLibraryState();
}

class _GeneralLibraryState extends State<GeneralLibrary> {
  List data= ["General Bookstore","Commercial Bookstore","Speciality Bookstore","Dasman Complex"];
  RxBool status= false.obs;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar:AppBar(backgroundColor: Colors.white,surfaceTintColor: Colors.white, elevation: 0,leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios, color: Color(0xff014E70),size: 20),
        onPressed: () => Navigator.of(context).pop(),
      ),title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("General Libraries",style: GoogleFonts.poppins(color: Colors.black,fontWeight: FontWeight.w600,fontSize: 22),),
          Container(
            alignment: Alignment.center,
            height: 40,
            width: 60,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: const Color(0xff014E70)
            ),
            child:  Row(mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset("assets/images/bag1.svg"),
                const SizedBox(width: 4,),
                const Text(("0"),style: TextStyle(color: Colors.white,fontSize: 22),)
              ],),
          ),
        ],
      ),),
      backgroundColor: Colors.white,
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
                Row(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Image(image: AssetImage('assets/images/singleCategories.png'),height: 85,),
                    const SizedBox(width: 10,),
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
                              Column(crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 27,top: 15),
                                  child: Text(
                                    "Library Type",
                                    style:
                                    GoogleFonts.poppins(fontSize: 20,fontWeight: FontWeight.w600),
                                  ),
                                ),
                                const SizedBox(height: 10,),
                                Obx(() {return
                                  Column(
                                    children: List.generate(
                                        data.length,
                                            (index) => Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Theme(data: ThemeData(unselectedWidgetColor: const Color(0xff014E70)),
                                              child: CheckboxListTile(
                                                controlAffinity:
                                                ListTileControlAffinity.leading,
                                                dense: true,
                                                visualDensity: VisualDensity.compact,
                                                activeColor: const Color(0xff014E70),
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
                                      height: 47,
                                      margin: EdgeInsets.only(bottom: 10),
                                      width:MediaQuery.of(context).size.width *.87,
                                      decoration: BoxDecoration(
                                          border: Border.all(color: Color(0xff014E70))
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
                        const Icon(Icons.keyboard_arrow_down_outlined)
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20,),
                SizedBox(
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 5,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 20,
                        mainAxisExtent: 250
                    ),
                    itemBuilder: (BuildContext context, int index){
                      return InkWell(onTap: (){

                        bottemSheet();
                      },
                        child: Container(
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),),
                          margin: const EdgeInsets.only(left: 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.asset(
                                height: size.height * .2,
                                'assets/images/bag.png',
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                '50% off',
                                style: GoogleFonts.poppins(
                                    fontSize: 14, fontWeight: FontWeight.w500,color: Color(0xffC22E2E)),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                'Ecstasy 165 days ',
                                style:
                                GoogleFonts.poppins(fontWeight: FontWeight.w500,fontSize: 16),
                              ),
                              const SizedBox(
                                height: 5,
                              ),

                              Text(
                                '1 piece',
                                style:
                                GoogleFonts.poppins(color: const Color(0xff858484),fontSize: 16),
                              ),
                              const SizedBox(
                                height: 5,
                              ),

                              Text(
                                'KD 12.700',
                                style: GoogleFonts.poppins(
                                    fontSize: 16, fontWeight: FontWeight.w500),
                              )
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
      ),);
  }
  Future bottemSheet(){
    Size size = MediaQuery.of(context).size;
    return showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.white,
        builder: (context) {
          return  Padding(
            padding: const EdgeInsets.all(15),
            child: SizedBox(
              width: size.width,
              height: size.height*.7,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(crossAxisAlignment:CrossAxisAlignment.start,
                    children: [
                      Align(alignment: Alignment.center,
                        child: Image.asset(
                          height: size.height * .2,
                          width:size.width*.7,
                          'assets/images/bag.png',

                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        '50% off',
                        style: GoogleFonts.poppins(

                            fontSize: 14, fontWeight: FontWeight.w500,color: Color(0xffC22E2E)),
                      ),
                      const SizedBox(
                        height: 5,

                      ),
                      Text(
                        'Ecstasy 165 days ',
                        style:
                        GoogleFonts.poppins(fontWeight: FontWeight.w500,fontSize: 16),
                      ),
                      const SizedBox(
                        height: 5,
                      ),

                      Text(
                        '1 piece',
                        style:
                        GoogleFonts.poppins(color: const Color(0xff858484),fontSize: 16),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(mainAxisAlignment:MainAxisAlignment.spaceBetween,children: [
                        Row(children: [
                          Text(
                            'KD 12.700',
                            style: GoogleFonts.poppins(
                                fontSize: 16, fontWeight: FontWeight.w500,color: Color(0xff014E70)),
                          ),
                          const SizedBox(width: 15,),
                          Text(
                            'KD 12.700',
                            style: GoogleFonts.poppins(decoration: TextDecoration.lineThrough,
                                fontSize: 16, fontWeight: FontWeight.w500,color: Color(0xff858484)),
                          ),
                        ],),

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
                      ],),
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
                      Text(
                        'to the rich father and the poor father; What the rich teach and the poor and middle class do not teach their children about to the Publisher s Synopsis: This book will shatter the myth that you need a big income to get rich... -Challenging',
                        style: GoogleFonts.poppins(
                          fontSize: 14, fontWeight: FontWeight.w400,),
                      ),
                      const SizedBox(height: 20,),
                    ],),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(children: [
                        Container(height: 25,width:25,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(100),border: Border.all(color: Colors.black),color: Color(0xffEAEAEA)),
                          child: const Center(child: Text("━",style: TextStyle(fontSize:15,fontWeight: FontWeight.w400),)),),
                        const SizedBox(width: 10,),
                        const Text("1",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 20),),
                        const SizedBox(width: 10,),
                        Container(height: 25,width: 25,decoration: BoxDecoration(borderRadius: BorderRadius.circular(100),border: Border.all(color: Colors.black),color: Color(0xffEAEAEA)),
                          child: const Center(child: Text("＋",style: TextStyle(fontSize:15,fontWeight: FontWeight.w600,color: Colors.black))),),
                      ],),
                      InkWell(onTap: (){
                        Get.toNamed(AddBagScreen.addBagScreen);
                      },

                        child: Container(decoration: BoxDecoration(color: Color(0xff014E70),borderRadius: BorderRadius.circular(22)),
                          padding: const EdgeInsets.fromLTRB(20,10,20,10),

                          child: Text("Add to Bag",style: GoogleFonts.poppins(fontSize: 16,fontWeight: FontWeight.w500,color: Colors.white),),),
                      )
                    ],),
                ],
              ),
            ),
          );
        });
  }
}
