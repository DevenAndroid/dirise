import 'package:dirise/widgets/common_colour.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


import 'package:shared_preferences/shared_preferences.dart';


class PopUpScreen extends StatefulWidget {
  const PopUpScreen({Key? key}) : super(key: key);

  @override
  State<PopUpScreen> createState() => _PopUpScreenState();
}

class _PopUpScreenState extends State<PopUpScreen> {


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: SingleChildScrollView(

        physics: const BouncingScrollPhysics(),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20,left: 13,right: 13),
                child: Row(children: [
                  const Icon(Icons.arrow_downward),
                  SizedBox(width: size.width*.02,),
                  Text("Select Project",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                  const Spacer(),
                  InkWell(
                      onTap: (){
                        Get.back();
                      },
                      child: const Icon(Icons.close,))
                ],),
              ),
              SizedBox(height: size.height*.015,),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text('Search Project',style: TextStyle(fontSize: 17),),
              ),
              SizedBox(height: size.height*.010,),
              const Divider(
                color: Color(0xfff6cdde),
              ),


            ]),
      ),
    );
  }
}
