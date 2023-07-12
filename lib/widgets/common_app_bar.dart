
import 'package:dirise/routers/my_routers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class CommonAppBar extends StatelessWidget {
  final String? titleText;
  const CommonAppBar({super.key,required this.titleText});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      surfaceTintColor: Colors.white,
      backgroundColor: Colors.white,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios, color: Color(0xff014E70),size: 20),
        onPressed: () => Navigator.of(context).pop(),

      ),
      titleSpacing: 0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(titleText!,style: GoogleFonts.poppins(color: Colors.black,fontWeight: FontWeight.w600,fontSize: 21),),
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: InkWell(onTap: (){

              Get.toNamed(MyRouters.bucketScreen);
            },
              child: Container(
                alignment: Alignment.center,
                height: 40,
                width: 60,

                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color(0xff014E70)
                ),
                child:  Row(mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset("assets/images/bag1.svg"),
                    const SizedBox(width: 10,),
                    const Text(("0"),style: TextStyle(color: Colors.white,fontSize: 20),)
                  ],),
              ),
            ),
          ),
        ],
      ),);
  }
}
