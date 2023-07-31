import 'dart:async';
import 'dart:developer';
import 'package:dirise/utils/helper.dart';
import 'package:dirise/widgets/common_colour.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../controller/vendor_controllers/products_controller.dart';
import '../../widgets/dimension_screen.dart';
import '../../widgets/vendor_common_textfield.dart';

class BookableUI extends StatefulWidget {
  final Function(
    String bookingType,
    String dateType,
    DateTime? selectedStartDateTime,
    DateTime? selectedEndDateTIme,
    List<String> slots,
  ) onChange;
  const BookableUI({super.key, required this.onChange});

  @override
  State<BookableUI> createState() => _BookableUIState();
}

class _BookableUIState extends State<BookableUI> {
  final controller = Get.put(ProductsController());

  RxString bookingType = "Virtual".obs;
  RxString dateType = "date".obs;

  final DateFormat timeFormat = DateFormat("hh:mm a");
  final DateFormat timeFormatWithoutAMPM = DateFormat("hh:mm");
  final DateFormat selectedDateFormat = DateFormat("dd-MMM-yyyy");
  DateTime? selectedStartDateTime;
  DateTime? selectedEndDateTIme;

  Duration startDuration = const Duration(hours: 10, minutes: 00);
  Duration endDuration = const Duration(hours: 10, minutes: 00);
  Map<Map<DateTime, DateTime>, bool> slots = {};

  DateTime get startDateTime => startDuration.fromTodayStart;

  DateTime get endDateTime => startDuration.inMinutes > endDuration.inMinutes
      ? endDuration.fromTodayStart.add(const Duration(days: 1))
      : endDuration.fromTodayStart;

  Timer? debounce;

  makeDelay({required Function(bool gg) nowPerform}) {
    if (debounce != null) {
      debounce!.cancel();
    }
    debounce = Timer(const Duration(milliseconds: 600), () {
      nowPerform(true);
    });
  }

  clearSlots() {
    if (slots.isNotEmpty) {
      slots.clear();
      setState(() {});
    }
  }

  updateValues() {
    List<String> slot = slots.entries
        .where((element) => element.value == true)
        .map((e) => "${timeFormatWithoutAMPM.format(e.key.keys.first)},${timeFormatWithoutAMPM.format(e.key.values.first)}")
        .toList();
    widget.onChange(bookingType.value, dateType.value, selectedStartDateTime, selectedEndDateTIme, slot);
  }

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

  pickDate({required Function(DateTime gg) onPick, DateTime? initialDate, DateTime? firstDate, DateTime? lastDate}) async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: initialDate ?? DateTime.now(),
        firstDate: firstDate ?? DateTime.now(),
        lastDate: lastDate ?? DateTime(2101),
        initialEntryMode: DatePickerEntryMode.calendarOnly);
    if (pickedDate == null) return;
    onPick(pickedDate);
    updateValues();
  }

  @override
  void dispose() {
    super.dispose();
    if (debounce != null) {
      debounce!.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        bookingTypeCard(),
        slotCard(),
        productAvailability(),
      ],
    );
  }

  Card bookingTypeCard() {
    return Card(
        color: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 3,
        margin: const EdgeInsets.only(bottom: 14),
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: AddSize.padding16, vertical: 15),
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
                        Obx(() {
                          return Radio<String>(
                              value: "Virtual",
                              groupValue: bookingType.value,
                              visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                              onChanged: (v) {
                                if (v == null) return;
                                bookingType.value = v;
                                updateValues();
                              });
                        }),
                        Flexible(
                          child: GestureDetector(
                            onTap: () {
                              bookingType.value = "Virtual";
                              updateValues();
                            },
                            behavior: HitTestBehavior.translucent,
                            child: Text(
                              "Virtual",
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w400, color: const Color(0xff2F2F2F), fontSize: 14),
                            ),
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
                        Obx(() {
                          return Radio<String>(
                              value: "Personal",
                              groupValue: bookingType.value,
                              visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                              onChanged: (v) {
                                if (v == null) return;
                                bookingType.value = v;
                                updateValues();
                              });
                        }),
                        Flexible(
                          child: GestureDetector(
                            onTap: () {
                              bookingType.value = "Personal";
                              updateValues();
                            },
                            behavior: HitTestBehavior.translucent,
                            child: Text(
                              "Personal",
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w400, color: const Color(0xff2F2F2F), fontSize: 14),
                            ),
                          ),
                        ),
                      ],
                    )),
                  ],
                ),
              ],
            )));
  }

  Card slotCard() {
    return Card(
        color: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 3,
        margin: const EdgeInsets.only(bottom: 14),
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: AddSize.padding16, vertical: 15).copyWith(bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Create Slot",
                  style: GoogleFonts.poppins(fontWeight: FontWeight.w500, color: const Color(0xff2F2F2F), fontSize: 15),
                ),
                12.spaceY,
                IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        child: VendorCommonTextfield(
                            readOnly: true,
                            onTap: () => _showDialog(
                                  CupertinoTimerPicker(
                                    mode: CupertinoTimerPickerMode.hm,
                                    initialTimerDuration: startDuration,
                                    onTimerDurationChanged: (Duration newDuration) {
                                      makeDelay(nowPerform: (bool v) {
                                        startDuration = newDuration;
                                        if (kDebugMode) {
                                          print("performed....    $startDuration");
                                        }
                                        String hour =
                                            "${startDuration.inHours < 10 ? "0${startDuration.inHours}" : startDuration.inHours}";
                                        int minute = startDuration.inMinutes % 60;
                                        String inMinute = "${minute < 10 ? "0$minute" : minute}";
                                        controller.startTime.text = "$hour : $inMinute";
                                        clearSlots();
                                        setState(() {});
                                      });
                                    },
                                  ),
                                ),
                            controller: controller.startTime,
                            key: controller.startTime.getKey,
                            hintText: "Start Time",
                            suffixIcon: const Icon(
                              CupertinoIcons.clock,
                              size: 20,
                            ),
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
                            onTap: () => _showDialog(
                                  CupertinoTimerPicker(
                                    mode: CupertinoTimerPickerMode.hm,
                                    initialTimerDuration: endDuration,
                                    // This is called when the user changes the timer's
                                    // duration.
                                    onTimerDurationChanged: (Duration newDuration) {
                                      makeDelay(nowPerform: (bool v) {
                                        endDuration = newDuration;
                                        if (kDebugMode) {
                                          print("performed....    $endDuration");
                                        }
                                        String hour =
                                            "${endDuration.inHours < 10 ? "0${endDuration.inHours}" : endDuration.inHours}";
                                        int minute = endDuration.inMinutes % 60;
                                        String inMinute = "${minute < 10 ? "0$minute" : minute}";
                                        controller.endTime.text = "$hour : $inMinute";
                                        clearSlots();
                                        setState(() {});
                                      });
                                    },
                                  ),
                                ),
                            controller: controller.endTime,
                            key: controller.endTime.getKey,
                            hintText: "End Time",
                            suffixIcon: const Icon(
                              CupertinoIcons.clock,
                              size: 20,
                            ),
                            validator: (value) {
                              if (value!.trim().isEmpty) {
                                return "End time is required";
                              }
                              return null;
                            }),
                      ),
                    ],
                  ),
                ),
                12.spaceY,
                VendorCommonTextfield(
                    controller: controller.serviceDuration,
                    key: controller.serviceDuration.getKey,
                    onChanged: (f) {
                      clearSlots();
                    },
                    hintText: "Service Duration (in minutes)",
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    validator: (value) {
                      if (value!.trim().isEmpty) {
                        return "Service duration is required";
                      }
                      if (startDateTime
                              .difference(endDateTime)
                              .abs()
                              .compareTo(Duration(minutes: int.tryParse(value) ?? 0)) ==
                          -1) {
                        return "Service duration is greater then start & end time duration";
                      }
                      return null;
                    }),
                10.spaceY,
                Row(
                  key: controller.slotKey,
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          slots.clear();
                          if (kDebugMode) {
                            print(startDateTime.difference(endDateTime).abs());
                            print(startDateTime
                                .difference(endDateTime)
                                .abs()
                                .compareTo(Duration(minutes: int.tryParse(controller.serviceDuration.text) ?? 0)));
                            print(startDateTime
                                    .difference(endDateTime)
                                    .abs()
                                    .compareTo(Duration(minutes: int.tryParse(controller.serviceDuration.text) ?? 0)) ==
                                -1);
                          }

                          Duration minutes = Duration(minutes: int.tryParse(controller.serviceDuration.text) ?? 0);

                          DateTime temp = startDateTime;
                          while (temp.millisecondsSinceEpoch < endDateTime.millisecondsSinceEpoch) {
                            slots[{temp: temp.add(minutes)}] = false;
                            temp = temp.add(minutes);
                          }
                          FocusManager.instance.primaryFocus!.unfocus();
                          setState(() {});
                          updateValues();
                          log(slots.toString());
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.buttonColor,
                            surfaceTintColor: AppTheme.buttonColor,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
                        child: Text(
                          slots.isEmpty ? "Create Slot" : "Slots Created - ${slots.length}",
                          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 15),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 4,
                ),
                Container(
                  constraints: BoxConstraints(maxHeight: context.getSize.width * .55, minHeight: 0),
                  child: Scrollbar(
                    thumbVisibility: false, //always show scrollbar
                    thickness: 5, //width of scrollbar
                    interactive: true,
                    radius: const Radius.circular(20), //corner radius of scrollbar
                    scrollbarOrientation: ScrollbarOrientation.right, //which side to show scrollbar
                    child: ListView.builder(
                        itemCount: slots.length,
                        padding: const EdgeInsets.only(top: 10),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return CheckboxListTile(
                              value: slots.values.toList()[index],
                              onChanged: (ff) {
                                if (ff == null) return;
                                slots[slots.keys.toList()[index]] = ff;
                                updateValues();
                                setState(() {});
                              },
                              visualDensity: const VisualDensity(vertical: -4, horizontal: -3),
                              // dense: true,
                              title: Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Flexible(
                                    child: Text("${timeFormat.format(slots.keys.toList()[index].keys.first)} -- "
                                        "${timeFormat.format(slots.keys.toList()[index].values.first)}"),
                                  ),
                                  if (slots.keys.toList()[index].values.first.millisecondsSinceEpoch >
                                      endDateTime.millisecondsSinceEpoch)
                                    const Text(
                                      " Exceeded",
                                      style: TextStyle(
                                          color: AppTheme.buttonColor,
                                          fontWeight: FontWeight.w500,
                                          height: 1.8,
                                          fontSize: 12),
                                    )
                                ],
                              ));
                        }),
                  ),
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

  Card productAvailability() {
    return Card(
        key: controller.productAvailabilityKey,
        color: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 3,
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: AddSize.padding16, vertical: AddSize.padding20).copyWith(bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Product Availability",
                  style: GoogleFonts.poppins(fontWeight: FontWeight.w500, color: const Color(0xff2F2F2F), fontSize: 15),
                ),
                12.spaceY,
                Row(
                  children: [
                    Flexible(
                        child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Obx(() {
                          return Radio<String>(
                              value: "date",
                              groupValue: dateType.value,
                              visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                              onChanged: (v) {
                                if (v == null) return;
                                dateType.value = v;
                                updateValues();
                              });
                        }),
                        Flexible(
                          child: GestureDetector(
                            onTap: () {
                              dateType.value = "date";
                              updateValues();
                            },
                            behavior: HitTestBehavior.translucent,
                            child: Text(
                              "Single Date",
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w400, color: const Color(0xff2F2F2F), fontSize: 14),
                            ),
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
                        Obx(() {
                          return Radio<String>(
                              value: "range",
                              groupValue: dateType.value,
                              visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                              onChanged: (v) {
                                if (v == null) return;
                                dateType.value = v;
                                updateValues();
                              });
                        }),
                        Flexible(
                          child: GestureDetector(
                            onTap: () {
                              dateType.value = "range";
                              updateValues();
                            },
                            behavior: HitTestBehavior.translucent,
                            child: Text(
                              "Date Range",
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w400, color: const Color(0xff2F2F2F), fontSize: 14),
                            ),
                          ),
                        ),
                      ],
                    )),
                  ],
                ),
                Obx(() {
                  return dateType.value == "range"
                      ? Column(
                          children: [
                            12.spaceY,
                            VendorCommonTextfield(
                                readOnly: true,
                                onTap: () {
                                  pickDate(
                                      onPick: (DateTime gg) {
                                        controller.startDate.text = selectedDateFormat.format(gg);
                                        selectedStartDateTime = gg;
                                      },
                                      initialDate: selectedStartDateTime,
                                      lastDate: selectedEndDateTIme);
                                },
                                controller: controller.startDate,
                                key: controller.startDate.getKey,
                                hintText: "Start Time",
                                suffixIcon: const Icon(
                                  CupertinoIcons.clock,
                                  size: 20,
                                ),
                                validator: (value) {
                                  if (value!.trim().isEmpty) {
                                    return "Start date is required";
                                  }
                                  return null;
                                }),
                            20.spaceY,
                            VendorCommonTextfield(
                                readOnly: true,
                                onTap: () {
                                  pickDate(
                                      onPick: (DateTime gg) {
                                        controller.endDate.text = selectedDateFormat.format(gg);
                                        selectedEndDateTIme = gg;
                                      },
                                      initialDate: selectedEndDateTIme ?? selectedStartDateTime,
                                      firstDate: selectedStartDateTime);
                                },
                                controller: controller.endDate,
                                key: controller.endDate.getKey,
                                // key: endTime.getKey,
                                hintText: "End Time",
                                suffixIcon: const Icon(
                                  CupertinoIcons.clock,
                                  size: 20,
                                ),
                                validator: (value) {
                                  if (value!.trim().isEmpty) {
                                    return "End date is required";
                                  }
                                  return null;
                                }),
                          ],
                        )
                      : Column(
                          children: [
                            12.spaceY,
                            VendorCommonTextfield(
                                readOnly: true,
                                onTap: () {
                                  pickDate(
                                    onPick: (DateTime gg) {
                                      controller.startDate.text = selectedDateFormat.format(gg);
                                      selectedStartDateTime = gg;
                                    },
                                    initialDate: selectedStartDateTime,
                                  );
                                },
                                controller: controller.startDate,
                                key: controller.startDate.getKey,
                                // key: startTime.getKey,
                                hintText: "Single Date",
                                suffixIcon: const Icon(
                                  CupertinoIcons.clock,
                                  size: 20,
                                ),
                                validator: (value) {
                                  if (value!.trim().isEmpty) {
                                    return "Single date is required";
                                  }
                                  return null;
                                }),
                          ],
                        );
                }),
                10.spaceY,
              ],
            )));
  }
}
