import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CommonAppBar extends StatelessWidget {
  final String? titleText;
  final List<Widget>? actions;
  const CommonAppBar({super.key, required this.titleText, this.actions});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      surfaceTintColor: Colors.white,
      backgroundColor: Colors.white,
      title: Text(
            titleText!,
            style: GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 18),
          ),
      actions: [
        ...actions ?? []
      ],
    );
  }
}
