import 'package:dirise/widgets/common_colour.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../routers/my_routers.dart';
import '../widgets/common_button.dart';
import '../widgets/customsize.dart';
import '../widgets/dimension_screen.dart';

class SetTimeScreen extends StatefulWidget {
  const SetTimeScreen({Key? key}) : super(key: key);
  static var setTimeScreen = "/setTimeScreen";

  @override
  State<SetTimeScreen> createState() => _SetTimeScreenState();
}

class _SetTimeScreenState extends State<SetTimeScreen> {
  bool select = false;
  String selectedDate = '12/06/23';
  String dropdownvalue = '13:00';

  var items = [
    '13:00',
    '18:00',
    '21:00',
    '24:00',
  ];
  String dropdownvalue1 = '17:00';

  var items1 = [
    '17:00',
    '20:00',
    '23:00',
    '01:00',
  ];
  // Future<void> displayOpenTimeDialog(int index) async {
  //   DateTime? time;
  //   try {
  //     time = intl.DateFormat("hh:mm a")
  //         .parse(setStoreTimeController.model.value.data![index].startTime);
  //   } catch (e) {
  //     time = intl.DateFormat("hh:mm")
  //         .parse(setStoreTimeController.model.value.data![index].startTime);
  //   }
  //   TimeOfDay? result = await showTimePicker(
  //       context: context,
  //       initialTime: TimeOfDay.fromDateTime(intl.DateFormat("hh:mm")
  //           .parse(setStoreTimeController.model.value.data![index].startTime)),
  //       builder: (context, child) {
  //         return MediaQuery(
  //             data: MediaQuery.of(context).copyWith(
  //               // Using 12-Hour format
  //                 alwaysUse24HourFormat: true),
  //             // If you want 24-Hour format, just change alwaysUse24HourFormat to true
  //             child: child!);
  //       });
  //   if (result != null) {
  //     setState(() {
  //       setStoreTimeController.model.value.data![index].startTime =
  //           result.format(context);
  //       // time.value = result!.format(context);
  //     });
  //   } else {
  //     return;
  //   }
  // }

  // Future<void> displayCloseTimeDialog(int index) async {
  //   DateTime? time;
  //   try {
  //     time = intl.DateFormat("hh:mm a")
  //         .parse(setStoreTimeController.model.value.data![index].endTime);
  //   } catch (e) {
  //     time = intl.DateFormat("hh:mm")
  //         .parse(setStoreTimeController.model.value.data![index].endTime);
  //   }
  //
  //   TimeOfDay? result = await showTimePicker(
  //       context: context,
  //       initialTime: TimeOfDay.fromDateTime(time),
  //       // initialTime: TimeOfDay.fromDateTime(
  //       //     DateFormat("hh:mm a").parse(setStoreTimeController.model.value.data![index].endTime)),
  //       builder: (context, child) {
  //         return MediaQuery(
  //             data: MediaQuery.of(context).copyWith(
  //               // Using 12-Hour format
  //                 alwaysUse24HourFormat: true),
  //             // If you want 24-Hour format, just change alwaysUse24HourFormat to true
  //             child: child!);
  //       });
  //   if (result != null) {
  //     setState(() {
  //       setStoreTimeController.model.value.data![index].endTime =
  //           result.format(context);
  //       // time.value = result!.format(context);
  //     });
  //   } else {
  //     return;
  //   }
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //     setStoreTimeController.getSetStoreTime();
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Image.asset(
              'assets/icons/backicon.png',
              height: 20,
            ),
          ),
        ),
        title: Text(
          "Set Store Time",
          style: GoogleFonts.raleway(fontSize: 18, fontWeight: FontWeight.w700, color: const Color(0xff303C5E)),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              SizedBox(
                height: AddSize.size10,
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: 6,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10), border: Border.all(color: AppTheme.buttonColor)),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Theme(
                              data: ThemeData(
                                  checkboxTheme: CheckboxThemeData(
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)))),
                              child: Checkbox(
                                activeColor: AppTheme.buttonColor,
                                checkColor: Colors.white,
                                value: select,
                                onChanged: (value) {
                                  select = value!;
                                  setState(() {});
                                },
                              ),
                            ),
                            const Text(
                              "Sun",
                              style: TextStyle(color: Color(0xFF9C9CB4), fontSize: 14, fontWeight: FontWeight.w300),
                            ),
                            /* Spacer(),
                                 GestureDetector(
                                   onTap: () async {
                                     DateTime? pickedDate = await showDatePicker(
                                       builder: (context, child) {
                                         return Theme(
                                           data: Theme.of(context).copyWith(
                                             colorScheme: const ColorScheme.light(
                                               primary: Color(0xFF7ED957),
                                               // header background color
                                               onPrimary: Colors.white,
                                               // header text color
                                               onSurface: Color(
                                                   0xFF7ED957), // body text color
                                             ),
                                             textButtonTheme: TextButtonThemeData(
                                               style: TextButton.styleFrom(
                                                 foregroundColor: const Color(
                                                     0xFF7ED957), // button text color
                                               ),
                                             ),
                                           ),
                                           child: child!,
                                         );
                                       },

                                       context: context,
                                       initialDate: DateTime.now(),
                                       firstDate: DateTime(1950),
                                       //DateTime.now() - not to allow to choose before today.
                                       lastDate: DateTime(2025),
                                     ).then((value) {
                                       // setState(() {
                                       //   _dateTime = value!;
                                       // });

                                       if (value != null) {
                                         String formattedDate =
                                         DateFormat('yyyy/MM/dd')
                                             .format(value);
                                         setState(() {
                                           selectedDate =
                                               formattedDate; //set output date to TextField value.
                                           log("Seleted Date     $selectedDate");
                                         });
                                       }
                                     });

                                     if (pickedDate != null) {
                                       String formattedDate =
                                       DateFormat('yyyy/MM/dd')
                                           .format(pickedDate);
                                       setState(() {
                                         selectedDate = formattedDate;
                                         log("Seleted Date     $selectedDate");
                                       });
                                     }
                                   },
                                   child: Row(
                                     children: [
                                       Image.asset('assets/images/calendar.png',height: 12,),
                                       addWidth(5),
                                        Text(selectedDate,
                                          style: TextStyle(
                                           color: Color(0xFF9C9CB4),
                                           fontSize: 14,
                                           fontWeight: FontWeight.w300
                                       ),),
                                     ],
                                   ),
                                 ),
*/
                            Spacer(),
                            DropdownButtonHideUnderline(
                              child: DropdownButton(
                                isExpanded: false,
                                style: const TextStyle(
                                  color: Color(0xFF9C9CB4),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                                value: dropdownvalue,
                                icon: const Icon(
                                  Icons.keyboard_arrow_down,
                                  color: Color(0xFF9C9CB4),
                                ),
                                items: items.map((String items) {
                                  return DropdownMenuItem(
                                    value: items,
                                    child: Text(items),
                                  );
                                }).toList(),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    dropdownvalue = newValue!;
                                  });
                                },
                              ),
                            ),
                            addWidth(15),
                            const Text(
                              "To",
                              style: TextStyle(color: Color(0xFF9C9CB4), fontSize: 14, fontWeight: FontWeight.w300),
                            ),
                            addWidth(15),
                            DropdownButtonHideUnderline(
                              child: DropdownButton(
                                isExpanded: false,
                                style: const TextStyle(
                                  color: Color(0xFF9C9CB4),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                                value: dropdownvalue1,
                                icon: const Icon(
                                  Icons.keyboard_arrow_down,
                                  color: Color(0xFF9C9CB4),
                                ),
                                items: items1.map((String items) {
                                  return DropdownMenuItem(
                                    value: items,
                                    child: Text(items),
                                  );
                                }).toList(),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    dropdownvalue1 = newValue!;
                                  });
                                },
                              ),
                            ),
                            addWidth(5),
                          ],
                        ),
                      ),
                      addHeight(15)
                    ],
                  );
                },
              ),
              // ...List.generate(1,
              //         (index) => Container(
              //       margin: const EdgeInsets.only(bottom: 10),
              //       decoration: BoxDecoration(
              //           borderRadius: BorderRadius.circular(10),
              //           border: Border.all(
              //               color: Colors.grey
              //               // setStoreTimeController
              //               //     .model
              //               //     .value
              //               //     .data![index]
              //               //     .status ==
              //               //     true
              //               //     ? AppTheme.primaryColor
              //               //     : AppTheme.greycolor
              //           )),
              //       child: Theme(
              //         data: ThemeData(
              //             checkboxTheme: CheckboxThemeData(
              //                 shape: RoundedRectangleBorder(
              //                     borderRadius:
              //                     BorderRadius.circular(5)))),
              //         child:  buildCheckboxListTile(index, context),
              //       ),
              //     )),
              const SizedBox(
                height: 93,
              ),
              CustomOutlineButton(
                title: 'Save',
                onPressed: () {
                  Get.toNamed(MyRouters.allProductScreen);
                },
              ),
              // ElevatedButton(
              //     // onPressed: () {
              //     //   updatedSetStoreTimeRepo(
              //     //       setStoreTimeController.model.value.data!,
              //     //       context)
              //     //       .then((value) {
              //     //     if (value.status == true) {
              //     //       showToast(value.message);
              //     //       Get.toNamed(VenderDashboard.vendorDashboard);
              //     //       vendorDashboardController.getVendorDashboardData();
              //     //     }
              //     //   });
              //     // },
              //   onPressed: (){},
              //     style: ElevatedButton.styleFrom(
              //         padding: const EdgeInsets.all(10),
              //         minimumSize:
              //         Size(double.maxFinite, AddSize.size50),
              //         primary: const Color(0xFF7ED957),
              //         elevation: 0,
              //         shape: RoundedRectangleBorder(
              //             borderRadius: BorderRadius.circular(10)),
              //         textStyle: TextStyle(
              //             fontSize: AddSize.font18,
              //             fontWeight: FontWeight.w600)),
              //     child: Text(
              //       "Save".tr.toUpperCase(),
              //       style: Theme.of(context)
              //           .textTheme
              //           .headline5!
              //           .copyWith(
              //           color: Colors.white,
              //           fontWeight: FontWeight.w500,
              //           fontSize: AddSize.font18),
              //     )),
            ],
          ),
        ),
      ),
    );
  }

  CheckboxListTile buildCheckboxListTile(int index, BuildContext context) {
    return CheckboxListTile(
      checkColor: Colors.white,
      activeColor: Colors.green,
      controlAffinity: ListTileControlAffinity.leading,
      title: Text(
        'Sun',
        // setStoreTimeController.model.value.data![index].weekDay!
        // .substring(0, 3)
        // .toString())
        // .capitalizeFirst!,
        style: Theme.of(context)
            .textTheme
            .headline6!
            .copyWith(fontWeight: FontWeight.w400, color: Colors.black, fontSize: AddSize.font14),
      ),
      // value: setStoreTimeController.model.value.data![index].status!,
      value: select,
      onChanged: (value) {
        // setStoreTimeController.model.value.data![index].status = value!;
        select = value!;
        setState(() {});
      },
      secondary: SizedBox(
        height: MediaQuery.of(context).size.height * 0.9,
        width: MediaQuery.of(context).size.width * 0.55,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
                onTap: () {
                  // if (setStoreTimeController
                  //     .model.value.data![index].status ==
                  //     true) {
                  //   displayOpenTimeDialog(index);
                  // }
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      //horizontal: AddSize.padding10,
                      vertical: AddSize.padding10),
                  child: Row(
                    children: [
                      // Expanded(
                      //   child: Obx(() {
                      //     DateTime? time;
                      //     try {
                      //       time = intl.DateFormat("hh:mm a").parse('23:59');
                      //     } catch(e){
                      //       time = intl.DateFormat("hh:mm").parse('23:59');
                      //     }
                      //     return Text(
                      //       intl.DateFormat("hh:mm a").format(time),
                      //       style: Theme.of(context)
                      //           .textTheme
                      //           .headline6!
                      //           .copyWith(
                      //           fontWeight: FontWeight.w400,
                      //           color:Colors.black,
                      //           fontSize: AddSize.font14),
                      //     );
                      //   }),
                      // ),
                      Text(
                        "To",
                        style: Theme.of(context)
                            .textTheme
                            .headline6!
                            .copyWith(fontWeight: FontWeight.w400, color: Colors.black, fontSize: AddSize.font14),
                      ),
                      const Icon(
                        Icons.keyboard_arrow_down_outlined,
                        color: Colors.black,
                      )
                    ],
                  ),
                )),
            const SizedBox(
              width: 5,
            ),
            //const Spacer(),
            Text(
              "To",
              style: Theme.of(context)
                  .textTheme
                  .headline6!
                  .copyWith(fontWeight: FontWeight.w400, color: Colors.black, fontSize: AddSize.font14),
            ),
            const SizedBox(
              width: 8,
            ),
            //const Spacer(),
            Expanded(
              child: InkWell(
                onTap: () {
                  // if (setStoreTimeController.model.value.data![index].status ==
                  //     true) {
                  //   displayCloseTimeDialog(index);
                  // }
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      // horizontal: AddSize.padding10,
                      vertical: AddSize.padding10),
                  child: Row(
                    children: [
                      // Expanded(
                      //   child: Obx(() {
                      //     DateTime? time;
                      //     try {
                      //       time = intl.DateFormat("hh:mm a").parse('23:59');
                      //     } catch(e){
                      //       time = intl.DateFormat("hh:mm").parse('23:59');
                      //     }
                      //     return Text(
                      //       intl.DateFormat("hh:mm a").format(time),
                      //       style: Theme.of(context)
                      //           .textTheme
                      //           .headline6!
                      //           .copyWith(
                      //           fontWeight: FontWeight.w400,
                      //           color: Colors.black,
                      //           fontSize: AddSize.font14),
                      //     );
                      //   }),
                      // ),
                      const Icon(
                        Icons.keyboard_arrow_down_outlined,
                        color: Colors.black,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
