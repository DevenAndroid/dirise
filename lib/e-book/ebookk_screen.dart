import 'package:dirise/widgets/common_colour.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';

import '../screens/myaccount_scrren.dart';


class EBook extends StatefulWidget {
  const EBook({Key? key}) : super(key: key);

  @override
  State<EBook> createState() => _EBookState();
}

class _EBookState extends State<EBook> {
  List data= ["E Book","Voice","Both"];
  RxBool status= false.obs;
  SingingCharacter? _character = SingingCharacter.lafayette;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return  Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(140),
        child: Container(

          child: SafeArea(
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios,
                      color: Color(0xff014E70), size: 20),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                Text(
                  'E book',
                  style: GoogleFonts.poppins(
                      fontSize: 18, fontWeight: FontWeight.w600),
                )
              ],
            ),
      ))),
      body:  SingleChildScrollView(
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
                Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () {
                        showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return  Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 26,vertical: 15),
                                    child: Text(
                                      "Type",
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
                                              ListTileTheme(
                                                 horizontalTitleGap: 0.0,

                                                child: CheckboxListTile(

                                                  controlAffinity:
                                                  ListTileControlAffinity.leading,
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
SizedBox(height: 50,),
                                  Align(alignment: Alignment.bottomCenter,
                                    child: Column(
                                      children: [
                                        Container(
                                          alignment: Alignment.center,
                                          height: 60,
                                          width:MediaQuery.of(context).size.width *.9,
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
                                          height: 60,
                                          width:MediaQuery.of(context).size.width *.9,
                                          decoration: BoxDecoration(
                                              border: Border.all(color:AppTheme.buttonColor)
                                          ),
                                          child: Text(
                                            "Clear All",
                                            style:
                                            GoogleFonts.poppins(fontSize: 18,fontWeight: FontWeight.w500,color: const Color(0xff014E70)),
                                          ),),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 5,)

                                ],
                              );
                            });
                      },


                      child: Container(
                        height: 35,
                        width: 90,

                        decoration: BoxDecoration(

                            border: Border.all(
                                color: const Color(0xff014E70)),
                            color: const Color(0xffEBF1F4),
                            borderRadius: BorderRadius.circular(22)),
                        child: Row(mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 8,right: 10),
                              child: Text(
                                "Type",
                                style:
                                GoogleFonts.poppins(fontSize: 15,fontWeight: FontWeight.w500,color: const Color(0xff014E70)),
                              ),
                            ),
                          Image.asset('assets/icons/arrowdown.png',height: 10,),

                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        showModalBottomSheet<void>(
                            context: context,
                            builder: (BuildContext context) {
                              return Container(
                                height: 330,
                                decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        topRight: Radius.circular(20))),
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Padding(
                                        padding:
                                        const EdgeInsets.only(left: 20, right: 20),
                                        child: Container(
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: const Color(0xffDCDCDC)),
                                                borderRadius:
                                                BorderRadius.circular(15)),
                                            child: ListTile(
                                              title: const Text('Arabic'),
                                              leading: Radio<SingingCharacter>(
                                                value: SingingCharacter.lafayette,
                                                groupValue: _character,
                                                activeColor: const Color(0xff014E70),
                                                onChanged: (SingingCharacter? value) {
                                                  setState(() {
                                                    _character = value;
                                                  });
                                                },
                                              ),
                                            )),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Padding(
                                        padding:
                                        const EdgeInsets.only(left: 20, right: 20),
                                        child: Container(
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: const Color(0xffDCDCDC)),
                                                borderRadius:
                                                BorderRadius.circular(15)),
                                            child: ListTile(
                                              title: const Text('English'),
                                              leading: Radio<SingingCharacter>(
                                                value: SingingCharacter.lafayette,
                                                groupValue: _character,
                                                activeColor: const Color(0xff014E70),
                                                onChanged: (SingingCharacter? value) {
                                                  setState(() {
                                                    _character = value;
                                                  });
                                                },
                                              ),
                                            )),
                                      ),
                                      SizedBox(
                                        height: size.height * .08,
                                      ),
                                      Center(
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 20, right: 20),
                                          child: Container(
                                            height: 56,
                                            width: MediaQuery.sizeOf(context).width,
                                            color: const Color(0xff014E70),
                                            child: const Center(
                                              child: Text(
                                                'Apply',
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            });
                      },
                      child: Container(
                        height: 35,
                        width: 120,

                        decoration: BoxDecoration(
                            border: Border.all(
                                color: const Color(0xff014E70)),
                            color: const Color(0xffEBF1F4),
                            borderRadius: BorderRadius.circular(22)),
                        child: Row(mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 8,right: 10),
                              child: Text(
                                "Language",
                                style:
                                GoogleFonts.poppins(fontSize: 15,fontWeight: FontWeight.w500,color: const Color(0xff014E70)),
                              ),
                            ),
                            Image.asset('assets/icons/arrowdown.png',height: 10,),

                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: 35,
                      width: 100,

                      decoration: BoxDecoration(
                          border: Border.all(
                              color: const Color(0xff014E70)),
                          color: const Color(0xffEBF1F4),
                          borderRadius: BorderRadius.circular(22)),
                      child: Row(mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 8,right: 10),
                            child: Text(
                              "Gender",
                              style:
                              GoogleFonts.poppins(fontSize: 15,fontWeight: FontWeight.w500,color: const Color(0xff014E70)),
                            ),
                          ),
                          Image.asset('assets/icons/arrowdown.png',height: 10,),

                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 25,),
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

                      },
                        child: Container(
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),),
                          margin: const EdgeInsets.only(left: 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.asset(
                                height: size.height * .2,
                                'assets/images/notebook.png',
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                'Atrium Classic Backpack Accessory',
                                style: GoogleFonts.poppins(
                                    fontSize: 16, fontWeight: FontWeight.w500),
                              ),
                              Text(
                                '1 piece',
                                style:
                                GoogleFonts.poppins(color: const Color(0xff858484),fontSize: 16),
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
      ),
    );
  }
}
