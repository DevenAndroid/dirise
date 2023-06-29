import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../widgets/common_colour.dart';
import '../categores/add_bag_screen.dart';

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
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios,
              color: Color(0xff014E70), size: 20),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Gaming Chairs",
              style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 19),
            ),
            Container(
              padding: const EdgeInsets.all(8),
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
                    style: TextStyle(color: Colors.white, fontSize: 23),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
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
                  height: 20,
                ),
                SizedBox(
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 4,
                    gridDelegate:
                         SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 20,
                            mainAxisExtent: size.height*.32),
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
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w500, fontSize: 15),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                '1 piece',
                                style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: const Color(0xff858484)),
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
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: SizedBox(
              width: size.width,
              height: size.height * .75,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Image.asset(
                      height: size.height * .2,
                      width: size.width * .7,
                      'assets/images/chairgaming.png',
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Text(
                    '50% off',
                    style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.red),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    'Gaming Chair Omen - Red',
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500, fontSize: 16),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    '1 piece',
                    style: GoogleFonts.poppins(
                        color: const Color(0xff858484), fontSize: 16),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'KD 12.700',
                        style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xff014E70)),
                      ),
                      Text(
                        'Add to list',
                        style: GoogleFonts.poppins(
                          shadows: [
                            const Shadow(
                                color: Colors.black, offset: Offset(0, -4))
                          ],
                          color: Colors.transparent,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          decoration: TextDecoration.underline,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Description',
                      style: GoogleFonts.poppins(
                        shadows: [
                          const Shadow(
                              color: Colors.black, offset: Offset(0, -4))
                        ],
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
                  Text(
                    '1:2 scale model',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    'Available in Secretlab NEO hybrid leather red and softwere plus febric',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    'Height-adjustment armrests for the right fit',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    'Child-friendly locking casters make for your little one',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
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
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xffEAEAEA)),
                            child: const Icon(Icons.remove),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const Text(
                            "1",
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 20),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Container(
                            height: 35,
                            width: 35,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xffEAEAEA)),
                            child: const Icon(Icons.add),
                          ),
                        ],
                      ),
                      InkWell(
                        onTap: () {

                          Get.toNamed(AddBagScreen.addBagScreen);
                        },
                        child: Container(
                          height: 36,
                          width: 140,
                          decoration: BoxDecoration(
                              color: const Color(0xff014E70),
                              borderRadius: BorderRadius.circular(22)),
                          child: Center(
                            child: Text(
                              "Add to Bag",
                              style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white),

                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }
}
