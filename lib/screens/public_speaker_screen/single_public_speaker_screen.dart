import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../widgets/common_app_bar.dart';
import '../../widgets/common_colour.dart';

class PublicSpeakerCategory extends StatefulWidget {
  const PublicSpeakerCategory({Key? key}) : super(key: key);
  static var singlePublicCategory = "/singlePublicCategory";

  @override
  State<PublicSpeakerCategory> createState() => _PublicSpeakerCategoryState();
}

class _PublicSpeakerCategoryState extends State<PublicSpeakerCategory> {
  pickDateFromDialog(context) {
    showDatePicker(

        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1950),
        lastDate: DateTime(2100),
        initialEntryMode: DatePickerEntryMode.calendarOnly)
        .then((pickedDate) {
      if (pickedDate == null) {
        return null;
      }

    });
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: CommonAppBar(
          titleText: 'Public Speaker',
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14.0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

              const ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(10)),
          child: Image(image: AssetImage('assets/images/storybooks.png'))),
      const SizedBox(
        height: 20,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Image(
            image: AssetImage('assets/images/teacher1.png'),
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
                  ("Sara Luies"),
                  style: GoogleFonts.poppins(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5, bottom: 5),
                  child: Text(
                    ("Books, Stationary and Electronics"),
                    style: GoogleFonts.poppins(
                        color: Colors.grey.withOpacity(.7), fontSize: 12, fontWeight: FontWeight.w500),
                  ),
                ),
                Text(
                  ("1457 items"),
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
                    TextFormField(
                      // controller: controller.fromDateController,
                      onTap: () {
                       pickDateFromDialog(context);
                      },
                      readOnly: true,
                      style:
                      const TextStyle(color: AppTheme.buttonColor, fontSize: 16),
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          suffixIcon:
                          const Icon(Icons.calendar_month_rounded),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Color(0xffE4E0E0)),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Color(0xffE4E0E0)),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Color(0xffE4E0E0)),
                              borderRadius: BorderRadius.circular(8.0)),
                          hintText: "Select Date and time",
                          hintStyle: const TextStyle(
                              color:Color(0xff4B4B4B), fontSize: 16)),
                    ),
                   const SizedBox(height: 30,),
                   Container(
                      height: 56,
                      width: MediaQuery.sizeOf(context).width,
                      color: const Color(0xff014E70),
                      child: const Center(
                        child: Text(
                          'Apply',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500, color: Colors.white),
                        ),
                      ),
                    ),


    ]))));
  }
}
