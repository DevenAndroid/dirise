import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:google_fonts/google_fonts.dart';

import '../widgets/common_colour.dart';
import 'check_out/add_bag_screen.dart';

class SchoolNursery extends StatefulWidget {
  const SchoolNursery({Key? key}) : super(key: key);

  @override
  State<SchoolNursery> createState() => _SchoolNurseryState();
}

class _SchoolNurseryState extends State<SchoolNursery> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(140),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios, color: Color(0xff014E70), size: 20),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  Text(
                    'Schools & Nurseries',
                    style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.all(8),
                    alignment: Alignment.center,
                    height: 42,
                    width: 70,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: AppTheme.buttonColor),
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
                          style: TextStyle(color: Colors.white, fontSize: 23),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
                ),
                const Image(image: AssetImage('assets/images/storybooks.png')),
                const SizedBox(
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Image(
                      image: AssetImage('assets/images/epg.png'),
                      height: 85,
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            ("English Play Group"),
                            style: GoogleFonts.poppins(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5, bottom: 5),
                            child: Text(
                              ("Education Summer Camp"),
                              style: GoogleFonts.poppins(
                                  color: Colors.grey.withOpacity(.7), fontSize: 12, fontWeight: FontWeight.w500),
                            ),
                          ),
                          Text(
                            ("24 items"),
                            style: GoogleFonts.poppins(
                                color: const Color(0xff014E70), fontSize: 18, fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 25,
                ),
                Text(
                  ("Brief"),
                  style: GoogleFonts.poppins(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  ("to the rich father and the poor father; What the rich teach and the poor and middle class do not teach their children about to the Publisher's Synopsis"),
                  style: GoogleFonts.poppins(
                      color: const Color(0xff014E70), fontSize: 14, fontWeight: FontWeight.w500, height: 1.6),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          'assets/icons/emailicon.png',
                          height: 28,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          ("Teacher@gmail.com"),
                          style: GoogleFonts.poppins(
                              color: const Color(0xff7D7D7D), fontSize: 14, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Image.asset(
                          'assets/icons/phoneicon.png',
                          height: 28,
                        ),
                        const SizedBox(
                          width: 3,
                        ),
                        Text(
                          ("+965 6565655"),
                          style: GoogleFonts.poppins(
                              color: const Color(0xff7D7D7D), fontSize: 14, fontWeight: FontWeight.w500),
                        ),
                      ],
                    )
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                const Divider(
                  thickness: .5,
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  'Courses',
                  style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 15,
                ),
                SizedBox(
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 2,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 20,
                        mainAxisExtent: size.height * .32),
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () {
                          bottemSheet();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          margin: const EdgeInsets.only(left: 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.asset(
                                height: size.height * .2,
                                'assets/images/epg.png',
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                'Roco NoteBook',
                                style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 14),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                '1 piece',
                                style: GoogleFonts.poppins(color: const Color(0xff858484)),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                'KD 12.700',
                                style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500),
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

  Future bottemSheet() {
    Size size = MediaQuery.of(context).size;
    return showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.white,
        builder: (context) {
          return SizedBox(
            width: size.width,
            height: size.height * .7,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Image.asset(
                          height: size.height * .2,
                          width: size.width * .7,
                          'assets/images/schoolnursery.png',
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Text(
                        '50% off',
                        style: GoogleFonts.poppins(
                            fontSize: 14, fontWeight: FontWeight.w500, color: const Color(0xffC22E2E)),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Ecstasy 165 days ',
                        style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 16),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        '1 piece',
                        style: GoogleFonts.poppins(color: const Color(0xff858484), fontSize: 16),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                'KD 12.700',
                                style: GoogleFonts.poppins(
                                    fontSize: 16, fontWeight: FontWeight.w500, color: const Color(0xff014E70)),
                              ),
                              const SizedBox(
                                width: 15,
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
                              fontWeight: FontWeight.w500,
                              decoration: TextDecoration.underline,
                            ),
                          )
                        ],
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
                            fontWeight: FontWeight.w500,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        'to the rich father and the poor father; What the rich teach and the poor and middle class do not teach their children about to the Publisher s Synopsis: This book will shatter the myth that you need a big income to get rich... -Challenging',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                height: 35,
                                width: 35,
                                decoration: const BoxDecoration(shape: BoxShape.circle, color: Color(0xffEAEAEA)),
                                child: const Icon(Icons.remove),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              const Text(
                                "1",
                                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Container(
                                height: 35,
                                width: 35,
                                decoration: const BoxDecoration(shape: BoxShape.circle, color: Color(0xffEAEAEA)),
                                child: const Icon(Icons.add),
                              ),
                            ],
                          ),
                          InkWell(
                            onTap: () {
                              Get.toNamed(BagsScreen.addBagScreen);
                            },
                            child: Container(
                              height: 36,
                              width: 140,
                              decoration: BoxDecoration(
                                  color: const Color(0xff014E70), borderRadius: BorderRadius.circular(22)),
                              child: Center(
                                child: Text(
                                  "Add to Bag",
                                  style: GoogleFonts.poppins(
                                      fontSize: 14, fontWeight: FontWeight.w500, color: Colors.white),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }
}
