import 'dart:async';
import 'dart:developer';
import 'package:dirise/utils/helper.dart';
import 'package:dirise/widgets/common_colour.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../widgets/dimension_screen.dart';
import '../../widgets/vendor_common_textfield.dart';

class BookableUI extends StatefulWidget {
  const BookableUI({super.key});

  @override
  State<BookableUI> createState() => _BookableUIState();
}

class _BookableUIState extends State<BookableUI> {
  String bookingType = "Virtual";

  void _showDialog(Widget child) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => Container(
        height: 216,
        padding: const EdgeInsets.only(top: 6.0),
        // The bottom margin is provided to align the popup above the system
        // navigation bar.
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        // Provide a background color for the popup.
        color: CupertinoColors.systemBackground.resolveFrom(context),
        // Use a SafeArea widget to avoid system overlaps.
        child: SafeArea(
          top: false,
          child: child,
        ),
      ),
    );
  }

  final TextEditingController startTime = TextEditingController();
  final TextEditingController endTime = TextEditingController();
  final TextEditingController serviceDuration = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        bookingTypeCard(),
        14.spaceY,
        slotCard(),
        14.spaceY,
      ],
    );
  }

  Card bookingTypeCard() {
    return Card(
        color: Colors.white,
        surfaceTintColor: Colors.white,
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: AddSize.padding16, vertical: AddSize.padding20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Booking Type",
                  style: GoogleFonts.poppins(fontWeight: FontWeight.w500, color: const Color(0xff2F2F2F), fontSize: 15),
                ),
                Row(
                  children: [
                    Flexible(
                        child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Radio<String>(
                            value: "Virtual",
                            groupValue: bookingType,
                            visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                            onChanged: (v) {
                              if (v == null) return;
                              bookingType = v;
                              setState(() {});
                            }),
                        Flexible(
                          child: Text(
                            "Virtual",
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w400, color: const Color(0xff2F2F2F), fontSize: 14),
                          ),
                        ),
                      ],
                    )),
                    const SizedBox(
                      width: 16,
                    ),
                    Flexible(
                        child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Radio<String>(
                            value: "Personal",
                            groupValue: bookingType,
                            visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                            onChanged: (v) {
                              if (v == null) return;
                              bookingType = v;
                              setState(() {});
                            }),
                        Flexible(
                          child: Text(
                            "Personal",
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w400, color: const Color(0xff2F2F2F), fontSize: 14),
                          ),
                        ),
                      ],
                    )),
                  ],
                ),
              ],
            )));
  }

  Duration startDuration = const Duration(hours: 10, minutes: 00);
  Duration endDuration = const Duration(hours: 10, minutes: 00);
  Map<Map<DateTime, DateTime>, bool> slots = {};

  DateTime get startDateTime => startDuration.fromTodayStart;
  DateTime get endDateTime => startDuration.inMinutes > endDuration.inMinutes ? endDuration.fromTodayStart.add(const Duration(days: 1)) : endDuration.fromTodayStart;


  Timer? debounce;

  makeDelay({
    required Function (bool gg) nowPerform
}){
    if(debounce != null){
      debounce!.cancel();
    }
    debounce = Timer(const Duration(milliseconds: 600), () {
      nowPerform(true);
    });
  }

  clearSlots(){
    if(slots.isNotEmpty){
      slots.clear();
      setState(() {});
    }
  }

  @override
  void dispose() {
    super.dispose();
    if(debounce != null){
      debounce!.cancel();
    }
  }

  final DateFormat timeFormat = DateFormat("hh:mm a");

  Card slotCard() {
    return Card(
        color: Colors.white,
        surfaceTintColor: Colors.white,
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: AddSize.padding16, vertical: AddSize.padding20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Create Slot",
                  style: GoogleFonts.poppins(fontWeight: FontWeight.w500, color: const Color(0xff2F2F2F), fontSize: 15),
                ),
                12.spaceY,
                Row(
                  children: [
                    Flexible(
                      child: VendorCommonTextfield(
                        readOnly: true,
                          onTap: ()=> _showDialog(
                            CupertinoTimerPicker(
                              mode: CupertinoTimerPickerMode.hm,
                              initialTimerDuration: startDuration,
                              onTimerDurationChanged: (Duration newDuration) {
                                makeDelay(
                                  nowPerform: (bool v){
                                    startDuration = newDuration;
                                    if (kDebugMode) {
                                      print("performed....    $startDuration");
                                    }
                                    String hour = "${startDuration.inHours < 10 ? "0${startDuration.inHours}" : startDuration.inHours}";
                                    int minute = startDuration.inMinutes % 60;
                                    String inMinute = "${minute < 10 ? "0$minute" : minute}";
                                    startTime.text = "$hour : $inMinute";
                                    clearSlots();
                                    setState(() {});
                                  }
                                );
                              },
                            ),
                          ),
                          controller: startTime,
                          key: startTime.getKey,
                          hintText: "Start Time",
                          suffixIcon: const Icon(CupertinoIcons.clock,size: 20,),
                          validator: (value) {
                            if (value!.trim().isEmpty) {
                              return "Start time is required";
                            }
                            return null;
                          }),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Flexible(
                      child: VendorCommonTextfield(
                          readOnly: true,
                          onTap: ()=> _showDialog(
                            CupertinoTimerPicker(
                              mode: CupertinoTimerPickerMode.hm,
                              initialTimerDuration: endDuration,
                              // This is called when the user changes the timer's
                              // duration.
                              onTimerDurationChanged: (Duration newDuration) {
                                makeDelay(
                                    nowPerform: (bool v){
                                      endDuration = newDuration;
                                      if (kDebugMode) {
                                        print("performed....    $endDuration");
                                      }
                                      String hour = "${endDuration.inHours < 10 ? "0${endDuration.inHours}" : endDuration.inHours}";
                                      int minute = endDuration.inMinutes % 60;
                                      String inMinute = "${minute < 10 ? "0$minute" : minute}";
                                      endTime.text = "$hour : $inMinute";
                                      clearSlots();
                                      setState(() {});
                                    }
                                );
                              },
                            ),
                          ),
                          controller: endTime,
                          key: endTime.getKey,
                          hintText: "End Time",
                          suffixIcon: const Icon(CupertinoIcons.clock,size: 20,),
                          validator: (value) {
                            if (value!.trim().isEmpty) {
                              return "End time is required";
                            }
                            return null;
                          }),
                    ),
                  ],
                ),
                12.spaceY,
                VendorCommonTextfield(
                  controller: serviceDuration,
                  onChanged: (f){
                    clearSlots();
                  },
                  hintText: "Service Duration (in minutes)",
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  validator: (value) {
                    if (value!.trim().isEmpty) {
                      return "Service duration is required";
                    }
                    if (startDateTime.difference(endDateTime).abs().compareTo(Duration(minutes: int.tryParse(value) ?? 0)) == -1) {
                      return "Service duration is greater then start & end time duration";
                    }
                    return null;
                  }
                ),
                10.spaceY,
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: (){
                          slots.clear();
                          if (kDebugMode) {
                            print(startDateTime.difference(endDateTime).abs());
                          print(startDateTime.difference(endDateTime).abs().compareTo(Duration(minutes: int.tryParse(serviceDuration.text) ?? 0)));
                          print(startDateTime.difference(endDateTime).abs().compareTo(Duration(minutes: int.tryParse(serviceDuration.text) ?? 0)) == -1);
                          }

                          Duration minutes = Duration(minutes: int.tryParse(serviceDuration.text) ?? 0);

                          DateTime temp = startDateTime;
                          while(temp.millisecondsSinceEpoch < endDateTime.millisecondsSinceEpoch){
                            slots[{temp : temp.add(minutes)}] = false;
                            temp = temp.add(minutes);
                          }
                          setState(() {});
                          log(slots.toString());

                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.buttonColor,
                          surfaceTintColor: AppTheme.buttonColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)
                          )
                        ),
                        child: Text( slots.isEmpty ? "Create Slot" : "Slots Created - ${slots.length}",style: const TextStyle(
                          color: Colors.white,fontWeight: FontWeight.w500,fontSize: 15
                        ),),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4,),
                Container(
                  constraints: BoxConstraints(
                    maxHeight: context.getSize.width*.55,
                    minHeight: 0
                  ),
                  child: ListView.builder(
                    itemCount: slots.length,
                      padding: const EdgeInsets.only(top: 10),
                      shrinkWrap: true,
                      itemBuilder: (context,index){
                    return CheckboxListTile(
                        value: slots.values.toList()[index],
                        onChanged: (ff){
                          if(ff==null)return;
                          slots[slots.keys.toList()[index]] = ff;
                          setState(() {});
                        },
                        visualDensity: const VisualDensity(vertical: -4,horizontal: -3),
                        // dense: true,
                        title: Text(
                            "${timeFormat.format(slots.keys.toList()[index].keys.first)} -- ${timeFormat.format(slots.keys.toList()[index].values.first)}"
                        )
                    );
                  }),
                ),
                // ...slots.entries.map((e) => CheckboxListTile(
                //   value: e.value,
                //     onChanged: (ff){
                //     if(ff==null)return;
                //       slots[e.key] = ff;
                //       setState(() {});
                //     },
                //     visualDensity: const VisualDensity(vertical: -4,horizontal: -3),
                //     // dense: true,
                //     title: Text(
                //         "${timeFormat.format(e.key.keys.first)} -- ${timeFormat.format(e.key.values.first)}"
                //     )
                // )).toList()
              ],
            )));
  }
}
