import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../language/app_strings.dart';
import '../widgets/common_colour.dart';


class PublishPostScreen extends StatefulWidget {
  const PublishPostScreen({super.key});
  static String route = "/PublishPostScreen";

  @override
  State<PublishPostScreen> createState() => _PublishPostScreenState();
}

class _PublishPostScreenState extends State<PublishPostScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        title: Text(
          AppStrings.publishPostScreen,
          style: GoogleFonts.poppins(color: Colors.white, fontSize: 20),
        ),
        centerTitle: true,
        backgroundColor: AppTheme.buttonColor,
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const  EdgeInsets.symmetric(vertical: 30,horizontal: 16),
        child: Column(
          children: [
              Container(
                decoration: BoxDecoration(color: Colors.white, boxShadow: [
                BoxShadow(
                  color: const Color(0xFF5F5F5F).withOpacity(0.4),
                  offset: const Offset(0.0, 0.2),
                  blurRadius: 2,
                ),
              ]),
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     const Text('What’s Happening?',style: TextStyle(
                      color: Color(0xFF5B5B5B),
                      fontWeight: FontWeight.w500,
                       fontSize: 16
                    ),),
                    const SizedBox(
                      height: 40,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                         Row(
                           children: [
                              Image.asset('assets/images/link-2.png',width: 28,),
                              SizedBox(
                                width: 10,
                              ),
                              Image.asset('assets/images/gallery.png',width: 25,),
                             SizedBox(
                               width: 12,
                             ),
                              Image.asset('assets/images/play-cricle.png',width: 27,),

                           ],
                         ),
                        GestureDetector(
                          onTap: (){},
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppTheme.buttonColor,
                              borderRadius: BorderRadius.circular(40),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 8),
                            child: const Text('Publish Post ',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.white
                              ),

                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            const SizedBox(
              height: 20,
            ),
            ListView.builder(
                shrinkWrap: true,
                 itemCount: 2,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(color: Colors.white, boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF5F5F5F).withOpacity(0.4),
                            offset: const Offset(0.0, 0.2),
                            blurRadius: 2,
                          ),
                        ]),
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                 Row(
                                   crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                       Image.asset('assets/images/post_img.png'),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                           Row(
                                             crossAxisAlignment: CrossAxisAlignment.start,
                                             children: [
                                               Text('Bothayna El Essa',
                                         style: GoogleFonts.poppins(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 14
                                          ),),
                                               const SizedBox(
                                                 width: 8,
                                               ),
                                               Image.asset('assets/images/check_mark.png',height: 16,)
                                             ],
                                           ),
                                          Text('@Bothayna El Essa007',
                                            style: GoogleFonts.poppins(
                                                color: Color(0xFF5B5B5B),
                                                fontWeight: FontWeight.w500,
                                                fontSize: 12
                                            ),),
                                        ],
                                      )
                                    ],
                                 ),
                                Text('10mint',
                                  style: GoogleFonts.poppins(
                                      color: Color(0xFF5B5B5B),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14
                                  ),),
                              ],
                            ),
                            const SizedBox(
                              height: 14,
                            ),
                            Text('There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words .',
                              style: GoogleFonts.poppins(
                                  color: Color(0xFF5B5B5B),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 13,
                                letterSpacing: 0.24,
                              ),),
                            const SizedBox(
                              height: 14,
                            ),
                           Stack(
                             children: [
                               SizedBox(
                                   width: double.maxFinite,
                                   child: Image.asset('assets/images/Rectangle 39892.png',fit: BoxFit.fitWidth,)),
                               Positioned(
                                   right: 4,
                                   top: 10,
                                   child: Container(
                                     width: 100,
                                     decoration: BoxDecoration(
                                       borderRadius: BorderRadius.circular(40),
                                       color: Colors.white,
                                     ),
                                     padding: EdgeInsets.all(4),
                                     child: Row(
                                       crossAxisAlignment: CrossAxisAlignment.center,
                                       mainAxisAlignment: MainAxisAlignment.center,
                                       children: [
                                          Icon(Icons.favorite_border,color: Color(0xFF014E70),),
                                         SizedBox(
                                           width: 10,
                                         ),
                                         Text('7482',
                                           style: GoogleFonts.poppins(
                                             color:Color(0xFF014E70),
                                             fontWeight: FontWeight.w500,
                                             fontSize: 13,
                                             letterSpacing: 0.24,
                                           ),),
                                       ],
                                     ),
                                   )
                               )
                             ],
                           )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      )
                    ],
                  );
                },
            )
          ],
        ),
      ),
    );
  }
}
