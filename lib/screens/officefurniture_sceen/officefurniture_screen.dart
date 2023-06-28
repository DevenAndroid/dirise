import 'package:dirise/routers/my_routers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../widgets/common_colour.dart';

class OfficeFurniture extends StatefulWidget {
  const OfficeFurniture({Key? key}) : super(key: key);

  @override
  State<OfficeFurniture> createState() => _OfficeFurnitureState();
}

class _OfficeFurnitureState extends State<OfficeFurniture> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 0,
        leading:   IconButton(
          icon: const Icon(Icons.arrow_back_ios,
              color: Color(0xff014E70), size: 20),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Office Furniture",
              style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 19),
            ),
            Container(
              padding: EdgeInsets.all(8),
              alignment: Alignment.center,
              height: 42,
              width: 70,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppTheme.buttonColor),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(
                    height: 25,
                    image: AssetImage(
                      'assets/icons/whishlist.png',
                    ),
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    '0',
                    style: TextStyle(
                        color: Colors.white, fontSize: 23),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(21)),
                child: Image.asset('assets/images/officebannerimage.png'),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Color(0xffF5F5F5)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Text(
                          "Chairs",
                          style: GoogleFonts.poppins(
                              color: Color(0xff131313),
                              fontWeight: FontWeight.w600,
                              fontSize: 18),
                        ),
                      ),
                      Image.asset(
                        'assets/images/chairs.png',
                        height: 85,
                      ),
                    ],
                  )),
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                height: 70,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Color(0xffF5F5F5)),
                child: Row(
                  children: [
                    SizedBox(
                      width: 15,
                    ),
                    Image.asset('assets/images/taskchair.png'),
                    SizedBox(
                      width: 35,
                    ),
                    Text(
                      "Task Chairs",
                      style: GoogleFonts.poppins(
                          color: const Color(0xFF131313),
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    ),
                    Spacer(),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 22,
                      color: Colors.grey,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Container(
                height: 70,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(21),
                    color: Color(0xffF5F5F5)),
                child: Row(
                  children: [
                    SizedBox(
                      width: 15,
                    ),
                    Image.asset('assets/images/gameingchair.png'),
                    SizedBox(
                      width: 45,
                    ),
                    Text(
                      "Gaming Chairs",
                      style: GoogleFonts.poppins(
                          color: const Color(0xFF131313),
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    ),
                    Spacer(),
                    InkWell(onTap: (){
                       Get.toNamed(MyRouters.singleChair);
                    },
                      child: Icon(
                        Icons.arrow_forward_ios,
                        size: 22,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Container(
                height: 70,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(21),
                    color: Color(0xffF5F5F5)),
                child: Row(
                  children: [
                    SizedBox(
                      width: 5,
                    ),
                    Image.asset('assets/images/loungechair.png'),
                    SizedBox(
                      width: 25,
                    ),
                    Text(
                      "Lounge Chairs",
                      style: GoogleFonts.poppins(
                          color: const Color(0xFF131313),
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    ),
                    Spacer(),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 22,
                      color: Colors.grey,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 20,),
              child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(21),
                      color: Color(0xffF5F5F5)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Text(
                          "Desks",
                          style: GoogleFonts.poppins(
                              color: Color(0xff131313),
                              fontWeight: FontWeight.w600,
                              fontSize: 18),
                        ),
                      ),
                      Image.asset(
                        'assets/images/desks.png',
                        height: 85,
                      ),
                    ],
                  )),
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(21),
                      color: Color(0xffF5F5F5)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Text(
                          "Bookcases",
                          style: GoogleFonts.poppins(
                              color: Color(0xff131313),
                              fontWeight: FontWeight.w600,
                              fontSize: 18),
                        ),
                      ),
                      Image.asset(
                        'assets/images/bookcase.png',
                        height: 85,
                      ),
                    ],
                  )),
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(21),
                      color: Color(0xffF5F5F5)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Text(
                          "Computer Work",
                          style: GoogleFonts.poppins(
                              color: Color(0xff131313),
                              fontWeight: FontWeight.w600,
                              fontSize: 18),
                        ),
                      ),
                      Image.asset(
                        'assets/images/chairs.png',
                        height: 85,
                      ),
                    ],
                  )),
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(21),
                      color: Color(0xffF5F5F5)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Text(
                          "Office Accessories",
                          style: GoogleFonts.poppins(
                              color: Color(0xff131313),
                              fontWeight: FontWeight.w600,
                              fontSize: 18),
                        ),
                      ),
                      Image.asset(
                        'assets/images/officeitems.png',
                        height: 85,
                      ),
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
