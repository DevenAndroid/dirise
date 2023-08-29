import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget{
  final String? titleText;
  final List<Widget>? actions;
  final Color? backGroundColor;
  final Color? textColor;
  const CommonAppBar({super.key, required this.titleText, this.actions, this.backGroundColor, this.textColor});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      surfaceTintColor: backGroundColor ?? Colors.white,
      backgroundColor: backGroundColor ?? Colors.white,
      leading: textColor != null ? IconButton(onPressed: (){
        Get.back();
      }, icon: Icon(Icons.adaptive.arrow_back, color: Colors.white,)) : null,
      title: Text(
        titleText!,
        style: GoogleFonts.poppins(color: textColor ??  Colors.black, fontWeight: FontWeight.w600, fontSize: 18),
      ),
      actions: [...actions ?? []],
    );
  }

  @override
  Size get preferredSize => const Size(double.maxFinite, kToolbarHeight);
}
