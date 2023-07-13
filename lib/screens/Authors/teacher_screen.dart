import 'package:dirise/screens/Authors/singel_teacher_screen.dart';
import 'package:dirise/widgets/common_colour.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../widgets/common_app_bar.dart';

class TeacherScreen extends StatefulWidget {
  const TeacherScreen({super.key});
  static var teacherScreen = "/teacherScreen";

  @override
  State<TeacherScreen> createState() => _TeacherScreenState();
}

class _TeacherScreenState extends State<TeacherScreen> {
  List data = ["Primary School", "High School", "Kindergarten ", "University ", "Masters"];
  RxBool status = false.obs;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: CommonAppBar(
          titleText: 'Teacher',
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

                ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    child: const Image(image: AssetImage('assets/images/storybooks.png'))),
                const SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () {
                    showModalBottomSheet(
                      isScrollControlled: true,
                        context: context,
                        builder: (context) {
                          return SizedBox(
                            height: size.height*.78,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 26, top: 20, bottom: 10),
                                      child: Text(
                                        "Education Level",
                                        style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                    Obx(() {
                                      return Column(
                                        children: List.generate(
                                            data.length,
                                            (index) => Column(
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: [
                                                    Theme(
                                                      data: ThemeData(unselectedWidgetColor: const Color(0xff014E70)),
                                                      child: CheckboxListTile(
                                                        controlAffinity: ListTileControlAffinity.leading,
                                                        dense: true,
                                                        visualDensity: VisualDensity.compact,
                                                        activeColor: const Color(0xff014E70),
                                                        value: status.value,
                                                        onChanged: (value) {
                                                          setState(() {
                                                            status.value = value!;
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
                                                )),
                                      );
                                    }),
                                  ],
                                ),
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Column(
                                    children: [
                                      Container(
                                        alignment: Alignment.center,
                                        height: 47,
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
                                        height: 47,
                                        margin: const EdgeInsets.only(bottom: 10),
                                        width: MediaQuery.of(context).size.width * .87,
                                        decoration: BoxDecoration(border: Border.all(color: const Color(0xff014E70))),
                                        child: Text(
                                          "Clear All",
                                          style: GoogleFonts.poppins(
                                              fontSize: 18, fontWeight: FontWeight.w500, color: const Color(0xff014E70)),
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
                  child: Row(
                    children: [
                      Container(
                        height: 35,
                        width: size.width*.4,
                        // padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
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
                                "Education Level",
                                style: GoogleFonts.poppins(
                                    fontSize: 14, fontWeight: FontWeight.w500, color: const Color(0xff014E70)),
                              ),
                            ),
                            const Icon(Icons.keyboard_arrow_down_outlined,color: AppTheme.buttonColor,)
                          ],
                        ),
                      ),
                      SizedBox(width: 20,),
                      Container(
                         height: 35,
                         width: size.width*.27,
                         padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
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
                                "Course",
                                style: GoogleFonts.poppins(
                                    fontSize: 14, fontWeight: FontWeight.w500, color: const Color(0xff014E70)),
                              ),
                            ),
                            const Icon(Icons.keyboard_arrow_down_outlined,color: AppTheme.buttonColor,)
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                SizedBox(
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 5,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 20,
                        childAspectRatio:
                            MediaQuery.of(context).size.width / (MediaQuery.of(context).size.height / 1.6)),
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () {
                          Get.toNamed(SelectedTeacher.selectedTeacher);
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
                                'assets/images/teacher1.png',
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                'Jarir Library ',
                                style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 18),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                '1457 Items',
                                style: GoogleFonts.poppins(
                                    fontSize: 14, fontWeight: FontWeight.w500, color: const Color(0xff014E70)),
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
}
