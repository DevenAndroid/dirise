import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:google_fonts/google_fonts.dart';

import '../../widgets/common_app_bar.dart';
import '../../widgets/common_colour.dart';
import '../check_out/add_bag_screen.dart';

class SingleChair extends StatefulWidget {
  const SingleChair({Key? key}) : super(key: key);

  @override
  State<SingleChair> createState() => _SingleChairState();
}

class _SingleChairState extends State<SingleChair> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: CommonAppBar(
          titleText: 'Gaming Chairs',
        ),
      ),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 13.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    child: const Image(image: AssetImage('assets/images/storybooks.png'))),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 4,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 20,
                        mainAxisExtent: size.height * .33),
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          singleChairBottomSheet();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          margin: const EdgeInsets.only(left: 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.asset(
                                height: size.height * .2,
                                'assets/images/chairgaming.png',
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                'Atrium Classic Backpack Accessory',
                                style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 15),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                '1 piece',
                                style: GoogleFonts.poppins(
                                    fontSize: 16, fontWeight: FontWeight.w500, color: const Color(0xff858484)),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                'KD 12.700',
                                style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            )),
      ),
    );
  }

  singleChairBottomSheet() {
    Size size = MediaQuery.of(context).size;
    return showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.white,
        builder: (context) {
          return SizedBox(
            width: size.width,
            height: size.height * .79,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 25.0),
                      child: Align(
                        alignment: Alignment.center,
                        child: Image.asset(
                          height: size.height * .24,
                          width: size.width * .7,
                          'assets/images/chairgaming.png',
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Text(
                        '50% off',
                        style: GoogleFonts.poppins(
                            fontSize: 18, fontWeight: FontWeight.w500, color: const Color(0xffC22E2E)),
                      ),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Text(
                        'Ecstasy 165 days ',
                        style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 16),
                      ),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Text(
                        '1 piece',
                        style: GoogleFonts.poppins(color: const Color(0xff858484), fontSize: 16),
                      ),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15, right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                'KD 6.350',
                                style: GoogleFonts.poppins(
                                    fontSize: 16, fontWeight: FontWeight.w500, color: const Color(0xff014E70)),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                'KD 12.700',
                                style: GoogleFonts.poppins(
                                    decoration: TextDecoration.lineThrough,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: const Color(0xff858484)),
                              ),
                            ],
                          ),
                          Text(
                            'Add to list',
                            style: GoogleFonts.poppins(
                              shadows: [const Shadow(color: Colors.black, offset: Offset(0, -4))],
                              color: Colors.transparent,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              decoration: TextDecoration.underline,
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Description',
                        style: GoogleFonts.poppins(
                          shadows: [const Shadow(color: Colors.black, offset: Offset(0, -4))],
                          color: Colors.transparent,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Text(
                        'to the rich father and the poor father; What the rich teach and the poor and middle class do not teach their children about to the Publisher s Synopsis: This book will shatter the myth that you need a big income to get rich... -Challenging',
                        style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w400, height: 1.7),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                  ],
                ),
                Card(
                  elevation: 10,
                  child: Container(
                    color: Colors.white,
                    width: size.width,
                    height: 60,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Row(
                            children: [
                              CircleAvatar(
                                radius: 18,
                                backgroundColor: Color(0xffEAEAEA),
                                child: Center(
                                    child: Text(
                                      "━",
                                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black),
                                    )),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "1",
                                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              CircleAvatar(
                                radius: 18,
                                backgroundColor: Color(0xffEAEAEA),
                                child: Center(
                                    child: Text(
                                      "+",
                                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.black),
                                    )),
                              ),
                            ],
                          ),
                          InkWell(
                            onTap: () {
                              Get.offNamed(BagsScreen.addBagScreen);
                            },
                            child: Container(
                              decoration:
                              BoxDecoration(color: const Color(0xff014E70), borderRadius: BorderRadius.circular(22)),
                              padding: const EdgeInsets.fromLTRB(20, 9, 20, 9),
                              child: Text(
                                "Add to Bag",
                                style: GoogleFonts.poppins(
                                    fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
