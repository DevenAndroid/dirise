import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/common_app_bar.dart';
import '../widgets/common_colour.dart';
import 'categores/single_categorie.dart';
import 'my_account_screens/myaccount_scrren.dart';
import 'school_nursery_category.dart';

class SchoolNurseryScreen extends StatefulWidget {
  const SchoolNurseryScreen({Key? key}) : super(key: key);
  static String route = "/SchoolNurseryScreen";

  @override
  State<SchoolNurseryScreen> createState() => _SchoolNurseryScreenState();
}

class _SchoolNurseryScreenState extends State<SchoolNurseryScreen> {
  List type = ["E Book", "Voice", "Both"];
  List gender = ["Male", "Female", "Both"];
  RxBool? status = false.obs;
  List<CheckBoxListTileModel> type1 = CheckBoxListTileModel.getList();
  List<CheckBoxListTileModel> gender1 = CheckBoxListTileModel.getList();
  SingingCharacter? _character = SingingCharacter.lafayette;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: CommonAppBar(
            titleText: 'School & Nurseries',
          ),
        ),
        body: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              showModalBottomSheet(
                                  isScrollControlled: true,
                                  context: context,
                                  builder: (context) {
                                    return SizedBox(
                                      height: size.height * .65,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 15),
                                            child: Text(
                                              "Type",
                                              style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                          Obx(() {
                                            return Column(
                                              children: List.generate(
                                                  type.length,
                                                  (index) => Column(
                                                        mainAxisSize: MainAxisSize.min,
                                                        children: [
                                                          ListTileTheme(
                                                            horizontalTitleGap: 5,
                                                            child: CheckboxListTile(
                                                              controlAffinity: ListTileControlAffinity.leading,
                                                              dense: true,
                                                              visualDensity: VisualDensity.compact,
                                                              activeColor: const Color(0xff014E70),
                                                              value: type1[index].isCheck!.value,
                                                              onChanged: (value) {
                                                                setState(() {
                                                                  type1[index].isCheck!.value = value!;
                                                                });
                                                              },
                                                              title: Text(
                                                                type1[index].title.toString(),
                                                                style: GoogleFonts.poppins(
                                                                  fontWeight: FontWeight.w500,
                                                                  color: Colors.black,
                                                                  fontSize: 16,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      )),
                                            );
                                          }),
                                          SizedBox(
                                            height: size.height * .23,
                                          ),
                                          Align(
                                            alignment: Alignment.bottomCenter,
                                            child: Column(
                                              children: [
                                                Container(
                                                  alignment: Alignment.center,
                                                  height: 48,
                                                  width: MediaQuery.of(context).size.width * .9,
                                                  decoration: const BoxDecoration(color: Color(0xff014E70)),
                                                  child: Text(
                                                    "Apply",
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 18, fontWeight: FontWeight.w500, color: Colors.white),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 20,
                                                ),
                                                Container(
                                                  alignment: Alignment.center,
                                                  height: 48,
                                                  width: MediaQuery.of(context).size.width * .9,
                                                  decoration:
                                                      BoxDecoration(border: Border.all(color: AppTheme.buttonColor)),
                                                  child: Text(
                                                    "Clear All",
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 18,
                                                        fontWeight: FontWeight.w500,
                                                        color: const Color(0xff014E70)),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          )
                                        ],
                                      ),
                                    );
                                  });
                            },
                            child: Container(
                              height: 36,
                              padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                              decoration: BoxDecoration(
                                  border: Border.all(color: const Color(0xff014E70)),
                                  color: const Color(0xffEBF1F4),
                                  borderRadius: BorderRadius.circular(22)),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8, right: 15),
                                    child: Text(
                                      "Type",
                                      style: GoogleFonts.poppins(
                                          fontSize: 14, fontWeight: FontWeight.w500, color: const Color(0xff014E70)),
                                    ),
                                  ),
                                  Image.asset(
                                    'assets/icons/arrowdown.png',
                                    height: 10,
                                  ),
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
                                      height: size.height * .46,
                                      decoration: const BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
                                      child: Center(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.only(left: 20, right: 20),
                                              child: Container(
                                                  decoration: BoxDecoration(
                                                      border: Border.all(color: const Color(0xffDCDCDC)),
                                                      borderRadius: BorderRadius.circular(15)),
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
                                              padding: const EdgeInsets.only(left: 20, right: 20),
                                              child: Container(
                                                  decoration: BoxDecoration(
                                                      border: Border.all(color: const Color(0xffDCDCDC)),
                                                      borderRadius: BorderRadius.circular(15)),
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
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(left: 20, right: 20),
                                              child: Container(
                                                  decoration: BoxDecoration(
                                                      border: Border.all(color: const Color(0xffDCDCDC)),
                                                      borderRadius: BorderRadius.circular(15)),
                                                  child: ListTile(
                                                    title: const Text('Several languages'),
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
                                              height: size.height * .03,
                                            ),
                                            Center(
                                              child: Padding(
                                                padding: const EdgeInsets.only(left: 20, right: 20),
                                                child: Container(
                                                  height: 48,
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
                              height: 36,
                              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                              decoration: BoxDecoration(
                                  border: Border.all(color: const Color(0xff014E70)),
                                  color: const Color(0xffEBF1F4),
                                  borderRadius: BorderRadius.circular(22)),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8, right: 10),
                                    child: Text(
                                      "Language",
                                      style: GoogleFonts.poppins(
                                          fontSize: 14, fontWeight: FontWeight.w500, color: const Color(0xff014E70)),
                                    ),
                                  ),
                                  Image.asset(
                                    'assets/icons/arrowdown.png',
                                    height: 10,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              showModalBottomSheet(
                                  isScrollControlled: true,
                                  context: context,
                                  builder: (context) {
                                    return SizedBox(
                                      height: size.height * .6,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 15),
                                            child: Text(
                                              "Gender",
                                              style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                          Obx(() {
                                            return Column(
                                              children: List.generate(
                                                  gender.length,
                                                  (index) => Column(
                                                        mainAxisSize: MainAxisSize.min,
                                                        children: [
                                                          ListTileTheme(
                                                            horizontalTitleGap: 5,
                                                            child: CheckboxListTile(
                                                              controlAffinity: ListTileControlAffinity.leading,
                                                              dense: true,
                                                              visualDensity: VisualDensity.compact,
                                                              activeColor: const Color(0xff014E70),
                                                              value: gender1[index].isCheck!.value,
                                                              onChanged: (value) {
                                                                setState(() {
                                                                  gender1[index].isCheck!.value = value!;
                                                                });
                                                              },
                                                              title: Text(
                                                                gender1[index].title.toString(),
                                                                style: GoogleFonts.poppins(
                                                                  fontWeight: FontWeight.w500,
                                                                  color: Colors.black,
                                                                  fontSize: 16,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      )),
                                            );
                                          }),
                                          SizedBox(
                                            height: size.height * .16,
                                          ),
                                          Align(
                                            alignment: Alignment.bottomCenter,
                                            child: Column(
                                              children: [
                                                Container(
                                                  alignment: Alignment.center,
                                                  height: 48,
                                                  width: MediaQuery.of(context).size.width * .87,
                                                  decoration: const BoxDecoration(color: Color(0xff014E70)),
                                                  child: Text(
                                                    "Apply",
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 18, fontWeight: FontWeight.w500, color: Colors.white),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 20,
                                                ),
                                                Container(
                                                  alignment: Alignment.center,
                                                  margin: const EdgeInsets.only(bottom: 10),
                                                  height: 48,
                                                  width: MediaQuery.of(context).size.width * .87,
                                                  decoration:
                                                      BoxDecoration(border: Border.all(color: const Color(0xff014E70))),
                                                  child: Text(
                                                    "Clear All",
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 18,
                                                        fontWeight: FontWeight.w500,
                                                        color: const Color(0xff014E70)),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  });
                            },
                            child: Container(
                              height: 36,
                              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                              decoration: BoxDecoration(
                                  border: Border.all(color: const Color(0xff014E70)),
                                  color: const Color(0xffEBF1F4),
                                  borderRadius: BorderRadius.circular(22)),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8, right: 10),
                                    child: Text(
                                      "Gender",
                                      style: GoogleFonts.poppins(
                                          fontSize: 14, fontWeight: FontWeight.w500, color: const Color(0xff014E70)),
                                    ),
                                  ),
                                  Image.asset(
                                    'assets/icons/arrowdown.png',
                                    height: 10,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 13,
                      ),
                      ListView.builder(
                        itemCount: 3,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 17),
                            child: InkWell(onTap: (){
                              Get.toNamed(SchoolNurseryCategory.route);
                            },
                              child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(color: const Color(0xffD9D9D9).withOpacity(.7), width: 1.3),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Row(
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
                                      child: Padding(
                                        padding: const EdgeInsets.only(top: 10),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Text(
                                              ("English Play Group"),
                                              style: GoogleFonts.poppins(
                                                  color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(top: 5, bottom: 5),
                                              child: Text(
                                                ("Education Summer Camp"),
                                                style: GoogleFonts.poppins(
                                                    color: Colors.grey.withOpacity(.7),
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w500),
                                              ),
                                            ),
                                            Text(
                                              ("24 items"),
                                              style: GoogleFonts.poppins(
                                                  color: const Color(0xff014E70),
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w500),
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      )
                    ]))));
  }
}
