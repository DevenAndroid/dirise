import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../utils/helper.dart';
import '../../widgets/dimension_screen.dart';

class ImageWidget extends StatefulWidget {
  const ImageWidget({super.key, required this.file, required this.title, required this.validation, required this.filePicked});
  final File file;
  final String title;
  final bool validation;
  final Function(File file) filePicked;

  @override
  State<ImageWidget> createState() => _ImageWidgetState();
}

class _ImageWidgetState extends State<ImageWidget> {
  File file = File("");

  bool get validation => widget.validation;

  pickImage() {
    NewHelper().addFilePicker().then((value) {
      if (value == null) return;
      widget.filePicked(value);
      file = value;
      setState(() {});
    });
  }

  @override
  void initState() {
    super.initState();
    file = widget.file;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: GoogleFonts.poppins(fontWeight: FontWeight.w500, color: const Color(0xff2F2F2F), fontSize: AddSize.font18),
        ),
        10.spaceY,
        GestureDetector(
          onTap: () {
            pickImage();
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: AddSize.padding16, vertical: AddSize.padding16),
            width: AddSize.screenWidth,
            height: context.getSize.width * .38,
            decoration: BoxDecoration(
                color: const Color(0xffE2E2E2).withOpacity(.4),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: !validation ? Colors.grey.shade300 : Colors.red,
                )),
            child: file.path == ""
                ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Select ${widget.title}",
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500,
                      color: validation ? Theme.of(context).colorScheme.error : const Color(0xff463B57),
                      fontSize: AddSize.font16),
                ),
                SizedBox(
                  height: AddSize.size10,
                ),
                Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: validation ? Theme.of(context).colorScheme.error : Colors.grey,
                        width: 1.8,
                      )),
                  padding: const EdgeInsets.all(6),
                  child: Icon(
                    Icons.file_copy_rounded,
                    size: 20,
                    color: validation ? Theme.of(context).colorScheme.error : Colors.grey,
                  ),
                )
              ],
            )
                : Image.file(file),
          ),
        ),
        14.spaceY,
      ],
    );
  }
}
