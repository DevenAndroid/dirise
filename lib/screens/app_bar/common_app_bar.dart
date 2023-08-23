import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget{
  final String? titleText;
  final List<Widget>? actions;
  final Color? backGroundColor;
  const CommonAppBar({super.key, required this.titleText, this.actions, this.backGroundColor});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      surfaceTintColor: backGroundColor ?? Colors.white,
      backgroundColor: backGroundColor ?? Colors.white,
      title: Text(
        titleText!,
        style: GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 18),
      ),
      actions: [...actions ?? []],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size(double.maxFinite, kToolbarHeight);
}
